//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Jennifer Kwan on 2/11/16.
//  Copyright © 2016  Jennifer Kwan. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets: [Tweet]?
    //wekk 5 v
    var tweetsBackup: Tweet?
//week 5 ^
    //var isMoreDataLoading = false
    var refreshControl: UIRefreshControl!
    let delay = 3.0 * Double(NSEC_PER_SEC)

    var faved: Bool = false
    var retweeted: Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    //Optional*Network Fail 1*
    
    @IBOutlet weak var networkErrorBackground: UIView!
    @IBOutlet weak var networkErrorLabel: UILabel!
    //Optiona*Network Fail1*

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //adding the tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //here code for pull to refresh
        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        
        
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
//ended code for pull to refresh
        
        //for the autolayout of the tableview row
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        
        
        tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            
            self.tableView.reloadData()
            
            self.refreshControl.endRefreshing()
            
        }
        
        
    }
    
    //finishing pull to refresh 
    func delay(delay:Double, closure:() -> ()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        delay(1, closure: {
            self.refreshControl.endRefreshing()
        })
    }
    

    
    
    /*******Optiona*Network Fail2*****/
    

    func checkNetwork(){
        if Reachability.isConnectedToNetwork() == true {
            networkErrorLabel.hidden = true
            networkErrorBackground.hidden = true
     self.view.bringSubviewToFront(self.networkErrorBackground)
        }else {
            networkErrorLabel.hidden = false
            networkErrorBackground.hidden = false
            
        }
    }
    
    
    
    /*****Optiona Network Fail 2***/
    
    //finished pull to refresh
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //tvds (tableview data source implementation)
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
 

    
   /*
    func testTweets() {
        let tweet = tweets![0]
        print(tweet.user!.name)
        //print(tweet.retweetCount as! Int)
        //print(tweet.favCount as! Int)
    }
   */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetsCell", forIndexPath: indexPath) as! TweetsCell
       
        cell.tweet = tweets![indexPath.row]
        
        
        return cell
        
        }
        

    
    //tvds ends here
   
    /*************************
    func scrollViewDidScroll(scrollView: UIScrollView) {
           if (!isMoreDataLoading) {
               // Calculate the position of one screen length before the bottom of the results
               let scrollViewContentHeight = tableView.contentSize.height
               let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
               
               // When the user has scrolled past the threshold, start requesting
               if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                   
                   isMoreDataLoading = true
               
                   // Code to load more results
                   loadMoreData()
               }
           }

    ****************************/
    
    
    
    /***********************/
    
//********* Segue *******
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//pass data to "DetailsViewController"
if (segue.identifier == "cellToDetails") {
cellData(sender)
    
    
let detailViewController = segue.destinationViewController as! DetailViewController
detailViewController.tweetar = tweetsBackup
}
    
else if (segue.identifier) == "SegueToSpecificProfilePage" {
    
    
    let button = sender as! UIButton
    let view = button.superview!
    let cell = view.superview as! TweetsCell
    
    //let indexPath = tableView.indexPathForCell(cell)
    //let tweet = tweets![indexPath!.row]
    //let user = tweet.user
    
    let specificProfileViewController = segue.destinationViewController as! SpecificProfileViewController
   // specificProfileViewController = user
    specificProfileViewController.tweetar = tweetsBackup
    
    }

    
    /*//trying to implement the segue
else if (segue.identifier) == "SegueToSpecificProfilePage" {
    
    
    let button = sender as! UIButton
    let view = button.superview!
    let cell = view.superview as! TweetsCell
    
    let indexPath = tableView.indexPathForCell(cell)
    let tweet = tweets![indexPath!.row]
    let user = tweet.user
    
    let profilePageViewController = segue.destinationViewController as! SpecificProfileViewController
    SpecificProfileViewController.user = user
    
    }
    
   
   */ //finished tyring to implement the segue [ for the specific Profile VIew Controller]

    
}

    func cellData(sender: AnyObject?) {
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        let tweetss = tweets![indexPath!.row]
        tweetsBackup = tweetss
    }



/********************/

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
        
        //to add the segue from home to login
        //self.performSegueWithIdentifier("logoutSegue", sender: self)
        
    }
    
    
    
    //Action to retweet/unretweet animation
    @IBAction func onRetweetButtonClicked(sender: UIButton) {
        let subviewPostion: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        let indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(subviewPostion)!
        let cell =  self.tableView.cellForRowAtIndexPath(indexPath)! as! TweetsCell
        
        if retweeted == false {
            TwitterClient.sharedInstance.retweet(["id": tweets![indexPath.row].id!]) { (tweet, error) -> () in
                cell.retwetImageView.image = UIImage(named: "retweet-action-on-green")
                self.retweeted = true
                print("You retweeted \(self.tweets![indexPath.row].user!.name!)'s post")
                self.tweets![indexPath.row].retweetCount += 1
                cell.retweetCountLabel.text = "\(self.tweets![indexPath.row].retweetCount)"
                //                    let indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
                //                    self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            }
        }else{
            TwitterClient.sharedInstance.unFavTweet(["id": tweets![indexPath.row].id!]) { (tweet, error) -> () in
                
                cell.retwetImageView.image = UIImage(named: "retweet-action-inactive")
                self.retweeted = false
                print("You retweeted \(self.tweets![indexPath.row].user!.name!)'s post")
                self.tweets![indexPath.row].retweetCount -= 1
                cell.retweetCountLabel.text = "\(self.tweets![indexPath.row].retweetCount)"
            }
        }
    }
    
    //Action to fave/unfav animation
    @IBAction func onFavButtonClicked(sender: UIButton) {
        let subviewPostion: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        let indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(subviewPostion)!
        let cell =  self.tableView.cellForRowAtIndexPath(indexPath)! as! TweetsCell
        
        if faved == false {
            TwitterClient.sharedInstance.favTweet(["id": tweets![indexPath.row].id!]) { (tweet, error) -> () in
                
                
                //heart animation when fav clicked
                let ImageName = "heart-"
                var imagesNames = [ "\(ImageName)1","\(ImageName)2","\(ImageName)3","\(ImageName)4","\(ImageName)5","\(ImageName)6","\(ImageName)7","\(ImageName)8","\(ImageName)9","\(ImageName)10"]
                var images = [UIImage]()
                
                for i in 0..<imagesNames.count{
                    images.append(UIImage(named: imagesNames[i])!)
                    cell.ffavImageView.animationImages = images
                }
                
                cell.ffavImageView.animationDuration = 1
                cell.ffavImageView.animationRepeatCount = 1
                cell.ffavImageView.image = UIImage(named: "like-action-on-red")
                cell.ffavImageView.startAnimating()
                
                self.faved = true
                print("You liked \(self.tweets![indexPath.row].user!.name!)'s post")
                self.tweets![indexPath.row].favCount += 1
                cell.favCountLabel.text = "\(self.tweets![indexPath.row].favCount)"
            }
        }else{
            
            TwitterClient.sharedInstance.unFavTweet(["id": tweets![indexPath.row].id!]) { (tweet, error) -> () in
                cell.ffavImageView.image = UIImage(named: "like-action-off")
                self.faved = false
                
                print("You unliked \(self.tweets![indexPath.row].user!.name!)'s post")
                self.tweets![indexPath.row].favCount -= 1
                cell.favCountLabel.text = "\(self.tweets![indexPath.row].favCount)"
            }
        }
    }
    

    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

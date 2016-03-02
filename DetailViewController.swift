//
//  DetailViewController.swift
//  Twitter
//
//  Created by Jennifer Kwan on 2/11/16.
//  Copyright © 2016  Jennifer Kwan. All rights reserved.
//

import UIKit
import SwiftMoment

class DetailViewController: UIViewController {

    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var detailUserHandle: UILabel!
    
    @IBOutlet weak var detailTweetContentText: UILabel!
    
    @IBOutlet weak var createdTime: UILabel!
    
    @IBOutlet weak var replyImageView: UIButton!
    
    @IBOutlet weak var replyButton: UIButton!
    
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favButton: UIButton!
    
    
   
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var favCountLabel: UILabel!
    
    
    
    
    @IBOutlet weak var retwetImageView: UIImageView!
    
    @IBOutlet weak var ffavImageView: UIImageView!
    
    
    var replyTo: String?
    var replyID: Int?
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var tweetar: Tweet!
    var timeSpanText: String?
    var faved: Bool = false
    var retweeted: Bool = false
    private var detailTweets =  [Tweet]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showProfile()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showProfile(){
        userName.text = tweetar!.user!.name!
        detailUserHandle.text = ("@\(tweetar!.user!.screenname!)")
        detailTweetContentText.text = tweetar!.text!
        detailImageView.setImageWithURL(NSURL(string: tweetar!.user!.profileImageUrl!)!)
        let tweetDate = parseTwitterDate("\(tweetar!.createdAt!)")
        createdTime.text = tweetDate
        favCheck()
        retweetCheck()
        
        replyID = tweetar.id!
        replyTo = detailUserHandle.text
        userDefaults.setValue(replyID, forKey: "detailReplyTo_ID")
        userDefaults.setValue(replyTo, forKey: "detailReplyTo_Handle")
    }

    func parseTwitterDate(twitterDate:String)->String?{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        
        let indate = formatter.dateFromString(tweetar!.createdAtString!)
        let outputFormatter = NSDateFormatter()
        outputFormatter.dateFormat = "h:mm a · dd MMM yy"
        var outputDate:String?
        if let d = indate {
            outputDate = outputFormatter.stringFromDate(d)
        }
        return outputDate;
    }
    
    
    
    @IBAction func onRetweetClicked(sender: AnyObject) {
        if retweeted == false {
            TwitterClient.sharedInstance.retweet(["id": tweetar!.id!]) { (tweet, error) -> () in
                self.retweeted = true
                print("You retweeted: \(self.tweetar!.user!.name!)'s post")
                
                let tweetCountNum = Int (self.tweetar.retweetCount += 1)
                print("num is \(tweetCountNum)")
                if tweetCountNum >= 1000 {
                    print("num2 is \(tweetCountNum)")
                    
                    let finaTweetCountNum = tweetCountNum / 1000
                    print("num3 is \(finaTweetCountNum)k")
                    
                    self.retweetCountLabel.text = "\(finaTweetCountNum)k)"
                    
                }
                else {
                }
                self.retwetImageView.image = UIImage(named: "retweet-action-on-green")
                self.retweetCheck()
            }
        }else{
            TwitterClient.sharedInstance.unRetweet(["id": tweetar!.id!]) { (tweet, error) -> () in
                self.retweeted = false
                print("You unretweeted: \(self.tweetar!.user!.name!)'s post")
                self.tweetar!.retweetCount -= 1
                self.retweetCountLabel.text = "\(self.tweetar!.retweetCount)"
                self.retwetImageView.image = UIImage(named: "retweet-action-inactive")
                self.retweetCheck()
            }
        }
    }
    
    
    
    @IBAction func onFavClicked(sender: AnyObject) {
        if faved == false {
            TwitterClient.sharedInstance.favTweet(["id": tweetar!.id!]) { (tweet, error) -> () in
                self.faved = true
                print("You liked: \(self.tweetar!.user!.name!)'s post")
                self.tweetar.favCount += 1
                
                var likeCountNum = self.tweetar!.favCount
                if likeCountNum > 1000 {
                    likeCountNum = likeCountNum / 1000
                }
                
                self.favCountLabel.text = "\(likeCountNum)"
                self.ffavImageView.image = UIImage(named: "like-action-on-red")
                
                self.favCheck()
            }
        }else{
            TwitterClient.sharedInstance.unFavTweet(["id": tweetar!.id!]) { (tweet, error) -> () in
                self.faved = false
                print("You unliked: \(self.tweetar!.user!.name!)'s post")
                self.tweetar!.favCount -= 1
                self.favCountLabel.text = "\(self.tweetar!.favCount)"
                self.ffavImageView.image = UIImage(named: "like-action-off")
                
                self.favCheck()
            }
        }
    }
    
    
    func favCheck(){
        let favCounts = tweetar!.favCount as Int
        if favCounts == 0 {
            favCountLabel.text = ""
        } else {
            favCountLabel.text = "\(tweetar!.favCount as Int)"
        }
    }
    
    
    func retweetCheck(){
        let retweetCounts = tweetar!.retweetCount as Int
        if retweetCounts == 0 {
            retweetCountLabel.text = ""
        } else {
            retweetCountLabel.text = "\(tweetar!.retweetCount as Int)"
        }
    }

}

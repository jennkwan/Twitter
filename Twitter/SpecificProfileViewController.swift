//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Jennifer Kwan on 2/11/16.
//  Copyright © 2016  Jennifer Kwan. All rights reserved.
//

import UIKit
import SwiftMoment
class SpecificProfileViewController: UIViewController {
 
    var replyTo: String?
    var replyID: Int?
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var tweetar: Tweet!
 
       private var detailTweets =  [Tweet]()
    
 //   var user: User?
   /// var tweet: Tweet?
    
    @IBOutlet weak var banner: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var numOfFollowing: UILabel!
    @IBOutlet weak var numOfFollowers: UILabel!
    @IBOutlet weak var tagline: UILabel!

    @IBOutlet weak var numOfTweets: UILabel!
    
    //var follower: Int?
    //var following: Int?
    //var tweetsnumba: Int?
    
    var profileBackgroundImageURL: String?
//let userDefaults = NSUserDefaults.standardUserDefaults()
  //  private var detailTweets =  [Tweet]()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showProfile()
        /*
        banner.setImageWithURL(NSURL(string: User.currentUser!.profileBackgroundImageURL!)!)
        //banner.setImageWithURL((user?.profileBackgroundImageURL)!)
        banner.sizeToFit()
        
        
        profileImage.setImageWithURL(NSURL(string: User.currentUser!.profileImageUrl!)!)
        userName.text = User.currentUser?.name
        handle.text = User.currentUser?.screenname
        tagline.text = User.currentUser?.tagline
        if let followerss = User.currentUser?.follower!  {
            numOfFollowers.text = String(followerss)
        }else {
            numOfFollowers.text = "0"
        }
        
        if let flowingg = User.currentUser?.following!  {
            numOfFollowing.text = String(flowingg)
        }else {
            numOfFollowing.text = "0"
        }
        if let tweetss = User.currentUser?.tweetsnumba!  {
            numOfTweets.text = String(tweetss)
        }else {
            numOfTweets.text = "0"
        }

        // Do any additional setup after loading the view.
        
       // let id = user?.id
        
    
*/
    }

    func showProfile(){
        userName.text = tweetar!.user!.name!
        handle.text = ("@\(tweetar!.user!.screenname!)")
        // detailTweetContentText.text = tweetar!.text!
        profileImage.setImageWithURL(NSURL(string: tweetar!.user!.profileImageUrl!)!)
        //timeLabel.text = timeSpanText  //displays timeSpan
        replyID = tweetar.id!
        //print("is issssss\(replyID)")
        tagline.text = tweetar!.user!.name
        banner.setImageWithURL(NSURL(string: tweetar!.user!.bannerURL!)!)
        
        numOfFollowers.text = String(tweetar!.user!.follower! )
        numOfFollowing.text = String(tweetar!.user!.following! )
        numOfTweets.text = String(tweetar!.user!.tweetsnumba! )
        //let userID = user?.userID
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
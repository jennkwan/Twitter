//
//  TweetsCell.swift
//  Twitter
//
//  Created by Jennifer Kwan on 2/11/16.
//  Copyright © 2016  Jennifer Kwan. All rights reserved.
//

import UIKit
import SwiftMoment

protocol TweetCellDelegate {
    func userReplyToTweet(reply_screenNameYOOO: String)
    
}

class TweetsCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userHandle: UILabel!
    
    @IBOutlet weak var tweetContentText: UILabel!

    @IBOutlet weak var createdTime: UILabel!
    
    //  (#5R) Added the Oulets for the retweet & favorite + TweetID
    
    @IBOutlet weak var replyImageView: UIButton!


    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favButton: UIButton!
    
    
    @IBOutlet weak var ffavImageView: UIImageView!
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var favCountLabel: UILabel!

    @IBOutlet weak var retwetImageView: UIImageView!
    var tweetID: String = ""
     // (#5R) Done adding the retweet & favorite outlets + TweetID
    
    
    var tweet: Tweet! {
        didSet {
            tweetContentText.text = tweet.text
            userName.text = tweet.user!.name
            userHandle.text = "@\(tweet.user!.screenname!)"
            
            profileImage.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
            
            createdTime.text = calculateTimeStamp(tweet.createdAt!.timeIntervalSinceNow) //<-This is for the time to look nice
            
            
         // (#5R) Starting adding the retweet & favorite outlets + TweetID
            
            //tweetID = tweet.id
            retweetCountLabel.text = String(tweet.retweetCount)
            favCountLabel.text = String(tweet.favCount)
            
            retweetCountLabel.text! == "0" ? (retweetCountLabel.hidden = true) : (retweetCountLabel.hidden = false)
            favCountLabel.text! == "0" ? (favCountLabel.hidden = true) : (favCountLabel.hidden = false)
            // (#5R) Done adding the retweet & favorite outlets + TweetID
            
             }
        
        
    }
    
    
    
    
    
    // (for the time to look nice)
    
    func calculateTimeStamp(timeTweetPostedAgo: NSTimeInterval) -> String {
        
        var rawTime = Int(timeTweetPostedAgo)
        var timeAgo: Int = 0
        var timeChar = ""
        
        rawTime = rawTime * (-1)
        
        if (rawTime <= 60) { //sec
            timeAgo = rawTime
            timeChar = "s"
        } else if ((rawTime/60) <= 60) { // min
            timeAgo = rawTime/60
            timeChar = "m"
        } else if (rawTime/60/60 <= 24) { // hr
            timeAgo = rawTime/60/60
            timeChar = "h"
        } else if (rawTime/60/60/24 <= 365) { // days
            timeAgo = rawTime/60/60/24
            timeChar = "d"
        } else if (rawTime/(3153600) <= 1) { // Years
            timeAgo = rawTime/60/60/24/365
            timeChar = "y"
        }
        
        return "\(timeAgo)\(timeChar)"
    }
    
    
    // (for the time to look nice)
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //changing the radius of the image
        
        profileImage.layer.cornerRadius = 3
        profileImage.clipsToBounds = true
        
        //for the autoLayout
        userName.preferredMaxLayoutWidth = userName.frame.size.width
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
     userName.preferredMaxLayoutWidth = userName.frame.size.width
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

   /*
    // (#5R) tryign to action
    @IBAction func onRetweet(sender: AnyObject) {
    
        TwitterClient.sharedInstance.retweet(Int(tweetID)!, params: nil, completion: {(error) -> () in
            self.retweetButton.setImage(UIImage(named: "retweet-action-on-pressed.png"), forState: UIControlState.Selected)
            
            if self.retweetCountLabel.text! > "0" {
                self.retweetCountLabel.text = String(self.tweet!.retweetCount! + 1)
            } else {
                self.retweetCountLabel.hidden = false
                self.retweetCountLabel.text = String(self.tweet!.retweetCount! + 1)
            }
        })

    }
    
    @IBAction func onFav(sender: AnyObject) {
        
        TwitterClient.sharedInstance.favTweet(Int(tweetID)!, params: nil, completion: {(error) -> () in
            self.favButton.setImage(UIImage(named: "like-action-on.png"), forState: UIControlState.Selected)
            
            if self.favCountLabel.text! > "0" {
                self.favCountLabel.text = String(self.tweet.favCount! + 1)
            } else {
                self.favCountLabel.hidden = false
                self.favCountLabel.text = String(self.tweet.favCount! + 1)
            }
        })

    }
    
   */
    // (#5R) finished Trying to action
    
    var delegate: TweetCellDelegate?
    
    @IBAction func onReply(sender: AnyObject) {
        //        let screenNameString = userHandle.text
        //        print("\(screenNameString)")
        //        delegate!.userReplyToTweet(screenNameString!)
    }

    
    
    
}

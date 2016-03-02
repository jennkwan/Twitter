//
//  Tweet.swift
//  Twitter
//
//  Created by Jennifer Kwan on 2/11/16.
//  Copyright © 2016  Jennifer Kwan. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    
    // (#5R) here for the favCount and retweetCount
    var id: Int?
    var retweetCount: Int
    var favCount: Int
    
    
    //week5 down here
    var replyUserStatusID: String?
    
    //week5 up here
    
    
    
    //  (#5R) ended the favCount and retweetCount
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        //week 5 down
        replyUserStatusID = dictionary["id_str"] as? String
        //week 5 up
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        //  (#5R)  here for the favCount and retweetCount
       id = dictionary["id"] as? Int  //<-not sure about this string
        
        retweetCount = dictionary["retweet_count"] as! Int
        favCount = dictionary["favorite_count"] as! Int
        
        
        
         // (#5R) ended the favCount and retweetCount
        
        
        
    }
    
    //convinience method that takes array of dictionaries and returns array of tweets
    class func tweetAsDictionary(dict: NSDictionary) -> Tweet {
        
        let tweet = Tweet(dictionary: dict)
        return tweet
    }

    

    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
    
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
    
        return tweets
}

    
}

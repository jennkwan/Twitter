//
//  User.swift
//  Twitter
//
//  Created by Jennifer Kwan on 2/11/16.
//  Copyright © 2016  Jennifer Kwan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

/*var to make the segue from logout(home to loginNagivationController
var window: UIWindow?
var storyboard = UIStoryboard(name: "Main", bundle: nil)
*/


var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"


class User: NSObject {

    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    var follower: Int?
    var following: Int?
    var tweetsnumba: Int?
    
    var bannerURL: String?
    
   // var userID: Int?

    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        
        follower = dictionary["followers_count"] as? Int
        following = dictionary["friends_count"] as? Int
        tweetsnumba = dictionary["statuses_count"] as? Int
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
    
        
        if dictionary["profile_banner_url"] != nil {
            bannerURL =  dictionary["profile_banner_url"] as? String

        }
        
    //userID = dictionary["id"] as! Int

        
        
    }
    //setting up the logout function
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
        
        
        
        /*
        //making  segue from logout(home) to loginNavigation
        
        var vc =
        
        storyboard.instantiateViewControllerWithIdentifier("HomeNavigationController") as! UINavigationController
        
        window?.rootViewController = vc
        
        */
    }
    
    
    //finishing the logout function
    
    
    
    class var currentUser: User? {
        get {
        if _currentUser == nil {
        let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData;
        if data != nil {
        do {
        let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions());
        _currentUser = User(dictionary: dictionary as! NSDictionary);
    } catch _ {
        
        }
        }
        }
        return _currentUser;
        }
        set(user) {
            _currentUser = user;
            
            if _currentUser != nil {
                do {
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: NSJSONWritingOptions());
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey);
                } catch _ {
                    
                }
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey);
            }
            NSUserDefaults.standardUserDefaults().synchronize();
        }
    }
    
}

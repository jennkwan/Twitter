//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Jennifer Kwan on 2/11/16.
//  Copyright © 2016  Jennifer Kwan. All rights reserved.
//

import UIKit


class ProfileViewController: UIViewController {

    @IBOutlet weak var banner: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var numOfFollowing: UILabel!
    @IBOutlet weak var numOfFollowers: UILabel!
    @IBOutlet weak var tagline: UILabel!

    @IBOutlet weak var numOfTweets: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            banner.setImageWithURL(NSURL(string: User.currentUser!.bannerURL!)!)

        
        
        
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

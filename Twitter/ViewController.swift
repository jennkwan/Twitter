//
//  ViewController.swift
//  Twitter
//
//  Created by Jennifer Kwan on 2/11/16.
//  Copyright © 2016  Jennifer Kwan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import AFNetworking

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                //perform segue
                
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                //self.destinationViewController as?
            } else {
                //handle login error
                
            }
        }

    }
}



//
//  ReplyViewController.swift
//  Twitter
//
//  Created by Jennifer Kwan on 2/11/16.
//  Copyright © 2016  Jennifer Kwan. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {

    @IBOutlet weak var textViewField: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        textViewField.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func insertTwitterHandle(handle: String) {
//        replyTextField.text = handle
//        replyTextField.delegate?.textViewDidChange!(replyTextField)
//    }

    @IBAction func cancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    @IBAction func sendAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

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

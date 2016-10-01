//
//  ContactUsViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/25/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import MessageUI

class SVContactUsViewController: SVBaseViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblMail: UILabel!
    
    //MARK : Overridden Methods
    
    @IBAction func callTapped() {
        
        if let url = NSURL(string: "telprompt:\(lblPhone.text!)")
        {
            if UIApplication.sharedApplication().canOpenURL(url)
            {
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }
    
    
    @IBAction func mailTapped() {
        
        let recipientEmail = self.lblMail.text!
        
        if MFMailComposeViewController.canSendMail() {
            let mailComposeVC = MFMailComposeViewController()
            mailComposeVC.mailComposeDelegate = self
            mailComposeVC.setSubject("")
            mailComposeVC.setToRecipients([recipientEmail])
            mailComposeVC.setMessageBody("", isHTML: false)
            presentViewController(mailComposeVC, animated: true, completion: nil)
        }
    }
    
    //MARK : Overridden Methods
    override func navBarConfig() -> SVNavBarConfig {
        return SVNavBarConfig(showBack: true, showSearch: true, showCart: true, title: "Contact Us")
    }
    
    
    //MARK : View Controller Life cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Mail Composer delegate
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
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

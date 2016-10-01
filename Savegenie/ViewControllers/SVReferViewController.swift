//
//  SVReferViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/27/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVReferViewController: SVBaseViewController {
    
    @IBOutlet weak var lblReferralCode:UILabel!
    @IBOutlet weak var lblReferralAmuont:UILabel!
    
    
    //MARK : Action Methods
    @IBAction func onReferTap() {
        
        //TODO- Activity controller
        
        let items = ["Buy from savegenie.mu and get 50 Rs off", "Download Savegenie, Grocery on Demand App on iOS & place first order using code & get Rs 50 OFF on order above Rs 1000. Click"]
        let activityViewController:UIActivityViewController  =
            UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        //activityViewController.completionHandler = UIActivityViewControllerCompletionHandler
        
        self.navigationController?.presentViewController(activityViewController, animated: true, completion: { 
            
            
        })
    }
    
    //MARK : Overridden Methods
    override func navBarConfig() -> SVNavBarConfig {
        return SVNavBarConfig(showBack: true, showSearch: true, showCart: true, title: "Refer & Earn")
    }
    
    
    //MARK : View Controller Life cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchReferralDetails()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private Methods
    private func fetchReferralDetails() {
        
        SVJSONAppService.fetchReferralDetails(Array<(key:String,value:AnyObject)>(), responsObjectKey: "") { (referralDetails:SVReferralDetails?, error:NSError?) in
            
            if let _ = referralDetails {
                
                self.lblReferralCode.text = referralDetails?.referralCode
                self.lblReferralAmuont.text = "Rs " + (referralDetails?.referralAmount)!
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

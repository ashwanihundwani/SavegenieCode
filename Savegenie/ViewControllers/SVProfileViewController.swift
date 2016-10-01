//
//  SVProfileViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/29/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class SVProfileViewController: SVBaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lblEmail:UILabel!
    @IBOutlet weak var btnArea:UIButton!
    @IBOutlet weak var lblFirstName:UITextField!
    @IBOutlet weak var lblLastName:UITextField!
    @IBOutlet weak var btnTitle:UIButton!
    @IBOutlet weak var txtPhoneNumber:UITextField!
    
    var areas:Array<String> = Array<String>()
    
    //MARK : Action Methods
    
    @IBAction func updateProfileTapped() {
        
    }
    
    @IBAction func btnTitleTapped() {
        
        ActionSheetStringPicker.showPickerWithTitle("Select a title", rows: ["Mr.", "Ms.", "Mrs."], initialSelection: 0, doneBlock: { (picker:ActionSheetStringPicker!, index:Int, value:AnyObject!) in
            
            self.btnTitle.setTitle(value as? String, forState: .Normal)
            
            }, cancelBlock: { (picker:ActionSheetStringPicker!) in
                
                
            }, origin: btnTitle)

    }
    
    @IBAction func btnAreaTapped() {
        
        if self.areas.count > 0 {
            ActionSheetStringPicker.showPickerWithTitle("Select area", rows: self.areas, initialSelection: 0, doneBlock: { (picker:ActionSheetStringPicker!, index:Int, value:AnyObject!) in
                
                self.btnArea.setTitle(value as? String, forState: .Normal)
                
                }, cancelBlock: { (picker:ActionSheetStringPicker!) in
                    
                    
                }, origin: btnArea)
        }
    }
    

    //MARK : Overridden Methods
    override func navBarConfig() -> SVNavBarConfig {
        return SVNavBarConfig(showBack: true, showSearch: true, showCart: true, title: "My Profile")
    }
    
    
    //MARK : View Controller Life cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAreas()
        SVXMLAppService.fetchUserProfile { (details:NSObject?, error:NSError?) in
            
            if let _ = details {
                
                let details = details as? SVUserDetails;
                
                SVUtil.saveUserDetails(details!)
                
                self.prepareUIWithProfile()
            }
            
        }
        prepareUIWithProfile()
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
    
    //MARK: Text Field Delegate Methods
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if textField === txtPhoneNumber{
            
            if string.characters.count + (textField.text?.characters.count)! <= 8 {
                return true
            }
            else {
                return false
            }
        }
        
        return true
    }
    
    //MARK: Private Methods
    
    private func fetchAreas() {
        
        SVXMLAppService.fetchAreas { (response:NSObject?, error:NSError?)->Void in
            
            if let _ = response {
                
                let areas = response as? SVAreas;
                
                for area:SVArea in (areas?.areas)! {
                    
                    self.areas.append(area.areaText!)
                }
            }
        }
    }

    private func prepareUIWithProfile() {
        
        if let user = SVUtil.getUserDetails(){

            
            txtPhoneNumber.text = user.phoneNumber
            lblFirstName.text = user.firstName
            lblLastName.text = user.lastName
            lblEmail.text = user.email
            btnArea.setTitle(user.area, forState: .Normal)
            btnTitle.setTitle(user.title, forState: .Normal)
            
            
        }
    }


}

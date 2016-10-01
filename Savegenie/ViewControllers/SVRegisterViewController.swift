//
//  SVRegisterViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/18/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class SVRegisterViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, SVRegisterCellDelegate {
    
    var areas:SVAreas?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchAreas()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if self.view.frame.size.height >= 568 {
            
            self.tableView.contentOffset = CGPointMake(0, 25)
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: Table View datasource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 650
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableCell:SVRegisterCell = (tableView.dequeueReusableCellWithIdentifier(String(SVRegisterCell)) as? SVRegisterCell)!
        
       
        tableCell.delegate=self
        
        return tableCell
    }
    
    //MARK: SVRegister Cell delegate Methods
    func didTapLogIn(sender: SVRegisterCell) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func didTapSelectArea(sender:SVRegisterCell) {
        
        if let _ = self.areas {
            ActionSheetStringPicker.showPickerWithTitle("Select area", rows: self.areas?.displayTexts(), initialSelection: 0, doneBlock: { (picker:ActionSheetStringPicker!, index:Int, value:AnyObject!) in
                
                sender.txtSelectArea.text = value as? String
                
                }, cancelBlock: { (picker:ActionSheetStringPicker!) in
                    
                    
                }, origin: sender)
        }
        
    }
    
    func didTapTitle(sender:SVRegisterCell) {

        
        ActionSheetStringPicker.showPickerWithTitle("Select a title", rows: ["Mr.", "Ms.", "Mrs."], initialSelection: 0, doneBlock: { (picker:ActionSheetStringPicker!, index:Int, value:AnyObject!) in
            
            sender.txtTitle.text = value as? String
            
            }, cancelBlock: { (picker:ActionSheetStringPicker!) in
                
                
        }, origin: sender)
    }
    
    func didTapStartShopping(sender:SVRegisterCell) {
        
        let validationData:(Bool, String) = sender.validateForm()
        if validationData.0 == true {
            
            SVUtil.showLoader()
            var params = Dictionary<String, AnyObject>()
            
            params["data[User][area_id]"] = self.areas?.areaIdForText(sender.txtSelectArea.text!)
            params["data[User][title]"] = sender.txtTitle.text!
            params["data[User][first_name]"] = sender.txtFirstName.text!
            params["data[User][last_name]"] = sender.txtLastName.text!
            params["data[User][email]"] = sender.txtEmail.text!
            params["data[User][password]"] = sender.txtPassword.text!
            params["data[User][cpassword]"] = sender.txtRetypePassword.text!
            params["data[UserDetail][cellphone]"] = sender.txtPhoneNumber.text!
            
            SVJSONAppService.register(
                params, responsObjectKey: "", completionHandler: { (response:SVUserDetails?, error:NSError?) in
                
                    SVUtil.hideLoader()
                    if let _ = response {
                        
                    }
                
            })
        }
        else {
            SVUtil.showAlert(SVConstants.APP_NAME, message: validationData.1, controller: self)
        }
    }
    
    //MARK: Private Methods
    private func fetchAreas() {

        SVXMLAppService.fetchAreas { (response:NSObject?, error:NSError?)->Void in
            
            if let _ = response {
                
                self.areas = response as? SVAreas
                
            }
        }
    }
    
    
    
}

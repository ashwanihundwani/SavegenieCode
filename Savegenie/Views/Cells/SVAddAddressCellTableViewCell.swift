//
//  SVAddAddressCellTableViewCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 8/6/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class SVAddAddressCellTableViewCell: UITableViewCell {
    
    var shippingAddress:SVAddShippingAddress? = nil
    
    @IBOutlet weak var txtName:UITextField!
    @IBOutlet weak var txtAddress:UITextField!
    @IBOutlet weak var txtStreet:UITextField!
    @IBOutlet weak var txtLandmark:UITextField!
    @IBOutlet weak var txtMobile:UITextField!
    @IBOutlet weak var txtSelectArea: UITextField!

    
    //MARK: Button Actions
    
    @IBAction func btnSelectAreaTapped(sender: AnyObject) {
        
        if let _ = shippingAddress {
            
            if shippingAddress!.areas?.areas.count > 0 {
                ActionSheetStringPicker.showPickerWithTitle("Select area", rows: shippingAddress!.areas!.displayTexts(), initialSelection: 0, doneBlock: { (picker:ActionSheetStringPicker!, index:Int, value:AnyObject!) in
                    
                    self.txtSelectArea.text = value as? String
                    
                    }, cancelBlock: { (picker:ActionSheetStringPicker!) in
                        
                        
                    }, origin: sender)
            }
        }
    }
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Public Methods
    
    internal func setAddress(address:SVAddShippingAddress) {
        
        shippingAddress = address
        self.txtSelectArea.text = address.areas?.areas.first?.areaText
        self.txtMobile.text = address.mobileNumber
        
    }
    
    internal func validateForm()-> (Bool,String) {
        
        
        // firstly checking for blank fields.
        guard self.txtName.text?.characters.count > 0
            
            else {
                return (false, "Please enter your name")
        }
        guard self.txtAddress.text?.characters.count > 0
            
            else {
                return (false, "Please enter Address")
        }
        
        guard self.txtSelectArea.text != "Select Area"
            
            else {
                return (false, "Please select Area")
        }
        
        
        guard self.txtStreet.text?.characters.count > 0
            
            else {
                return (false, "Please enter Street")
        }
        
        guard self.txtMobile.text?.characters.count > 0
            
            else {
                return (false, "Please enter your mobile number")
        }

        
        
        // finally return true if all inputs are valid
        return (true, "")
        
    }
    
    
    
}

//
//  SVRegisterCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/18/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

protocol SVRegisterCellDelegate : class{
    
    func didTapLogIn(sender:SVRegisterCell)
    
    func didTapSelectArea(sender:SVRegisterCell)
    
    func didTapTitle(sender:SVRegisterCell)
    
    func didTapStartShopping(sender:SVRegisterCell)
}

class SVRegisterCell: UITableViewCell, UITextFieldDelegate, UIWebViewDelegate {

    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var txtFirstName: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtSelectArea: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtRetypePassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var webView:UIWebView!
    
    weak var delegate:SVRegisterCellDelegate? = nil
    
    
    //MARK: Button Actions
    
    @IBAction func btnSelectAreaTapped(sender: AnyObject) {
        
        if let tempDelegate = delegate {
            
            tempDelegate.didTapSelectArea(self)
        }
        
    }
    @IBAction func btnShoppingTapped(sender: AnyObject) {
        
        if let tempDelegate = delegate {
            
            tempDelegate.didTapStartShopping(self)
        }
    }
    @IBAction func btnLoginTapped(sender: AnyObject) {
        
        if let tempDelegate = delegate {
            
            tempDelegate.didTapLogIn(self)
        }
    }
    
    @IBAction func btnTitleTapped(sender: AnyObject) {
        
        if let tempDelegate = delegate {
            
            tempDelegate.didTapTitle(self)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.txtSelectArea.text = "Gurgaon"
        //self.txtTitle.text = "Mr."
        // Initialization code
        
        self.webView.loadHTMLString("<html><body link=\"4EB6AC\"><center><span style=\"color:#FFFFFF\">By clicking \"Start Shopping\" you are accepting</span> <a href=\"http://savegenie.mu//pages/termsOfUse\"><span style=\"font-size:12px;color:#4EB6AC\">Terms & Conditions</span></a><span style=\"color:#FFFFFF\"> and </span><a href=\"http://savegenie.mu//pages/privacyPolicy\"><span style=\"font-size:12px;color:#4EB6AC\">Privacy Policy</span></a></center></body></html>", baseURL: nil)
        
        //self.tnCWebView.scrollView.contentOffset = CGPointMake(0, -20)
        self.webView.scrollView.scrollEnabled = false
        self.webView.scrollView.showsVerticalScrollIndicator = false
        self.webView.scrollView.showsHorizontalScrollIndicator = false
        self.webView.delegate = self
        
    }
    
    //MARK: Private Methods
    
    func validateForm()-> (Bool,String) {
        
        
        // firstly checking for blank fields.
        guard txtTitle.text?.characters.count > 0
            && txtEmail.text?.characters.count > 0
            && txtPassword.text?.characters.count > 0
            && txtRetypePassword.text?.characters.count > 0
            && txtFirstName.text?.characters.count > 0
            && txtLastName.text?.characters.count > 0
            && txtSelectArea.text?.characters.count > 0
            
            else {
            return (false, "Please enter all the details")
        }
        
        // checking for valid email id
        guard SVUtil.isValidEmail(txtEmail.text!) else {
            
            return (false, SVConstants.EMAIL_VALIDATION_MESSAGE)
        }
        
        // checking whether both Password & Retyped Password are same
        guard txtPassword.text == txtRetypePassword.text else {
            
            return (false, "Password & Confirm password must be same")
        }

        
        // finally return true if all inputs are valid
        return (true, "")
        
    }
    
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
    
    //MARK: WebView Delegate Methods
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if request.URLString.containsString("termsOfUse") {
            
            SVUtil.openURL((request.URL?.URLString)!)
            
            return false
        }
        else if request.URLString.containsString("privacyPolicy") {
            
            SVUtil.openURL((request.URL?.URLString)!)
            
            return false
        }
        
        return true
    }

}

 //
//  SVLoginViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/18/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVLoginViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    //MARK: Button Actions
    
    @IBAction func btnLoginTapped()
    {
//        let drawerController = SVUtil.getVCWithIdentifier("KYDrawerController")
//        
//        SVUtil.appWindow().rootViewController = drawerController
//        
//        return
        // Validate credentials before making a call to server
        if self.areCredentialsValid() {
            
            
            SVUtil.showLoader()
            SVJSONAppService.login(self.txtEmail.text!, password: self.txtPassword.text!, responsObjectKey: "", completionHandler: { (response:SVUserDetails?, error:NSError?) in
                
                if let _ = response  {
                
                    if response?.result == "1" {
                    
                        SVUtil.saveUserDetails(response!)
                        
                        self.fetchCartInfo()
                    }
                    else {
                        
                        SVUtil.hideLoader()
                        SVUtil.showAlert(SVConstants.APP_NAME, message: "Invalid Username or Password", controller: self)
                    }
                    
                }
                else {
                    
                    SVUtil.hideLoader()
                    SVUtil.showAlert(SVConstants.APP_NAME, message: SVConstants.CONNECTION_ERROR_MESSAGE, controller: self)
                }
            })
            
            
        }
    }
    
    @IBAction func btnSignUpTapped()
    {
        let signUpController = SVUtil.getVCWithIdentifier("SVRegisterViewController") as! SVRegisterViewController
        
        self.navigationController?.pushViewController(signUpController, animated: true)
    }
    
    @IBAction func btnForgotPasswordTapped()
    {
        let forgotPasswordController = SVUtil.getVCWithIdentifier("SVForgotPasswordViewController") as! SVForgotPasswordViewController
        
        self.navigationController?.pushViewController(forgotPasswordController, animated: true)
    }
    
    
    //MARK: ViewController Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    //MARK: Private Methods
    
    private func fetchCartInfo()
    {
        SVTextAppService.selectCart { (obj:AnyObject?, error:NSError?) in
            
            SVXMLAppService.fetchCartInfo { (cartInfo:NSObject?, error:NSError?) in
                
                let cartInfo = cartInfo as? SVCartInfo
                
                SVUtil.saveCustomObject(SVConstants.CART_INFO_KEY, object: cartInfo)
                
                SVTextAppService.fetchBadgeCount(completionHandler: { (count:AnyObject?, error:NSError?) in
                    
                    let badgeCount = count as? String
                    
                    let cartInfo:SVCartInfo = (SVUtil.getCustomObject(SVConstants.CART_INFO_KEY) as? SVCartInfo)!
                    
                    cartInfo.count = badgeCount
                    
                    SVUtil.saveCustomObject(SVConstants.CART_INFO_KEY, object: cartInfo)
                    
                    SVUtil.hideLoader()
                    
                    let drawerController = SVUtil.getVCWithIdentifier("KYDrawerController")
                    
                    SVUtil.appWindow().rootViewController = drawerController
                    
                    return
                })
                
                
            }
            
        }
    }
    private func areCredentialsValid()->Bool {
        
        if(txtEmail.text == "")
        {
            SVUtil.showAlert(SVConstants.APP_NAME, message: SVConstants.EMAIL_BLANK_VALIDATION_MESSAGE, controller: self)
            
            return false
        }
        
        if(txtPassword.text == "")
        {
            SVUtil.showAlert(SVConstants.APP_NAME, message: SVConstants.PASSWORD_BLANK_VALIDATION_MESSAGE, controller: self)
            
            return false
        }
        
        if SVUtil.isValidEmail(txtEmail.text!) == false {
            
            SVUtil.showAlert(SVConstants.APP_NAME, message: SVConstants.EMAIL_VALIDATION_MESSAGE, controller: self)
            
            return false

        }
        
        return true
    }
}

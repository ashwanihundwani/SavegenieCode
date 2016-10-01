//
//  SVForgotPasswordViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/18/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVForgotPasswordViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var btnSendInstruction: UIButton!
    
    @IBOutlet weak var btnSignIn: UIButton!
    
    //MARK: Button Actions
    @IBAction func btnSendInstructionTapped()
    {
        if SVUtil.isValidEmail(txtEmail.text!) {
            //TODO - implement send instructions
        }
        else {
            
            // show alert for invalid email.
            SVUtil.showAlert(SVConstants.APP_NAME, message: SVConstants.EMAIL_VALIDATION_MESSAGE, controller: self)
        }
    }
    
    @IBAction func btnSignInTapped()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: ViewController Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
}

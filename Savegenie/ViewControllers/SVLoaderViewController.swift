//
//  SVLoaderViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/30/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import Zip
import Alamofire

class SVLoaderViewController: UIViewController {
    
    @IBOutlet weak var pager:UIPageControl!
    var loadingZipData = false
    
    //MARK : Private Methods
    
    internal func showLoginController() {
        
        let controller:UINavigationController = UINavigationController(rootViewController: SVUtil.getVCWithIdentifier("SVLoginViewController"))
        
        SVUtil.appWindow().rootViewController = controller
    }
    
    private func executeLoadingFlow() {
        
        if SVUtil.validDataAvailable() {
            
            self.checkAndPerformLogin()
        }
        else {
            
            SVDownloadService.downloadDataZip(completionHandler: { (filePath:String?, error:NSError?) in
                
                
                if let _ = filePath {
                    
                    let url:NSURL = NSURL(string:filePath!)!
                    
                    SVUtil.unZip(url, completionHandler: { (success:Bool) in
                        
                        SVDataImportManager.importData(completionHandler: { (success:Bool) in
                            
                            if success == true {
                                
                                SVUtil.setIsDataAvailable(true)
                                self.checkAndPerformLogin()
                            }
                            
                        })
                        
                    })
                    
                    
                }
                else {
                    SVUtil.showAlert(SVConstants.APP_NAME, message: "Error in loading data. Please retry.", controller: self, actionHandler: { (action:UIAlertAction) in
                        
                        self.executeLoadingFlow()
                    })
                }
            })

            
            
        }

    
    }
    
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
                    
                    let drawerController = SVUtil.getVCWithIdentifier("KYDrawerController")
                    
                    SVUtil.appWindow().rootViewController = drawerController
                    
                    return
                })
                
                
            }
        }
        
    }
    
    private func performLogin() {
        if let userDetails = SVUtil.getUserDetails() {
            SVJSONAppService.login(userDetails.email, password: userDetails.password, responsObjectKey: "", completionHandler: { (details:SVUserDetails?, error:NSError?) in
                
                var loginSuccessful:Bool = false
                if let tempDetails = details {
                    
                    if tempDetails.result == "1" {
                        
                        SVUtil.saveUserDetails(tempDetails)
                        self.fetchCartInfo()
                        
                        loginSuccessful = true
                    }
                    
                }
                
                if loginSuccessful == false {
                    
                    self.performSelector(#selector(self.showLoginController), withObject: nil, afterDelay: 3.5)
                }
            })
        }
    }
    
    private func checkAndPerformLogin() {
        if let _ = SVUtil.getUserDetails() {
            self.performLogin()
        }
        else {
            
            self.performSelector(#selector(self.showLoginController), withObject: nil, afterDelay: 3.5)
            
        }
    }
    
    internal func updatePage() {
        
        let currentPage:Int = pager.currentPage;
        
        pager.currentPage = currentPage < pager.numberOfPages - 1 ? (currentPage + 1) : 0
        self.performSelector(#selector(self.updatePage), withObject: nil, afterDelay: 0.2)
        
    }

    //MARK : View Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO - need to remove
//        let drawerController = SVUtil.getVCWithIdentifier("KYDrawerController")
//        
//        SVUtil.appWindow().rootViewController = drawerController
//        
//        return

        self.performSelector(#selector(self.updatePage), withObject: nil, afterDelay: 0.5)
        
       executeLoadingFlow()
        
        
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

}

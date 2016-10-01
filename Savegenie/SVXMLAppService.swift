//
//  SVXMLAppService.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/28/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import Alamofire

class SVXMLAppService: NSObject {
 
    //MARK: Private Methods
    static private func handleResponse(url:String, response : Response<String, NSError>, competionHandler handler : (NSObject?, NSError?) -> Void )
    {
        
        
        if response.result.isSuccess
        {
            let result:String = response.result.value!
            print(result)
            
            if let xmlString:String = response.result.value {
                
                print(xmlString);
                
                let object = XMLParser.parserXML(xmlString, URL: url)
                handler(object, nil)
            }
            else {
                print("error")
            }
        }
        else
        {
            handler(nil, response.result.error);
        }
    }
    
    static private func get(URL : String!, params : Dictionary<String, AnyObject!>?, completionHandler handler:(NSObject?, NSError?) -> Void){
        
        Alamofire.request(.GET, URL, parameters: params, encoding: .URL, headers: nil).responseString { (response:Response<String, NSError>) in
            
            SVXMLAppService.handleResponse(URL, response: response, competionHandler: handler)
            
            
        }
    }
    
    static private func post(URL : String!, params : Dictionary<String, AnyObject!>, completionHandler handler:(NSObject?, NSError?) -> Void){
        
        Alamofire.request(.POST, URL, parameters: params, encoding: .URL, headers: nil).responseString { (response:Response<String, NSError>) in
            
            SVXMLAppService.handleResponse(URL, response: response, competionHandler: handler)
            
            
        }
    }
    
    //MARK: Public Methods
    
    static internal func fetchAreas(completionHandler handler: (NSObject? , NSError?) -> Void){
        
        let URL = SVConstants.AREAS_URL
    
        SVXMLAppService.get(URL, params: nil, completionHandler: handler)
    
    }
    
    static internal func fetchUserProfile(completionHandler handler: (NSObject? , NSError?) -> Void){
        
        let URL = SVConstants.MY_PROFILE_URL
        
        SVXMLAppService.get(URL, params: nil, completionHandler: handler)
        
    }
    
    static internal func fetchCartInfo(completionHandler handler: (NSObject? , NSError?) -> Void){
        
        let URL = SVConstants.CART_INFO
        
        let params:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        
        self.post(URL, params: params, completionHandler: handler);
        
    }
    
    static internal func saveAddress(params : Dictionary<String, AnyObject!>, completionHandler handler: (NSObject? , NSError?) -> Void){
        
        let URL = SVConstants.SAVE_ADDRESS
        
        self.post(URL, params: params, completionHandler: handler);
        
    }



}

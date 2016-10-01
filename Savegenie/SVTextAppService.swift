//
//  SVTextAppService.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/10/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import Alamofire

class SVTextAppService: NSObject {

    //MARK: Private Methods
    
    static private func handleResponse(url:String, response : Response<String, NSError>, competionHandler handler : (NSObject?, NSError?) -> Void )
    {
        
        
        if response.result.isSuccess
        {
            let result:String = response.result.value!
            print(result)
            
            handler(result, nil)
        }
        else
        {
            handler(nil, response.result.error);
        }
    }
    
    static private func requestHeaders()->Dictionary<String, String>
    {
        var headers:Dictionary<String,String> = Dictionary<String,String>();
        
        headers["Content-Type"] = "application/x-www-form-urlencoded"
        
        return headers
    }
    
    static private func get(URL : String!, params : Dictionary<String, AnyObject!>?, completionHandler handler:(AnyObject?, NSError?) -> Void){
        
        Alamofire.request(.GET, URL, parameters: params, encoding: .URL, headers: requestHeaders()).responseString { (response:Response<String, NSError>) in
            
            SVTextAppService.handleResponse(URL, response: response, competionHandler: handler)
        }
    }
    
    static private func post(URL : String!, params : Dictionary<String, AnyObject!>?, completionHandler handler:(AnyObject?, NSError?) -> Void){
        
        Alamofire.request(.POST, URL, parameters: params, encoding: .URL, headers: requestHeaders()).responseString { (response:Response<String, NSError>) in
            
            SVTextAppService.handleResponse(URL, response: response, competionHandler: handler)
            
            
        }
    }

    
    static internal func getFavProducts(completionHandler handler: (AnyObject? , NSError?) -> Void){
        
        let URL = SVConstants.FAV_PRODUCTS_URL
        
        var params:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        
        params["minval"] = "0"
        self.post(URL, params: params, completionHandler: handler);
        
    }
    
    static internal func selectCart(completionHandler handler: (AnyObject? , NSError?) -> Void){
        
        let URL = SVConstants.SELECT_CART_URL
    
        self.get(URL, params: nil, completionHandler: handler);
        
    }
    
    static internal func fetchBadgeCount(completionHandler handler: (AnyObject? , NSError?) -> Void){
        
        let URL = SVConstants.CART_BADGE_COUNT
        
        let params:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        
        self.post(URL, params: params, completionHandler: handler);
        
    }
    
    static func selectShippingAddress(params:Dictionary<String, AnyObject>?,completionHandler handler: (AnyObject? , NSError?) -> Void){
        
        let URL = SVConstants.SELECT_ADDRESS
        
        self.post(URL, params: params, completionHandler: handler);
        
    }
}

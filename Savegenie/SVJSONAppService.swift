//
//  SVJSONAppService.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/26/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper
import Alamofire

/**
 This class uses Alamofire & AlamoFire Object Mapper to deal with JSOn based API responses
 */
class SVJSONAppService: NSObject {
    
    static private func handleResponse<T:Mappable>(response : Response<T, NSError>, competionHandler handler : (T?, NSError?) -> Void )
    {
        
        let result:Result = response.result
        let datastring = NSString(data: response.data!, encoding: NSUTF8StringEncoding)
        print(datastring)
        if result.isSuccess
        {
            if let parsedObject:T = response.result.value{
                
                print(parsedObject);
                handler(parsedObject,nil)
            }
            else {
                print("error")
            }
        }
        else
        {
            handler(nil, result.error);
        }
    }
    
    static private func requestHeaders()->Dictionary<String, String>
    {
        var headers:Dictionary<String,String> = Dictionary<String,String>();
        
        headers["Content-Type"] = "application/x-www-form-urlencoded"
        
        return headers
    }
    
    static private func get<T:Mappable>(URL : String!, params : Dictionary<String, AnyObject!>?, responseObjectKey : String!, completionHandler handler:(T?, NSError?) -> Void){
        
        
        
        Alamofire.request(.GET, URL, parameters: params, encoding: .URL, headers: SVJSONAppService.requestHeaders()).responseObject(responseObjectKey) { (response: Response<T, NSError>) in
            
            self.handleResponse(response, competionHandler: handler)
        }
        
        
    }
    
    static private func post<T:Mappable>(URL : String!, params : Dictionary<String, AnyObject!>, responseObjectKey : String!, completionHandler handler:(T?, NSError?) -> Void){
        
        Alamofire.request(.POST, URL, parameters: params, headers: SVJSONAppService.requestHeaders()).responseObject(responseObjectKey) { (response: Response<T, NSError>) in
            
            print("In post API response callback")
            print(response.data)
            print(response.result)
            self.handleResponse(response, competionHandler: handler)
        }
    }
    
    static private func post<T:Mappable>(URL : String!, params : Array<(key:String, value:AnyObject)>?, responseObjectKey : String!, completionHandler handler:(T?, NSError?) -> Void){
        
        Alamofire.request(.POST, URL, parameters: params, headers: SVJSONAppService.requestHeaders()).responseObject(responseObjectKey) { (response: Response<T, NSError>) in
            
            print("In post API response callback")
            print(response.data)
            print(response.result)
            self.handleResponse(response, competionHandler: handler)
        }
    }
    
    //internal methods
    
    static internal func login(username : String!, password : String!, responsObjectKey: String!, completionHandler handler: (SVUserDetails? , NSError?) -> Void){
        
        let URL = SVConstants.LOGIN_URL
        
        var params:Dictionary<String,AnyObject!> = Dictionary<String,AnyObject!>();
        
        params["data[User][email]"] = username
        params["data[User][password]"] = password
        params["data[User][gcmid]"] = ""
        params["data[User][device_id]"] = "000000000000000"
    
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    static internal func register(params : Dictionary<String, AnyObject>, responsObjectKey: String!, completionHandler handler: (SVUserDetails? , NSError?) -> Void){
        
        let URL = SVConstants.REGISTER_URL
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    static internal func fetchCart(params : Dictionary<String, AnyObject>, responsObjectKey: String!, completionHandler handler: (SVCart? , NSError?) -> Void){
        
        let URL = SVConstants.CART_URL
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    static func updateCart(params : Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVUpdateCartResult? , NSError?) -> Void){
        
        let URL = SVConstants.UPDATE_CART_URL
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    static func deleteItemFromCart(params : Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVUpdateCartResult? , NSError?) -> Void){
        
        let URL = SVConstants.DELETE_CART_ITEM_URL
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    static func fetchOrderDetails(params : Dictionary<String, AnyObject>, responsObjectKey: String!, completionHandler handler: (SVReviewOrderDetails? , NSError?) -> Void){
        
        let URL = SVConstants.ORDER_DETAIL_URL
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    static func fetchShippingAddresses(responsObjectKey: String!, completionHandler handler: (SVShippingAddresses? , NSError?) -> Void){
        
        let URL = SVConstants.USER_ADDRESSES
        
        self.get(URL, params: nil, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    static func applyCoupon(params:Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVApplyCouponResponse? , NSError?) -> Void){
        
        let URL = SVConstants.APPLY_COUPON
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    
    static func fetchDeliverySlot(params:Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVDeliverySlot? , NSError?) -> Void){
        
        let URL = SVConstants.SELECT_DELIVERY_SLOT
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    static func fetchThreeHoursDelivery(params:Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVThreeHoursResponse? , NSError?) -> Void){
        
        let URL = SVConstants.SELECT_DELIVERY_SLOT
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    static func fetchReferralDetails(params:Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVReferralDetails? , NSError?) -> Void){
        
        let URL = SVConstants.REFERRAL_DETAILS
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }

    static func fetchMyOrders(params:Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVPlacedOrdersDetails? , NSError?) -> Void){
        
        let URL = SVConstants.MY_ORDER_URL
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    static func fetchOrderInfoById(params:Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVPlacedOrder? , NSError?) -> Void){
        
        let URL = SVConstants.ORDER_INFO_BY_ID
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    static func fetchMyList(params:Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVMyLists? , NSError?) -> Void){
        
        let URL = SVConstants.MY_LIST
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }

    static func chooseList(params:Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVCart? , NSError?) -> Void){
        
        let URL = SVConstants.CHOOSE_LIST
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    static func enterShippingAddress(params:Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVAddShippingAddress? , NSError?) -> Void){
        
        let URL = SVConstants.ENTER_SHIPPING_ADDRESS
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    static func fetchDeals(params:Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVDeals? , NSError?) -> Void){
    
        
        let URL = SVConstants.GET_DEALS
        
        //URL = "http://localhost/Savegenie/Deals.json"
    
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
    
    }
    
    static func fetchBanners(params:Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVBanners? , NSError?) -> Void){
        
        
        let URL = SVConstants.GET_BANNERS
        
        //URL = "http://localhost/Savegenie/Deals.json"
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    static func fetchShopCategories(params:Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVShopCategories? , NSError?) -> Void){
        
        
        let URL = SVConstants.SHOP_CATEGORIES
        
        //URL = "http://localhost/Savegenie/Deals.json"
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    static func fetchStores(params:Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVStores? , NSError?) -> Void){
        
        
        let URL = SVConstants.GET_STORES
        
        //URL = "http://localhost/Savegenie/Deals.json"
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    static func fetchMasterCategories(params:Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVMasterCategories? , NSError?) -> Void){
        
        
        let URL = SVConstants.MASTER_CATEGORY_STORE
        
        //URL = "http://localhost/Savegenie/Deals.json"
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    static func changeArea(params:Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVChangeAddressResponse? , NSError?) -> Void){
        
        let URL = SVConstants.CHANGE_AREA
        
        //URL = "http://localhost/Savegenie/Deals.json"
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    static func fetchCommonSlot(params:Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVCommonSlot? , NSError?) -> Void){
        
        let URL = SVConstants.COMMON_SLOT
        
        //URL = "http://localhost/Savegenie/Deals.json"
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    static func fetchPromos(params:Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVDeals? , NSError?) -> Void){
        
        let URL = SVConstants.PROMOS
        
        //URL = "http://localhost/Savegenie/Deals.json"
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
    
    static func fetchSponsoredProducts(params:Array<(key:String, value:AnyObject)>, responsObjectKey: String!, completionHandler handler: (SVCommonSlot? , NSError?) -> Void){
        
        let URL = SVConstants.SPONSORED_PRODUCTS
        
        //URL = "http://localhost/Savegenie/Deals.json"
        
        self.post(URL, params: params, responseObjectKey: responsObjectKey, completionHandler: handler);
        
    }
}

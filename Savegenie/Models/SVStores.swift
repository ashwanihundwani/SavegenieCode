//
//  SVStores.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 01/09/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper



class SVStore: NSObject, Mappable, ISVStore {
    static var currentStoreInstance:SVStore? = nil;
    var identifier:String?
    var name:String?
    var image:String?
    var mos:String?
    var storeRating:String?
    var slot:String?
    var date:String?
    
    static func getCurrentStore() -> SVStore? {
        
        return currentStoreInstance
    }
    
    static func setCurrentStore(store:SVStore) {
        
        currentStoreInstance = store
    }
    
    required init?(_ map: Map) {
        
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        identifier <- map["id"]
        name <- map["name"]
        mos <- map["mos"]
        storeRating <- map["rating"]
        slot <- map["slot"]
        date <- map["date"]
        image <- map["image"]

    }
    
    //MARK: ISVStore protocol implementation
    var storeImageURL:String {
        
        get{
            return self.image!
        }
    }
    var storeName:String {
        get{
            
            return self.name!
        }
    }
    
    var freeDeliveryText:String {
        get{
            
            return self.mos!
        }
    }
    
    var rating:Int {
        get{
            
            return Int(self.storeRating!)!
        }
    }
    var deliveryTime:String {
        get{
            
            return self.slot!
        }
    }
}


class SVStores: NSObject, Mappable {

    var stores:Array<SVStore>? = Array<SVStore>()

    
    required init?(_ map: Map) {
        
        
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        stores <- map["response"]
    }
    
    //MARK: ISVBanner protocol implementation
//    var bannerImageURL: String {
//        
//        get {
//            
//            return bannerImage!
//        }
//    }
}

//
//  SVCart.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/11/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

class SVCartProduct : NSObject, Mappable {
    
    var skuID:String? = nil
    var skuName:String? = nil
    var cartID:String? = nil
    var count:String? = nil
    var mrp:String? = nil
    var status:String? = nil
    
    required init?(_ map: Map) {
        
        
    }

    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
    
        skuID <- map["productskuid"]
        skuName <- map["productskuname"]
        cartID <- map["cartid"]
        count <- map["count"]
        mrp <- map["mrp"]
        status <- map["status"]
    }
    
}

class SVCart: NSObject, Mappable {
    
    var products:Array<SVCartProduct> = Array<SVCartProduct>()
    var result:String?
    var cartName:String?
    var count:String?
    
    required init?(_ map: Map) {
        
    }

    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        products <- map["response.listitem"]
        result <- map["response.result"]
        cartName <- map["response.cartname"]
        count <- map["response.countitems"]
       
    }

}

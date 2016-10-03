//
//  SVStorePromos.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 02/10/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

class SVStorePromos : NSObject, Mappable {
    
    var promos:Array<SVStorePromo>?
    required init?(_ map: Map) {
        
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
 
        promos <- map["coupon"]
    }
    
}

class SVStorePromo: NSObject, Mappable {
    
    var identifier:String?
    var getProductIds:Array<String>?
    var buyProductIds:Array<String>?
    
    
    required init?(_ map: Map) {
        
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        identifier <- map["id"]
        let buyIds:String? = map["buy_product_sku"].currentValue as? String
        let productIds:String? = map["get_product_sku"].currentValue as? String
        
        buyProductIds = buyIds?.componentsSeparatedByString(",")
        getProductIds = productIds?.componentsSeparatedByString(",")
        
        
    }


}

//
//  SVApplyCouponResponse.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/24/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

class SVApplyCouponResponse: NSObject, Mappable {
    
    var message:String? = nil
    var netPrice:String? = nil
    var couponPrice:String? = nil
    
    required init?(_ map: Map) {
        
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
    
        message <- map["response.0.message"]
        netPrice <- map["response.0.netprice"]
        couponPrice <- map["response.0.couponprice"]
        
    }
    
}

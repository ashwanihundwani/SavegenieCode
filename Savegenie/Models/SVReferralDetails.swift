//
//  SVReferralDetails.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 8/2/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

class SVReferralDetails: NSObject, Mappable {
    
    var referralCode:String? = nil
    var referralAmount:String? = nil
    
    required init?(_ map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        
        referralCode <- map["order.coupon"]
        referralAmount <- map["order.amount"]
        
    }

}

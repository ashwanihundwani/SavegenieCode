//
//  SVPlacedOrder.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 8/4/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

class SVPlacedOrder: NSObject, Mappable {
    
    var discount:String? = nil
    var storePrice:String? = nil
    var couponPrice:String? = nil
    var deliveryDate:String? = nil
    var deliveryTime:String? = nil
    var netPrice:String? = nil
    var deliveryFee:String? = nil
    var address:String? = nil
    var orderItems:Array<SVReviewOrderItem>? = nil
    var displayItems:Array<(key:String, value:String)> = Array<(key:String, value:String)>()
    
    required init?(_ map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        
        storePrice <- map["order.price"]
        displayItems.append(("Store Price", "Rs " + storePrice!))
        
        discount <- map["order.DealDiscPrice"]
        displayItems.append(("Deal Discount", "Rs " + discount!))
        
        
        couponPrice <- map["order.CouponPrice"]
        displayItems.append(("Coupon /Referral", "Rs " + couponPrice!))
        
        deliveryFee <- map["order.delprice"]
        displayItems.append(("Delivery Fee", "Rs " +  deliveryFee!))
        
        netPrice <- map["order.tolalRupesOrder"]
        displayItems.append(("Net Amount", "Rs " + netPrice!))
        
        deliveryDate <- map["order.deliveryDate"]
        displayItems.append(("Delivery Date", deliveryDate!))
        
        
        deliveryTime <- map["order.Time"]
        displayItems.append(("Delivery Time", deliveryTime!))
        
        address <- map["order.Address"]
        displayItems.append(("Delivery Address", address!))
        
        orderItems <- map["allitem"]
    }

}

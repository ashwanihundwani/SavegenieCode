//
//  SVReviewOrderDetails.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/21/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

enum ReviewOrderType : Int {
    
    case Deal
    case DealProduct
    case Product
}

class SVOrderDetails:NSObject {
    
    var priceAtMrp:String? = nil
    var priceAfterDeal:String? = nil
    var identifier:String? = nil
    var storeIdentifier:String? = nil
    var referralBonus:String? = nil
    
}

class SVReviewOrderItem : NSObject, Mappable {
    
    var productSkuName:String? = nil
    var productSKUId:String? = nil
    var quantity:String? = nil
    var image:String? = nil
    var storeSKU:String? = nil
    var fulfillCount:String? = nil
    var price:String? = nil
    var mrp:String? = nil
    var deal:String? = nil
    var total:String? = nil
    var isDeal:String? = nil
    
    required init?(_ map: Map) {
        
        
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        productSkuName <- map["productSkuName"]
        quantity <- map["quantity"]
        productSKUId <- map["product_sku_id"]
        image <- map["image"]
        storeSKU <- map["storesku"]
        fulfillCount <- map["fulfill_count"]
        price <- map["price"]
        mrp <- map["mrp"]
        deal <- map["deal"]
        total <- map["total"]
        isDeal <- map["isdeal"]
    }
    
    //MARK : Public Methods
    internal func getViewType() -> ReviewOrderType{
        
        if self.productSkuName == "Deal Price" {
            return .Deal
        }
        else if self.deal == "nodeal" {
            return .Product
        }
        else {
            return .DealProduct
        }
    }
    
}

class SVReviewOrderDetails: NSObject, Mappable {
    
    var deliveryCharges:String? = nil
    var storePrice:String? = nil
    var netPrice:String? = nil
    var dealDiscount:String? = nil
    var orderDetails:SVOrderDetails? = nil
    var orderItems:Array<SVReviewOrderItem>? = nil
    
    required init?(_ map: Map) {
        
        /*
        productSkuName: "Stewards Lazzat Safran Powder 300 gm",
        product_sku_id: "1993",
        image: "No-Brand-Safran-Powder-300-Gm.png",
        storesku: "6789",
        quantity: "1",
        fulfill_count: "1",
        price: "45",
        mrp: "50",
        deal: "nodeal",
        total: "45",
        isdeal: "nodeal"
        */
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        var response:Array<Dictionary<String, AnyObject>>? = nil
        map["response"]
        
        response = (map.currentValue as? Array<Dictionary<String, AnyObject>>)!
        self.orderDetails = SVOrderDetails()
        
        
        if let deliveryItem:Dictionary<String, AnyObject> = response?.first {
            
            self.orderDetails?.storeIdentifier = deliveryItem["id"] as? String
            deliveryCharges = deliveryItem["deliverycost"] as? String
            
        }
        
        if response?.count > 1, let deliveryItem:Dictionary<String, AnyObject> = response?[1] {
            
            self.orderDetails?.priceAtMrp = deliveryItem["priceatmrp"] as? String
            self.orderDetails?.priceAfterDeal = deliveryItem["priceafterdeal"] as? String
            self.orderDetails?.identifier = deliveryItem["id"] as? String
            self.orderDetails?.referralBonus = deliveryItem["referlbonus"] as? String
            storePrice = deliveryItem["storeprice"] as? String
            dealDiscount = deliveryItem["dealdiscount"] as? String
            netPrice = deliveryItem["netprice"] as? String
        }
        
        if response?.count > 2, let allItems = response?[2] {
            
            orderItems <- map["response.2.allitem"]
            
        }
        
    }
    

}

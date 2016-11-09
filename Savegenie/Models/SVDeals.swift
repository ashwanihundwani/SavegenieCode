//
//  SVDeals.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 8/7/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

class SVDealProduct: NSObject,Mappable {
    
    var storeSku:String? = nil
    var code:String? = nil
    var mrp:String? = nil
    var priceString:String? = nil
    var product_skus_id:String? = nil
    var qty:String? = nil
    var image:String? = nil
    
    required init?(_ map: Map) {
        
        
    }
    
    func mapping(map: Map) {
        
        storeSku <- map["storeSku"]
        code <- map["code"]
        mrp <- map["mrp"]
        priceString <- map["priceString"]
        product_skus_id <- map["product_skus_id"]
        qty <- map["qty"]
        image <- map["image"]
        
    }
}

class SVDeal: NSObject,Mappable {
    
    var dealTypeStr:String? = nil
    var dealName:String? = nil
    var dealPrice:String? = nil
    var dealMrp:String? = nil
    var productCategoryId:String? = nil
    var productMasterCategoryId:String? = nil
    
    var dealProducts:Array<SVDealProduct> = Array<SVDealProduct>()
    
    required init?(_ map: Map) {
        
        
    }
    
    func mapping(map: Map) {
        
        dealTypeStr <- map["DealType"]
        dealName <- map["DealName"]
        dealPrice <- map["DealPrice"]
        dealMrp <- map["DealMrp"]
        dealProducts <- map["DealProducts"]
        productCategoryId <- map["productcategory_id"]
        productMasterCategoryId <- map["prodmastcategory_id"]
        
        
    }
    
    //MARK : Public Methods
    internal func allSKUIDs() -> Array<String>{
        
        var skuIDs:Array<String> = Array<String>()
        
        for product:SVDealProduct in self.dealProducts {
                
                skuIDs.append(product.product_skus_id!)
        }
        
        return skuIDs
    }
    
    internal func allSKUCounts() -> Array<String>{
        
        var skuCounts:Array<String> = Array<String>()
        for product:SVDealProduct in self.dealProducts {
                
            skuCounts.append(product.qty!)
        }
        
        return skuCounts
    }
}


class SVDeals: NSObject, Mappable {
    static var currentOfferDeals :SVDeals? = nil;
    
    var deals:Array<SVDeal> = Array<SVDeal>()
    var coupons: Array<SVStorePromo> = Array<SVStorePromo>()
    
    static func getCurrentDeals() -> SVDeals? {
        
        return currentOfferDeals
    }
    
    static func setCurrentDeals(deals: SVDeals?) {
        
        currentOfferDeals = deals
    }
    
    required init?(_ map: Map) {
        
        
    }

    func mapping(map: Map) {
        
        deals <- map["response"]
        coupons <- map["coupon"]
    }


}

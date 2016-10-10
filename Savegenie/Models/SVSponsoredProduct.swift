//
//  SVSponsoredProduct.swift
//  Savegenie
//
//  Created by Brammanand Soni on 10/10/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

class SVSponsoredProduct: NSObject, Mappable {

    var spProdArray: Array<SVSponsoredProductDetails>?
    static var sponsoredProductArray : Array<SVSponsoredProductDetails>?
    
    static func getSponsoredProductsArray() -> Array<SVSponsoredProductDetails>? {
        
        return sponsoredProductArray
    }
    
    static func setSponsoredProductsArray(spProd: Array<SVSponsoredProductDetails>?) {
        
        sponsoredProductArray = spProd
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        spProdArray <- map["response"]
    }
}

class SVSponsoredProductDetails: NSObject, Mappable {
    var assetPlaceId: String?
    var masterCategoryId: String?
    var categoryId: String?
    var productTypeId: String?
    var productSKUId: String?
    var productSKUNo: String?
    var storeId: String?
    var adId: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        assetPlaceId <- map["asset_place_id"]
        masterCategoryId <- map["master_category_id"]
        categoryId <- map["category_id"]
        productTypeId <- map["product_type_id"]
        productSKUId <- map["product_sku_id"]
        productSKUNo <- map["product_sku_no"]
        storeId <- map["store_id"]
        adId <- map["ad_id"]
    }
}

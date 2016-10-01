//
//  ISVBanner.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 23/08/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import Foundation

protocol ISVBanner: class {
    
    var bannerImageURL:String { get }
}

protocol ISVShopCategory: class {
    
    var categoryImageURL:String { get }
    var categoryName:String { get }
}

protocol ISVStore: class {
    
    var storeImageURL:String { get }
    var storeName:String { get }
    var freeDeliveryText:String { get }
    var rating:Int { get }
    var deliveryTime:String { get }
    
}
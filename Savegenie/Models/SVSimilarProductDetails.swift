//
//  SVSimilarProductDetails.swift
//  Savegenie
//
//  Created by Brammanand Soni on 10/4/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

class SVSimilarProductDetails: NSObject, Mappable {
    
    var similarProductsIds: Array<String>? {
        get {
            return idsString?.componentsSeparatedByString("+")
        }
    }
    
    var idsString: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
         idsString <- map["bought_together_product"]
    }
}

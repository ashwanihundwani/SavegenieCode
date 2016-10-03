//
//  SVProductDetails.swift
//  Savegenie
//
//  Created by Brammanand Soni on 10/3/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

class SVProductDetails: NSObject, Mappable {

    var imagesArray: Array<String>?
    var descriptions: Array<SVproductDescription>?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        imagesArray <- map["image"]
        descriptions <- map["description"]
    }
}

class SVproductDescription: NSObject, Mappable {
    
    var header: String?
    var details: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        header <- map["header"]
        details <- map["detail"]
    }
}

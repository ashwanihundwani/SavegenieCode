
//
//  SVShippingAddresses.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/23/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import Foundation
import ObjectMapper

class SVShippingAddress: NSObject, Mappable {
    
    var identifier:String? = nil
    var name:String? = nil
    var address:String? = nil
    var locality:String? = nil
    var area:String? = nil
    var city:String? = nil
    var mobileno:String? = nil
    var selected:Bool = false
    
    required init?(_ map: Map) {
        
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        identifier <- map["id"]
        name <- map["name"]
        locality <- map["locality"]
        address <- map["address"]
        area <- map["area"]
        city <- map["city"]
        mobileno <- map["mobileno"]
    }
    
    
}


class SVShippingAddresses: NSObject, Mappable {
    
    var addresses:Array<SVShippingAddress>? = nil
    required init?(_ map: Map) {
        
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        addresses <- map["shippingaddress"]
    }

}

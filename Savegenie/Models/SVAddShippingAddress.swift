//
//  SVAddShippingAddress.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 8/6/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

class SVAddShippingAddress: NSObject, Mappable {
    
    var areas:SVAreas? = nil
    var registeredArea:String? = nil
    var cityName:String? = nil
    var cityId:String? = nil
    var mobileNumber:String? = nil
    
    //MARK: Initialization
    required init?(_ map: Map) {
        
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        areas = SVAreas(map)
        
        registeredArea <- map["response.1.regesteredArea"]
        cityName <- map["response.1.cityName"]
        cityId <- map["response.1.cityId"]
        mobileNumber <- map["response.1.mobileno"]
        
        
    }

}

//
//  SVThreeHoursResponse.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 8/2/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

class SVThreeHoursResponse: NSObject, Mappable {

    var flag:String? = nil
    var storeSlot:String? = nil
    var promisedTime:String? = nil
    
    required init?(_ map: Map) {
        
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        flag <- map["flag"]
        storeSlot <- map["storeSlots"]
        promisedTime <- map["promisedTime"]
    }
    
    //MARK : Public Methods
    
    func formattedPromisedTime() -> String {
        
        let date = SVUtil.dateFromString(promisedTime!, inFormat: "HH:mm:ss")
        
        return SVUtil.stringFromDate(date!, inFormat: "HH:mm")!
    }
}

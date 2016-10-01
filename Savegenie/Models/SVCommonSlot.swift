//
//  SVCommonSlot.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 17/09/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import ObjectMapper

class SVCommonSlot: NSObject, Mappable {

    var result:String?
    var slot:String?
    var date:String?
    
    required init?(_ map: Map) {
        
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        result <- map["result"]
        slot <- map["slot"]
        date <- map["date"]
        
    }
}

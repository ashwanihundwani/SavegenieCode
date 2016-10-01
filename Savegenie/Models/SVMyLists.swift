//
//  SVMyLists.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 8/4/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

class SVMyList:NSObject, Mappable {
    
    var name:String? = nil
    var id:String? = nil
    
    required init?(_ map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        
        name <- map["name"]
        id <- map["id"]
    }
}

class SVMyLists: NSObject, Mappable {
    
    var lists:Array<SVMyList>? = nil
    
    required init?(_ map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        
        lists <- map["lists"]
        
    }
}

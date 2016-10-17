//
//  SVSettings.swift
//  Savegenie
//
//  Created by Brammanand Soni on 10/17/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

class SVSettings: NSObject, Mappable {

    var settingsArray: Array<SVKeyValueItem>?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        settingsArray <- map["response"]
    }
}

class SVKeyValueItem: NSObject, Mappable {
    var key: String?
    var value: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        key <- map["key"]
        value <- map["value"]
    }
}

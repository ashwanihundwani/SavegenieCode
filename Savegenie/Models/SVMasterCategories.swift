//
//  SVMasterCategories.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 02/09/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

class SVCategory: NSObject, Mappable {
    
    var identifier:String?
    var name:String?
    var image:String?
    
    required init?(_ map: Map) {
        
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        identifier <- map["id"]
        name <- map["name"]
        image <- map["image"]
        
    }
}


class SVMasterCategories: NSObject, Mappable {
    
    var categories:Array<SVCategory>? = Array<SVCategory>()
    
    
    required init?(_ map: Map) {
        
        
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        categories <- map["response"]
    }
}
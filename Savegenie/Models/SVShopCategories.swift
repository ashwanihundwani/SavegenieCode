//
//  SVShopCategories.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 30/08/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

class SVShopCategory: NSObject, Mappable, ISVShopCategory {
    
    var categoryImage:String?
    var identifier:String?
    var priority:String?
    var catName:String?
    var catCode:String?
    
    required init?(_ map: Map) {
        
        
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        categoryImage <- map["image"]
        identifier <- map["id"]
        priority <- map["priority_id"]
        catName <- map["name"]
        catCode <- map["code"]
        
    }
    
    var categoryImageURL: String {
        
        get {
            
            return categoryImage!
        }
    }
    var categoryName: String {
        
        get {
            
            return catName!
        }
    }
    
}

class SVShopCategories: NSObject, Mappable {
    
    var categories:Array<SVShopCategory>? = Array<SVShopCategory>()
    
    required init?(_ map: Map) {
        
        
    }
    
    override init() {
        
        super.init()
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        categories <- map["response"]
    }
    
}

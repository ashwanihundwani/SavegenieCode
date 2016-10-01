//
//  SVAreas.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/28/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import SWXMLHash
import ObjectMapper

class SVArea: NSObject, Mappable{
    
    var areaText:String? = nil
    var areaId:String? = nil
    
    required init?(_ map: Map) {
        
    }
    
    override init() {
        
    }
    
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        areaId <- map["area_id"]
        areaText <- map["area_name"]

    }
}

class SVAreas: NSObject, Mappable {
    
    var areas:Array<SVArea> = Array<SVArea>()
    
    required init?(_ map: Map) {
        
        areas <- map["response.0.areaId"]
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        //areas <- map["areaId"]
    }
    
    required init(xml:String) {
        
        let indexer:XMLIndexer = SWXMLHash.parse(xml)
        
        super.init()
        
        for element in indexer["response"]["area"] {
            
            let area:SVArea? = SVArea()
            area?.areaText = element["name"].element?.text
            area?.areaId = element["id"].element?.text
            
            areas.append(area!)
        }
        
    }
    
    //MARK: Public Methods
    internal func areaIdForText(text:String)-> String {
        
        for area:SVArea in self.areas {
            
            if area.areaText == text {
                
                return area.areaId!
            }
        }
        
        return ""
    }
    
    internal func displayTexts() -> Array<String> {
        
        var strings:Array<String> = Array<String>()
        
        for area:SVArea in self.areas {
            
            strings.append(area.areaText!)
        }
        
        
        return strings
    }

}

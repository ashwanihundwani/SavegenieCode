//
//  SVUpdateCartResult.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/13/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

class SVUpdateCartResult: NSObject, Mappable {
    
    var cartItemCount:String? = nil
    
    required init?(_ map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        
        map["result.result"]
        
        let item = map.currentValue as? NSNumber
        
        cartItemCount = "\((item?.intValue)!)"
        
        
    }

}

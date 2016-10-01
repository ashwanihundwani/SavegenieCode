//
//  SVPlacedOrderDetails.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 8/2/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

class SVPlacedOrderDetails: NSObject, Mappable {
    var id:String? = nil
    var created:String? = nil
    var orderStatus:String? = nil
    
    required init?(_ map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        created <- map["created"]
        
        created = SVUtil.stringFromDate(SVUtil.dateFromString(created!, inFormat: "yyyy-MM-dd HH:mm:ss")!, inFormat: "yyyy-MM-dd")
        
        orderStatus <- map["order_status"]
        
    }
}


class SVPlacedOrdersDetails: NSObject, Mappable {
    
    var details:Array<SVPlacedOrderDetails>? = nil
    required init?(_ map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        
        details <- map["orders"]
        
    }
    

}

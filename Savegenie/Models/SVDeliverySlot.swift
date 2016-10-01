//
//  SVDeliverySlot.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/26/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

class SVDeliveryDay:NSObject, Mappable {
    
    var dayName:String? = nil
    var date:String? = nil
    var available:String? = nil
    var fullDate:String? = nil
    
    
    var selected:Bool = false
    
    required init?(_ map: Map) {
        
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        dayName <- map["dayname"]
        date <- map["date"]
        available <- map["available"]
        fullDate <- map["fulldate"]
        
    }
    
    //MARK: Public Methods
    internal func getDisplayDateString() -> String {
        let dateObj = SVUtil.dateFromString(self.fullDate!, inFormat: "yyyy-MM-dd")
        
        return SVUtil.stringFromDate(dateObj!, inFormat: "dd MMM, EEE")!
        
    }

}

class SVDeliverySlot: NSObject, Mappable {
    
    //MARK: Mapper properties
    var slots:Array<SVDeliveryDay> = Array<SVDeliveryDay>()
    var threeHrsDelivery:String? = nil
    
    //MARK : UI Helper properties
    var dates:Array<String> {
        
        get {
            var arrDates = Array<String>()
            for deliveryDate:SVDeliveryDay in slots {
                
                arrDates.append(deliveryDate.getDisplayDateString())
                
            }
            return arrDates
        }
    }
    
    
    //MARK: Initialization
    required init?(_ map: Map) {
        
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        slots <- map["slot"]
        threeHrsDelivery <- map["threeHrs.0.threehourstime"]
    }

    //MARK: Public Methods
    internal func deselectAll() {
        
        for deliveryDay in self.slots {
            deliveryDay.selected = false
        }
    }
    

}

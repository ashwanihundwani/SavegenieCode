//
//  ProductCategory.swift
//  
//
//  Created by Ashwani Hundwani on 7/1/16.
//
//

import Foundation
import CoreData

@objc(ProductCategory)
class ProductCategory: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    internal func prepareWithDict(dict:Dictionary<String, AnyObject>) {
        
        /*
         name: "Drinks",
         image: "drinks.png",
         priority_id: "2",
         id: "1",
         active: "1",
         
         */
        if let str = dict["active"] as? String {
            
             self.active = NSNumber(integer: Int((str))!)
        }
    
        self.image = dict["image"] as? String
        self.name = dict["name"] as? String
        self.identifier = dict["id"] as? String
        self.priority_id = NSNumber(integer: Int((dict["priority_id"] as? String)!)!)
    }
    
}

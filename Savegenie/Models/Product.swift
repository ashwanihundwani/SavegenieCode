//
//  Product.swift
//  
//
//  Created by Ashwani Hundwani on 7/1/16.
//
//

import Foundation
import CoreData

@objc(Product)
class Product: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    internal func prepareWithDict(dict:Dictionary<String, AnyObject>) {
        
        /*
         id: "76",
         size: "250",
         unit: "ml",
         code: "Axe Dark Temptation Gel Douche 250 ml",
         image: "Axe-Dark-Temptation-Gel-Douche-250-Ml.png",
         mrp: "168",
         product_type: "117",
         pop_index: "19",
         product_cat_id: "15",
         product_master_cat_id: "5",
         Store-41: "150",
         deal_active: "0",
         aDeal_active: "0"
         
         */
        self.identifier = dict["id"] as? String
        self.size = dict["size"] as? String
        self.unit = dict["unit"] as? String
        self.productName = dict["code"] as? String
        self.image = dict["image"] as? String
        self.mrp = NSNumber(float: Float((dict["mrp"] as? String)!)!)
        self.productType = dict["product_type"] as? String
        self.popIndex = NSNumber(integer: Int((dict["pop_index"] as? String)!)!)
        self.categoryId = dict["product_cat_id"] as? String
        self.masterCategoryId = dict["product_master_cat_id"] as? String
        
        if let discountStr:String = dict["Store-41"] as? String {
            if discountStr == "" {
                
            }
            else {
                
                self.discountedPrice = NSNumber(float: Float((dict["Store-41"] as? String)!)!)
            }
        }
        
        self.dealActive = NSNumber(integer: Int((dict["deal_active"] as? String)!)!)
        
        // defining relationship with Category
        if let cat = SVCoreDataManager.categoryWithId(self.categoryId!, level: 2) {
            
            self.category = cat
        }
        
        // defining relationship with Master Category
        if let cat = SVCoreDataManager.categoryWithId(self.masterCategoryId!, level: 1) {
            
            self.masterCategory = cat
        }
        
        
    }
    
}

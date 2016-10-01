//
//  SVDataImportManager.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/1/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import CoreData

class SVDataImportManager: NSObject {
    
    static func prepareProducts(objectContext:NSManagedObjectContext) {
        
        var exists:Bool = true
        var fileNumber:Int8 = 1
        while (exists) {
            
            let fileName = String("productsku-\(fileNumber).json")
            if let sku1JSON = SVUtil.pathByAddingFileName(fileName) {
                
                exists = NSFileManager.defaultManager().fileExistsAtPath(sku1JSON.path!)
                
                if exists {
                    
                    SVDataImportManager.prepareProducts(fileName, objectContext: objectContext)
                }
                else {
                    exists = false
                }
            }
            
            
            fileNumber += 1
                
        }
            
    }
    
    static func prepareProducts(fileName:String, objectContext:NSManagedObjectContext) {
        
        let sku1JSON = SVUtil.pathByAddingFileName(fileName)
        
        do{
            let dict:NSDictionary =  try NSJSONSerialization.JSONObjectWithData(NSData(contentsOfURL: sku1JSON!)!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            if let obj = dict.objectForKey("response") {
                
                let products:Array<Dictionary<String, AnyObject>> = (obj as? Array<Dictionary<String, AnyObject>>)!
                
                
                for dict:Dictionary<String, AnyObject> in products {
                    
                    let dbProduct:Product = (SVCoreDataManager.createNewEntity(SVConstants.PRODUCT_DB_ENTITY, context: objectContext) as? Product)!
                    
                    
                    dbProduct.prepareWithDict(dict)
                }

            }
        }
            
            
        catch let error as NSError {
            print("json error: \(error.localizedDescription)")
        }
        
        //finally save the objects & relationships in DB.
//        do {
//            try objectContext.save()
//        }
//        catch {
//            
//        }
        
        
        
    }
    
    static func prepareProductCategories(objectContext:NSManagedObjectContext) {
        
        //var categories:Array<SVProductCategory> = Array<SVProductCategory>()
        let categoriesJSONFileURL = SVUtil.pathByAddingFileName("makeXmlTree.json")
        do{
            let dict:NSDictionary =  try NSJSONSerialization.JSONObjectWithData(NSData(contentsOfURL: categoriesJSONFileURL!)!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            

            let categories:Array<Dictionary<String, AnyObject>> = (dict.objectForKey("Prodmastcategory") as? Array<Dictionary<String, AnyObject>>)!
            
           
            for dict:Dictionary<String, AnyObject> in categories {
                
                let dbCategory:ProductCategory = (SVCoreDataManager.createNewEntity(SVConstants.CATEGORY_DB_ENTITY, context: objectContext) as? ProductCategory)!
                
                
                dbCategory.prepareWithDict(dict)
                dbCategory.level = NSNumber(unsignedShort: 1)
                
                
                let subCategories:Array<Dictionary<String, AnyObject>> = (dict["SubMenu"] as? Array<Dictionary<String, AnyObject>>)!
                
                for subCat:Dictionary<String, AnyObject> in subCategories {
                    
                    let dbSubCategory:ProductCategory = (SVCoreDataManager.createNewEntity(SVConstants.CATEGORY_DB_ENTITY,  context: objectContext) as? ProductCategory)!
                    
                    dbSubCategory.prepareWithDict(subCat)
                    
                    
                    dbSubCategory.level = NSNumber(unsignedShort: 2)
                    dbSubCategory.parentCategory = dbCategory

                    let subCategories:Array<Dictionary<String, AnyObject>> = (subCat["ProductType"] as? Array<Dictionary<String, AnyObject>>)!
                    
                    for productCat:Dictionary<String, AnyObject> in subCategories {
                        
                        let dbProductCategory:ProductCategory = (SVCoreDataManager.createNewEntity(SVConstants.CATEGORY_DB_ENTITY,  context: objectContext) as? ProductCategory)!
                        
                        dbProductCategory.prepareWithDict(productCat)
                        
                        dbProductCategory.level = NSNumber(unsignedShort: 3)
                        dbProductCategory.parentCategory = dbSubCategory
                        
                    }
                }
            }
        }
        catch let error as NSError {
            print("json error: \(error.localizedDescription)")
        }
        
//        //finally save the objects & relationships in DB.
//        do {
//            try objectContext.save()
//        }
//        catch {
//            
//        }
        
        
    }
    
    static internal func importData(completionHandler handler:(Bool)->Void) {

        
        let bgContext:NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        
        bgContext.parentContext = SVUtil.managedObjectContext()
        
        //bgContext.persistentStoreCoordinator = bgContext.parentContext?.persistentStoreCoordinator
        
        bgContext.performBlock {
            
            
            //clear all existing data
            SVCoreDataManager.clearDB(bgContext)
            
            // prepare Product Categories
            SVDataImportManager.prepareProductCategories(bgContext)
            
            //prepare Products
            SVDataImportManager.prepareProducts(bgContext)
            
            do {
                try bgContext.save()
                
                bgContext.parentContext?.performBlock({
                    
                    do {
                        try bgContext.parentContext!.save()
                        
                        handler(true)
                        
                    }
                    catch {
                        
                    }
                })
            }
            catch {
                
            }
        }
        
        
        
        
    }

}

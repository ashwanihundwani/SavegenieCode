//
//  SVCoreDataManager.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/1/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import CoreData

class SVCoreDataManager: NSObject {
    
    
    static internal func createNewEntity(entityName:String, context:NSManagedObjectContext) -> NSManagedObject{
        
        let object:NSManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: context)
        
        return object
        
    }
    
    // fetch category for selected Identifier
    static internal func categoryWithId(identifier:String, level:Int8) -> ProductCategory?{
        
        let fetchRequest = NSFetchRequest(entityName: SVConstants.CATEGORY_DB_ENTITY)
        let predicate = NSPredicate(format: "identifier LIKE[C] %@ AND level = %d", identifier, level)
        
        
        fetchRequest.predicate = predicate
        
        do {
            let category = try SVUtil.managedObjectContext().executeFetchRequest(fetchRequest).first as? ProductCategory
            
            return category

        }
        catch {
            
        }
        
        return nil
    }
    
    static func fetchSubCategoriesForCategoryWithId(categoryId:String, level:Int8) ->Array<ProductCategory>{
        
        let parentCat:ProductCategory = SVCoreDataManager.categoryWithId(categoryId, level: level)!
        
        let array:Array<ProductCategory> = (parentCat.children?.allObjects as? Array<ProductCategory>)!
        
        
        let sortedCategories = array.sort({ (cat1 : ProductCategory, cat2 : ProductCategory) -> Bool in
            
            
            return cat1.priority_id?.integerValue < cat2.priority_id?.integerValue})
        
        
        return sortedCategories
    }
    
    
    //fetch all categories filter by hierarchy level and sorted by priority
    static internal func fetchCategoriesWithLevel(level:Int8, priority:Bool) -> Array<ProductCategory>?{
        
        let fetchRequest = NSFetchRequest(entityName: SVConstants.CATEGORY_DB_ENTITY)
        let predicate = NSPredicate(format: "level = %d", level)
        
        
        fetchRequest.predicate = predicate
        
        do {
            let categories:Array<ProductCategory>? = try SVUtil.managedObjectContext().executeFetchRequest(fetchRequest) as? Array<ProductCategory>
            
            //sorting categories for priority
            let sortedCategories = categories!.sort({ (cat1 : ProductCategory, cat2 : ProductCategory) -> Bool in
                
                
                return cat1.priority_id?.integerValue < cat2.priority_id?.integerValue})
            
            
            return sortedCategories
            
        }
        catch {
            
        }
        
        return nil
    }

    static internal func filterProductsForCriteria(criteria:SVProductFilterCriteria)-> Array<Product>? {
        
        let fetchRequest = NSFetchRequest(entityName: SVConstants.PRODUCT_DB_ENTITY)
        
        var predicateFormat = ""
        
        var arguments:Array<AnyObject> = Array<AnyObject>()
        
        var firstAdded = false
        
        if criteria.promo == true {
            arguments.append(criteria.promo)
            firstAdded = true
            predicateFormat = predicateFormat + "dealActive = %d"
        }
        
        if let catId = criteria.categoryId {
            
            arguments.append(catId)
            if firstAdded == true {
                predicateFormat = predicateFormat + " AND "
            }
            
            firstAdded = true
            
            predicateFormat = predicateFormat + "categoryId = %@"
            
        }
        
        if let masterCatId = criteria.masterCategoryId {
            
            arguments.append(masterCatId)
            if firstAdded == true {
                predicateFormat = predicateFormat + " AND "
            }
            
            firstAdded = true
            
            predicateFormat = predicateFormat + "masterCategoryId = %@"
            
        }
        
        if let productTypeId = criteria.productTypeId {
            
            arguments.append(productTypeId)
            if firstAdded == true {
                predicateFormat = predicateFormat + " AND "
            }
            
            firstAdded = true
            
            predicateFormat = predicateFormat + "productType = %@"
            
        }
        
        
        let predicate = NSPredicate(format: predicateFormat, argumentArray: arguments)
        
        
        fetchRequest.predicate = predicate
        
        do {
            let products:Array<Product>? = try SVUtil.managedObjectContext().executeFetchRequest(fetchRequest) as? Array<Product>
            
            
            return products
            
        }
        catch {
            
        }
    
        return nil
        
    }
    
    static internal func fetchProductsWithSearchKeyword(keyword:String) -> Array<Product>? {
        
        let fetchRequest = NSFetchRequest(entityName: SVConstants.PRODUCT_DB_ENTITY)
        
        let predicate = NSPredicate(format: "productName CONTAINS[CD] %@", keyword)
        
        
        fetchRequest.predicate = predicate
        
        do {
            let products:Array<Product>? = try SVUtil.managedObjectContext().executeFetchRequest(fetchRequest) as? Array<Product>
            
            
            return products
            
        }
        catch {
            
        }
        
        return nil
    }
    
    static internal func clearDB(context : NSManagedObjectContext) {
        
        
        // clear products
        var fetchRequest = NSFetchRequest(entityName: SVConstants.PRODUCT_DB_ENTITY)
        
        do {
            let products:Array<Product>? = try SVUtil.managedObjectContext().executeFetchRequest(fetchRequest) as? Array<Product>
            
            for product:Product in products! {
                
                SVUtil.managedObjectContext().deleteObject(product)
            }
            
            do {
                
                try context.save()
            }
            catch {
                
            }
        }
        catch {
            
        }
        
        // clear Categories
        fetchRequest = NSFetchRequest(entityName: SVConstants.CATEGORY_DB_ENTITY)
        
        do {
            let categories:Array<ProductCategory>? = try SVUtil.managedObjectContext().executeFetchRequest(fetchRequest) as? Array<ProductCategory>
            
            for category:ProductCategory in categories! {
                
                SVUtil.managedObjectContext().deleteObject(category)
            }
            
            do {
                
                try context.save()
            }
            catch {
                
            }

        }
        catch {
            
        }
        
        
    }
    
    static internal func getProductsWithIds(productIds:Array<String>)->Array<Product>? {
        
        let fetchRequest = NSFetchRequest(entityName: SVConstants.PRODUCT_DB_ENTITY)
        
        let predicate = NSPredicate(format: "identifier IN %@", productIds)
        
        
        fetchRequest.predicate = predicate
        
        do {
            let products:Array<Product>? = try SVUtil.managedObjectContext().executeFetchRequest(fetchRequest) as? Array<Product>
            
            
            return products
            
        }
        catch {
            
        }
        
        return nil
    }
    
    static internal func fetchCategoryWithId(identifier:String)-> ProductCategory? {
        
        let fetchRequest = NSFetchRequest(entityName: SVConstants.CATEGORY_DB_ENTITY)
        
        let predicate = NSPredicate(format: "identifier = %@", identifier)
       
        
        fetchRequest.predicate = predicate
        
        do {
            let products:Array<ProductCategory>? = try SVUtil.managedObjectContext().executeFetchRequest(fetchRequest) as? Array<ProductCategory>
            
            
            return products?.count > 0 ? products![0] : nil
            
        }
        catch {
            
        }
        
        return nil
    }

}

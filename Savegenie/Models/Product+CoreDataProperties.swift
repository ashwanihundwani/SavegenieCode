//
//  Product+CoreDataProperties.swift
//  
//
//  Created by Ashwani Hundwani on 7/2/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Product {

    @NSManaged var categoryId: String?
    @NSManaged var dealActive: NSNumber?
    @NSManaged var discountedPrice: NSNumber?
    @NSManaged var identifier: String?
    @NSManaged var image: String?
    @NSManaged var masterCategoryId: String?
    @NSManaged var mrp: NSNumber?
    @NSManaged var popIndex: NSNumber?
    @NSManaged var productName: String?
    @NSManaged var productType: String?
    @NSManaged var promoDealActive: NSNumber?
    @NSManaged var size: String?
    @NSManaged var unit: String?
    @NSManaged var category: ProductCategory?
    @NSManaged var masterCategory: ProductCategory?
    @NSManaged var isFavorite: NSNumber?
    @NSManaged var quantity: NSNumber?
    

}

//
//  ProductCategory+CoreDataProperties.swift
//  
//
//  Created by Ashwani Hundwani on 7/1/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ProductCategory {

    @NSManaged var active: NSNumber?
    @NSManaged var identifier: String?
    @NSManaged var image: String?
    @NSManaged var name: String?
    @NSManaged var priority_id: NSNumber?
    @NSManaged var products: ProductCategory?
    @NSManaged var children: NSSet?
    @NSManaged var parentCategory: ProductCategory?

}

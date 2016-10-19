//
//  SVProductFilterCriteria.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/2/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVProductFilterCriteria: NSObject {
    
    var promo:Bool = false
    var bestSelling = false
    var favorite = false
    var categoryId:String? = nil
    var masterCategoryId:String? = nil
    var productTypeId:String? = nil
    var storeID: String?
}

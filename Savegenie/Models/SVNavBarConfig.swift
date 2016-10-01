//
//  SVNavBarConfig.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/25/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVNavBarConfig: NSObject {

    var showBack:Bool = true
    var showSearch:Bool = true
    var showCart:Bool = true
    var title:String? = nil
    
    init(showBack:Bool, showSearch:Bool, showCart:Bool, title:String) {
        super.init()
        
        self.showBack = showBack
        self.showSearch = showSearch
        self.showCart = showCart
        self.title = title
    }
}

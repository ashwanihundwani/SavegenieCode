//
//  SVVisitedStores.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 17/09/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

var stores:Array<SVStore> = Array<SVStore>()

class SVVisitedStores: NSObject {
    
    static func addStore(store:SVStore){
        
        if store.name == self.getStores().first?.name {
            return
        }
        
        if stores.count > 1 {
            stores.removeLast()
        }
    
        stores.append(store)
    }
    
    static func getStores() -> Array<SVStore> {
        
        return stores
    }
    
    static func multipleStoresVisited()-> Bool{
        
        return (stores.count > 1)
    }

}

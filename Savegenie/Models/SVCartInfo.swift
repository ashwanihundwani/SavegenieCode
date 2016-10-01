//
//  SVCartInfo.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/12/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import SWXMLHash

class SVCartInfo: NSObject, NSCoding {
    
    var cartId:String? = nil
    var count:String? = nil
    
    required init(xml:String) {
        
        super.init()
        
        let indexer:XMLIndexer = SWXMLHash.parse(xml)
        
        cartId = indexer["response"]["listid"].element?.text
        
        
    }

    //MARK: Encoding & Decoding Methods
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(cartId, forKey: "cart_id")
        aCoder.encodeObject(count, forKey: "count")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init()
        
        cartId = aDecoder.decodeObjectForKey("cart_id") as? String
        count = aDecoder.decodeObjectForKey("count") as? String
        
    }
    
}

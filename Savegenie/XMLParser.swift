//
//  XMLParser.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/29/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class XMLParser: NSObject {
    
    static func parserXML(xml:String, URL:String) -> NSObject?{
        
        if URL == SVConstants.AREAS_URL {
            
            return SVAreas(xml:xml)
            
        }
        else if URL == SVConstants.MY_PROFILE_URL {
            
            return SVUserDetails(xml:xml)
        }
        
        else if URL == SVConstants.CART_INFO {
            
            return SVCartInfo(xml:xml)
        }
        
        return nil;
        
    }
    

}

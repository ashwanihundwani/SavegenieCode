//
//  SVLoginResponse.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/26/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper
import SWXMLHash

/**
 This class is used to save the details of the logged in user.
 */
class SVUserDetails: NSObject, NSCoding, Mappable {
    
    var result:String? = nil
    var firstName:String? = nil
    var lastName:String? = nil
    var email:String? = nil
    var password:String? = nil
    var userGroup:String? = nil
    var identifier:String? = nil
    var area:String? = nil
    var phoneNumber:String? = nil
    var detailId:String? = nil
    var title:String? = nil
    
    required init?(_ map: Map) {
        
    }

    required init(xml:String) {
        
        super.init()
        
        let indexer:XMLIndexer = SWXMLHash.parse(xml)
        
        for element in indexer["response"]["user"] {
            
            email = element["email"].element?.text
            identifier = element["id"].element?.text
            firstName = element["first_name"].element?.text
            lastName = element["last_name"].element?.text
            area = element["area"].element?.text
            phoneNumber = element["cellphone"].element?.text
            detailId = element["userdetailid"].element?.text
            title = element["title"].element?.text
            if let oldDetails = SVUtil.getUserDetails() {
                
                password = oldDetails.password
                userGroup = oldDetails.userGroup
                
            }
        }
        
    }

    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        map["login"]
        if let array:Array<Dictionary<String,AnyObject>> = map.currentValue as? Array<Dictionary<String, AnyObject>> {
            
            if array.count > 0 {
                if let details:Dictionary<String, AnyObject> = array.first {
                    
                    result = details["result"] as? String
                    
                    firstName = details["fname"] as? String
                    
                    lastName = details["lname"] as? String
                    
                    email = details["email"] as? String
                    
                    password = details["password"] as? String
                    
                    userGroup = details["group"] as? String
                    
                    area = details["areaName"] as? String
                }
            }
            
        }
    }
    
    //MARK: Encoding & Decoding Methods
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(firstName, forKey: "first_name")
        aCoder.encodeObject(lastName, forKey: "last_name")
        aCoder.encodeObject(result, forKey: "result")
        aCoder.encodeObject(email, forKey: "email")
        aCoder.encodeObject(password, forKey: "password")
        aCoder.encodeObject(userGroup, forKey: "usergroup")
        aCoder.encodeObject(area, forKey: "area")
        aCoder.encodeObject(detailId, forKey: "detailId")
        aCoder.encodeObject(phoneNumber, forKey:"phone")
        aCoder.encodeObject(identifier, forKey:"id")
        aCoder.encodeObject(title, forKey:"title")
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init()
        
        firstName = aDecoder.decodeObjectForKey("first_name") as? String
        lastName = aDecoder.decodeObjectForKey("last_name") as? String
        result = aDecoder.decodeObjectForKey("result") as? String
        email = aDecoder.decodeObjectForKey("email") as? String
        password = aDecoder.decodeObjectForKey("password") as? String
        userGroup = aDecoder.decodeObjectForKey("usergroup") as? String
        area = aDecoder.decodeObjectForKey("area") as? String
        detailId = aDecoder.decodeObjectForKey("detailId") as? String
        phoneNumber = aDecoder.decodeObjectForKey("phone") as? String
        identifier = aDecoder.decodeObjectForKey("id") as? String
        title = aDecoder.decodeObjectForKey("title") as? String
        
    }
    

}

//
//  SVBanners.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 29/08/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ObjectMapper

class SVBanner: NSObject, Mappable, ISVBanner {
    
    var bannerImage:String?
    var identifier:String?
    var priority:String?
    
    required init?(_ map: Map) {
        
        
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        bannerImage <- map["image"]
        identifier <- map["id"]
        priority <- map["priority"]
        
    }
    
    //MARK: ISVBanner protocol implementation
    var bannerImageURL: String {
        
        get {
            
            return bannerImage!
        }
    }
    
}

class SVBanners: NSObject, Mappable {
    
    var banners:Array<SVBanner>? = Array<SVBanner>()

    required init?(_ map: Map) {
        
        
    }
    
    override init() {
        
        super.init()
    }
    
    //MARK: Mappable protocol implementation
    func mapping(map: Map) {
        
        banners <- map["response"]
    }
    
    //MARK: Public Methods
    
    func addBanner(banner:SVBanner) {
        
        self.banners?.append(banner)
    }
    
    internal func getVerticalBanners() -> SVBanners {
    
        let banners:SVBanners = SVBanners()
        
        for banner:SVBanner in self.banners! {
            
            if banner.priority != "1" {
                
                banners.addBanner(banner)
                
            }
        }
        
        return banners
    }
    
    internal func getHorizontalBanners() -> SVBanners {
        
        let banners:SVBanners = SVBanners()
        
        for banner:SVBanner in self.banners! {
            
            if banner.priority == "1" {
                
                banners.addBanner(banner)
                
            }
        }
        
        return banners
    }
    
}

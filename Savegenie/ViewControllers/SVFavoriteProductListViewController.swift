//
//  SVFavoriteProductListViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/10/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVFavoriteProductListViewController: SVProductListViewController {

    
    //MARK: Abstract Overridden Methods
    
    override func navBarConfig() -> SVNavBarConfig {
        
        return SVNavBarConfig(showBack: true, showSearch: true, showCart: true, title: "My Favorites")
    }
    
    override func reloadData() {
        
        SVUtil.showLoader()
        SVTextAppService.getFavProducts { (products:AnyObject?, error:NSError?) in
            
            if let _ = products {
                
                let strProducts = products as? String
                
                let productsArray:Array<String> = (strProducts?.componentsSeparatedByString("-"))!
                
                self.products = SVCoreDataManager.getProductsWithIds(productsArray)
                
                self.showUIBasedOnTotalProducts()
                
                
            }
            else {
                SVUtil.showAlert(SVConstants.APP_NAME, message:SVConstants.CONNECTION_ERROR_MESSAGE, controller:self)
            }
            
            SVUtil.hideLoader()
        }
    
    }
    
}

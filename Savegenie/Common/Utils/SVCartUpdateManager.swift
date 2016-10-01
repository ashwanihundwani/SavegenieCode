//
//  SVCartManager.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/13/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

enum CartAction {
    
    case Add
    case Substract
    case Delete
}

class SVCartUpdateManager: NSObject {
    
    //MARK: Private Methods
    
    static private func saveUpdateResultAndNotify() {
        
        NSNotificationCenter.defaultCenter().postNotificationName(SVConstants.CART_UPDATED_NOTIFICATION, object: nil)
        
    }
    
    static private func getParamsForSKUs(skuIds:Array<String>,counts:Array<String>,  action:CartAction)-> Array<(key:String, value:AnyObject)>{
        
        var params:Array<(key:String, value:AnyObject)> = Array<(key:String, value:AnyObject)> ()
        
        let ids:String = skuIds.joinWithSeparator("-")
        let counts:String = counts.joinWithSeparator("-")
        
        switch(action) {
            
        case .Add :
            params.append(("data[productSkuId]", ids))
            params.append(("data[plusminus]", "1"))
            params.append(("data[count]", counts))
            params.append(("data[qtycount]", "0"))
            
        case .Substract :
            params.append(("data[productSkuId]", ids))
            params.append(("data[plusminus]", "0"))
            params.append(("data[count]", counts))
            params.append(("data[qtycount]", "0"))
        case .Delete :
            params.append(("data[productskuid]", ids))
        }
        
        return params
    }
    
    static private func getParamsForSKU(skuId:String, action:CartAction)-> Array<(key:String, value:AnyObject)>{
        
        var params:Array<(key:String, value:AnyObject)> = Array<(key:String, value:AnyObject)> ()
        
        switch(action) {
            
        case .Add :
            params.append(("data[productSkuId]", skuId))
            params.append(("data[plusminus]", "1"))
            params.append(("data[count]", "1"))
            //params.append(("data[qtycount]", "0"))

        case .Substract :
            params.append(("data[productSkuId]", skuId))
            params.append(("data[plusminus]", "0"))
            params.append(("data[count]", "1"))
            //params.append(("data[qtycount]", "0"))
        case .Delete :
            params.append(("data[productskuid]", skuId))
        }
        
        return params
    }
    
    static private func fetchCartInfo(completionHandler handler:(Bool)->Void)
    {
        SVTextAppService.selectCart { (obj:AnyObject?, error:NSError?) in
            
            SVXMLAppService.fetchCartInfo { (cartInfo:NSObject?, error:NSError?) in
                
                let cartInfo = cartInfo as? SVCartInfo
                
                SVUtil.saveCustomObject(SVConstants.CART_INFO_KEY, object: cartInfo)
                
                SVTextAppService.fetchBadgeCount(completionHandler: { (count:AnyObject?, error:NSError?) in
                    
                    let badgeCount = count as? String
                    
                    let cartInfo:SVCartInfo = (SVUtil.getCustomObject(SVConstants.CART_INFO_KEY) as? SVCartInfo)!
                    
                    cartInfo.count = badgeCount
                    
                    SVUtil.saveCustomObject(SVConstants.CART_INFO_KEY, object: cartInfo)
                    
                    handler(true)
                    SVCartUpdateManager.saveUpdateResultAndNotify()
                    
                })
                
                
            }
        }
        
    }
    
    static private func updateItem(params:Array<(key:String, value:AnyObject)>,completionHandler handler:(Bool)->Void) {
    
        SVJSONAppService.updateCart(params, responsObjectKey: "") { (result:SVUpdateCartResult?, error:NSError?) in
            //                let cartInfo:SVCartInfo = (SVUtil.getCustomObject(SVConstants.CART_INFO_KEY) as? SVCartInfo)!
            //
            //                cartInfo.count = result?.cartItemCount
            //
            //                SVUtil.saveCustomObject(SVConstants.CART_INFO_KEY, object: cartInfo)
            //
            //                SVCartUpdateManager.saveUpdateResultAndNotify()

            SVCartUpdateManager.fetchCartInfo(completionHandler: handler)
            
            
        }
    }
    
    static private func deleteItem(params:Array<(key:String, value:AnyObject)>, completionHandler handler:(Bool)->Void) {
        
        SVJSONAppService.deleteItemFromCart(params, responsObjectKey: "") { (result:SVUpdateCartResult?, error:NSError?) in
            
            SVCartUpdateManager.fetchCartInfo(completionHandler: handler)
            
        }
    }
    
    
    //MARK: public Methods
    
    static internal func addSKUs(skus:Array<String>,counts:Array<String>, completionHandler handler:(Bool)->Void) {
        
        let params = SVCartUpdateManager.getParamsForSKUs(skus, counts: counts, action: .Add)
        
        SVCartUpdateManager.updateItem(params, completionHandler: handler)
        
        //NSNotificationCenter.defaultCenter().postNotificationName(SVConstants.CART_UPDATED_NOTIFICATION, object: nil)
        
    }

    
    static internal func addSKU(sku:String, completionHandler handler:(Bool)->Void) {
        
        let params = SVCartUpdateManager.getParamsForSKU(sku, action: .Add)
        
        SVCartUpdateManager.updateItem(params, completionHandler: handler)
        
        //NSNotificationCenter.defaultCenter().postNotificationName(SVConstants.CART_UPDATED_NOTIFICATION, object: nil)
        
    }
    
    static internal func removeSKUs(skus:Array<String>,counts:Array<String>, completionHandler handler:(Bool)->Void) {
        
        let params = SVCartUpdateManager.getParamsForSKUs(skus, counts: counts, action: .Substract)
        
        SVCartUpdateManager.updateItem(params, completionHandler: handler)
        //NSNotificationCenter.defaultCenter().postNotificationName(SVConstants.CART_UPDATED_NOTIFICATION, object: nil)
        
    }
    static internal func removeSKU(sku:String, completionHandler handler:(Bool)->Void) {
        
        let params = SVCartUpdateManager.getParamsForSKU(sku, action: .Substract)
        
        SVCartUpdateManager.updateItem(params, completionHandler: handler)
        //NSNotificationCenter.defaultCenter().postNotificationName(SVConstants.CART_UPDATED_NOTIFICATION, object: nil)
        
    }
    
    static internal func deleteProducts(skus:Array<String>, completionHandler handler:(Bool)->Void) {
        
        let params = SVCartUpdateManager.getParamsForSKUs(skus, counts:Array<String>(), action: .Delete)
        
        SVCartUpdateManager.deleteItem(params,completionHandler: handler)
        
        //NSNotificationCenter.defaultCenter().postNotificationName(SVConstants.CART_UPDATED_NOTIFICATION, object: nil)
    }
    
    static internal func deleteProduct(sku:String, completionHandler handler:(Bool)->Void) {
        
        let params = SVCartUpdateManager.getParamsForSKU(sku, action: .Delete)
        
        SVCartUpdateManager.deleteItem(params,completionHandler: handler)
        
        //NSNotificationCenter.defaultCenter().postNotificationName(SVConstants.CART_UPDATED_NOTIFICATION, object: nil)
    }

}

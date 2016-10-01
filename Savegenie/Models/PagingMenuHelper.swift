//
//  PagingMenuHelper.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/3/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import PagingMenuController

enum PagingViewType {
    
    case Promo
    case BestSelling
    case Favourite
    case Category
}

struct CategoryMenuItem : MenuItemViewCustomizable {
    
    var title:String? = nil
    var displayMode: MenuItemDisplayMode {
        
        let title = MenuItemText(text: self.title!, color: UIColor(red: 180.0 / 255/0, green : 180.0 / 255.0, blue: 180.0 / 255.0, alpha: 1.0), selectedColor: UIColor.whiteColor(), font: SVUtil.getHelveticaFontWithSize(15) , selectedFont: SVUtil.getHelveticaFontWithSize(15))
        
        return .Text(title: title)
    }
}

struct CategoriesMenu : MenuViewCustomizable {
    
    var backgroundColor: UIColor {
        return UIColor(hexString: SVConstants.APP_THEME_COLOR_RED)
    }
    
    var selectedBackgroundColor: UIColor {
        return UIColor(hexString: SVConstants.APP_THEME_COLOR_RED)
    }
    var displayMode: MenuDisplayMode {
        return .Standard(widthMode: .Flexible, centerItem: false, scrollingMode: .PagingEnabled)
    }
    var focusMode: MenuFocusMode {
        return .None
    }
    var height: CGFloat {
        return 40
    }
    
    // set property
    var itemsOptions: [MenuItemViewCustomizable]
    
}

class PagingMenuHelper: NSObject {
    
    
    var pagingConfig:(controllers:Array<UIViewController>, menuOptions:CategoriesMenu, showFilter:Bool)? = nil
    
    //MARK: Private Methods
    
    private func viewControllersForChildCategories(masterCategory:ProductCategory) -> Array<SVProductListViewController> {
        
        var controllers:Array<SVProductListViewController> = Array<SVProductListViewController>()
        
        
        let category = SVCoreDataManager.categoryWithId(masterCategory.identifier! , level:1)
        
        let array:Array<ProductCategory> = (category?.children?.allObjects as? Array<ProductCategory>)!
        
        let sortedCategories = array.sort({ (cat1 : ProductCategory, cat2 : ProductCategory) -> Bool in
            
            
            return cat1.priority_id?.integerValue < cat2.priority_id?.integerValue})
        
        
        
        for cat:ProductCategory in sortedCategories {
            
            let vc:SVCategoryProductListViewController = (SVUtil.getPagingVCWithIdentifier("SVCategoryProductListViewController") as? SVCategoryProductListViewController)!
            
            vc.fetchCriteria = SVProductFilterCriteria()
            vc.fetchCriteria?.masterCategoryId = masterCategory.identifier
            vc.fetchCriteria?.categoryId = cat.identifier
            
            controllers.append(vc)
            
        }
        
        
        
        return controllers
    }
    
    private func viewControllersForMasterCategories(promo:Bool) -> Array<SVProductListViewController> {
        
        var controllers:Array<SVProductListViewController> = Array<SVProductListViewController>()
        
        let cats = SVCoreDataManager.fetchCategoriesWithLevel(1, priority: true)
        
        for cat:ProductCategory in cats! {
        
            var vc:SVProductListViewController? = nil
            if promo == true {
                
                vc = (SVUtil.getPagingVCWithIdentifier("SVPromoProductListViewController") as? SVPromoProductListViewController)!
            }
            else {
                vc = (SVUtil.getPagingVCWithIdentifier("SVCategoryProductListViewController") as? SVCategoryProductListViewController)!
            }
            
            
            vc!.fetchCriteria = SVProductFilterCriteria()
            vc!.fetchCriteria?.masterCategoryId = cat.identifier
            controllers.append(vc!)
            
        }
        
        return controllers
    }
    
    private func catMenuForCategories(categories:Array<ProductCategory>) -> CategoriesMenu{
        
        var items:Array<MenuItemViewCustomizable> = Array<MenuItemViewCustomizable>()
        for cat:ProductCategory in categories {
            
            var item:CategoryMenuItem = CategoryMenuItem()
            
            item.title = cat.name
            items.append(item)
            
        }
        
        return CategoriesMenu(itemsOptions: items)
    }
    
    private func categoryMenuForMasterCategories()->CategoriesMenu {
        
        let cats = SVCoreDataManager.fetchCategoriesWithLevel(1, priority: true)
        
        return catMenuForCategories(cats!)
        
    }
    
    private func categoryMenuForChildCategories(masterCat:ProductCategory)->CategoriesMenu {
        
        let category = SVCoreDataManager.categoryWithId(masterCat.identifier!, level: 1)
        
        let array:Array<ProductCategory> = (category?.children?.allObjects as? Array<ProductCategory>)!
        
        let sortedCategories = array.sort({ (cat1 : ProductCategory, cat2 : ProductCategory) -> Bool in
            
            
            return cat1.priority_id?.integerValue < cat2.priority_id?.integerValue})

        return catMenuForCategories(sortedCategories)
        
    }
    
    private func pagingConfigForPromo() -> (controllers:Array<UIViewController>, menuOptions:CategoriesMenu, showFilter:Bool){
        
        let controllers:Array<SVProductListViewController> = viewControllersForMasterCategories(true)
        
        for controller:SVProductListViewController in controllers {
            
            controller.productViewType = .Promo
            controller.fetchCriteria?.promo = true
        }
        
        let menu = categoryMenuForMasterCategories()
        
        return (controllers, menu, false)
    }
    private func pagingConfigForBestSelling() -> (controllers:Array<UIViewController>, menuOptions:CategoriesMenu, showFilter:Bool){
        
        let controllers:Array<SVProductListViewController> = viewControllersForMasterCategories(false)
        
        for controller:SVProductListViewController in controllers {
            
            controller.productViewType = .BestSelling
        }
        
        let menu = categoryMenuForMasterCategories()
        
        return (controllers, menu, true)
        
    }
    
    private func pagingConfigForFavorites() -> (controllers:Array<UIViewController>, menuOptions:CategoriesMenu, showFilter:Bool){
        
        let controllers:Array<SVProductListViewController> = viewControllersForMasterCategories(false)
        
        let menu = categoryMenuForMasterCategories()
        
        return (controllers, menu, false)
    }
    
    private func pagingConfigForMasterCategory(category:ProductCategory) -> (controllers:Array<UIViewController>, menuOptions:CategoriesMenu, showFilter:Bool){
        
        //TODO - VC for Promo, Best Sell need to add.
        var controllers:Array<SVProductListViewController> = Array<SVProductListViewController>()
        
        // Add View for Promo
        let promoVC:SVPromoProductListViewController = (SVUtil.getPagingVCWithIdentifier("SVPromoProductListViewController") as? SVPromoProductListViewController)!
        
        promoVC.fetchCriteria = SVProductFilterCriteria()
        promoVC.fetchCriteria?.masterCategoryId = category.identifier
        promoVC.fetchCriteria?.promo = true
        promoVC.productViewType = .Promo
        
        // Add View for Best Selling
        let bestSellingVC:SVCategoryProductListViewController = (SVUtil.getPagingVCWithIdentifier("SVCategoryProductListViewController") as? SVCategoryProductListViewController)!
        
        bestSellingVC.fetchCriteria = SVProductFilterCriteria()
        bestSellingVC.fetchCriteria?.masterCategoryId = category.identifier
        bestSellingVC.productViewType = .BestSelling
        
        controllers.append(promoVC)
        
        controllers.append(bestSellingVC)
        
        controllers.appendContentsOf(viewControllersForChildCategories(category))
        
        
        
        var menu = categoryMenuForChildCategories(category)
    
        var promoMenuItem:CategoryMenuItem = CategoryMenuItem()
        
        promoMenuItem.title = "Promo"

        menu.itemsOptions.insert(promoMenuItem, atIndex: 0)

        var bsMenuItem:CategoryMenuItem = CategoryMenuItem()
        
        bsMenuItem.title = "Best Selling"
        
        menu.itemsOptions.insert(bsMenuItem, atIndex: 1)

        
        return (controllers, menu, true)
    }
    
    init(viewType:PagingViewType,category:ProductCategory?) {
        
        super.init()
        
        switch viewType {
        case .Promo:
            pagingConfig = pagingConfigForPromo()
        case .BestSelling:
            pagingConfig = pagingConfigForBestSelling()
        case .Favourite:
            pagingConfig = pagingConfigForFavorites()
        case .Category:
            pagingConfig = pagingConfigForMasterCategory(category!)
            
        }
     }
    
}

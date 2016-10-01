//
//  PagingMenuViewController.swift
//  PagingMenuControllerDemo
//
//  Created by Yusuke Kita on 5/17/16.
//  Copyright © 2016 kitasuke. All rights reserved.
//

import UIKit
import PagingMenuController


class PagingMenuViewController: SVBaseViewController {
    
    
    var childControllers:Array<UIViewController> = Array<UIViewController>()
    var menuOptions:MenuViewCustomizable? = nil
    var selectedController:UIViewController? = nil
    var options: PagingMenuControllerCustomizable!
    var showFilters:Bool = false
    
    //MARK : Private Methods
    internal func filterTapped() {
    
        if selectedController == nil {
            
            let options:PagingMenuOptions1 = self.options as! PagingMenuOptions1
            
            selectedController = options.controllers.first
        }
        
        let controller:SVProductListViewController = (selectedController as? SVProductListViewController)!
        
        controller.showFilters()
        
    }
    
    //MARK: Overridden Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //TODO- remove next line
        //showFilters = false
        
        selectedController = self.childControllers.first
        
        if showFilters == true {
            var rightButtons = self.navigationItem.rightBarButtonItems;
            
            let filterButton:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "filter_icon"), style: .Plain, target: self, action: #selector(filterTapped))
            
            rightButtons?.insert(filterButton, atIndex: 1)
            
            filterButton.imageInsets = UIEdgeInsetsMake(0.0, 0.0, 0, 0)
            
            let searchButton:UIBarButtonItem = rightButtons![2]
            
            searchButton.imageInsets = UIEdgeInsetsMake(0, 0.0, 0, 0)
            
            self.navigationItem.rightBarButtonItems = rightButtons
            
        }
        
        let pagingMenuController:PagingMenuController = self.childViewControllers.first as! PagingMenuController
        pagingMenuController.delegate = self
        
        
        pagingMenuController.setup(options)
        
        let menuOptions:PagingMenuOptions1 = (options as? PagingMenuOptions1)!
        
        let controller:SVProductListViewController = (menuOptions.controllers.first as? SVProductListViewController)!
        let controller2:SVProductListViewController = (menuOptions.controllers[1] as? SVProductListViewController)!
        
        
        
        if  (controller2.productViewType != .Promo
            &&  controller.productViewType == .Promo) {
            
            var params:Array<(key: String, value: AnyObject)> = Array<(key: String, value: AnyObject)>()
            
            params.append(("data[storeId]", "41"))
            params.append(("data[pmcId]", (controller.fetchCriteria?.masterCategoryId)!))

            
            SVJSONAppService.fetchDeals(params, responsObjectKey: "", completionHandler: { (deals:SVDeals?, error:NSError?) in
                
                if let _ = deals {
                    
                    if deals?.deals.count > 0 {
                        
                    }
                    else {
                        pagingMenuController.moveToMenuPage(1)
                    }
                }
                else {
                    pagingMenuController.moveToMenuPage(1)
                }
            })
            
        }
    
        
        
    }
    
    
    override func navBarConfig() -> SVNavBarConfig {
        
        return SVNavBarConfig(showBack: true, showSearch: true, showCart: true, title: self.title!)
    }
}

extension PagingMenuViewController: PagingMenuControllerDelegate {
    // MARK: - PagingMenuControllerDelegate

    func willMoveToPageMenuController(menuController: UIViewController, previousMenuController: UIViewController) {
        
        selectedController = menuController
    }

    func didMoveToPageMenuController(menuController: UIViewController, previousMenuController: UIViewController) {
    }
    
    func willMoveToMenuItemView(menuItemView: MenuItemView, previousMenuItemView: MenuItemView) {
        
    }
    
    func didMoveToMenuItemView(menuItemView: MenuItemView, previousMenuItemView: MenuItemView) {
        
    }
}
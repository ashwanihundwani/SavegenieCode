//
//  SVProductListViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/2/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

let sponsopredProductMaxLimit = 3

class SVProductListViewController: SVBaseViewController, UITableViewDataSource, UITableViewDelegate, SVFilterViewDelegate, SVProductCellDelegate {

    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var lblNoContent:UILabel!
    
    var filterView:SVFilterView? = nil
    
    var productViewType:PagingViewType = .Category
    
    var products:Array<Product>? = Array<Product>()
    
    var fetchCriteria:SVProductFilterCriteria? = nil
    
    var selectedCategory:ProductCategory? = nil
    
    var sponsoredProductArray = SVSponsoredProduct.getSponsoredProductsArray()
    
    //MARK: Protected Methods
    
    internal func showUIBasedOnTotalProducts() {
        if self.itemsAvailable() {
            
            self.tableView.reloadData()
            self.lblNoContent.hidden = true
        }
        else {
            self.lblNoContent.hidden = false
            self.tableView.hidden = true
        }
    }
    
    //MARK: Abstract Methods
    
    internal func numberOfItems() -> Int {
        
        if let _ = products {
            return (self.products?.count)!
        }
        
        return 0
    }
    
    internal func itemsAvailable() -> Bool{
        
        return products?.count > 0
    }
    
    internal func reloadData()
    {
        if let criteria = fetchCriteria {
            fetchCriteria?.storeID = SVStore.getCurrentStore()?.identifier
            var productArray = SVCoreDataManager.filterProductsForCriteria(criteria)
            if let _ = sponsoredProductArray, _ = productArray {
                
                var sponsopredProductIndex = Array<Int>()
                for sponsoredProduct in sponsoredProductArray! {
                    for (index, product) in productArray!.enumerate() {
                        
                        if sponsoredProduct.productSKUId?.componentsSeparatedByString("-").contains(product.identifier!) == true {
                            sponsopredProductIndex.append(index)
                        }
                        
                        if sponsopredProductIndex.count >= sponsopredProductMaxLimit {
                            break
                        }
                    }
                    
                    if sponsopredProductIndex.count >= sponsopredProductMaxLimit {
                        break
                    }
                }
                
                for index in sponsopredProductIndex {
                    let product = productArray![index]
                    product.sponsored = true
                    productArray!.insert(product, atIndex: 0)
                    productArray!.removeAtIndex(index + 1)
                }
                
                products = productArray
            }
            else {
                products = SVCoreDataManager.filterProductsForCriteria(criteria)
            }
        }
        
        showUIBasedOnTotalProducts()
    }
    
    internal func showFilters() {
        
        if let _ = filterView {
            
            filterView?.hide()
        }
        else {
            
            let filterView:SVFilterView =  (NSBundle.mainBundle().loadNibNamed("SVFilterView", owner: nil, options: nil).first as? SVFilterView)!
            
            self.view.addSubview(filterView)
            
            filterView.delegate = self
            
            filterView.categories = fetchSubCategories()
            
            filterView.selectedCategory = selectedCategory
            
            
            filterView.frame = self.view.bounds
            filterView.frame.origin.y = self.view.frame.size.height
            
            filterView.show()
            
            self.filterView = filterView
            
        }
        
    }
    internal func cellHeight(indexPath:NSIndexPath)-> CGFloat {
    
        return 100
    }
    
    internal func prepareCell(cell:SVProductCell, product:Product) {
        
        cell.setDBProduct(product)
        cell.showSponsoredTag(product.sponsored)
        cell.showOfferLabel(getOfferForProduct(product))
        
    }
    
    func getOfferForProduct(product: Product) -> Bool {
        let coupons = SVDeals.getCurrentDeals()?.coupons
        var totalOfferProduct = Array<String>()
        if let _ = coupons {
            for promo in coupons! {
                
                
                if let buyPIds = promo.buyProductIds {
                    for pId in buyPIds {
                        totalOfferProduct.append(pId)
                    }
                }
                
                if let getPIds = promo.getProductIds {
                    for pId in getPIds {
                        totalOfferProduct.append(pId)
                    }
                }
            }
        }
        
        return totalOfferProduct.contains(product.identifier!)
    }
    
    internal func cellForIndexPath(indexPath:NSIndexPath)-> UITableViewCell
    {
        let tableCell:SVProductCell = (tableView.dequeueReusableCellWithIdentifier(String(SVProductCell)) as? SVProductCell)!
        //tableCell.showSponsoredTag(indexPath.row < sponsopredProductIndex.count)
        
        tableCell.delegate = self
        
        self.prepareCell(tableCell, product: products![indexPath.row])
        
        return tableCell
    }
    
    internal func performAddAction(sender:SVProductCell) {
        
        if let product = sender.dbProduct {
            SVUtil.showLoader()
            SVCartUpdateManager.addSKU(product.identifier!, completionHandler: { (success:Bool) in
                
                SVUtil.hideLoader()
            })
        }
    }
    
    internal func performSubstractAction(sender:SVProductCell) {
        
        if let product = sender.dbProduct {
            
            SVUtil.showLoader()
            SVCartUpdateManager.removeSKU(product.identifier!, completionHandler: { (success:Bool) in
                
                SVUtil.hideLoader()
            })
            
        }
        
    }
    
    //MARK: View Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor(hexString: "EEEEEE")   
        self.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Table View datasource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.numberOfItems()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.cellHeight(indexPath)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return self.cellForIndexPath(indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.productViewType != .Promo {
            
            let controller:SVProductDetailViewController = (SVUtil.getVCWithIdentifier("SVProductDetailViewController") as? SVProductDetailViewController)!
            
            controller.product = products![indexPath.row]
            
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SVProductListViewController {
    
    
    //MARK: Private Methods
    
    
    //private func messageForViewType()
    
    func levelForController()->Int8 {
        
        if self.productViewType == .BestSelling {
            return 1
        }
        
        if let _ = self.fetchCriteria?.categoryId {
            
            return 2
        }
        
        return 1
    }
    
    func fetchSubCategories() -> Array<ProductCategory> {
        
        if self.productViewType == .BestSelling {
            
            let categories = SVCoreDataManager.fetchSubCategoriesForCategoryWithId(self.fetchCriteria!.masterCategoryId!, level: 1)
            
            return categories
        }
        
        if let _ = self.fetchCriteria?.categoryId {
            
            let categories = SVCoreDataManager.fetchSubCategoriesForCategoryWithId(self.fetchCriteria!.categoryId!, level: 2)
            
            return categories
            
        }
        else {
            
            let categories = SVCoreDataManager.fetchSubCategoriesForCategoryWithId(self.fetchCriteria!.masterCategoryId!, level: 1)
            
            return categories

        }
    }
    
    //MARK: SVFilterView Delegate Methods
    func didDisappearView(sender: SVFilterView) {
        
        
        self.filterView = nil
        
    }
    
    func didSelectShowAll(sender: SVFilterView) {
        
        let level:Int8 = self.levelForController()
        
        if level == 1 {
            self.fetchCriteria?.categoryId = nil
        }
        else if level == 2 {
            self.fetchCriteria?.productTypeId = nil
        }
        
        self.reloadData()
        
        self.filterView?.hide()
        self.filterView = nil
    }
    
    func didSelectCategory(category: ProductCategory, sender: SVFilterView) {
        
        
        let level:Int8 = self.levelForController()
        
        if level == 1 {
            self.fetchCriteria?.categoryId = category.identifier
        }
        else if level == 2 {
            self.fetchCriteria?.productTypeId = category.identifier
        }
        
        self.selectedCategory = category
        
        self.reloadData()
        
        self.filterView?.hide()
        self.filterView = nil
        
    }
    
    //MARK: Product Cell Delegate Methods
    func didTapPlus(sender: SVProductCell, maxreached: Bool) {
        
        if maxreached == true {
            
            SVUtil.showAlert(SVConstants.APP_NAME, message: "Maximum limit reached", controller: self)
            return
        }

        self.performAddAction(sender)
        
    }
    func didTapMinus(sender: SVProductCell) {
        
        self.performSubstractAction(sender)
    }
    
    
    
}

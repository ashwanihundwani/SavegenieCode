//
//  SVPromoProductListViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/2/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

let PRODUCT_CELL_HEIGHT = 90
let PLUST_CELL_HEIGHT = 20

class SVPromoProductListViewController: SVProductListViewController {

    var deals:SVDeals? = nil
    var isLoading:Bool = false
    
    //MARK : Private Methods
    private func prepareUI() {
        
        self.tableView.reloadData()
        self.showUIBasedOnTotalProducts()
    }
    
    private func fetchDeals() {
        
        isLoading = true
        
        var params:Array<(key: String, value: AnyObject)> = Array<(key: String, value: AnyObject)>()
        
        params.append(("data[storeId]", (SVStore.getCurrentStore()?.identifier)!))
        params.append(("data[pmcId]", (self.fetchCriteria?.masterCategoryId)!))

        SVJSONAppService.fetchDeals(params, responsObjectKey: "") { (deals:SVDeals?, error:NSError?) in
            
            self.isLoading = false
            if let _ = deals {
                
                self.deals = deals
                self.prepareUI()
            }
            
        }
    }
    
    
    
    //MARK : Overridden Methods
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.isLoading == false {
            
            self.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    override func itemsAvailable() -> Bool{
        
        return self.deals?.deals.count > 0
    }
    
    override func reloadData()
    {
        self.fetchDeals()
    }
    
    override func showFilters() {
        
    }
    
    override func cellHeight(indexPath:NSIndexPath)-> CGFloat {
        
        var height:Int = 65
        
        if self.deals?.deals.count == 1 {
            
            height = height + 115
        }
        else if self.deals?.deals.count > 1 {
            
            let productCount = self.deals?.deals[indexPath.row].dealProducts.count;
            
            height = height + productCount! * PRODUCT_CELL_HEIGHT + (productCount! - 1) * PLUST_CELL_HEIGHT
        }
        
        
        return CGFloat(height)
        
    }
    
    override func numberOfItems() -> Int {
        
        if let _ = deals {
            
            return (deals?.deals.count)!
        }
        return 0
    }
    
    override func cellForIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:SVPromoProductCell = (self.tableView.dequeueReusableCellWithIdentifier("SVPromoProductCell") as? SVPromoProductCell)!
        
        cell.delegate = self
        cell.setDeal((self.deals?.deals[indexPath.row])!)
        
        return cell
    }
    
    override func performAddAction(sender: SVProductCell) {
        
        let promoCell = sender as? SVPromoProductCell
    
        SVUtil.showLoader()
        if let tempPromo:SVDeal = promoCell?.promo {
            
            
            SVCartUpdateManager.addSKUs(tempPromo.allSKUIDs(), counts: tempPromo.allSKUCounts(), completionHandler: { (success:Bool) in
                
                SVUtil.hideLoader()
                
            })
        }
    }
    
    override func performSubstractAction(sender: SVProductCell) {
        
        let promoCell = sender as? SVPromoProductCell
        
        SVUtil.showLoader()
        if let tempPromo:SVDeal = promoCell?.promo {
            
            SVCartUpdateManager.removeSKUs(tempPromo.allSKUIDs(), counts: tempPromo.allSKUCounts(), completionHandler: { (success:Bool) in
                
                
                SVUtil.hideLoader()
            })
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

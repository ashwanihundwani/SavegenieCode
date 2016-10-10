//
//  SVStoreListViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 28/08/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit


enum StoreListSection: Int {
    
    case horizontalBanners = 0
    case stores = 1
    case verticalBanners = 2
}

class StoreListUIHelper : NSObject {
    
    var sections:Array<StoreListSection> = []
    //Public Helper Methods
    subscript(index:Int)-> StoreListSection {
        
        return sections[index]
    }
    func count() -> Int {
        
        return sections.count
    }
    
    //Public Methods
    
    internal func cellIdentifierForSection(section:NSIndexPath)-> String {
        
        var identifier:String = ""
        
        let section = sections[section.section]
        
        switch section {
            
        case .horizontalBanners:
            identifier = "SVBannerTableCell"
            
        case .verticalBanners:
            identifier = "SVVerticalBannerCell"
        case .stores:
            identifier = "SVStoreCell"
        }
        
        return identifier
    }
    
    internal func addSection(section:StoreListSection) {
        
        sections.append(section)
        sections.sortInPlace{ (section1:StoreListSection, section2:StoreListSection) -> Bool in
            
            return section1.rawValue < section2.rawValue
        }
    }
    
}



class SVStoreListViewController: SVBaseViewController {

    @IBOutlet weak var tableView:UITableView!
    var uiHelper:StoreListUIHelper = StoreListUIHelper()
    var horizontalBanners:SVBanners? = nil
    var verticalBanners:SVBanners? = nil
    var stores:SVStores? = nil;
    var shopCategory:SVShopCategory?
    var masterCategories:SVMasterCategories?
    var resultCounter:Int = 0
    var commonSlot:SVCommonSlot? =  nil
    var promos:SVDeals? = nil
    var selectedStore:SVStore? = nil
    
    override func navBarConfig() -> SVNavBarConfig {
        
        return SVNavBarConfig(showBack: true, showSearch: false, showCart: false, title: (self.shopCategory?.catName)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchBanners()
        self.fetchStores()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private Methods
    private func fetchBanners() {
        
        let params:Array<(key:String, value:AnyObject)> = [("data[page]", "2"), ("shopcategory_id", (shopCategory?.identifier)!)]
        
        SVJSONAppService.fetchBanners(params, responsObjectKey: "") { (banners:
            SVBanners?, error:NSError?) in
            
            if let _ = banners {
                
                self.verticalBanners = banners?.getVerticalBanners()
                
                if self.verticalBanners?.banners!.count > 0 {
                    
                    self.uiHelper.addSection(.verticalBanners)
                }
                
                self.horizontalBanners = banners?.getHorizontalBanners()
                
                if self.horizontalBanners?.banners!.count > 0 {
                    
                    self.uiHelper.addSection(.horizontalBanners)
                }
                
                self.tableView.reloadData()
            }
            
        }
    }
    
    private func fetchStores() {
        
        let params:Array<(key:String, value:AnyObject)> = [("data[shop_cat]", (self.shopCategory?.identifier!)!)]
        
        SVJSONAppService.fetchStores(params, responsObjectKey: "") { (stores:
            SVStores?, error:NSError?) in
            
            if let _ = stores {
                
                self.stores = stores
                
                if self.stores?.stores!.count > 0 {
                    
                    self.uiHelper.addSection(.stores)
                }
                
                self.tableView.reloadData()
            }
            
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

extension SVStoreListViewController : UITableViewDelegate, UITableViewDataSource {
    
    //MARK: UITableView Delegate & Datasource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return self.uiHelper.count()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.uiHelper[section] == .verticalBanners{
            
            return (self.verticalBanners?.banners?.count)!
        }
        else if self.uiHelper[section] == .horizontalBanners {
            
            return 1
        }
        else if  self.uiHelper[section] == .stores{
            return (self.stores?.stores?.count)!
        }
        else {
            
            return 1
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view:UIView =  UIView(frame: CGRectMake(0,0,self.view.frame.size.width, 20))
        
        view.backgroundColor = UIColor(RGB: (r: 230, g: 230, b: 230))
        
        return view
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 15.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let section = uiHelper[indexPath.section]
        
        switch section {
            
        case .horizontalBanners, .verticalBanners:
            return self.view.frame.size.width * SVConstants.BANNER_HEIGHT_MULTIPLIER
        case .stores:
            return 70
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(uiHelper.cellIdentifierForSection(indexPath))
        
        if cell == nil {
            
            let section = uiHelper[indexPath.section]
            
            switch section {
                
            case .horizontalBanners:
                
                let tempCell:SVBannerTableCell = (NSBundle.mainBundle().loadNibNamed("SVBannerTableCell", owner: nil, options: nil).first as? SVBannerTableCell)!
                
                tempCell.banners = (self.horizontalBanners?.banners)!;
                tempCell.collectionView.reloadData()
                cell = tempCell
                //cell.banners = self.horizontalBanners
                
            case .verticalBanners:
                
                let tempCell:SVVerticalBannerCell = (NSBundle.mainBundle().loadNibNamed("SVVerticalBannerCell", owner: nil, options: nil).first as? SVVerticalBannerCell)!
                
                tempCell.setBannerData((self.verticalBanners?.banners![indexPath.row])!)
                
                cell = tempCell
            case .stores:
                
                let tempCell:SVStoreCell = (NSBundle.mainBundle().loadNibNamed("SVStoreCell", owner: nil, options: nil).first as? SVStoreCell)!
                
                tempCell.setStore((self.stores?.stores![indexPath.row])!)
                
                
                cell = tempCell
                
            }
            
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.uiHelper[indexPath.section] == .stores {
            
            let store:SVStore = (stores?.stores![indexPath.row])!
            
            self.selectedStore = store
            
            SVStore.setCurrentStore(store);
            
            SVVisitedStores.addStore(store)
            
            SVUtil.showLoader()
            self.fetchCategories(store)
            self.fetchPromos(store)
            self.fetchSponsorProducts(store)
            
            if SVVisitedStores.multipleStoresVisited() {
                
                self.fetchCommonSlot(store)
            }
            
            
        }
    }
}

//MARK: Home Screen Functionality
extension SVStoreListViewController : SVMultipleStoreViewDelegate {
    
    private func fetchCategories(store:SVStore) {
        
        let params:Array<(key:String, value:AnyObject)> = [("data[store_id]", store.identifier!), ("data[shopcategory_id]", (shopCategory?.identifier)!)]
        
        
        SVJSONAppService.fetchMasterCategories(params, responsObjectKey: "") { (categories:SVMasterCategories?, error:NSError?) in
            
            
            if let _ = categories {
                
                self.masterCategories = categories
            }
            else {
                
            }
            self.resultCounter = self.resultCounter + 1
            
            self.performActionBasedOnFetchedData()
        }
    }
    
    private func fetchPromos(store:SVStore) {
        
        let params:Array<(key:String, value:AnyObject)> = [("data[storeId]", store.identifier!)]
        
        SVJSONAppService.fetchPromos(params, responsObjectKey: "") { (promos:SVDeals?, error:NSError?) in
            
            if let _ = promos {
                self.promos = promos
            }
            self.resultCounter = self.resultCounter + 1
            
            self.performActionBasedOnFetchedData()
            
        }
        
    }
    
    private func fetchSponsorProducts(store:SVStore) {
        
        let params:Array<(key:String, value:AnyObject)> = [("data[storeId]", store.identifier!)]
        
        SVJSONAppService.fetchSponsoredProducts(params, responsObjectKey: "") { (sponsoredProduct: SVSponsoredProduct?, error:NSError?) in
            
            //TODO - Save the sponsor products Model to use it on subsequent screens.
            SVSponsoredProduct.setSponsoredProductsArray(sponsoredProduct?.spProdArray)
            self.resultCounter = self.resultCounter + 1
            self.performActionBasedOnFetchedData()
        }
    }
    
    
    private func fetchCommonSlot(store:SVStore) {
    
        let params:Array<(key:String, value:AnyObject)> = [("data[storeId]", store.identifier!)]
        
        
        SVJSONAppService.fetchCommonSlot(params, responsObjectKey: "") { (commonSlot:SVCommonSlot?, error:NSError?) in
            
            if let _ = commonSlot {

                self.commonSlot = commonSlot;
                
            }
            else {
                
            }
            self.resultCounter = self.resultCounter + 1
            
            self.performActionBasedOnFetchedData()
            
            
        }
    }
    
    private func performActionBasedOnFetchedData() {
        // 3 will be 4 after sponsor products parsing
        if SVVisitedStores.multipleStoresVisited() == true
            && self.resultCounter == 4 {
            
            self.resultCounter = 0
            SVUtil.hideLoader()
            let addressView:SVMultipleStoreView = (NSBundle.mainBundle().loadNibNamed("MultipleStoreView", owner: nil, options: nil).first as? SVMultipleStoreView)!
                        
            addressView.delegate = self
            addressView.setDeliverySlot("Your estimated delivery slot would be from \(commonSlot!.date!) \(commonSlot!.slot!)")
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            addressView.frame = appDelegate.window!.bounds
            
            self.navigationController?.view.addSubview(addressView)
            
            
        }
            // 2 will be 3 after sponsor products parsing
        else if (self.resultCounter == 3 && SVVisitedStores.multipleStoresVisited() == false) {
            
            SVUtil.hideLoader()
            self.resultCounter = 0
            let vc:SVHomeViewController = (SVUtil.getVCWithIdentifier("SVHomeViewController") as? SVHomeViewController)!
            
            vc.masterCategories = self.masterCategories
            vc.store = self.selectedStore
            vc.promos = self.promos
            
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    //MARK: Multiple store view
    func didTapProceed(view: SVMultipleStoreView) {
        
        if let _ = self.masterCategories {
            
            let vc:SVHomeViewController = (SVUtil.getVCWithIdentifier("SVHomeViewController") as? SVHomeViewController)!
            
            vc.masterCategories = masterCategories
            vc.promos = self.promos
            vc.store = self.selectedStore
            
            self.navigationController?.pushViewController(vc, animated: false)

        }
        
        view.removeFromSuperview()
    }
    
    
}



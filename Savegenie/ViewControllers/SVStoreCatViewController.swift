//
//  SVStoreCatViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 23/08/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

let CATEGORY_CELL_HEIGHT:CGFloat = 140.0

enum StoreCatSection: Int {
    
    case addressSelection = 0
    case horizontalBanners = 1
    case categories = 2
    case verticalBanners = 3
}



class StoreCatUIHelper : NSObject {
    
    var sections:Array<StoreCatSection> = [.addressSelection]
    
    
    
    //Public Helper Methods
    subscript(index:Int)-> StoreCatSection {
    
        return sections[index]
    }
    func count() -> Int {
        
        return sections.count
    }
    
    //Public Methods
    
    internal func cellIdentifierForSection(section:NSIndexPath)-> String {
    
        var identifier:String = ""
        
        let section = sections[section.section]
        
        switch section{
        case .addressSelection:
            identifier = "SVChangeLocationCell"
            
        case .horizontalBanners:
            identifier = "SVBannerTableCell"
            
        case .verticalBanners:
            identifier = "SVBannerCell"
        case .categories:
            identifier = "SVStoreCategoriesCell"
        
        
        }
        return identifier
    }
    
    internal func addSection(section:StoreCatSection) {
        
        sections.append(section)
        sections.sortInPlace{ (section1:StoreCatSection, section2:StoreCatSection) -> Bool in
          
            return section1.rawValue < section2.rawValue
        }
    }
    
    
}

class SVStoreCatViewController: SVBaseViewController, SVStoreCategoriesCellDelegate{
    
    @IBOutlet weak var tableView:UITableView!
    var uiHelper:StoreCatUIHelper = StoreCatUIHelper()
    var areas:SVAreas?
    var horizontalBanners:SVBanners? = nil
    var verticalBanners:SVBanners? = nil
    var categories:SVShopCategories? = nil
    
    //MARK: Private Methods
    
    private func changeArea(value:String) {
        
        SVJSONAppService.changeArea([(key: "data[area_id]", value: value)], responsObjectKey:"") { (response:SVChangeAddressResponse?, error:NSError?) in
            
            if let _ = response {
                
                let controller:SVLoaderViewController = (SVUtil.getVCWithIdentifier("SVLoaderViewController") as? SVLoaderViewController)!
                
                SVUtil.appWindow().rootViewController = controller
                
            }
        }
    }
    private func fetchAreas() {
        
        SVXMLAppService.fetchAreas { (response:NSObject?, error:NSError?)->Void in
            
            if let _ = response {
                
                self.areas = response as? SVAreas
                
            }
        }
    }
    
    private func fetchBanners() {
        
        let params:Array<(key:String, value:AnyObject)> = [("data[page]", "1")]
        
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
    private func fetchShopCategories() {
        
        let params:Array<(key:String, value:AnyObject)> = []
        
        SVJSONAppService.fetchShopCategories(params, responsObjectKey: "") { (categories:
            SVShopCategories?, error:NSError?) in
            
            if let _ = categories {
                
                self.categories = categories;
                if self.categories?.categories?.count > 0 {
                    self.uiHelper.addSection(.categories)
                    self.tableView.reloadData()
                }
                
            }
            
        }
    }
    
    internal func menuTapped() {
        
        let drawerController = self.navigationController?.parentViewController as? KYDrawerController;
        
        if let _ = drawerController {
            drawerController?.setDrawerState(.Opened, animated: true)
        }
        
    }

    
    private func doInitialConfiguration() {
        
        let menuButton:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu_icon"), style: .Plain, target: self, action: #selector(menuTapped))
        
        self.navigationItem.leftBarButtonItem = menuButton
        
        self.fetchAreas()
        self.fetchBanners()
        self.fetchShopCategories()
    }

    //MARK: View Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.doInitialConfiguration()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func navBarConfig() -> SVNavBarConfig {
        
        return SVNavBarConfig(showBack: false, showSearch: false, showCart: false, title: "Shop Category")
    }
    
}

extension SVStoreCatViewController : UITableViewDelegate, UITableViewDataSource, SVChangeLocationCellDelegate {
    
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
        else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view:UIView =  UIView(frame: CGRectMake(0,0,self.view.frame.size.width, 20))
        
        view.backgroundColor = UIColor(RGB: (r: 230, g: 230, b: 230))

        
        if self.uiHelper[section] == .categories {
            
            let label = UILabel(frame: CGRectMake(0,22,self.view.frame.size.width, 20))
            
            label.text = "Select Shop Category"
            label.textAlignment = .Center
            label.textColor = UIColor.darkGrayColor()
            let mainView:UIView =  UIView(frame: CGRectMake(0,0,self.view.frame.size.width, 40))
            
            mainView.addSubview(view)
            mainView.addSubview(label)
            return mainView
        }
        else {
            return view
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if self.uiHelper[section] == .addressSelection{
            
            return 5.0
        }
        else if self.uiHelper[section] == .categories {
            return 45
        }
        else
        {
            return 15
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let section = uiHelper[indexPath.section]
        
        switch section {
            
        case .addressSelection:
            return 35
            
        case .categories:
            let dividend = ((self.categories?.categories?.count)! / 3)
            let modulus =  ((self.categories?.categories?.count)! % 3)
            
            let factor = dividend + ((modulus > 0) ? 1 : 0);
            
            
            return CATEGORY_CELL_HEIGHT * CGFloat(factor)
        
        case .horizontalBanners:
            return self.view.frame.size.width * SVConstants.BANNER_HEIGHT_MULTIPLIER
            
        case .verticalBanners:
            return self.view.frame.size.width * SVConstants.BANNER_HEIGHT_MULTIPLIER
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(self.uiHelper.cellIdentifierForSection(indexPath))
        
        if cell == nil {
            
            let section = uiHelper[indexPath.section]
            
            switch section {
            case .addressSelection:
                
                
                let tempCell:SVChangeLocationCell = (NSBundle.mainBundle().loadNibNamed("SVChangeLocationCell", owner: nil, options: nil).first as? SVChangeLocationCell)!
                
                tempCell.delegate = self
                
                cell = tempCell
                
                
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
            case .categories:
                
                let tempCell:SVStoreCategoriesCell = (NSBundle.mainBundle().loadNibNamed("SVStoreCategoriesCell", owner: nil, options: nil).first as? SVStoreCategoriesCell)!
                
                tempCell.delegate = self

                tempCell.categories = (self.categories?.categories)!
                
                cell = tempCell
            }
        }
        
        return cell!
    }
    
    //MARK: Location Change Cell Delegate
    func didTapChangeLocation(sender: SVChangeLocationCell) {
        
        if let _ = self.areas {
            ActionSheetStringPicker.showPickerWithTitle("Select area", rows: self.areas?.displayTexts(), initialSelection: 0, doneBlock: { (picker:ActionSheetStringPicker!, index:Int, value:AnyObject!) in
                
                sender.btnChangeLocation .setTitle(value as? String, forState: .Normal)
                sender.lblLocation.text = "Your delivery area is " + (value as? String)!
                
                self.changeArea((self.areas?.areaIdForText((value as? String)!))!)
                
                }, cancelBlock: { (picker:ActionSheetStringPicker!) in
                    
                    
                }, origin: sender)
        }
    }
    
    //MARK : SVStoreCategoriesCell Delegate Methods
    
    func didTapCategory(category: ISVShopCategory, sender: SVStoreCategoriesCell) {
        
        let categoryInstance:SVShopCategory = category as! SVShopCategory
        
        let controller:SVStoreListViewController = (SVUtil.getVCWithIdentifier("SVStoreListViewController") as? SVStoreListViewController)!
        
        controller.shopCategory = categoryInstance
        
        self.navigationController?.pushViewController(controller, animated: true)
        
        
    }
}


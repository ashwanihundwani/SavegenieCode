//
//  SVHomeViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/23/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import PagingMenuController

let PROMO_INDEX = 0
let BEST_SELLING_INDEX = 1
let FAVOURITES_INDEX = 2
let TOTAL_OTHER_CATEGORIES = 3


class SVHomeViewController: SVBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblStoreName:UILabel!
    
    var store:SVStore?
    var categories:Array<ProductCategory> = Array<ProductCategory>()
    var masterCategories:SVMasterCategories?
    var promos:SVDeals?
    
    //MARK: Overridden Methods
    override func navBarConfig() -> SVNavBarConfig {
        
        return SVNavBarConfig(showBack: true, showSearch: false, showCart: false, title: "Master Category")
    }

    //MARK : IBAction Methods
    @IBAction func onViewTap() {
        
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    //MARK: View Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblStoreName.text = store?.name
        
        SVTextAppService.selectCart(completionHandler: { (obj:AnyObject?, error:NSError?) in
            
            
        })
        
        self.categories = SVCoreDataManager.fetchCategoriesWithLevel(1, priority:true)!
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Collection View Delegate & Datasource Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.masterCategories?.categories?.count)!;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(self.view.frame.size.width / 2 - 3, self.view.frame.size.width / 2 - 3)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(3, 0, 0, 0)
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:SVHomeItemCell = collectionView .dequeueReusableCellWithReuseIdentifier("SVHomeItemCell", forIndexPath: indexPath) as! SVHomeItemCell
        
        let cat:SVCategory = (self.masterCategories?.categories![indexPath.row])!
        cell.imgCategory.setImageWithURL(SVUtil.masterCategoryImageURL(cat.image!))
        cell.lblCatName.text = cat.name
        
        //Set category images
//        if indexPath.row >= TOTAL_OTHER_CATEGORIES {
//            
//            let cat:ProductCategory = self.categories[indexPath.row - TOTAL_OTHER_CATEGORIES]
//            cell.imgCategory.image = UIImage(named: cat.image!)
//            cell.lblCatName.text = cat.name
//        }
//        else {
//            switch indexPath.row {
//            case PROMO_INDEX:
//                cell.imgCategory.image = UIImage(named: "deals")
//                cell.lblCatName.text = "Promos"
//            case BEST_SELLING_INDEX:
//                cell.imgCategory.image = UIImage(named: "bestsell")
//                cell.lblCatName.text = "Best Selling"
//            case FAVOURITES_INDEX:
//                cell.imgCategory.image = UIImage(named: "favorites")
//                cell.lblCatName.text = "My Favorites"
//            default:
//                break;
//            
//            }
//        }
        
        
        return cell
    }
}

// Navigation & Preparation for Paging Controllers for selected categories
extension SVHomeViewController {

    
    //MARK: Collection View Delegate Methods
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let category:SVCategory = self.masterCategories![indexPath.row];
        
        //Alcoholic Category
        if (category.identifier == "12") {
            
            let alert = UIAlertController(title: SVConstants.APP_NAME, message: "Please confirm if you are above 18 years of age. No delivery to minors", preferredStyle: UIAlertControllerStyle.Alert)
            
            
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler:  { (action:UIAlertAction) in
                
                self.performSegueWithIdentifier("PagingControllerSegue", sender: indexPath)
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        else if (category.name == "Promo" || category.name == "Best Selling") {
            
             self.performSegueWithIdentifier("PagingControllerSegue", sender: indexPath)
        }
        else if (category.name == "Favourite") {
        self.navigationController?.pushViewController(SVUtil.getVCWithIdentifier("SVFavoriteProductListViewController"), animated: true)
        }
        else {
            
            self.performSegueWithIdentifier("PagingControllerSegue", sender: indexPath)
        }
        
    }
    
    //MARK: Private Methods

    
    private func viewTypeForIndexPath(indexPath:NSIndexPath) -> PagingViewType {
        
        var viewType:PagingViewType = .Category
        
        let masterCat:SVCategory = self.masterCategories![indexPath.row];
        
        if (masterCat.name == "Promo") {
            
            viewType = .Promo
        }
        else if (masterCat.name == "Best Selling") {
            
            viewType = .BestSelling
        }
        
        return viewType
        
    }
    
    private func controllersAndMenuOptionsForIndexPath(indexPath:NSIndexPath)-> (controllers:Array<UIViewController>, menuOptions:CategoriesMenu, showFilter:Bool) {
        
        let cat:SVCategory? = self.masterCategories![indexPath.row];

        let prodCat:ProductCategory? = SVCoreDataManager.fetchCategoryWithId(cat!.identifier!);
        
        
        let helper:PagingMenuHelper = PagingMenuHelper(viewType: viewTypeForIndexPath(indexPath), category: prodCat)
        
        return helper.pagingConfig!
        
        
    }
    
    //MARK: Segue / Navigation Methods
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "PagingControllerSegue" {
            
            let viewController = segue.destinationViewController as? PagingMenuViewController
            
            let cell:SVHomeItemCell = (collectionView.cellForItemAtIndexPath((sender as? NSIndexPath)!) as? SVHomeItemCell)!
            
            
            viewController!.title = cell.lblCatName.text
            
            let pair:(controllers:Array<UIViewController>, menuOptions:CategoriesMenu, showFilter:Bool) = controllersAndMenuOptionsForIndexPath((sender as? NSIndexPath)!)
            
            viewController!.showFilters = pair.showFilter
            
            viewController!.options = PagingMenuOptions1(controllers: pair.controllers, menuOptions: pair.menuOptions)
            
        }
        
        
    }
    
    
}

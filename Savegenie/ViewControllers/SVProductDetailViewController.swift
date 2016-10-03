//
//  o.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/25/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import Kingfisher

class SVProductDetailViewController: SVBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var productDetails: SVProductDetails?
    
    var product:Product? = nil
    //@IBOutlet weak var imgProduct: UIImageView!
    //@IBOutlet weak var lblProductName: UILabel!
    //@IBOutlet weak var lblPrice: UILabel!

    //MARK: Overridden Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchProductDetails()
        // Do any additional setup after loading the view.
        
        //lblProductName.text = product?.productName!
        var attrText:NSMutableAttributedString = NSMutableAttributedString()
        
        let mrpString = "Rs. \(product!.mrp!.integerValue) /"
        
        
        let attrMRPText:NSMutableAttributedString = NSMutableAttributedString(string: mrpString)
        
        attrMRPText.addAttribute(NSFontAttributeName,
                                 value: UIFont(
                                    name: "Helvetica",
                                    size: 11.0)!,
                                 range: NSRange(
                                    location: 0,
                                    length: mrpString.characters.count))
        
        attrMRPText.addAttribute(NSForegroundColorAttributeName,
                                 value: UIColor.grayColor(),
                                 range: NSRange(
                                    location:0,
                                    length:mrpString.characters.count))
        
        attrMRPText.addAttribute(NSStrikethroughStyleAttributeName,
                                 value: NSNumber(int:1),
                                 range: NSRange(
                                    location:0,
                                    length:mrpString.characters.count))
        
        let disountString = " Rs. \(product!.discountedPrice!.integerValue)"
        
        let attrDiscountText:NSMutableAttributedString = NSMutableAttributedString(string: disountString)
        
        attrDiscountText.addAttribute(NSFontAttributeName,
                                      value: UIFont(
                                        name: "Helvetica-Bold",
                                        size: 11.0)!,
                                      range: NSRange(
                                        location: 0,
                                        length: disountString.characters.count))
        
        attrDiscountText.addAttribute(NSForegroundColorAttributeName,
                                      value: UIColor.blackColor(),
                                      range: NSRange(
                                        location:0,
                                        length:disountString.characters.count))
        
        attrText.appendAttributedString(attrMRPText)
        attrText.appendAttributedString(attrDiscountText)
        
        //lblPrice.attributedText = attrText
        
        //imgProduct.setImageWithURL(SVUtil.productImageURL(product!.image!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func navBarConfig() -> SVNavBarConfig {
        return SVNavBarConfig(showBack: true, showSearch: true, showCart: true, title: "Product Detail")
    }
    
    // MARK: Private Methods
    
    func fetchProductDetails() {
        
        if let pid = product?.identifier {
            SVUtil.showLoader()
            SVJSONAppService.fetchProductDetails(["product_sku_id": pid], responsObjectKey: "") { (details: SVProductDetails?, error:NSError?) in
                self.productDetails = details
                self.tableView.reloadData()
                SVUtil.hideLoader()
            }
        }
    }
    
    //MARK: UITableViewDataSource, UITableViewDelegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return productDetails?.descriptions?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier("SVProductDetailsTableCell") as! SVProductDetailsTableCell
            (cell as! SVProductDetailsTableCell).configureCellWithImagesArray(productDetails?.imagesArray)
        }
        else {
            cell = tableView.dequeueReusableCellWithIdentifier("SVProductSummaryTableCell") as! SVProductSummaryTableCell
            (cell as! SVProductSummaryTableCell).configureCellWithDetails(self.productDetails?.descriptions?[indexPath.row])
        }
        
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        }
        
        return 55
    }

}

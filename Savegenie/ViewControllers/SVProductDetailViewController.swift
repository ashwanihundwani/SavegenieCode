//
//  o.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/25/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import Kingfisher

class SVProductDetailViewController: SVBaseViewController {
    
    var product:Product? = nil
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!

    //MARK: Overridden Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lblProductName.text = product?.productName!
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
        
        lblPrice.attributedText = attrText
        
        imgProduct.setImageWithURL(SVUtil.productImageURL(product!.image!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func navBarConfig() -> SVNavBarConfig {
        return SVNavBarConfig(showBack: true, showSearch: true, showCart: true, title: "Product Detail")
    }
    
    
    //MARK: Private Methods
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  SVProductCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/25/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

protocol SVProductCellDelegate : class {
    
    func didTapPlus(sender: SVProductCell, maxreached: Bool)
    func didTapMinus(sender:SVProductCell)
    
}


class SVProductCell: UITableViewCell {
    
    @IBOutlet weak var lblProductName:UILabel!
    @IBOutlet weak var lblProductPrice:UILabel!
    @IBOutlet weak var imgProduct:UIImageView!
    @IBOutlet weak var lblQuantity:UILabel!
    @IBOutlet weak var imgOpenPromo:UIImageView!
    @IBOutlet weak var sponsoredLabel: UILabel!
    @IBOutlet weak var offerLabel: UILabel!
    
    var dbProduct:Product? = nil
    var dealProd:SVDealProduct? = nil
    weak var delegate:SVProductCellDelegate? = nil
    
    
    //MARK: Action Methods
    @IBAction func plusTapped() {
        var limit:Bool = false
        
        var quantity = Int(lblQuantity.text!)!
        
        quantity = quantity + 1
        
        if quantity <= 12 {
            
            lblQuantity.text = String(quantity)
        }
        else {
            limit = true
        }
        
        if let _ = delegate {
            delegate?.didTapPlus(self, maxreached: limit)
        }
    }
    
    @IBAction func minusTapped() {
        
        var quantity = Int(lblQuantity.text!)!
        
        quantity = quantity - 1
        
        if quantity >= 0 {
            
            lblQuantity.text = String(quantity)
        }
        else {
            return
        }
        
        
        if let _ = delegate {
            delegate?.didTapMinus(self)
        }
    }

    //MARK: Public methods
    func showSponsoredTag(show: Bool) {
        sponsoredLabel.hidden = !show
    }
    
    func showOfferLabel(show: Bool) {
        offerLabel.hidden = !show
    }
    
    internal func setProduct(product : SVProductModel) {
        
        lblProductName.text = product.productName
        lblProductPrice.text = product.actualPrice! + " " + product.discountedPrice!
        lblQuantity.text = "\(product.quantity)"
        
    }
    internal func setDBProduct(product : Product) {
        
        dbProduct = product
        
        lblProductName.text = product.productName
        //lblProductPrice.text = "\(product.mrp!.floatValue)" + " " + "\(product.discountedPrice!.floatValue)"
        
        var attrText:NSMutableAttributedString = NSMutableAttributedString()
        
        let mrpString = "Rs. \(product.mrp!.integerValue) /"
        

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
        
        var disountString = ""
        if let storeId = SVStore.getCurrentStore()?.identifier, let storePriceDict = SVUtil.convertStringToDictionary(product.storePrices!), let price = storePriceDict["Store-\(storeId)"] as? String {            
            disountString = " Rs. \(price)"
        }
        else {
            disountString = " Rs. \(product.discountedPrice!.integerValue)"
        }

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
        
        lblProductPrice.attributedText = attrText
        
        if let imgPromo = self.imgOpenPromo {
            
            if product.dealActive?.integerValue > 0 {
                imgPromo.hidden = false
            }
            else {
                
                imgPromo.hidden = true
            }
        }
        else {
            
        }
        
        lblQuantity.text = "\(product.quantity!.integerValue)"
        imgProduct.setImageWithURL(SVUtil.productImageURL(product.image!))
        
    }
    
    
    internal func setDealProduct(product : SVDealProduct) {
        
        dealProd = product
        
        lblProductName.text = product.code
    
        let mrpString = "Rs. \(product.mrp!)"
        
        lblProductPrice.text = mrpString
        
        lblQuantity.text = "Qty \(Int(product.qty!)!)"
        imgProduct.setImageWithURL(SVUtil.productImageURL(product.image!))
        
    }
    
    //MARK : View Controller Lifr Cycle Methods
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

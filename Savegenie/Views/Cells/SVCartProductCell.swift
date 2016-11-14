//
//  SVCartProductCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/11/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

protocol SVCartProductCellDelegate : class {
    
    func didTapDelete(sender:SVCartProductCell)
    func didTapPlus(sender:SVCartProductCell, maxreached:Bool)
    func didTapMinus(sender:SVCartProductCell)
    
}

class SVCartProductCell: UITableViewCell {

    @IBOutlet weak var lblProductName:UILabel!
    @IBOutlet weak var lblQuantity:UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImageLabel: UIImageView!
    
    weak var delegate:SVCartProductCellDelegate? = nil
    var productDB:SVCartProduct? = nil
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
    @IBAction func onCrossTap(sender: AnyObject) {
        
        if let _ = delegate {
            delegate?.didTapDelete(self)
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Overridden Methods
    internal func setCartProduct(product:SVCartProduct) {
        
        self.productDB = product
        self.lblProductName.text = product.skuName
        self.lblQuantity.text = product.count
        self.priceLabel.text = ""
        if let price = product.mrp {
            self.priceLabel.text = "Rs \(price)"
        }
        
        let product1 = SVCoreDataManager.getProductsWithIds([product.skuID!])?.first
        productImageLabel.setImageWithURL(SVUtil.productImageURL((product1?.image)!))
        
    }

}

//
//  SVSimilarProductTableCell.swift
//  Savegenie
//
//  Created by Brammanand Soni on 10/4/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVSimilarProductTableCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellWithProductDetails(product: Product?) {
        if let image = product?.image {
            productImageView.setImageWithURL(SVUtil.productImageURL(image))
        }
        productNameLabel.text = product?.productName
        
        priceLabel.text = ""
        if let price = product?.mrp {
            priceLabel.text = "\(price)"
        }
    }

}

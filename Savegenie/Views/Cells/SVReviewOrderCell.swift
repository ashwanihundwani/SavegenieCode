//
//  ReviewOrderCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/20/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVReviewOrderCell: UITableViewCell {
    
    @IBOutlet weak var lblProductName:UILabel!
    @IBOutlet weak var lblQuantity:UILabel!
    @IBOutlet weak var lblUnitPrice:UILabel!
    @IBOutlet weak var lblTotal:UILabel!
    
    internal func setOrderItem(item:SVReviewOrderItem) {
        
        lblProductName.text = item.productSkuName
        lblQuantity.text = item.quantity
        lblUnitPrice.text = item.price
        lblTotal.text = item.total
        
        switch item.getViewType() {
        case .Deal:
            self.backgroundColor = UIColor(RGB: (250, 250, 250))
        case .DealProduct:
            self.backgroundColor = UIColor(RGB: (230, 247, 253))
        case .Product:
            self.backgroundColor = UIColor(RGB: (255, 255, 255))

        }
    }

}

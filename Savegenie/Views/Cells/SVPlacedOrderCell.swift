//
//  SVPlacedOrderCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 8/3/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVPlacedOrderCell: UITableViewCell {
    
    @IBOutlet weak var lblOrderId:UILabel!
    @IBOutlet weak var lblOrderStatus:UILabel!
    @IBOutlet weak var lblOrderDate:UILabel!

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: Public Methods
    internal func setOrder(order:SVPlacedOrderDetails) {
        
        lblOrderId.text = order.id
        lblOrderDate.text = order.created
        lblOrderStatus.text = order.orderStatus
    }
}

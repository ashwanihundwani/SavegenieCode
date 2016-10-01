
//
//  SVAddressCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/23/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVAddressCell: UITableViewCell {
    
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblAddress:UILabel!
    @IBOutlet weak var headerView:UIView!
    @IBOutlet weak var lblSelectedAddress:UILabel!
    @IBOutlet weak var selectedAddressViewHeightConst:NSLayoutConstraint!
    
    //MARK: Public Methods
    internal func setAddress(address:SVShippingAddress) {
        
        lblName.text = address.name
        
        var addressStr:String = address.address!
        
        if let _ = address.locality {
            
            addressStr = addressStr + "\n" + address.locality!
        }
        
        if let _ = address.area {
            
            addressStr = addressStr + "\n" + address.area!
        }
        
        if let _ = address.city {
            
            addressStr = addressStr + "\n" + address.city!
        }
        
        if let _ = address.mobileno {
            
            addressStr = addressStr + "\n" + address.mobileno!
        }
        
        lblAddress.text = addressStr
        
        if address.selected == true {
            
            self.headerView.backgroundColor = UIColor(RGB: (198, 218, 103))
            self.selectedAddressViewHeightConst.constant = 20
            
        }
        else {
            
            self.headerView.backgroundColor = UIColor(hexString: SVConstants.APP_THEME_COLOR_RED)

            self.selectedAddressViewHeightConst.constant = 0
        }
    }
}

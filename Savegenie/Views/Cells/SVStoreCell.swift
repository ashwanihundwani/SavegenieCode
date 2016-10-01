//
//  SVStoreCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 29/08/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVStoreCell: UITableViewCell {
    
    @IBOutlet weak var lblStoreName:UILabel!
    @IBOutlet weak var lblStoreImage:UIImageView!
    @IBOutlet weak var lblDelivertTime:UILabel!
    @IBOutlet weak var lblRating:UILabel!
    @IBOutlet weak var lblFreeDelivery:UILabel!
    @IBOutlet weak var imgRateView:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Public Methods
    func setStore(store:ISVStore){
        
        lblStoreName.text = store.storeName
        lblStoreImage.setImageWithURL(SVUtil.storeImageURL(store.storeImageURL))
        lblDelivertTime.text = "Delivery By Today \(store.deliveryTime)"
        lblRating.text = "\(store.rating)"
        
        
        imgRateView.image = UIImage(named: "\(store.rating)star")
        lblFreeDelivery.text = "Free Delivery Above Rs. \(store.freeDeliveryText)"
        
        
    }
    
    
}

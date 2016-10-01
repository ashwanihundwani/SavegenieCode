//
//  SVMultipleStoreView.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 17/09/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

protocol SVMultipleStoreViewDelegate : class {
    
    func didTapProceed(view:SVMultipleStoreView)
}

class SVMultipleStoreView: UIView {
    
    @IBOutlet weak var lblDeliverySlot:UILabel!
    @IBOutlet weak var imgStore1:UIImageView!
    @IBOutlet weak var imgStore2:UIImageView!
    
    weak var delegate:SVMultipleStoreViewDelegate?
    var store:SVStore?
    
    internal func setDeliverySlot(slot:String)
    {
        self.lblDeliverySlot.text = slot
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor(red: 109.0 / 255.0, green: 109.0 / 255.0, blue: 109.0 / 255.0, alpha: 0.7)
        
        let store1:SVStore = SVVisitedStores.getStores().first!
        let store2:SVStore = SVVisitedStores.getStores().last!
        self.imgStore1.setImageWithURL(SVUtil.storeImageURL(store1.storeImageURL))
        self.imgStore2.setImageWithURL(SVUtil.storeImageURL(store2.storeImageURL))
    }
    
    @IBAction func btnCancelTapped(sender: AnyObject) {
        
        self.removeFromSuperview()
    }
    
    @IBAction func btnProceedTapped(sender: AnyObject) {
        
        if let _ = self.delegate {
            self.delegate!.didTapProceed(self)
        }
        
    }

    
}

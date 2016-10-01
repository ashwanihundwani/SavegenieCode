//
//  SVBannerCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 23/08/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVBannerCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView:UIImageView!
    
    internal func setBannerData(banner:ISVBanner) {
        
        self.imageView.setImageWithURL(SVUtil.bannerURL(banner.bannerImageURL))
        
    }
    
}

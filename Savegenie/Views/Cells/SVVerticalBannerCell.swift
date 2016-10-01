//
//  SVVerticalBannerCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 28/08/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVVerticalBannerCell: UITableViewCell {
    
    @IBOutlet weak var bannerImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    internal func setBannerData(banner:ISVBanner) {
        
        self.bannerImageView.setImageWithURL(SVUtil.bannerURL(banner.bannerImageURL))
    }
    
}

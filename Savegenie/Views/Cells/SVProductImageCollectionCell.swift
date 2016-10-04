//
//  SVProductImageCollectionCell.swift
//  Savegenie
//
//  Created by Brammanand Soni on 10/2/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVProductImageCollectionCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    
    func configureCellWithImage(imageString: String) {
        let url = SVUtil.productLargeImageURL(imageString)
        productImageView.setImageWithURL(url)
    }
}

//
//  SVShopCategoryCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 23/08/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVShopCategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var categoryName:UILabel!
    
    
    internal func setCategoryData(category:ISVShopCategory) {
        
        self.imageView.setImageWithURL(SVUtil.categoryImageURL(category.categoryImageURL))
        self.categoryName.text = category.categoryName
        
    }
}

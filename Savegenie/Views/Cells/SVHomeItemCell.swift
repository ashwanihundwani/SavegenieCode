//
//  SVHomeItemCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/23/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVHomeItemCell: UICollectionViewCell {
    
    @IBOutlet weak var lblCatName: UILabel!
    @IBOutlet weak var imgCategory:UIImageView!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {

        containerView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        super.awakeFromNib()
        // Initialization code
    }

}

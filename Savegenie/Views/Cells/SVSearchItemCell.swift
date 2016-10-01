//
//  SVSearchItemCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/24/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVSearchItemCell: UITableViewCell {
   
    @IBOutlet weak var lblSearchItem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    //MARK: Internal methods
    internal func setSearchItem(searchItem:Product) {
        
        self.lblSearchItem.text = searchItem.productName!
    }
    
}

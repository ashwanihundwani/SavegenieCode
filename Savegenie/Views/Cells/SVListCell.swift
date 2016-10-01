//
//  SVListCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 8/4/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVListCell: UITableViewCell {
    
    @IBOutlet weak var lblList:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Public Methods
    internal func setList(list:SVMyList) {
        
        self.lblList.text = list.name
    }

}

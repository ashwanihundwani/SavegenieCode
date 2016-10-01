//
//  SVOrderSummaryCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 8/4/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVOrderSummaryCell: UITableViewCell {
    
    @IBOutlet weak var lblKey:UILabel!
    @IBOutlet weak var lblValue:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK : Public Methods
    internal func setOrderSummary(summary:(key:String, value:String)) {
        
        lblKey.text = summary.key
        lblValue.text = summary.value
        
        
    }

}

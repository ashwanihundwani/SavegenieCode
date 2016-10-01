//
//  SVFilterCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/6/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

let DOT_VIEW_TAG = 234565

class SVFilterCell: UITableViewCell {
    
    @IBOutlet weak var lblFilter:UILabel!
    @IBOutlet weak var radioView:UIView!
    
    internal (set) var filterSelected:Bool = false {
        
        didSet {
            
            let dotView = radioView!.viewWithTag(DOT_VIEW_TAG)
            
            if filterSelected == true {
                
                dotView?.hidden = false
                radioView.layer.borderColor = UIColor(hexString: "DF0000").CGColor
                
            }
            else {
                
                dotView?.hidden = true
                radioView.layer.borderColor = UIColor.blackColor().CGColor
            }
        }
    }
    
    internal func setTitle(title:String, filterSelected:Bool) {
        
        lblFilter.text = title
        self.filterSelected = filterSelected
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        radioView.layer.borderColor = UIColor.blackColor().CGColor
        radioView.layer.masksToBounds = true
        radioView.layer.borderWidth = 2
        radioView.layer.cornerRadius = radioView.frame.size.height / 2

        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

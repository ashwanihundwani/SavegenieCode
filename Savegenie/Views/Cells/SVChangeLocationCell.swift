//
//  SVChangeLocationCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 27/08/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

protocol SVChangeLocationCellDelegate : class {
    
    func didTapChangeLocation(sender:SVChangeLocationCell)
}

class SVChangeLocationCell: UITableViewCell {
    
    @IBOutlet weak var lblLocation:UILabel!
    @IBOutlet weak var btnChangeLocation:UIButton!
    weak var delegate:SVChangeLocationCellDelegate? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let user = SVUtil.getUserDetails()
        
        if let _ = user {
            
            lblLocation.text  = "Your delivery area is " + (user?.area)!
            
        }
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Public Methods
    func setLocation(location:String) {
        
        self.lblLocation.text = location
        self.btnChangeLocation .setTitle(location, forState: .Normal)
    }
    
    //MARK: IBActions
    @IBAction func changeLocationTapped() {
        
        if let _ = delegate {
            self.delegate?.didTapChangeLocation(self)
        }
        
    }
    
}

//
//  SvOrderCompleteReferCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/31/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

protocol SVOrderCompleteReferCellDelegate : class {
    
    func didTapRefer()
}


class SVOrderCompleteReferCell: UITableViewCell {
    
    
    @IBOutlet weak var lblCoupon:UILabel!
    weak var delegate:SVOrderCompleteReferCellDelegate? = nil
    
    //MARK: Button Action Methods
    @IBAction func referTapped()
    {
        if let _ = delegate {
            
            delegate?.didTapRefer()
        }
        
    }

}

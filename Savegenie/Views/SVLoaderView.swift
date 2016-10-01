//
//  SVLoaderView.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/26/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVLoaderView: UIView {

    @IBOutlet weak var loaderImageView:UIImageView!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    //MARK: Private Methods
    func animate() {
        
        var images:Array<UIImage> = Array<UIImage>()
        
        images.append(UIImage(named: "loader_animation1")!)
        images.append(UIImage(named: "loader_animation2")!)
        images.append(UIImage(named: "loader_animation3")!)
        images.append(UIImage(named: "loader_animation4")!)
        
        loaderImageView.animationImages = images
        loaderImageView.animationDuration = 0.5
        loaderImageView.startAnimating()
        
    }
    
    //MARK : Overridden Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 0.2)
        
        animate()
    }
    
    

}

//
//  UIImageViewExtension.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/9/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    internal func setImageWithURL(url:NSURL) {
        
        self.kf_setImageWithURL(url,
                                placeholderImage: UIImage(named: ""),
                                optionsInfo: nil,
                                progressBlock: { (receivedSize, totalSize) -> () in
                                    
            },
                                completionHandler: { (image, error, cacheType, imageURL) -> () in
                                    
            }
        )
    }

}


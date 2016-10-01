//
//  SVCategoriesLayout.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 31/08/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

let itemHeight = 133

class SVCategoriesLayout: UICollectionViewLayout {
    
    private var contentWidth:CGFloat = SVUtil.appWindow().frame.size.width
    private var contentHeight:CGFloat = CGFloat(itemHeight)
    private var cache:[UICollectionViewLayoutAttributes] = []
    private var numberOfColumns:Int = 3
    
    override func prepareLayout() {
        
        let dividend = (self.collectionView?.numberOfItemsInSection(0))! / numberOfColumns
        let modulo =  (self.collectionView?.numberOfItemsInSection(0))! % numberOfColumns
        
        contentHeight = contentHeight * CGFloat(dividend + (modulo > 0 ? 1 : 0))
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        
        var xOffset = [CGFloat]()
        
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth )
        }
        
        for item:Int in 0...((collectionView?.numberOfItemsInSection(0))! - 1) {
            
            let indexPath = NSIndexPath(forItem: item, inSection: 0)
            
            let originX = xOffset[item % numberOfColumns]
            
            let factor = item / numberOfColumns
            
            let originY:CGFloat = CGFloat(itemHeight * factor)
            
            let frame:CGRect = CGRectMake(originX,originY, (contentWidth  / 3) - 3, CGFloat(itemHeight))
            
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            
            attributes.frame = frame
            
            cache.append(attributes)
            
        }
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes  in cache {
            if CGRectIntersectsRect(attributes.frame, rect ) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    

}

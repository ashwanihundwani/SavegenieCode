//
//  SVBannerTableCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 27/08/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVBannerTableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView:UICollectionView!
    
    var banners:Array<SVBanner> = Array<SVBanner>()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.registerNib(UINib(nibName: "SVBannerCell", bundle:nil), forCellWithReuseIdentifier: "SVBannerCell")
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //MARK: UICollectionViewCell Delegate & Datasources
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.banners.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(self.frame.size.width, (self.frame.size.width) * SVConstants.BANNER_HEIGHT_MULTIPLIER)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:SVBannerCell? = collectionView.dequeueReusableCellWithReuseIdentifier("SVBannerCell", forIndexPath: indexPath) as? SVBannerCell
        
        cell?.setBannerData(banners[indexPath.row])
        
        return cell!
    }
    
}

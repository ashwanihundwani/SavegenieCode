//
//  SVStoreCategoriesCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 28/08/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

protocol SVStoreCategoriesCellDelegate : class {
    
    func didTapCategory(category:ISVShopCategory, sender:SVStoreCategoriesCell)
    
}

class SVStoreCategoriesCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    weak var delegate:SVStoreCategoriesCellDelegate?
    @IBOutlet weak var collectionView:UICollectionView!
    var categories:[SVShopCategory] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.registerNib(UINib(nibName: "SVShopCategoryCell", bundle:nil), forCellWithReuseIdentifier: "SVShopCategoryCell")
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: CollectionView Delegate & datasource Methods
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.categories.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(self.frame.size.width / 3,  135)
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
        
        let cell:SVShopCategoryCell = collectionView .dequeueReusableCellWithReuseIdentifier("SVShopCategoryCell", forIndexPath: indexPath) as! SVShopCategoryCell
        
        cell.setCategoryData(self.categories[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if let _ = delegate {
            delegate?.didTapCategory(self.categories[indexPath.row], sender: self)
        }
    }
    
}

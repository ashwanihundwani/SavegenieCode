//
//  SVProductDetailsTableCell.swift
//  Savegenie
//
//  Created by Brammanand Soni on 10/2/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

let pageCount = 10

class SVProductDetailsTableCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pageControl.numberOfPages = pageCount
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: UICollectionViewDataSource, UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SVProductImageCollectionCell", forIndexPath: indexPath) as! SVProductImageCollectionCell
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageWidth = collectionView.frame.size.width
        let currentPage = collectionView.contentOffset.x / pageWidth
        
        pageControl.currentPage = Int(ceil(currentPage))
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.width, collectionView.frame.height)
    }
    
    // MARK: IBActions
    
    @IBAction func reviewProductButtonClicked(sender: UIButton) {
        
    }
    
    @IBAction func plusButtonClicked(sender: UIButton) {
        countLabel.text = String(Int(countLabel.text!)! + 1)
    }
    
    @IBAction func minusButtonClicked(sender: UIButton) {
        if Int(countLabel.text!) > 0 {
            countLabel.text = String(Int(countLabel.text!)! - 1)
        }
    }
}

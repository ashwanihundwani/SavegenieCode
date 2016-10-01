//
//  SVFilterView.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/6/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

protocol SVFilterViewDelegate : class {
    
    func didSelectCategory(category:ProductCategory, sender:SVFilterView)
    func didSelectShowAll(sender:SVFilterView)
    func didDisappearView(sender:SVFilterView)
    
}

class SVFilterView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var categories:Array<ProductCategory> = Array<ProductCategory>()
    
    var selectedCategory:ProductCategory? = nil
    
    weak var delegate:SVFilterViewDelegate? = nil
    
    @IBOutlet weak var tableView:UITableView!
    
    //MARK: UITableView Delegate & Datasource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // + 1 for showAll cell
        return categories.count + 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var tableCell:SVFilterCell? =
            tableView.dequeueReusableCellWithIdentifier(String(SVFilterCell)) as? SVFilterCell
        
        if tableCell == nil {
            
            tableCell = (NSBundle.mainBundle().loadNibNamed("SVFilterCell", owner: nil, options: nil).first as? SVFilterCell)!
        }
        
        if indexPath.row == categories.count {
            
            var selected:Bool = true
            if let _ = selectedCategory {
                
                selected = false
            }
            
            tableCell!.setTitle("Show All", filterSelected: selected)
        }
        else {
            
            let category:ProductCategory = self.categories[indexPath.row]
            
            var selected:Bool = false
            
            if category.name == selectedCategory?.name {
                
                selected = true
            }
            
            tableCell!.setTitle(category.name!, filterSelected: selected)
            
        }
        
        return tableCell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tableView.reloadData()
        
        if indexPath.row < categories.count {
            
            selectedCategory = categories[indexPath.row]
            
        }
        else {
            selectedCategory = nil
        }
        
        if let _ = delegate {
            
            if indexPath.row == categories.count {
                
                delegate?.didSelectShowAll(self)
            }
            else {
                
                let category = categories[indexPath.row]
                
                delegate?.didSelectCategory(category, sender: self)
            }

        }
    }
    
    //MARK: Action Methods
    
    @IBAction func showAllTapped() {
        
        if let _ = delegate {
            
            delegate?.didSelectShowAll(self)
        }

    }
    
    //MARK: Public Methods
    
    internal func show() {
        
        
        UIView.animateWithDuration(0.5, animations: { 
            
             self.frame.origin.y = 0
        }) { (success:Bool) in
            
            
        }
        
    }
    
    
    internal func hide() {
        
        UIView.animateWithDuration(0.5, animations: { 
            
            self.frame.origin.y = self.superview!.frame.size.height
            
        }) { (completed:Bool) in
            
            self.removeFromSuperview()
            
            if let _ = self.delegate {
                
                self.delegate?.didDisappearView(self)
            }
        }
        
    }
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    

}

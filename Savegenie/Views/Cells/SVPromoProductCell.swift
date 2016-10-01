//
//  SVPromoProductCell.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/9/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit



class SVPromoProductCell: SVProductCell, UITableViewDelegate, UITableViewDataSource {
    
    var promo:SVDeal? = nil
    
    @IBOutlet weak var tableView:UITableView!
    
    @IBOutlet weak var lblSavings:UILabel!
    
    internal func setDeal(deal:SVDeal) {
        
        promo = deal
        self.lblSavings.text = "Save Rs. \(Int((Float(deal.dealMrp!))!) - Int((Float(deal.dealPrice!))!))"
        
        let attrText:NSMutableAttributedString = NSMutableAttributedString()
        
        let mrpString = "Rs. \(Int(Float(deal.dealMrp!)!)) / "
        
        
        let attrMRPText:NSMutableAttributedString = NSMutableAttributedString(string: mrpString)
        
        attrMRPText.addAttribute(NSFontAttributeName,
                                 value: UIFont(
                                    name: "Helvetica",
                                    size: 11.0)!,
                                 range: NSRange(
                                    location: 0,
                                    length: mrpString.characters.count))
        
        attrMRPText.addAttribute(NSForegroundColorAttributeName,
                                 value: UIColor.grayColor(),
                                 range: NSRange(
                                    location:0,
                                    length:mrpString.characters.count))
        
        attrMRPText.addAttribute(NSStrikethroughStyleAttributeName,
                                 value: NSNumber(int:1),
                                 range: NSRange(
                                    location:0,
                                    length:mrpString.characters.count))
        
        let disountString = "Rs. \(Int(Float(deal.dealPrice!)!))"
        
        let attrDiscountText:NSMutableAttributedString = NSMutableAttributedString(string: disountString)
        
        attrDiscountText.addAttribute(NSFontAttributeName,
                                      value: UIFont(
                                        name: "Helvetica-Bold",
                                        size: 11.0)!,
                                      range: NSRange(
                                        location: 0,
                                        length: disountString.characters.count))
        
        attrDiscountText.addAttribute(NSForegroundColorAttributeName,
                                      value: UIColor.blackColor(),
                                      range: NSRange(
                                        location:0,
                                        length:disountString.characters.count))
        
        attrText.appendAttributedString(attrMRPText)
        attrText.appendAttributedString(attrDiscountText)
        
        lblProductPrice.attributedText = attrText
        lblQuantity.text = "0"
        
        self.tableView.reloadData()
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row % 2 == 1 {
            
            return 20
        }
        else {
            
            return 90
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = promo {
            
            if promo?.dealProducts.count > 0 {
                
                if promo?.dealProducts.count > 1 {
                    return ((promo?.dealProducts.count)! * 2) - 1
                }
                else {
                    return 1
                }
            }
            else {
                return 0
            }
            
            
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if promo?.dealProducts.count == 1 {
            
            let cell:SVProductCell = self.tableView.dequeueReusableCellWithIdentifier("SVProductCell") as! SVProductCell
            
            
            cell.setDealProduct((self.promo?.dealProducts[indexPath.row])!)
            
            
            return cell
        }
        
        if indexPath.row % 2 == 1 {
            
            let cell = self.tableView.dequeueReusableCellWithIdentifier("PlusCell")
            
            return cell!
        }
        else {
            
            let cell:SVProductCell = self.tableView.dequeueReusableCellWithIdentifier("SVProductCell") as! SVProductCell
            
            
            cell.setDealProduct((self.promo?.dealProducts[(indexPath.row / 2)])!)
            
            
            return cell
        }
    }

}

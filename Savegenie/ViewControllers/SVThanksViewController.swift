//
//  SVThanksViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/27/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVThanksViewController: SVBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView:UITableView!
    
     //MARK: Button Action Methods
    @IBAction func goToHomeTapped()
    {
        
        SVUtil.appWindow().rootViewController = SVUtil.getVCWithIdentifier("SVLoaderViewController")
    }
    
    
    //MARK: Overridden Methods
    override func navBarConfig() -> SVNavBarConfig {
        
        return SVNavBarConfig(showBack: true, showSearch: false, showCart: false, title: "Order Complete")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK: Table View datasource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return 1
        
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 10))
        
        view.backgroundColor = UIColor.lightGrayColor()
        
        return view
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        case 1:
            return 250
        case 2:
            return 150
        default:
            return 0
        }
    
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return UITableViewCell()
        
//        let tableCell:SVReviewOrderCell = (tableView.dequeueReusableCellWithIdentifier(String(SVReviewOrderCell)) as? SVReviewOrderCell)!
//        
//        tableCell.setOrderItem(product!)
//        
//        return tableCell
    }
    

}

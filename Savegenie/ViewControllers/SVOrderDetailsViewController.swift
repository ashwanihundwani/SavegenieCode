//
//  SVOrderDetailsViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 8/4/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVOrderDetailsViewController: SVBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var order:SVPlacedOrderDetails? = nil
    var orderDetails:SVPlacedOrder? = nil
    
    
    @IBOutlet weak var tableView:UITableView!
    
    //MARK: Overridden Methods
    override func navBarConfig() -> SVNavBarConfig {
        return SVNavBarConfig(showBack: true, showSearch: true, showCart: true, title: "Order Id " + (order?.id!)!)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchOrderById()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Table View datasource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let _ = orderDetails {
            if section == 0 {
                return (orderDetails?.displayItems.count)!
            }
            else if section == 1 {
                return (orderDetails?.orderItems?.count)!
            }

        }
        
        return 0
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 && indexPath.row == (self.orderDetails?.displayItems.count)! - 1 {
            
            let summary = self.orderDetails?.displayItems[indexPath.row]
            
            let height = SVUtil.heightForView((summary?.value)!, font: SVUtil.getHelveticaFontWithSize(13), width: self.view.frame.size.width - 145)
            
            return height + 15
        }
        return 30
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return section == 0 ? 40 : 80
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let view:UILabel = UILabel(frame: CGRectMake(0,0,self.view.frame.size.width, 40))
            
            view.textColor = UIColor.grayColor()
            
            view.textAlignment = .Center
            
            view.text = "Order Information"
            
            return view
        }
        else if section == 1
        {
            let container = UIView(frame: CGRectMake(0,0,self.view.frame.size.width, 80))
            
            let view:UILabel = UILabel(frame: CGRectMake(15,0,self.view.frame.size.width - 30, 40))
            
            
            view.textColor = UIColor.grayColor()
            
            view.textAlignment = .Center
            
            view.text = "Your Cart"
            
            container.addSubview(view)
            
            let headerView:OrderDetailHeaderView = (NSBundle.mainBundle().loadNibNamed("OrderDetailHeaderView", owner: nil, options: nil).first as? OrderDetailHeaderView)!
            
            headerView.frame = CGRectMake(0, 40, self.view.frame.size.width, 40)
            
            container.addSubview(headerView)
            
            return container
        }
        
        return nil
        
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 1
        {
            let tableCell:SVReviewOrderCell = (tableView.dequeueReusableCellWithIdentifier(String(SVReviewOrderCell)) as? SVReviewOrderCell)!
            
            let product = self.orderDetails?.orderItems![indexPath.row]
            
            tableCell.setOrderItem(product!)
            
            return tableCell

        }
        else {
            let tableCell:SVOrderSummaryCell = (tableView.dequeueReusableCellWithIdentifier(String(SVOrderSummaryCell)) as? SVOrderSummaryCell)!
            
            let summary:(key:String, value:String) = (self.orderDetails?.displayItems[indexPath.row])!
            
            
            tableCell.setOrderSummary(summary)
            
            if summary.key == "Net Amount" {
                
                tableCell.backgroundColor = UIColor.lightGrayColor()
            }
            else {
                tableCell.backgroundColor = UIColor.whiteColor()
            }
            
            return tableCell

        }
        
        
    }
    
    
    //MARK: Private Methods
    private func fetchOrderById() {
        
        var params:Array<(key:String, value:AnyObject)> = Array<(key:String, value:AnyObject)>()
        
        params.append(("data[orderId]", (self.order?.id)!))
        
            SVJSONAppService.fetchOrderInfoById(params, responsObjectKey: "", completionHandler: { (order:SVPlacedOrder?, error:NSError?) in
            
                if let _ = order {
                    self.orderDetails = order
                    self.tableView.reloadData()
                }
        })
    }
}

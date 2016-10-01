//
//  SVOrdersViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/25/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVOrdersViewController: SVBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    var orders:SVPlacedOrdersDetails? = nil
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var lblNoContent:UILabel!
    

    
    //MARK : Overridden Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchMyOrders()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func navBarConfig() -> SVNavBarConfig {
        return SVNavBarConfig(showBack: true, showSearch: true, showCart: true, title: "My Orders")
    }
    
    

    //MARK: Table View datasource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let _ = orders {
            return (orders?.details?.count)!
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableCell:SVPlacedOrderCell = (tableView.dequeueReusableCellWithIdentifier(String(SVPlacedOrderCell)) as? SVPlacedOrderCell)!
        
        tableCell.setOrder((self.orders?.details![indexPath.row])!)
        
        return tableCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc:SVOrderDetailsViewController = (SVUtil.getVCWithIdentifier("SVOrderDetailsViewController") as? SVOrderDetailsViewController)!
        
        vc.order = self.orders?.details![indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: Private Methods
    private func fetchMyOrders()
    {
        SVJSONAppService.fetchMyOrders(Array<(key: String, value: AnyObject)>(), responsObjectKey: "") { (details:SVPlacedOrdersDetails?, error:NSError?) in
            
            if let _ = details {
                
                self.orders = details
                
                if self.orders?.details?.count > 0 {
                    self.tableView.hidden = false
                    self.lblNoContent.hidden = true
                    self.tableView.reloadData()
                }
                else {
                    
                     self.lblNoContent.hidden = false
                     self.tableView.hidden = true
                }
                
                
            }
            else {
                self.lblNoContent.hidden = false
                self.tableView.hidden = true
            }
        }
    }
}

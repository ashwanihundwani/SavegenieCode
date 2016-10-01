//
//  SVReviewOrderViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/20/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVReviewOrderViewController: SVBaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var summaryContainer:UIView!
    @IBOutlet weak var lblNetPrice:UILabel!
    @IBOutlet weak var lblStorePrice:UILabel!
    @IBOutlet weak var lblDeliveryCharges:UILabel!
    @IBOutlet weak var lblDiscount:UILabel!
    
    var orderDetails:SVReviewOrderDetails? = nil
    
    
    //MARK: Action Methods
    @IBAction func didTapSelectAddress() {
        
        let addressVC = SVUtil.getCartVCWithIdentifier("SVSelectAddressViewController") as? SVSelectAddressViewController
        
        addressVC?.orderDetails = self.orderDetails?.orderDetails
        
        self.navigationController?.pushViewController(addressVC!, animated: true)
        
    }
    
    //MARK: Overridden Methods
    
    override func navBarConfig() -> SVNavBarConfig {
        
        return SVNavBarConfig(showBack: true, showSearch: false, showCart: false, title: "Review Order")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchOrderDetails()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Table View datasource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let _ = orderDetails {
            return (self.orderDetails?.orderItems?.count)!
        }
        
        return 0
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 35
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableCell:SVReviewOrderCell = (tableView.dequeueReusableCellWithIdentifier(String(SVReviewOrderCell)) as? SVReviewOrderCell)!
        
        let product = self.orderDetails?.orderItems![indexPath.row]
        
        tableCell.setOrderItem(product!)
        
        return tableCell
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
    
    private func prepareUI() {
        
        self.tableView.reloadData()
        self.tableView.hidden = false
        self.summaryContainer.hidden = false
        
        self.lblDiscount.text = "Rs " + (self.orderDetails?.dealDiscount)!
        self.lblStorePrice.text = "Rs " + (self.orderDetails?.storePrice)!
        self.lblNetPrice.text = "Rs " + (self.orderDetails?.netPrice)!
        self.lblDeliveryCharges.text = "Rs " + (self.orderDetails?.deliveryCharges)!
        
    }
    private func fetchOrderDetails() {
    
        self.tableView.hidden = true
        self.summaryContainer.hidden = true
        
        var details:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        
        details["data[storeId]"] = "41"
        
        SVUtil.showLoader()
        SVJSONAppService.fetchOrderDetails(details, responsObjectKey: "") { (details:SVReviewOrderDetails?, error:NSError?) in
            SVUtil.hideLoader()
            if let _ = details {
                self.orderDetails = details
                self.prepareUI()
            }
            
        }
    }

}

//
//  SelectAddressViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/22/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVSelectAddressViewController: SVBaseViewController, UITableViewDataSource, UITableViewDelegate, AddAddressViewDelegate{

    
    var addresses:SVShippingAddresses? = nil
    var selectedAddress:SVShippingAddress? = nil
    var orderDetails:SVOrderDetails? = nil
    @IBOutlet weak var tableView:UITableView!
    
    //MARK: Action Methods
    @IBAction func didTapApplyCoupon() {
        
        if self.selectedAddress != nil {
            
            var params = Dictionary<String,AnyObject>()
            
            params["data[address]"] = self.selectedAddress?.identifier
            
            SVTextAppService.selectShippingAddress(params, completionHandler: { (
                obj:AnyObject?, error:NSError?) in
                
                
            })
            
        let couponController = SVUtil.getCartVCWithIdentifier("SVApplyCouponViewController") as? SVApplyCouponViewController
            
        couponController?.address = self.selectedAddress
        couponController?.orderDetails = self.orderDetails
            
        self.navigationController?.pushViewController(couponController!, animated: true)
        
            
        }
        else {
            SVUtil.showAlert(SVConstants.APP_NAME, message: "Please select address.", controller: self)
        }
    }
    @IBAction func didTapAddAddress() {
        
        let addressView:AddAddressView = (NSBundle.mainBundle().loadNibNamed("AddAddressView", owner: nil, options: nil).first as? AddAddressView)!
        
        addressView.delegate = self
        
        addressView.parentController = self.navigationController;
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        addressView.frame = appDelegate.window!.bounds
        
        self.navigationController?.view.addSubview(addressView)
        
    }
    
    //MARK: Overridden Methods
    
    override func navBarConfig() -> SVNavBarConfig {
        
        
        return SVNavBarConfig(showBack: true, showSearch: false, showCart: false, title: "Select Shipping Address")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchShippingAddresses()
    
    }
    
    //MARK: Private Methods
    
    private func prepareUI() {
        
        self.tableView.reloadData()
        
    }
    private func fetchShippingAddresses() {
        
        SVUtil.showLoader()
        SVJSONAppService.fetchShippingAddresses("") { (addresses:SVShippingAddresses?, error:NSError?) in
            
            if let _ = addresses {
                self.addresses = addresses
                self.prepareUI()
            }
            else {
                
            }
            
            SVUtil.hideLoader()
            
        }
    }
    
    //MARK: Table View datasource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let _ = addresses {
            return (self.addresses?.addresses?.count)!
        }
        
        return 0
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let address = self.addresses?.addresses![indexPath.row]
        
        if address?.selected == true {
            
            return 190
        }
        
        return 170
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableCell:SVAddressCell = (tableView.dequeueReusableCellWithIdentifier(String(SVAddressCell)) as? SVAddressCell)!
        
        let address = self.addresses?.addresses![indexPath.row]
        
        tableCell.setAddress(address!)
        
        return tableCell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let address = self.addresses?.addresses![indexPath.row]
        
        address?.selected = true
    
        if let _ = self.selectedAddress{
            
            self.selectedAddress?.selected = false
            
        }
        
        self.selectedAddress = address
        
        tableView.reloadData()
    }
    
    //MARK: AddAddressView Delegate Methods
    func didSaveAddress(sender: AddAddressView) {
        
        self.fetchShippingAddresses()
    }
}

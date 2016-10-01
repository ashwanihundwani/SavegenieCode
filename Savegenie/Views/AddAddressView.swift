//
//  AddAddressView.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 8/6/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

protocol AddAddressViewDelegate : class {
    
    func didSaveAddress(sender:AddAddressView)
}


class AddAddressView: UIView, UITableViewDelegate, UITableViewDataSource {

    weak var delegate:AddAddressViewDelegate? = nil
    var parentController:UIViewController? = nil
    var enteredAddress:SVAddShippingAddress? = nil
    
    @IBOutlet weak var tableView:UITableView!
    
    //MARK: Action Methods
    
    @IBAction func btnCancelTapped(sender: AnyObject) {
        
        self.removeFromSuperview()
    }
    
    @IBAction func btnSaveTapped(sender: AnyObject) {
        
        let cell:SVAddAddressCellTableViewCell = (self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? SVAddAddressCellTableViewCell)!
        
        let validationData:(Bool, String) = cell.validateForm()
        
        if validationData.0 == true {
            
            SVUtil.showLoader()
            var params = Dictionary<String, AnyObject>()
            
            params["data[ShippingAddress][name]"] = cell.txtName.text!
            params["data[ShippingAddress][address]"] = cell.txtAddress.text!
            params["data[ShippingAddress][areaName]"] = cell.txtSelectArea.text!
            params["data[ShippingAddress][areaId]"] = self.enteredAddress?.areas?.areaIdForText(cell.txtSelectArea.text!)
            params["data[ShippingAddress][city]"] = self.enteredAddress?.cityId
            params["data[ShippingAddress][mobileno]"] = cell.txtMobile.text!
            params["data[ShippingAddress][society_name]"] = cell.txtStreet.text!
            
            params["data[ShippingAddress][landmark]"] = cell.txtLandmark.text!
            
            
            SVUtil.showLoader()
            
            SVXMLAppService.saveAddress(params, completionHandler: { (object:NSObject?, error:NSError?) in
                if let _ = self.delegate {
                        
                        self.delegate?.didSaveAddress(self)
                }
                
                SVUtil.hideLoader()
                self.removeFromSuperview()
            })
        }
        else {
            SVUtil.showAlert(SVConstants.APP_NAME, message: validationData.1, controller: self.parentController!)
        }
    }
    
    //MARK : Private Methods
    
    private func prepareUI() {
        
        self.tableView.reloadData()
        
    }
    
    private func fetchEnterAddress()
    {
        SVJSONAppService.enterShippingAddress(Array<(key: String, value: AnyObject)>(), responsObjectKey: "") { (address:SVAddShippingAddress?, error:NSError?) in
            
            if let _ = address {
                self.enteredAddress = address
                self.prepareUI()
            }
        }
    }
    
    //MARK: Overridden Methods
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.fetchEnterAddress()
        
        self.backgroundColor = UIColor(red: 109.0 / 255.0, green: 109.0 / 255.0, blue: 109.0 / 255.0, alpha: 0.7)
        
    }
    
    //MARK: UITableView Delegate & Datasource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 350
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var tableCell:SVAddAddressCellTableViewCell? =
            tableView.dequeueReusableCellWithIdentifier(String(SVAddAddressCellTableViewCell)) as? SVAddAddressCellTableViewCell
        
        if tableCell == nil {
            
            tableCell = (NSBundle.mainBundle().loadNibNamed("SVAddAddressCellTableViewCell", owner: nil, options: nil).first as? SVAddAddressCellTableViewCell)!
        }
        
        if let _ = enteredAddress {
            
            tableCell?.setAddress(self.enteredAddress!)
            
        }
        
        
        return tableCell!
    }
}

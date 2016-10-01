//
//  SVApplyCouponViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/23/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVApplyCouponViewController: SVBaseViewController {
    
    var address:SVShippingAddress? = nil
    var orderDetails:SVOrderDetails? = nil
    
    @IBOutlet weak var txtCoupon:UITextField!
    @IBOutlet weak var lblErrorMessage:UILabel!
    @IBOutlet weak var lblAddress:UILabel!
    @IBOutlet weak var lblOrderAmount:UILabel!
    @IBOutlet weak var lblCouponDiscount:UILabel!
    @IBOutlet weak var lblWallet:UILabel!
    @IBOutlet weak var lblNetAmount:UILabel!
    
    
    //MARK: Action Methods
    @IBAction func didTapSelectDeliverySlot() {
        
        let controller:SVDeliverySlotViewController = (SVUtil.getCartVCWithIdentifier("SVDeliverySlotViewController") as? SVDeliverySlotViewController)!
        
        controller.orderDetails = self.orderDetails
        controller.address = self.address
        
        self.navigationController?.pushViewController(controller, animated: true)
        
        
    }
    @IBAction func didTapApplyCoupon() {
        
        self.applyCoupon()
        

    }
    
    //MARK: Overridden Methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var addressStr:String = (self.address?.address)!
        
        if let _ = address!.locality {
            
            addressStr = addressStr + " , " + (address?.locality!)!
        }
        
        if let _ = address!.area {
            
            addressStr = addressStr + " , " + (address?.area!)!
        }
        
        if let _ = address!.city {
            
            addressStr = addressStr + " , " + (address?.city!)!
        }
        
        if let _ = address!.mobileno {
            
            addressStr = addressStr + " , " + address!.mobileno!
        }
        
        self.lblAddress.text = addressStr
        
        self.lblOrderAmount.text = "Rs " + (self.orderDetails?.priceAfterDeal)!
        self.lblCouponDiscount.text = "Rs 0.00"
        
        self.lblNetAmount.text = "Rs " + (self.orderDetails?.priceAfterDeal)!
        self.lblWallet.text = "Rs " + (self.orderDetails?.referralBonus)!
        
    }
    
    override func navBarConfig() -> SVNavBarConfig {
        
        return SVNavBarConfig(showBack: true, showSearch: false, showCart: false, title: "Apply Coupon Code/Referral")
    }
    
    //MARK: Private Methods
    
    private func updateUIForAppliedCoupon(coupon:SVApplyCouponResponse) {
        
        self.lblErrorMessage.text = coupon.message
        if let _ = coupon.netPrice {
            
            self.lblNetAmount.text = "Rs " + coupon.netPrice!
            self.lblCouponDiscount.text = "Rs "  + coupon.couponPrice!
        }
        else {
            
            self.lblCouponDiscount.text = "Rs 0.00"
            self.lblNetAmount.text = "Rs " + (self.orderDetails?.priceAfterDeal)!
        }
    }
    private func applyCoupon() {
        if self.txtCoupon.text?.characters.count > 0 {
            
            var params:Array<(key:String, value:AnyObject)> = Array<(key:String, value:AnyObject)>()
            
            params.append(("data[order][sgenieCouponCode]", (txtCoupon.text as? AnyObject)!))
            
            params.append(("data[ordergenerate][OrdId]", (self.orderDetails?.identifier as? AnyObject)!))
            
            params.append(("data[order][totalRupees]", (self.orderDetails?.priceAfterDeal as? AnyObject)!))
            
            params.append(("data[order][totalMrp]", (self.orderDetails?.priceAtMrp as? AnyObject)!))
            
            params.append(("data[order][storeId]", (self.orderDetails?.storeIdentifier as? AnyObject)!))
            
            SVUtil.showLoader()
            SVJSONAppService.applyCoupon(params, responsObjectKey: "", completionHandler: { (response:SVApplyCouponResponse?, error:NSError?) in
                
                if let _ = response {
                    
                    self.updateUIForAppliedCoupon(response!)
                }
                
                
                SVUtil.hideLoader();
                //self.lblErrorMessage.text = "Invalid Savegenie coupon code"
                
            })
            
        }
        else {
            lblErrorMessage.text = "Please enter the coupon code"
        }

    }

}

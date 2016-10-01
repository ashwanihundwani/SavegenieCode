//
//  SVDeliverySlotViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/25/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

let timeSlots:Array<String> = ["09:00 To 11:30", "11:30 To 14:30", "13:00 To 16:30", "15:30 To 19:00", "17:30 To 21:00"]

class SVDeliverySlotViewController: SVBaseViewController, UIWebViewDelegate {
    
    @IBOutlet weak var lblMonth:UILabel!
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var lblYear:UILabel!
    @IBOutlet weak var lblTime:UILabel!
    @IBOutlet weak var btnThreeHrs:UIButton!
    @IBOutlet weak var lblThreeHrsTitle:UILabel!
    @IBOutlet weak var lblThreeHrsSubTitle:UILabel!
    @IBOutlet weak var btnSelectDate:UIButton!
    @IBOutlet weak var btnSelectTime:UIButton!
    @IBOutlet weak var tnCWebView:UIWebView!
    
    
    var deliverySlots:SVDeliverySlot? = nil
    var orderDetails:SVOrderDetails? = nil
    var address:SVShippingAddress? = nil
    var selectedSlot:SVDeliveryDay? = nil
    var selectedSlotTime:String? = nil
    
    
    var startHours:Array<String> = ["09:00", "11:30", "13:00", "15:30", "17:30"]
    
    var currentTimeSlots:Array<String>?  = nil
    
    
    //MARK: IBAction Methods
    
    @IBAction func didTapConfirmOrder() {
        
        guard let _ = self.selectedSlot, let _ = self.selectedSlotTime
            else {
            
                SVUtil.showAlert(SVConstants.APP_NAME, message: "Please select date and time", controller: self)
                return;
                
        }
        
        self.confirmOrder(false)
    }
    
    @IBAction func threeHoursDeliveryTapped() {
        
        let date = SVUtil.dateFromString((self.deliverySlots?.threeHrsDelivery)!, inFormat: "HH:mm:ss")
        
        let timeStr = SVUtil.stringFromDate(date!, inFormat: "HH:mm")
        
        let alert = UIAlertController(title: "Three Hours Delivery", message: "Please confirm delivery time \(timeStr!)", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler:  { (action:UIAlertAction) in
            
            self.confirmOrder(true)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func selectDateTapped() {
        
        ActionSheetStringPicker.showPickerWithTitle("Select date", rows: self.deliverySlots?.dates, initialSelection: 0, doneBlock: { (picker:ActionSheetStringPicker!, index:Int, value:AnyObject!) in
            
            let slot:SVDeliveryDay = (self.deliverySlots?.slots[index])!;
            
            self.deliverySlots!.deselectAll()
            
            slot.selected = true;
            self.selectedSlot = slot
            
            self.btnSelectDate .setTitle(slot.getDisplayDateString(), forState: .Normal)
            
            self.lblMonth.text = SVUtil.stringFromDate(SVUtil.dateFromString(slot.fullDate!, inFormat: "yyyy-MM-dd")!, inFormat: "MMM")
            
            self.lblDate.text = SVUtil.stringFromDate(SVUtil.dateFromString(slot.fullDate!, inFormat: "yyyy-MM-dd")!, inFormat: "dd")
            
            self.lblYear.text = SVUtil.stringFromDate(SVUtil.dateFromString(slot.fullDate!, inFormat: "yyyy-MM-dd")!, inFormat: "yyyy")
            
            
            }, cancelBlock: { (picker:ActionSheetStringPicker!) in
                
                
            }, origin: btnSelectDate)

    }


    @IBAction func selectTimeTapped() {
        
        self.timeSlotForSelectedDate()
        
        ActionSheetStringPicker.showPickerWithTitle("Select time", rows: self.currentTimeSlots, initialSelection: 0, doneBlock: { (picker:ActionSheetStringPicker!, index:Int, value:AnyObject!) in
            
            self.lblTime.text = value as? String
            self.btnSelectTime .setTitle(value as? String, forState: .Normal)
            
            self.selectedSlotTime = value as? String
            
            }, cancelBlock: { (picker:ActionSheetStringPicker!) in
                
                
            }, origin: btnSelectTime)
    }
    
    
    
    //MARK: Overridden Methods
    override func navBarConfig() -> SVNavBarConfig {
        
        return SVNavBarConfig(showBack: true, showSearch: false, showCart: false, title: "Select Delivery Slot")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tnCWebView.loadHTMLString("<html><body link=\"4EB6AC\"><center>By clicking \"Order Confirm\" you are accepting <a href=\"http://savegenie.mu//pages/termsOfUse\"><span style=\"font-size:12px;color:#4EB6AC\">Terms & Conditions</span></a></center></body></html>", baseURL: nil)
        
        //self.tnCWebView.scrollView.contentOffset = CGPointMake(0, -20)
        self.tnCWebView.scrollView.scrollEnabled = false
        self.tnCWebView.scrollView.showsVerticalScrollIndicator = false
        self.tnCWebView.scrollView.showsHorizontalScrollIndicator = false
        self.tnCWebView.delegate = self
        self.fetchDeliverySlots()
    }
    
    //MARK: Private Methods
    
    private func confirmOrder(threeHourseDelivery:Bool) {
        
        var params:Array<(key:String, value:AnyObject)> = Array<(key:String, value:AnyObject)>()
        
        params.append(("data[delchkaddr]",""))
        params.append(("data[delchkaddress]",""))
        params.append(("data[delchkname]",""))
        params.append(("data[delchkcity]",""))
        params.append(("data[delchkarea]",""))
        params.append(("data[delchkmob]",""))
        
        params.append(("data[order][41][pickupDelivery]","delivery"))
        
        //TODO-
        params.append(("data[order][selectedStoreSlot]",""))
        
        if threeHourseDelivery {
            
            params.append(("data[order][selectDate]",""))

        }
        else {
            params.append(("data[order][selectDate]",(self.selectedSlot?.fullDate)!))
        }
        
        params.append(("data[order][pickupDelivery]","delivery"))
        params.append(("data[order][storeId]","41"))
        //TODO - orderdetails priceAtMrp - priceAtDeal
        params.append(("data[order][discount]",""))
        //TODO - need to check with android
        params.append(("data[order][sgenieCouponCode]","0"))
        params.append(("data[order][totalRupees]",(self.orderDetails?.priceAfterDeal)!))
        
        //TODO - Order id, need to check
        params.append(("data[ordergenerate][OrdId]","0"))
        //TODO - need to check if redeem wallet is checked.
        params.append(("data[referral][chekuncheckid]","0"))
        
        //TODO - finally API call
        
    }
    
    private func prepareUI() {
    
        
        if self.deliverySlots?.threeHrsDelivery == "0" {
            self.btnThreeHrs.backgroundColor = UIColor.grayColor()
            self.btnThreeHrs.userInteractionEnabled = false
            self.lblThreeHrsTitle.text = "Delivery in next three hours unavailable"
            self.lblThreeHrsSubTitle.text = "Please select your convenient delivery date and time below"
        }
        else {
            self.btnThreeHrs.backgroundColor = UIColor(hexString: SVConstants.APP_THEME_COLOR_RED)
            self.btnThreeHrs.userInteractionEnabled = true
            
            let date = SVUtil.dateFromString((self.deliverySlots?.threeHrsDelivery)!, inFormat: "HH:mm:ss")
            
            let timeStr = SVUtil.stringFromDate(date!, inFormat: "HH:mm")
            self.lblThreeHrsTitle.text = "Delivery Today By \(timeStr!) Hours"
            self.lblThreeHrsSubTitle.text = "Click this option for instant delivery"
            
        }
        
    }
    private func fetchDeliverySlots() {
        
        var params:Array<(key:String, value:AnyObject)> = Array<(key:String, value:AnyObject)>()

        
        params.append(("data[storeid]",(self.orderDetails?.storeIdentifier)!))
        params.append(("data[pickdel]", "delivery"))
        params.append(("data[address]", (self.address?.identifier)!))
        
        
        SVUtil.showLoader()
        SVJSONAppService.fetchDeliverySlot(params, responsObjectKey: "", completionHandler: { (response:SVDeliverySlot?, error:NSError?) in
            
            self.deliverySlots = response
            self.prepareUI()
            
            SVUtil.hideLoader();
            
        })
    }
    
    private func timeSlotForSelectedDate() {

        if SVUtil.dateFromString((self.selectedSlot?.fullDate)!, inFormat: "yyyy-MM-dd")?.isToday() == true {
            
            let index:Int = self.timeIndexForTodayDate()
            
            self.currentTimeSlots = Array(timeSlots[index..<timeSlots.count])
        }
        else {
            
            self.currentTimeSlots = timeSlots
        }
    }
    
    private func timeIndexForTodayDate() -> Int{
        
        let date:NSDate = NSDate()
        
        var index:Int = 0
        
        let secondsElapsed = date.hour() * 60 * 60 + date.minute() * 60 + date.seconds()
        
        //9
        if secondsElapsed >= 32400 && secondsElapsed < 40680 {
            
            index = 1
        }
        else if secondsElapsed >= 40680 && secondsElapsed < 46800 {
            
            index = 2
        }
        else if secondsElapsed >= 46800 && secondsElapsed < 55080 {
            
            index = 3
        }
        else
        {
            index = 4
        }

        return index
    }
    
    //MARK: WebView Delegate Methods
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if request.URLString.containsString("termsOfUse") {
            
            SVUtil.openURL((request.URL?.URLString)!)
            
            return false
        }
        return true
    }
}

//
//  SVUtil.swift
//  IGTCarpool
//
//  Created by Ashwani on 07/03/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

import Foundation
import UIKit
import Zip
import CoreData

enum IndicatorPostion {
    case left
    case right
    case middle
}


class SVUtil : NSObject
{
    static var loaderSuperView:UIView?
    static func isUserLoggedIn()->Bool
    {
        if let _ = NSUserDefaults.standardUserDefaults().objectForKey(""){
            
            return true;
        }
        return false;
    }
    
    static func isRegistrationCompleted()->Bool
    {
        let completed:Bool = NSUserDefaults.standardUserDefaults().boolForKey("")
        
        return completed
    }
    
    static func setRegistrationCompleted()
    {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "")
    }

    
    static func mainStoryBoard()->UIStoryboard!
    {
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    }
    
    static func pagingStoryBoard()->UIStoryboard!
    {
        return UIStoryboard(name: "PagingMenuViewController", bundle: NSBundle.mainBundle())
    }
    
    static func cartStoryBoard()->UIStoryboard!
    {
        return UIStoryboard(name: "Cart", bundle: NSBundle.mainBundle())
    }
    
    static func saveCustomObject(withKey: String!, object: AnyObject!){
        
        let objData:NSData? = NSKeyedArchiver.archivedDataWithRootObject(object)
        
        NSUserDefaults.standardUserDefaults().setObject(objData, forKey: withKey)
    }
    
    static func removeCustomObject(withKey: String!){
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey(withKey)
    }
    
    static func getCustomObject(withKey: String!)->AnyObject?{
        
        
        
        let data:NSData? = NSUserDefaults.standardUserDefaults().objectForKey(withKey) as? NSData
        
        if data != nil {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data!)
        }
        
        else {
            return nil
        }
        
        
    }
    
    static func getUserDetails()->SVUserDetails? {
        return SVUtil.getCustomObject(SVConstants.USER_DETAIL_ARCHIVE_KEY) as? SVUserDetails
    }
    
    static func saveUserDetails(details : SVUserDetails) {
        return SVUtil.saveCustomObject(SVConstants.USER_DETAIL_ARCHIVE_KEY, object:details)
    }
    
    static func showActivityIndicatorOnView(view:UIView, position:IndicatorPostion, tintColor:UIColor) {
        
        var indicator:UIActivityIndicatorView!;
        indicator=UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge);
        
        indicator.color = tintColor
        
        switch(position) {
        case .left :
            print("hello")
            
        case .right :
            var halfButtonHeight : CGFloat
            halfButtonHeight=view.frame.size.height/2
            
            indicator.center = CGPointMake(view.frame.size.width - halfButtonHeight , halfButtonHeight);
            view.addSubview(indicator);
            indicator.startAnimating();
        case .middle :
            
            view.addSubview(indicator);
            indicator.center = view.center
            indicator.startAnimating();
        }
        
    }

    static func showActivityIndicatorOnView(view:UIView, position:IndicatorPostion) {
    
        SVUtil.showActivityIndicatorOnView(view, position: position, tintColor: UIColor.blackColor())
    }
    
    static func hideActivityIndicatorOnView(view:UIView) {
        for subView  in view.subviews {
            
            if subView.isKindOfClass(UIActivityIndicatorView) {
                subView.removeFromSuperview()
            }
        }
    }
    static func getMessageForConnectionError(error: NSError) -> String
    {
        var message : String
        switch error.code{
        case NSURLErrorNotConnectedToInternet:
            message = SVConstants.INTERNET_ERROR_MESSAGE
        
        default:
            message = SVConstants.CONNECTION_ERROR_MESSAGE;
        }
        
        return message
    }
    
    static func showAlert(title: String, message: String, controller: UIViewController)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
        
        controller.presentViewController(alert, animated: true, completion: nil)
        
        
    }

    
    static func showAlert(title: String, message: String, controller: UIViewController, actionHandler handler: (UIAlertAction) -> Void)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: handler))
        
        controller.presentViewController(alert, animated: true, completion: nil)

        
    }
    
    static func currentDateWithFormat(format : String) -> String
    {
        
        let formatter:NSDateFormatter? = NSDateFormatter();
        
        formatter?.dateFormat = format;
        
        return (formatter?.stringFromDate(NSDate()))!
    }
    
    static func dateFromString(string:String, inFormat format:String)->NSDate?{
        
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = format
        
        return formatter.dateFromString(string)
    
    }
    
    static func stringFromDate(date:NSDate, inFormat format:String)->String?{
        
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = format
        
        return formatter.stringFromDate(date)
        
    }
    
    static func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = text
        
        
        label.sizeToFit()
        return label.frame.height
    }
    
    static func getHelveticaFontWithSize(size:CGFloat) -> UIFont {
        
        return UIFont(name: "HelveticaNeue", size: size)!
        
    }
    
    static func getHelveticaBoldFontWithSize(size:CGFloat) -> UIFont {
        
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
        
    }
    
    static func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    static func getPagingVCWithIdentifier(identifier:String)->UIViewController {
        
        let storyboard = SVUtil.pagingStoryBoard()
        
        return storyboard.instantiateViewControllerWithIdentifier(identifier)
    }
    
    static func getVCWithIdentifier(identifier:String)->UIViewController {
        
        let storyboard = SVUtil.mainStoryBoard()
        
        return storyboard.instantiateViewControllerWithIdentifier(identifier)
    }
    
    static func getCartVCWithIdentifier(identifier:String)->UIViewController {
        
        let storyboard = SVUtil.cartStoryBoard()
        
        return storyboard.instantiateViewControllerWithIdentifier(identifier)
    }
    
    static func appWindow()->UIWindow {
        
        return ((UIApplication.sharedApplication().delegate?.window)!)!
    }
    
    static func showLoader() {
        
        
        if let _ = SVUtil.appWindow().viewWithTag(SVConstants.API_LOADER_TAG) {
            
            //Do nothing
        }
        else {
            let loader:SVLoaderView = (NSBundle.mainBundle().loadNibNamed("SVLoaderView", owner: nil, options: nil).first as? SVLoaderView)!
            
            loader.tag = SVConstants.API_LOADER_TAG
            
            loader.frame = SVUtil.appWindow().bounds
            
            SVUtil.appWindow().addSubview(loader)
        }
        

    }
    
    static func hideLoader() {
        
        let view = SVUtil.appWindow().viewWithTag(SVConstants.API_LOADER_TAG)
        
        if let _ = view {
            view?.removeFromSuperview()
        }
        
    }
    
    static private func setDataTimestamp(){
        
        return NSUserDefaults.standardUserDefaults().setBool(true, forKey:SVConstants.DATA_AVAILABLE_KEY)
    }
    
    static func setIsDataAvailable(available:Bool){
        
        return NSUserDefaults.standardUserDefaults().setBool(available, forKey:SVConstants.DATA_AVAILABLE_KEY)
    }
    
    static func isDataAvailable() -> Bool {
        
        return NSUserDefaults.standardUserDefaults().boolForKey(SVConstants.DATA_AVAILABLE_KEY)
    }
    
    static func validDataAvailable()-> Bool{

        if SVUtil.isDataAvailable() == true {
            return true
        }
        else {
            return false
        }
    }
    
    static func documentsDirectoryPath() -> NSURL {
        
        return NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    }
    
    static func pathByAddingFileName(fileName:String)-> NSURL? {
        
        return SVUtil.documentsDirectoryPath().URLByAppendingPathComponent(fileName)
    }
    
    static func unZip(filePath:NSURL, completionHandler handler:(Bool)->Void){
        
        do {
            
            try Zip.unzipFile(filePath, destination: SVUtil.documentsDirectoryPath(), overwrite: true, password: nil, progress: { (progress) -> () in
                
                //completed
                if progress >= 1.0 {
                    
                    handler(true)
                }
            }) // Unzip
            
        }
        catch {
            print("Something went wrong")
        }
    }
    
    static func managedObjectContext()->NSManagedObjectContext {
        
        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as? AppDelegate)!
        
        return appDelegate.managedObjectContext;
        
        
    }
    
    static func saveContext() {
        
        let delegate:AppDelegate = (UIApplication.sharedApplication().delegate as? AppDelegate)!
        
        delegate.saveContext()
    }
    
    static func productImageURL(imageName:String) -> NSURL {
        
        var urlStr = SVConstants.IMAGE_BASE_URL + imageName
        
        urlStr = urlStr.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        return NSURL(string: urlStr)!
        
    }
    
    static func categoryImageURL(imageName:String) -> NSURL {
        
        var urlStr = SVConstants.CATEGORY_BASE_URL + imageName
        
        urlStr = urlStr.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        return NSURL(string: urlStr)!
        
    }
    static func masterCategoryImageURL(imageName:String) -> NSURL {
        
        var urlStr = SVConstants.MASTER_CATEGORY_BASE_URL + imageName
        
        urlStr = urlStr.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        return NSURL(string: urlStr)!
        
    }
    static func bannerURL(imageName:String) -> NSURL {
        
        var urlStr = SVConstants.BANNER_BASE_URL + imageName
        
        urlStr = urlStr.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        return NSURL(string: urlStr)!
        
    }
    
    static func storeImageURL(imageName:String) -> NSURL {
        
        var urlStr = SVConstants.STORE_IMAGE_BASE_URL + imageName + ".png"
        
        urlStr = urlStr.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        return NSURL(string: urlStr)!
        
    }
    
    
    static func getBadgeText()-> String? {
        
        let cartInfo:SVCartInfo? = SVUtil.getCustomObject(SVConstants.CART_INFO_KEY) as? SVCartInfo
        
        if let _ = cartInfo {
            
            return cartInfo?.count!
        }
        else {
            return "0"
        }
        
    }
    
    static func openURL(url:String) {
        
        if let url = NSURL(string: url)
        {
            if UIApplication.sharedApplication().canOpenURL(url)
            {
                UIApplication.sharedApplication().openURL(url)
            }
        }

    }
}

//
//  SVBaseViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/25/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

let BADGE_TAG = 5670

class SVBaseViewController: UIViewController {
    
    //MARK: Abstract Overridden Methods, should be implemented by the subclasses.
    internal func navBarConfig()-> SVNavBarConfig {
        
        return SVNavBarConfig(showBack: true, showSearch: true, showCart: true, title: "")
    }
    
    //MARK: Private Methods
    
    private func getBadgeLabel()->UILabel? {
        
        return self.navigationController?.navigationBar.viewWithTag(BADGE_TAG) as? UILabel
    }
    internal func cartTapped() {
        
        self.navigationController?.pushViewController(SVUtil.getCartVCWithIdentifier("SVCartViewController"), animated: true)
        
    }
    
    internal func searchTapped() {
        self.navigationController?.pushViewController(SVUtil.getVCWithIdentifier("SVSearchViewController"), animated: true)
        
    }
    
    internal func backTapped() {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    internal func prepareNavBar(config:SVNavBarConfig) {
        
        if self.navigationController != nil {
            
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            
            self.navigationController?.navigationBar.barTintColor = UIColor(hexString: SVConstants.APP_THEME_COLOR_RED)
            
            //self.navigationController?.navigationBar.backgroundColor = UIColor(hexString: SVConstants.APP_THEME_COLOR_RED)
            self.navigationController?.navigationBar.translucent = false
            
            self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
            
            var items:Array<UIBarButtonItem> = Array<UIBarButtonItem>()
            
            if config.showCart {
                
                let cartButton:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "cart"), style: .Plain, target: self, action: #selector(cartTapped))
                
                items.append(cartButton)
            }
            
            if config.showSearch {
                
                let searchButton:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_icon2"), style: .Plain, target: self, action: #selector(searchTapped))
                
                items.append(searchButton)
                
                
            }
            
            if items.count > 0 {
                
                self.navigationItem.rightBarButtonItems = items
                
            }
            
            if config.title?.characters.count > 0 {
                
                let label:UILabel = UILabel(frame: CGRectMake(0, 0, 140, 30))
                
                label.textAlignment = .Center
                
                label.text = config.title
                
                label.font = SVUtil.getHelveticaBoldFontWithSize(18)
                
                label.textColor = UIColor.whiteColor()
                
                self.navigationItem.titleView = label
                
            }
            
            if config.showBack {
                
                let backButton = UIBarButtonItem(image: UIImage(named: "left_arrow"), style: .Plain, target: self, action: #selector(backTapped))
                
                self.navigationItem.leftBarButtonItem = backButton
            }
        }
        
    }

    //MARK: View Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = self.navigationController?.navigationBar.viewWithTag(BADGE_TAG) {
            
            
            
        }
        else {
            
            self.addBadge()
        }
        NSNotificationCenter.defaultCenter().addObserverForName(SVConstants.CART_UPDATED_NOTIFICATION, object: nil, queue: nil) { (notification
            ) in
            
            self.getBadgeLabel()?.text = SVUtil.getBadgeText()!
        }

        
        self.prepareNavBar(self.navBarConfig())
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if self.navBarConfig().showCart == true {
            getBadgeLabel()?.hidden = false
            getBadgeLabel()?.text = SVUtil.getBadgeText()!
        }
        else {
            getBadgeLabel()?.hidden = true
        }
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
    
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}



extension SVBaseViewController {
    
    private func addBadge()
    {
        
        let badgeLabel = UILabel(frame: CGRectMake(self.view.frame.width - 20, 0, 16, 16))
        
        badgeLabel.tag = BADGE_TAG
        badgeLabel.layer.cornerRadius = 8;
        badgeLabel.layer.masksToBounds = true;
        self.navigationController?.navigationBar.addSubview(badgeLabel)
        badgeLabel.backgroundColor = UIColor(RGB: (255, 190, 0))
        badgeLabel.textColor = UIColor.blackColor()
        badgeLabel.textAlignment = .Center;
        badgeLabel.text = SVUtil.getBadgeText()!
        badgeLabel.font = UIFont.systemFontOfSize(10)
        
        
    }
}

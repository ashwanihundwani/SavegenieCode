//
//  Menu.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/26/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

enum MenuAction : Int {
    
    case MyOrders
    case MyProfile
    case Refer
    case Affiliation
    case MyLists
    case ContactUs
    case Logout
}


class Menu: UITableViewController {

    var menuItems:Array<(text:String, image:String, action:MenuAction)> = Array<(text:String, image:String, action:MenuAction)>()

    
    //MARK : Private Methods
    func setTableHeaderView() {
        
        let view:UIView = UIView(frame: CGRectMake(0,0,self.tableView.frame.size.width, 120))
        
        let imageView = UIImageView(frame: CGRectMake(5,25,70, 70))
        
        imageView.image = UIImage(named: "savegenie_logo_2")
        
        view.addSubview(imageView)
        
        let title:UILabel = UILabel( frame: CGRectMake(85,40,self.tableView.frame.size.width - 85, 40))
        
        title.numberOfLines = 2
        
        title.font = SVUtil.getHelveticaFontWithSize(16)
        
        if let user = SVUtil.getUserDetails() {
            
            title.text = "Welcome\n\(user.firstName!) \(user.lastName!)"
        }
        
        
        
        view.addSubview(title)
        
        view.backgroundColor = UIColor(red: 245.0 / 255.0, green: 245.0 / 255.0, blue: 245.0 / 255.0, alpha: 1)
        
        self.tableView.tableHeaderView = view
    }
    
    func performAction(action:MenuAction) {
        
        let drawerController = self.navigationController?.parentViewController as? KYDrawerController;
        
        let homeController = drawerController?.mainViewController as? UINavigationController
        
        switch action {
            
        case .MyOrders:
            homeController!.pushViewController(SVUtil.getVCWithIdentifier("SVOrdersViewController"), animated: false)
        case .ContactUs:
            homeController!.pushViewController(SVUtil.getVCWithIdentifier("SVContactUsViewController"), animated: false)
        case .Refer:
            homeController!.pushViewController(SVUtil.getVCWithIdentifier("SVReferViewController"), animated: false)
        case .Logout:
            
            SVUtil.removeCustomObject(SVConstants.USER_DETAIL_ARCHIVE_KEY)
                //TODO - Add Logout functionality
            SVUtil.appWindow().rootViewController = UINavigationController(rootViewController: (SVUtil.getVCWithIdentifier("SVLoginViewController")))
            
        case .MyProfile:
            homeController!.pushViewController(SVUtil.getVCWithIdentifier("SVProfileViewController"), animated: false)
            
        case .MyLists:
            homeController!.pushViewController(SVUtil.getVCWithIdentifier("SVListViewController"), animated: false)
        default:
            break
        }
    }
    
    //MARK : View Controller Life Cycle Methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        setTableHeaderView()
        
        menuItems.append((text: "My Orders", image: "orders", action:.MyOrders))
        menuItems.append((text: "My Profile", image: "myprofile", action:.MyProfile))
        menuItems.append((text: "Refer & Earn", image: "refer", action:.Refer))
        menuItems.append((text: "Affiliation", image: "affiliation", action:.Affiliation))
        menuItems.append((text: "My Lists", image: "lists", action:.MyLists))
        menuItems.append((text: "Contact Us", image: "contact", action:.ContactUs))
        menuItems.append((text: "Logout", image: "logout", action:.Logout))
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    //MARK : Table view
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return menuItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:SVMenuItemCell? = tableView.dequeueReusableCellWithIdentifier("SVMenuItemCell") as? SVMenuItemCell
        
        if let _ = cell {
            
        }
        else {
            
            let itemCell:SVMenuItemCell = (NSBundle.mainBundle().loadNibNamed("SVMenuItemCell", owner: nil, options: nil).first as? SVMenuItemCell)!
            
            cell = itemCell
        }
        
        let record:(String, String, MenuAction) = menuItems[indexPath.row]
        cell?.lblTitle.text = record.0
        cell?.imgItem.image = UIImage (named: record.1)
        
        return cell!
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        performAction(menuItems[indexPath.row].action)
        
        let drawerController = self.navigationController?.parentViewController as? KYDrawerController;
        
        if let _ = drawerController {
            drawerController?.setDrawerState(.Closed, animated: true)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

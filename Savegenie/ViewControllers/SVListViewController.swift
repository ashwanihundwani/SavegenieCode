//
//  SVListViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 8/4/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVListViewController: SVBaseViewController, UITableViewDelegate, UITableViewDataSource {

    var lists:SVMyLists? = nil
    @IBOutlet weak var tableView:UITableView!
    
    //MARK: Overridden Methods
    override func navBarConfig() -> SVNavBarConfig {
        return SVNavBarConfig(showBack: true, showSearch: true, showCart: true, title: "My Lists")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        fetchMyLists()
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
    
    //MARK: TableView Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let _ = self.lists {
            
            return (self.lists?.lists?.count)!
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        return 40
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableCell:SVListCell = (tableView.dequeueReusableCellWithIdentifier(String(SVListCell)) as? SVListCell)!
        
        tableCell.setList((self.lists?.lists![indexPath.row])!)
        
        return tableCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc:SVCartViewController = (SVUtil.getCartVCWithIdentifier("SVCartViewController") as? SVCartViewController)!
        
        vc.cartId = lists?.lists![indexPath.row].id
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK: Private Methods
    private func fetchMyLists()
    {
        SVJSONAppService.fetchMyList(Array<(key: String, value: AnyObject)>(), responsObjectKey: "") { (lists:SVMyLists?, error:NSError?) in
            
            if let _ = lists {
                self.lists = lists
                self.tableView.reloadData()
            }
            
        }
    }

}

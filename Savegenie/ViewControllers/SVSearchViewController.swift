//
//  SVSearchViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 6/23/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVSearchViewController: SVBaseViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView:UITableView!
    
    var filteredItems:Array<Product> = Array<Product>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func navBarConfig() -> SVNavBarConfig {
        
        return SVNavBarConfig(showBack: true, showSearch: false, showCart: true, title: "Search")
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Table View datasource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableCell:SVSearchItemCell = (tableView.dequeueReusableCellWithIdentifier(String(SVSearchItemCell)) as? SVSearchItemCell)!
        
        let searchItem = self.filteredItems[indexPath.row]
        
        tableCell.setSearchItem(searchItem)
        
        return tableCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let productController:SVProductViewController = (SVUtil.getVCWithIdentifier("SVProductViewController") as? SVProductViewController)!
        
        productController.products = Array<Product>()
        
        productController.products.append(filteredItems[indexPath.row])
        
        self.navigationController?.pushViewController(productController, animated: true)
    }
    
    //MARK: UITextField Delegate Methodse
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        var finalString:NSString = textField.text!
        
        finalString = finalString.stringByReplacingCharactersInRange(range, withString: string)
        
        if finalString.length > 0 {
            
            filteredItems = SVCoreDataManager.fetchProductsWithSearchKeyword(finalString as String)!
        }
        else {
            
            filteredItems.removeAll()
        }
        self.tableView.reloadData()
        return true
    }


}

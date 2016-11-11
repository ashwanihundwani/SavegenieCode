//
//  SVCartViewController.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/11/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit

class SVCartViewController: SVBaseViewController, UITableViewDataSource, SVCartProductCellDelegate {

    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var cart:SVCart? = nil
    var cartId:String? = nil
    
    //MARK: Action Methods
    @IBAction func didTapCheckout() {
        
        if cart?.products.count > 0 {
            self.navigationController?.pushViewController(SVUtil.getCartVCWithIdentifier("SVReviewOrderViewController"), animated: true)
            
        }
        else {
            SVUtil.showAlert(SVConstants.APP_NAME, message: "Please add some items in cart to proceed.", controller: self)
        }
    }
    
    //MARK: Overridden Methods
    
    override func navBarConfig() -> SVNavBarConfig {
        
        var title:String = ""
        
        if let _ = cart {
            if cart?.products.count > 0 {
                title = (cart?.cartName)! + " (\(cart!.count!))"
            }
            else {
                title = "Cart is empty"
            }
        }
        else {
                title = "Cart is empty"
        }
        
        return SVNavBarConfig(showBack: true, showSearch: false, showCart: false, title: title)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVUtil.showLoader()
        
        if let _ = cartId {
            self.chooseCart()
        }
        else {
            
            self.selectCart()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private Methods
    
    private func selectCart()
    {
        SVTextAppService.selectCart { (obj:AnyObject?, error:NSError?) in
            
            self.fetchCart()
        }
    }
    
    internal func prepareCell(cell:SVCartProductCell, product:SVCartProduct) {
        cell.delegate = self
        cell.setCartProduct(product)
        
    }
    
    private func chooseCart() {
        
        var params:Array<(key: String, value: AnyObject)> = Array<(key: String, value: AnyObject)>()
        
        params.append(("data[id]",cartId!))
        
        SVJSONAppService.chooseList(params, responsObjectKey: "", completionHandler: { (cart:SVCart?, error:NSError?) in
                
                self.cart = cart
                self.prepareNavBar(self.navBarConfig())
                
                if self.cart?.products.count > 0 {
                    
                    self.tableView.reloadData()
                    self.tableView.hidden = false
                }
                else {
                    self.tableView.hidden = true
                }
                
                
                SVUtil.hideLoader()
                
            })
    }
    
    private func fetchCart() {
        
        
        let params:Dictionary<String,AnyObject> = Dictionary<String, AnyObject>()
        
        //params["data[id]"] = "8755"
        
        
        SVJSONAppService.fetchCart(params, responsObjectKey: "", completionHandler: { (response:SVCart?, error:NSError?) in
                
                self.cart = response
                self.prepareNavBar(self.navBarConfig())
                    
                if self.cart?.products.count > 0 {
                    
                    self.tableView.reloadData()
                    self.tableView.hidden = false
                }
                else {
                    self.tableView.hidden = true
                }
            
            
                SVUtil.hideLoader()
                
        })
        
    }
    
    private func setTotalPrice() {
        var totalPrice = 0
        if cart?.products.count > 0 {
            for cartProduct in (cart?.products)! {
                if let _ = cartProduct.mrp, price = Int(cartProduct.mrp!) {
                    totalPrice += price
                }
            }
        }
        
        totalPriceLabel.text = "Rs \(totalPrice)"
    }
    
    //MARK: Table View datasource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let _ = cart {
            return (self.cart?.products.count)!
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableCell:SVCartProductCell = (tableView.dequeueReusableCellWithIdentifier(String(SVCartProductCell)) as? SVCartProductCell)!
        
        tableCell.delegate = self
        
        
        let product = self.cart?.products[indexPath.row];
        
        
        self.prepareCell(tableCell, product:product!)
        
        setTotalPrice()
        
        return tableCell
    }
    
    //MARK : SVCart Product Cell Delegate Methods
    func didTapPlus(sender: SVCartProductCell, maxreached: Bool) {
        
        if maxreached == true {
            
            SVUtil.showAlert(SVConstants.APP_NAME, message: "Maximium limit reached", controller: self)
            return
        }
        
        if let product:SVCartProduct = sender.productDB {
            
            SVUtil.showLoader()
            
//            let indexPath = self.tableView.indexPathForCell(sender)
//            let cartProduct:SVCartProduct = (self.cart?.products[(indexPath?.row)!])!
//            
//            let countInt = Int(product.count!)! + 1
//            
//            cartProduct.count = "\(countInt)"
            
            SVCartUpdateManager.addSKU(product.skuID!, completionHandler: { (success:Bool) in
                
                SVUtil.hideLoader()
                self.tableView.reloadData()
                
            })
        }
    }
    
    func didTapMinus(sender: SVCartProductCell) {
        
        if let product:SVCartProduct = sender.productDB {
            
            SVUtil.showLoader()
//            
//            let indexPath = self.tableView.indexPathForCell(sender)
//            let cartProduct:SVCartProduct = (self.cart?.products[(indexPath?.row)!])!
//            
//            let countInt = Int(product.count!)! - 1
//            
//            cartProduct.count = "\(countInt)"
            
            SVCartUpdateManager.removeSKU(product.skuID!, completionHandler: { (success:Bool) in
                
                SVUtil.hideLoader()
                self.tableView.reloadData()
                
            })
        }

    }
    
    func didTapDelete(sender: SVCartProductCell) {
        
        if let product:SVCartProduct = sender.productDB {
            
            SVUtil.showLoader()
            SVCartUpdateManager.deleteProduct(product.skuID!, completionHandler: { (success:Bool) in
                
                self.selectCart()
                
            })
        }
    }
}

//
//  MyCartCell.swift
//  MarketPlace
//
//  Created by Administrator on 8/25/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

@objc protocol mycartDelegate
{
    optional  func mycartDelegateFunction(tagInfo:Int)
     optional  func mycartDelegateFunctionOffline(tagInfo:Int)
  optional  func mycartdeleteDelegateFunction(tagInfo:Int)
    optional  func mycartdeleteDelegateFunctionOffline(tagInfo:Int)
    
}

class MyCartCell: UITableViewCell {

    @IBOutlet var productImg : UIImageView!
    @IBOutlet weak var prodTitleLabel:UILabel!
    @IBOutlet weak var prodPriceLabel:UILabel!
    @IBOutlet weak var quantityBtn:UIButton!
    @IBOutlet weak var deleteBtn:UIButton!
    @IBOutlet weak var outOfstockLbl:UILabel!
    var delegates : mycartDelegate?
    var lineItemId:Int!
    var placedPrice:String!
    var BasketId: Int!
    var quantity:Int!
    var oldQntity:NSString!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func seleactQuantity(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId"){
        self.delegates?.mycartDelegateFunction!(self.quantityBtn.tag)
        }else{
            self.delegates?.mycartdeleteDelegateFunctionOffline!(self.quantityBtn.tag)
        }
    }
    @IBAction func deleteCartItem(sender: AnyObject) {
       
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId"){
        self.delegates?.mycartdeleteDelegateFunction!(self.quantityBtn.tag)
        }else{
            self.delegates?.mycartDelegateFunctionOffline!(self.quantityBtn.tag)
        }
        
    }
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        switch buttonIndex{
        case 0: break
        // self.checkBtn.setTitle("Qty:1", forState: UIControlState.Normal)
        case 1: break
        // self.checkBtn.setTitle("Qty:2", forState: UIControlState.Normal)
        case 2: break
        //  self.checkBtn.setTitle("Qty:3", forState: UIControlState.Normal)
        case 3: break
        //  self.checkBtn.setTitle("Qty:4", forState: UIControlState.Normal)
        default:
            print("cancel")
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

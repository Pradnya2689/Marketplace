//
//  OrderTableViewCell.swift
//  MarketPlace
//
//  Created by Administrator on 01/09/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
@objc protocol orderReturnDelegate
{
    optional  func ratebuttonClicked(orderId:String,customerLineNumber:String)
    optional  func trackbuttonClicked(orderId:String)
    
}
class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var imgOrderCell: UIImageView!
    @IBOutlet weak var nameLabelOrderCell: UILabel!
    @IBOutlet weak var trackBtn:UIButton!
    @IBOutlet weak var viewReturnsBtn:UIButton!
    @IBOutlet weak var freeBeLabl:UILabel!
    
    weak var  delegates:orderReturnDelegate!
    var orderId:String!
    var customerLineNumber:String!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func viewReturnClk(){
        self.delegates.ratebuttonClicked!(self.orderId,customerLineNumber: self.customerLineNumber)
    }
    
    @IBAction func trackBtnClk(){
        self.delegates.trackbuttonClicked!(self.orderId)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

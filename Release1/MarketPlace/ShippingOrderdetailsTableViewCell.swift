//
//  ShippingOrderdetailsTableViewCell.swift
//  MarketPlace
//
//  Created by Administrator on 07/09/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class ShippingOrderdetailsTableViewCell: UITableViewCell {

    let screenSize: CGRect = UIScreen.mainScreen().bounds

   
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var prodImgView: UIImageView!
    @IBOutlet weak var prodNameLb: UILabel!
    @IBOutlet weak var shopNameLb: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var amountLabelOutlet: UILabel!
    @IBOutlet weak var shipmentNoLb: UILabel!
    @IBOutlet weak var delvDateLb: UILabel!
    @IBOutlet weak var inVoiceNoLb: UILabel!
       @IBOutlet weak var freebeLbl:UILabel!
    @IBOutlet weak var orderStatusLbl:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        statusLabel.translatesAutoresizingMaskIntoConstraints = true
//        statusLabel.frame = CGRectMake(141.0, 80.0, 171.0, 20.0)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

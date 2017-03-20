//
//  ShippingHeaderTableViewCell.swift
//  MarketPlace
//
//  Created by Administrator on 07/09/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class ShippingHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var addTV: UITextView!
    @IBOutlet weak var totalTileLbl:UILabel!
    @IBOutlet weak var totalAmtLb: UILabel!
    @IBOutlet weak var numberofOrderLb: UILabel!
    @IBOutlet weak var payMethodLB: UILabel!
    @IBOutlet weak var subtotalLbl:UILabel!
    @IBOutlet weak var shippingLbl:UILabel!
    @IBOutlet weak var promotionalLbl:UILabel!
    @IBOutlet weak var promotionalTitleLbl:UILabel!
    @IBOutlet weak var promotionalDevider:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

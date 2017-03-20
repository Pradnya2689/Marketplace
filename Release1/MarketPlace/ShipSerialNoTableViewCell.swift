//
//  ShipSerialNoTableViewCell.swift
//  MarketPlace
//
//  Created by Administrator on 27/09/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class ShipSerialNoTableViewCell: UITableViewCell {
    @IBOutlet weak var serialLbl:UILabel!
    @IBOutlet weak var shipSerialNoLabel: UILabel!
    @IBOutlet weak var shipmentNoLbl:UILabel!
    @IBOutlet weak var statusLbl:UILabel!
    @IBOutlet weak var deliveryDateLbl:UILabel!
    @IBOutlet weak var invoiceNoLbl:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

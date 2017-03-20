//
//  AddressPickupTableViewCell.swift
//  MarketPlace
//
//  Created by Administrator on 28/09/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class AddressPickupTableViewCell: UITableViewCell {

    @IBOutlet weak var addressPickupBtn: UIButton!
    @IBOutlet weak var pickupCellNameLabel: UILabel!
    @IBOutlet weak var pickupAddress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

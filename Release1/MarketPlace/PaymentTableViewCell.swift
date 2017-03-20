//
//  PaymentTableViewCell.swift
//  MarketPlace
//
//  Created by Administrator on 30/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var paymentTBLabel: UILabel!
    @IBOutlet weak var paymentTBImageView: UIImageView!
    @IBOutlet weak var codLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

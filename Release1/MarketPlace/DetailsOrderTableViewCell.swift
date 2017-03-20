//
//  DetailsOrderTableViewCell.swift
//  MarketPlace
//
//  Created by Administrator on 06/09/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class DetailsOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var orderAmountLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderStatusLabel: UILabel!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var actInd:UIActivityIndicatorView!
    var freeItemIndicator:String!
   // @IBOutlet weak var freebeLbl:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

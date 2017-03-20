//
//  FreeBeCell.swift
//  MarketPlace
//
//  Created by pradnya on 08/11/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class FreeBeCell: UITableViewCell {
    @IBOutlet weak var prodImg:UIImageView!
    @IBOutlet weak var freebeLbl:UILabel!
    @IBOutlet weak var prodNamelbl:UILabel!
    @IBOutlet weak var prodPriceLbl:UILabel!
    @IBOutlet weak var qntBtn:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  ViewReturnHeaderCell.swift
//  MarketPlace
//
//  Created by pradnya on 14/11/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class ViewReturnHeaderCell: UITableViewCell {
    @IBOutlet var returnLbl:UILabel!
    @IBOutlet var returnDate:UILabel!
    @IBOutlet   var returnStatus:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

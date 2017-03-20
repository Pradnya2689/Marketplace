//
//  ReviewCell.swift
//  MarketPlace
//
//  Created by pradnya on 14/09/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    @IBOutlet var review1Title:UILabel!
    @IBOutlet var review1DateLbl:UILabel!
    @IBOutlet var review1stars:FloatRatingView!
    @IBOutlet var review1Commnt:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

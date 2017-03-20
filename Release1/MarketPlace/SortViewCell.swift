//
//  SortViewCell.swift
//  MarketPlace
//
//  Created by Administrator on 16/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class SortViewCell: UITableViewCell {

    @IBOutlet weak var sortLabel: UILabel!
    @IBOutlet var sortTypeLbl:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        sortLabel.translatesAutoresizingMaskIntoConstraints = true
//        sortLabel.frame = CGRectMake(0, 50, screenWidth, 1)
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

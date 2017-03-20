//
//  CustomHeaderCell.swift
//  MarketPlace
//
//  Created by inpanr07 on 08/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class CustomHeaderCell: UITableViewCell {

    @IBOutlet var headerTextLbl: UILabel!
    @IBOutlet var headerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        headerImage.translatesAutoresizingMaskIntoConstraints = true
        headerTextLbl.frame = CGRectMake(60.0, 9.0, 331.0, 40.0)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

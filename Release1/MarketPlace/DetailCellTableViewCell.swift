//
//  DetailCellTableViewCell.swift
//  MarketPlace
//
//  Created by Administrator on 28/09/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class DetailCellTableViewCell: UITableViewCell {

    @IBOutlet weak var prodImageView: UIImageView!
    @IBOutlet weak var nameProdLabel: UILabel!
    @IBOutlet weak var prodQtyLabel: UILabel!
   
    @IBOutlet weak var priceProdLabel: UILabel!
    @IBOutlet weak var compNameLb: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        priceProdLabel.translatesAutoresizingMaskIntoConstraints = true
//        priceProdLabel.frame = CGRectMake(76.0, 68.0, 42.0, 21.0)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

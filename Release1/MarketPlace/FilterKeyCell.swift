//
//  FilterKeyCell.swift
//  MarketPlace
//
//  Created by Administrator on 17/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class FilterKeyCell: UITableViewCell {
    
    @IBOutlet var optionLabl:UILabel!
    @IBOutlet var countBtn:MIBadgeButton!
    override func awakeFromNib() {
        super.awakeFromNib()
      //  countBtn = MIBadgeButton.init(frame:  CGRectMake(90, 10, 45, 45))
       //countBtn.frame = CGRectMake(90, 10, 45, 45)
       countBtn.badgeEdgeInsets =  UIEdgeInsetsMake(10, 0, 0, 10)
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

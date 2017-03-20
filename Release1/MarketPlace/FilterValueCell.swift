//
//  FilterValueCell.swift
//  MarketPlace
//
//  Created by Administrator on 17/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class FilterValueCell: UITableViewCell {
    @IBOutlet var valueLbl:UILabel!
    var uniqueId :  NSString!
     var pId :  Int!
    @IBOutlet var userReviwImg:FloatRatingView!
    @IBOutlet var prodCntLbl:UILabel!
    @IBOutlet var chkBbtn:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

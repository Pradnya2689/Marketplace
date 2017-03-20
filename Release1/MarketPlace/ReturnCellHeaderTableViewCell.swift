//
//  ReturnCellHeaderTableViewCell.swift
//  MarketPlace
//
//  Created by Administrator on 23/09/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class ReturnCellHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var returnStatusLb: UILabel!
    @IBOutlet weak var returnNumberLb: UILabel!
    @IBOutlet weak var dateLbReturn: UILabel!
    @IBOutlet weak var returnOrderNumberLb: UILabel!
    @IBOutlet weak var priceLb: UILabel!
    @IBOutlet weak var returnQtyLb: UILabel!
    @IBOutlet weak var returnNameLabel: UILabel!
    @IBOutlet weak var returnView: UIView!
    @IBOutlet weak var returnImgView: UIImageView!
    @IBOutlet weak var companyNameLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

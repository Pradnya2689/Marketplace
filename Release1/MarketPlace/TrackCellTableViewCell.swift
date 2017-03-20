//
//  TrackCellTableViewCell.swift
//  MarketPlace
//
//  Created by Administrator on 03/10/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class TrackCellTableViewCell: UITableViewCell {

    @IBOutlet weak var trckCircleWhite: UIImageView!
    @IBOutlet weak var trackCircleBlue: UIImageView!
    @IBOutlet weak var trackWhitePath: UIImageView!
    @IBOutlet weak var trackBluePath: UIImageView!
    @IBOutlet weak var trackStageLabel: UILabel!
    @IBOutlet weak var trackDateLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

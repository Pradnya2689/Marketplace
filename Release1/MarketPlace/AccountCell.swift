//
//  AccountCell.swift
//  Myaccount
//
//  Created by Developer on 8/12/16.
//  Copyright © 2016 Ingram. All rights reserved.
//

import UIKit

class AccountCell: UITableViewCell {

    @IBOutlet weak var locaationLabel: UILabel!
    @IBOutlet weak var cellPhoto: UIImageView!
    @IBOutlet weak var accountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

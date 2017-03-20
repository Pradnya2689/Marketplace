//
//  CustomViewCell.swift
//  scrolltableView
//
//  Created by inpanr07 on 18/07/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class CustomViewCell: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var valuelbl: UILabel!
    @IBOutlet weak var noResultLbl:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.lbl.layer.borderWidth = 1
        self.valuelbl.layer.borderWidth = 1
         self.lbl.layer.borderColor = UIColor (red: 230.0, green: 230.0, blue: 230.0, alpha: 0.0).CGColor
        self.valuelbl.layer.borderColor = UIColor (red: 230.0, green: 230.0, blue: 230.0, alpha: 0.0).CGColor
                // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

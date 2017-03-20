//
//  AddressTableViewCell.swift
//  MarketPlace
//
//  Created by Administrator on 25/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var addTitleLabel: UILabel!
    
    @IBOutlet weak var editaddressLabel: UITextView!
    
    @IBOutlet weak var separatorLabel: UILabel!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var addSetBtn: UIButton!
    @IBOutlet weak var addEditBtn: UIButton!
    @IBOutlet weak var addNameLabel: UILabel!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBAction func editAddressButton(sender: AnyObject) {
       // address
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addEditBtn.layer.borderWidth = 1;
        addEditBtn.layer.borderColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1).CGColor
        addSetBtn.layer.borderWidth = 1;
        addSetBtn.layer.borderColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1).CGColor
        
        }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  WishListCell.swift
//  MarketPlace
//
//  Created by pradnya on 31/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
@objc protocol wishListDelegate
{
    optional  func mycartDelegateFunction(sku:String)
    
    
}

class WishListCell: UITableViewCell {
    @IBOutlet var productImg : UIImageView!
    @IBOutlet weak var prodTitleLabel:UILabel!
    @IBOutlet weak var prodPriceLabel:UILabel!
    @IBOutlet weak var discountLabl:UILabel!
    var skunumber:String!
    var delegates : wishListDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func deleteFRomWishList(){
        self.delegates?.mycartDelegateFunction!(skunumber)
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

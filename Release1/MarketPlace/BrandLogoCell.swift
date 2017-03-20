//
//  BrandLogoCell.swift
//  MarketPlace
//
//  Created by Administrator on 09/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

@objc protocol vendorLogocellDelegate
{
  // optional func vendorBtnClk(vendrDet:VendorLogoList)
}

class BrandLogoCell: UICollectionViewCell {
    @IBOutlet var logoImg:UIImageView!
    var delegates : vendorLogocellDelegate?
    var vendorDet : VendorLogoList!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.logoImg.translatesAutoresizingMaskIntoConstraints = true
        self.logoImg.frame=CGRectMake(5, 3, 60, 50)
        
    }
    
    @IBAction func logoClicked(){
   // self.delegates?.vendorBtnClk?(self.vendorDet)
    }
}

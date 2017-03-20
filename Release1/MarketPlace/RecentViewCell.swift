//
//  RecentViewCell.swift
//  MarketPlace
//
//  Created by Administrator on 09/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class RecentViewCell: UICollectionViewCell{
    @IBOutlet weak var categoryLabl: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var prodImg: UIImageView!
    var sku:String!
    @IBOutlet weak var newProdImgView: UIImageView!
    @IBOutlet var DescriptionLbl: UILabel!
   let boundss = UIScreen.mainScreen().bounds
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prodImg.translatesAutoresizingMaskIntoConstraints = true
        self.prodImg.frame=CGRectMake(8, 8, 144, 105)
        self.categoryLabl.translatesAutoresizingMaskIntoConstraints = true
        self.categoryLabl.frame=CGRectMake(8, 126, 144, 21)
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = true
        self.priceLabel.frame=CGRectMake(8, 152, 144, 21)
        
       self.priceLabel.textAlignment = NSTextAlignment.Center
    }
    
}

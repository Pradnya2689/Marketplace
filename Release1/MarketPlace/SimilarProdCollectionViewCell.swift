//
//  SimilarProdCollectionViewCell.swift
//  MarketPlace
//
//  Created by Administrator on 19/10/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class SimilarProdCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ImgViewSimilarProd: UIImageView!
    @IBOutlet weak var prodNameSimilarProd: UILabel!
    @IBOutlet weak var priceLbSimilarProd: UILabel!
    
    override func awakeFromNib() {
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.layer.borderWidth = 0.3
        
       
    }
    
}

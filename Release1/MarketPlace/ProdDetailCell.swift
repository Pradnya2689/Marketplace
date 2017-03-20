//
//  ProdDetailCell.swift
//  MarketPlace
//
//  Created by pradnya on 02/12/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import Alamofire

@objc protocol myProdFavDelegate
{
    optional  func mycartDelegateFunction(tagInfo:Int,sender:DOFavoriteButton,sku:String)
}
class ProdDetailCell: UITableViewCell,FloatRatingViewDelegate {

    @IBOutlet weak var prodTableLabel: UILabel!
    @IBOutlet weak var newProdIV: UIImageView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descrptnView: UIView!
    //  @IBOutlet weak var favouritebtn: UIButton!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescriptn: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var actualPriceLbl: UILabel!
    @IBOutlet weak var favBtn: DOFavoriteButton!
    @IBOutlet var floatRatingView: FloatRatingView!
    @IBOutlet var DiscountLbl: UILabel!
    var delegates : myProdFavDelegate?
    var request: Request?
    var glacierScenic: GlacierScenic!
    var skuNumber:String!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.floatRatingView.emptyImage = UIImage(named: "StarEmpty")
        self.floatRatingView.fullImage = UIImage(named: "StarFull")
        // Optional params
        self.floatRatingView.delegate = self
        self.floatRatingView.contentMode = UIViewContentMode.ScaleAspectFit
        self.floatRatingView.maxRating = 5
        self.floatRatingView.minRating = 1
        
        self.favBtn.imageColorOff = UIColor.blueColor()
        self.favBtn.imageColorOn = UIColor.blueColor()
        self.favBtn.circleColor = UIColor.blueColor()
        self.favBtn.lineColor = UIColor.blueColor()
        self.favBtn.duration = 1.0
        self.layer.borderColor = UIColor.init(colorLiteralRed: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1).CGColor
        self.layer.borderWidth = 0.3
        
        productImage.translatesAutoresizingMaskIntoConstraints =  true
        productImage.frame = CGRectMake(13, 12, 87, 100)
        
        productName.translatesAutoresizingMaskIntoConstraints = true
        productName.frame = CGRectMake(4, 0, 200, 42)
        
        DiscountLbl.translatesAutoresizingMaskIntoConstraints = true
        DiscountLbl.frame = CGRectMake(8, 0, 52, 20)
        
        ratingLbl.translatesAutoresizingMaskIntoConstraints = true
        ratingLbl.frame = CGRectMake(91, 43, 171, 15)
        
        prodTableLabel.translatesAutoresizingMaskIntoConstraints = true
        prodTableLabel.frame = CGRectMake(0, screenHeight, screenWidth, 1)
    }
    
    
    
    func configureCellWithURLString(URLString: String, placeholderImage: UIImage) {
        let size = productImage.frame.size
        
        productImage.af_setImageWithURL(
            NSURL(string: URLString)!,
            placeholderImage: placeholderImage,
            filter:nil,
            imageTransition: .CrossDissolve(0.2)
        )
    }
    func configure(glacierScenic: GlacierScenic) {
        self.glacierScenic = glacierScenic
        reset()
        loadImage()
    }
    
    func reset() {
        productImage.image = nil
        request?.cancel()
        // captionLabel.hidden = true
    }
    
    @IBAction func favBtnClk(sender:AnyObject){
        self.delegates?.mycartDelegateFunction!(favBtn.tag,sender: favBtn,sku: skuNumber)
    }
    func loadImage() {
        if let image = PhotosDataManager.sharedManager.cachedImage(glacierScenic.photoURLString) {
            populateCell(image)
            return
        }
        downloadImage()
    }
    
    func downloadImage() {
        // loadingIndicator.startAnimating()
        let urlString = glacierScenic.photoURLString
        request = PhotosDataManager.sharedManager.getNetworkImage(urlString) { image in
            self.populateCell(image)
        }
    }
    func populateCell(image: UIImage)
    {
        //loadingIndicator.stopAnimating()
        productImage.image = image
        //        captionLabel.text = glacierScenic.name
        //        captionLabel.hidden = false
    }
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(ratingView: FloatRatingView, isUpdating rating:Float) {
        //        self.liveLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
    
    func floatRatingView(ratingView: FloatRatingView, didUpdate rating: Float) {
        //        self.updatedLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

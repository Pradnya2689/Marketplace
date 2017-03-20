 //
//  ViewController.swift
//  scrolltableView
//
//  Created by inpanr07 on 15/07/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import QuartzCore
import Alamofire
import ObjectMapper
import AlamofireImage
import CoreData
import Crashlytics

class ViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate ,UIAlertViewDelegate,UITextFieldDelegate,webServiceDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIGestureRecognizerDelegate{
    
    @IBOutlet weak var ratingScroll: UIScrollView!
    var sectionheader : NSMutableArray = NSMutableArray()
    var  rowsectionname : NSMutableArray = NSMutableArray()
    
    var newDict3 :NSMutableDictionary = NSMutableDictionary ()
    
    @IBOutlet weak var newProductImageView: UIImageView!
    var  imagelinkArr : NSMutableArray = NSMutableArray()
    var  imageArr : NSMutableArray = NSMutableArray()
    var  sheader  = [String]()
    var  rowsinheader  = [[String]]()
    
    var imageurl : NSString!
    var image : UIImage!
    
    var skuNumber : String! = ""
    var ratingfloat : Float!
    
    var nprice : String! = ""
    var gprice : String! = ""
    
     var sno = ""
    
    var similProdImgArr: NSMutableArray = NSMutableArray()
    var similarProdNameArr: NSMutableArray = NSMutableArray()
    var similarProdPriceArr: NSMutableArray = NSMutableArray()
    var similarProdArray:NSMutableArray = NSMutableArray()
    var viewHasMovedUp : Bool = true

    
    @IBOutlet var productName: UILabel!
    @IBOutlet var pricelabel: UILabel!
    
    @IBOutlet var pincodestatuslbl: UILabel!
    @IBOutlet var descView: UITextView!
  //  @IBOutlet var carousel: iCarousel!
    @IBOutlet var addcartbuynwView: UIView!
    
    @IBOutlet var qtyPickerView: UIPickerView!
    @IBOutlet var PincodechkV1: UIView!
    @IBOutlet var QtyChkV2: UIView!
    @IBOutlet var pincode: UITextField!
    @IBOutlet var checkBtn: UIButton!
    @IBOutlet var QtyBtn: UIButton!
    @IBOutlet weak var ScrollView1: UIScrollView!
    @IBOutlet weak var tbl1: UITableView!
    @IBOutlet weak private var containerViewHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak private var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var prodCollectionView: UICollectionView!
    @IBOutlet var sellernamelbl: UILabel!
    @IBOutlet var totalReviewCntLbl:UILabel!
    @IBOutlet var userratingview: FloatRatingView!
    @IBOutlet var sellersBtn: UIButton!
    @IBOutlet var addToCartBtn: UIButton!
    @IBOutlet weak var favBtn: DOFavoriteButton!
    @IBOutlet weak var innerVc:UIView!
    var placedPrice: NSString!=""
    var productId:NSString!=""
    var vendorPartNumber:String!=""
    var extendedPrice:NSString!=""
    var vendorCode:NSString!=""
    var imageURLMedium:NSString!=""
    var sellerNumber:NSString!=""
    var limitedStock:Int!=0
    var maximumQuantity:Int!=0
    var availabilty:Int!=0
    var netPrc:String!=""
    var priceforcart:String!=""
    var sellerName:String!=""
    var skuno:String!=""
    var productDict:NSMutableDictionary!=NSMutableDictionary()
    var pickerDataSource = ["1", "2", "3", "4"];
    
    var prodStr:String!=""
    
    @IBOutlet var fivestarRatingLbl: UILabel!
    @IBOutlet var fourstarratingLbl: UILabel!
    @IBOutlet var threestarratingLbl: UILabel!
    @IBOutlet var twostarratingLbl: UILabel!
    @IBOutlet var onestarratingLbl: UILabel!
    @IBOutlet var NoReviewsLbl: UILabel!
    @IBOutlet var sellerarrowImg:UIImageView!
    @IBOutlet weak var rateSubmitBtn: UIButton!
   // var viewHasMovedUp : Bool
    
    let imageDownloader = ImageDownloader(
        configuration: ImageDownloader.defaultURLSessionConfiguration(),
        downloadPrioritization: .FIFO,
        maximumActiveDownloads: 4,
        imageCache: AutoPurgingImageCache()
    )
    
    
    
    private var tableRows : [String] = []
    var itemcarousel: [Int] = []
    var imageArr1: [UIImage] = []
    var dict : NSMutableDictionary!
    var isClick:String!=""
     @IBOutlet var bannerView:UIView!
    
    private var pageViewController: UIPageViewController?
    var contentImages : NSArray!
    var pageController:UIPageViewController!
     let boundss = UIScreen.mainScreen().bounds
    
    @IBOutlet var reviewRatingView:UIView!
    @IBOutlet var giveRatingView:FloatRatingView!
    @IBOutlet var totalReviewLable:UILabel!
    @IBOutlet var star5Slider:UIProgressView!
    @IBOutlet var star4Slider:UIProgressView!
    @IBOutlet var star3Slider:UIProgressView!
    @IBOutlet var star2Slider:UIProgressView!
    @IBOutlet var star1Slider:UIProgressView!
    @IBOutlet var review1Title:UILabel!
    @IBOutlet var review1DateLbl:UILabel!
    @IBOutlet var review1stars:FloatRatingView!
    @IBOutlet var review1Commnt:UILabel!
    @IBOutlet var review2Title:UILabel!
    @IBOutlet var review2DateLbl:UILabel!
    @IBOutlet var review2stars:FloatRatingView!
    @IBOutlet var review2Commnt:UILabel!
    
    @IBOutlet var reviewView:UIView!
    @IBOutlet var review1view:UIView!
    @IBOutlet var review2View:UIView!
    @IBOutlet var tableheader:UIView!
    @IBOutlet var allReviewBtn:UIButton!
    var totalReviewCnt:Int!=0
    
    var ratingReviewArray:NSMutableArray!=NSMutableArray()
    @IBOutlet var innerView:UIView!
    @IBOutlet var givRatingView:FloatRatingView!
    @IBOutlet var titileLbl:UITextField!
    @IBOutlet var decrLbl:UITextField!
    @IBOutlet var errorLbl:UILabel!
    @IBOutlet var addRatingView:UIView!
    @IBOutlet var ratingImg:UIImageView!
    @IBOutlet var discountLbl:UILabel!
    @IBOutlet var outOfstockLable:UILabel!
    
    @IBOutlet var buybtn:UIButton!
    @IBOutlet var addCrtBtn:UIButton!
    
    @IBOutlet weak var notificationBtn: UIButton!
    
    @IBOutlet var buyNowView:UIView!
    @IBOutlet var notifyBtn:UIButton!
    @IBOutlet var noInternetVC:UIView!
    @IBOutlet var wifiImg:UIImageView!
    @IBOutlet var noconnetinlbl:UILabel!
    @IBOutlet var retryBtn:UIButton!
    var scrHeight: CGSize!
    @IBOutlet var ratingInnerVC:UIView!
    @IBOutlet var productAttributVc:UIView!
    @IBOutlet var prodAttr1Lbl:UILabel!
    @IBOutlet var prodAttr2Lbl:UILabel!
    @IBOutlet var prodAttr3Lbl:UILabel!
    @IBOutlet var prodAttr4Lbl:UILabel!
    @IBOutlet var prodAttr5Lbl:UILabel!
    var attributeDetailsArray:NSMutableArray=NSMutableArray()
    let dataLayer: TAGDataLayer = TAGManager.instance().dataLayer
    var prodDescr:NSMutableAttributedString!
    @IBOutlet var fulfilledLbl:UILabel!
    @IBOutlet var fulfilledImg:UIImageView!
    @IBOutlet var moreInfoBtn:UIButton!
    @IBOutlet var prodDetLbl:UILabel!
    @IBOutlet var mainVc:UIView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        for i in 0...5
        {
            itemcarousel.append(i)
        }
    }
    
    @IBOutlet var similarProdView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // JHProgressHUD.sharedHUD.showInView(self.view)
         NoReviewsLbl.hidden = true
        similProdImgArr = ["https://inquirecontent1.ingrammicro.com/images/95/1020936574.jpg","https://inquirecontent1.ingrammicro.com/images/95/1020936573.jpg","http://172.29.180.154/pidmdev/images/95/9_1013352_Front.jpg","https://inquirecontent1.ingrammicro.com/images/95/1020936093.jpg","https://inquirecontent1.ingrammicro.com/images/95/1020936074.jpg"]
        similarProdNameArr = ["SMART-UPS VT SUBFEED DISTRIBUTION 400/230V (12) C19 16A & (1) 50A 3P HW OUTPUT","SMART-UPS VT SUBFEED DISTRIBUTION 400/230V (12) C19 16A & (1) 40A 3P HW OUTPUT","RACK PDU BASIC ZERO U10A 230V 15 C13","RACK PDU BASIC 1U 16A 208/230V (12)C13 HORIZONTAL MOUNT","RACK PDU 2G, SWITCHED, ZEROU, 16A, 230V, (21) C13 & (3) C19, IEC309 CORD"]
        similarProdPriceArr = ["2028.61","2028.61","238.47","194.74","1044.67"]
        addcartbuynwView.layer.shadowColor = UIColor.blackColor().CGColor
        addcartbuynwView.layer.shadowOpacity = 0.4
        addcartbuynwView.layer.shadowOffset = CGSizeZero
        buyNowView.layer.shadowColor = UIColor.blackColor().CGColor
        buyNowView.layer.shadowOpacity = 0.8
        buyNowView.layer.shadowOffset = CGSizeMake(2.0, 0.0)
        notificationBtn.layer.shadowColor = UIColor.blackColor().CGColor
        notificationBtn.layer.shadowOpacity = 0.8
        notificationBtn.layer.shadowOffset = CGSizeMake(2.0, 0.0)
        attributeDetailsArray = NSMutableArray()
        let backButton : UIBarButtonItem = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.Plain, target: self, action: "")
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        self.PincodechkV1.hidden = true
        self.QtyChkV2.hidden = true
        self.addcartbuynwView.hidden = true
       // self.tbl1.hidden = true
        self.notificationBtn.hidden = true
  
        
       // self.userratingview.rating = ratingfloat
        let image2 = UIImage(named: "kart")!
        self.addToCartBtn.setImage(image2, forState: UIControlState.Normal)
        
        
        self.sellersBtn.titleEdgeInsets = UIEdgeInsetsMake(-3, 0, 0, 0);
        //         self.sellersBtn.tintColor = UIColor (red: 31/255.0, green: 75/255.0, blue: 164/255.0, alpha: 1.0)
        
        self.addToCartBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        self.addToCartBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.addToCartBtn.tintColor = UIColor (red: 31/255.0, green: 75/255.0, blue: 164/255.0, alpha: 1.0)

        self.pincode.delegate = self
        
        self.pincode.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        
        
        self.pincode.useUnderline()
        
        self.checkBtn.layer.borderWidth = 0.8
        self.checkBtn.layer.borderColor = UIColor (red: 31/255.0, green: 75/255.0, blue: 164/255.0, alpha: 1.0).CGColor
        
        self.QtyBtn.layer.borderWidth = 0.8
       
        self.QtyBtn.layer.borderColor = UIColor (red: 31/255.0, green: 75/255.0, blue: 164/255.0, alpha: 1.0).CGColor
    
        QtyBtn.titleLabel?.textAlignment = NSTextAlignment.Center
        
        self.PincodechkV1.layer.borderWidth = 0.4
        self.PincodechkV1.layer.borderColor = UIColor (red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0).CGColor
        
        self.notifyBtn.layer.borderWidth = 0.8
        self.notifyBtn.layer.borderColor = UIColor (red: 31/255.0, green: 75/255.0, blue: 164/255.0, alpha: 1.0).CGColor
        
        self.QtyChkV2.layer.borderWidth = 0.4
        self.QtyChkV2.layer.borderColor = UIColor (red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0).CGColor
        
        
        self.favBtn.imageColorOff = UIColor.blueColor()
        self.favBtn.imageColorOn = UIColor.blueColor()
        self.favBtn.circleColor = UIColor.blueColor()
        self.favBtn.lineColor = UIColor.blueColor()
        self.favBtn.duration = 1.0
        
        if wishLstGlobalArray.containsObject(self.skuNumber){
            self.favBtn.selected = true
        }else{
            self.favBtn.selected = false
        }

        
       let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
        self.noInternetVC.removeFromSuperview()
        let headers = [
            "Authorization": authorizationWithoutLogin,
            "Accept": "application/json"
        ]
   
            var escapedAddress = self.skuNumber.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
             let url12 = "\(baseUrl)product?id=\(escapedAddress!)&offers=X"
     
            print(url12)
     
        Alamofire.request(.GET, url12, headers: headers)
            
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)
                var strData = NSString(data: response.data!, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)")// server data
                print(response.result)   // result of response serialization
                if(response.result.isSuccess){
                if let JSON : NSArray = response.result.value as! NSArray {
                    var  sellerArr : NSMutableArray! = NSMutableArray()
                    for (index, seller) in JSON.enumerate() {
                        let prodDet:NSMutableDictionary!=NSMutableDictionary()
                        
                        if let sellerName : String = seller["sellerName"] as? String where index > 0
                        {
                            sellerArr.addObject(sellerName)
                            
                        }
                        
                    }
                    if(sellerArr.count > 1){
                        self.sellersBtn.hidden = false
                        self.sellerarrowImg.hidden = false
                    self.sellersBtn.setTitle("\(sellerArr.count-1) other sellers", forState: UIControlState.Normal)
                    }else if(sellerArr.count == 1){
                        self.sellersBtn.hidden = true
                        self.sellerarrowImg.hidden = true
//                        self.sellersBtn.hidden = false
//                        self.sellersBtn.setTitle("\(sellerArr.count-1) other seller", forState: UIControlState.Normal)
                    }else{
                        self.sellersBtn.hidden = true
                        self.sellerarrowImg.hidden = true
                    }
                    
                }
                }
        }
        print(self.skuNumber)
            var shwdsc:Bool!
            var showBool : Bool!
            var escapedAddress1 = self.skuNumber.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        var url : NSURL!
        url = NSURL(string:"\(baseUrl)product?id=\(escapedAddress1!)")
        print(url)
        Alamofire.request(.GET, url!, headers: headers)
            .validate(contentType: ["application/json"])
            
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)
                var strData = NSString(data: response.data!, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)")// server data
                print(response.result)
                
                if(response.result.isSuccess){
                    let defaults = NSUserDefaults.standardUserDefaults()
                    
                    if let userId = defaults.objectForKey("userId") as? Int{
                        self.favBtn.hidden = false
                    }else{
                        self.favBtn.hidden = true
                    }
                    
                    if let JSON : NSArray = response.result.value as? NSArray {
                        print(JSON.count)
                        
                        self.prodStr = ""
                        if(JSON.count > 1){
                            if let indexobj = JSON.objectAtIndex(1) as AnyObject?
                            {
                                
                            }
                            else
                            {
                                self.PincodechkV1.hidden = true
                                self.QtyChkV2.hidden = true
                                self.addcartbuynwView.hidden = true
                                
                                
                            }
                        }
                        for (index, forecast) in JSON.enumerate()
                        {
                            // self.favBtn.hidden = false
                            print("testing123\(forecast["skuNumber"] as? String)")
                            if let offers : Int = forecast["offers"] as? Int where index == 1
                            {
                                if(offers > 1){
                                self.sellersBtn.setTitle("\(offers) other sellers", forState: UIControlState.Normal)
                                }else{
                                    self.sellersBtn.setTitle("\(offers) other seller", forState: UIControlState.Normal)
                                }
                            }
                          if let productHeader = forecast["attributeDetails"] as? NSArray where index == 0
                            {
                                if(productHeader.count > 0)
                                {
                                    //self.attributeDetailsArray = productHeader as! NSMutableArray
                                   self.attributeDetailsArray = NSMutableArray(array: productHeader)
                                }
                                
                                
                            }
                            self.fulfilledImg.hidden = false
                            self.fulfilledLbl.hidden = false
                            self.moreInfoBtn.hidden = false
                            if(self.attributeDetailsArray.count > 0){
                        
                                self.productAttributVc.hidden = false
                                self.productAttributVc.translatesAutoresizingMaskIntoConstraints = true
                                self.productAttributVc.frame = CGRectMake(0, 290, screenWidth, 168)
                                self.moreInfoBtn.translatesAutoresizingMaskIntoConstraints = true
                                self.moreInfoBtn.frame = CGRectMake(4, 458, 109, 27)
                                
//                                for (index,self.attributeDetailsArray) in EnumerateSequence
//                                {
//                                   
//                                    let attredit = attr as! NSMutableDictionary
//                                   
//                                    self.prodAttr1Lbl.text = "• \(attredit["name"] as! String): \(attredit["value"] as! String)"
//                                
//                                }
                          for i in 0..<self.attributeDetailsArray.count
                            {
                                if (i == 0) {
                                    if let attr = self.attributeDetailsArray[0] as? NSDictionary{
                                        self.prodAttr1Lbl.text = "• \(attr["name"] as! String): \(attr["value"] as! String)"
                                    }
                                }
                                    else if(i == 1)
                                    {
                                        if let attr = self.attributeDetailsArray[1] as? NSDictionary{
                                            self.prodAttr2Lbl.text = "• \(attr["name"] as! String): \(attr["value"] as! String)"
                                        }
                                    }
                                    else if (i == 2)
                                    {
                                        if let attr = self.attributeDetailsArray[2] as? NSDictionary{
                                            self.prodAttr3Lbl.text = "• \(attr["name"] as! String): \(attr["value"] as! String)"
                                        }
                                    }
                                    else if (i == 3)
                                    {
                                        if let attr = self.attributeDetailsArray[3] as? NSDictionary{
                                            self.prodAttr4Lbl.text = "• \(attr["name"] as! String): \(attr["value"] as! String)"
                                        }
                                    }
                                    else if (i == 4)
                                    {
                                        if let attr = self.attributeDetailsArray[4] as? NSDictionary{
                                            self.prodAttr5Lbl.text = "• \(attr["name"] as! String): \(attr["value"] as! String)"
                                        }
                                    }
                                
                                }
                                
                                
                             //   }
                          /*    if let attr = self.attributeDetailsArray[0] as? NSDictionary{
                                    self.prodAttr1Lbl.text = "• \(attr["name"] as! String): \(attr["value"] as! String)"
                                }
                                
                                if let attr = self.attributeDetailsArray[1] as? NSDictionary{
                                    self.prodAttr2Lbl.text = "• \(attr["name"] as! String): \(attr["value"] as! String)"
                                }
                                
                                if let attr = self.attributeDetailsArray[2] as? NSDictionary{
                                    self.prodAttr3Lbl.text = "• \(attr["name"] as! String): \(attr["value"] as! String)"
                                }
                                
                                if let attr = self.attributeDetailsArray[3] as? NSDictionary{
                                    self.prodAttr4Lbl.text = "• \(attr["name"] as! String): \(attr["value"] as! String)"
                                }
                        
                                if let attr = self.attributeDetailsArray[4] as? NSDictionary{
                                    self.prodAttr5Lbl.text = "• \(attr["name"] as! String): \(attr["value"] as! String)"
                                }*/
                            }else{
                                self.productAttributVc.translatesAutoresizingMaskIntoConstraints = true
                                self.productAttributVc.frame = CGRectMake(0, 290, screenWidth, 0)
                                self.moreInfoBtn.translatesAutoresizingMaskIntoConstraints = true
                                self.moreInfoBtn.frame = CGRectMake(4, 290, 109, 27)
                            }
                            
                            if let productHeader : String = forecast["description"] as? String where index == 0
                            {
                                self.productName.text = productHeader
                                
                            }
                            if let productHeader : String = forecast["sellerNumber"] as? String where index == 1
                            {
                                self.sellerNumber = productHeader
                                
                            }
                            if let productHeader : String = forecast["productId"] as? String where index == 0
                            {
                                self.productId = productHeader
                                
                            }
                            if let productHeader : Int = forecast["avaliableQuantity"] as? Int where index == 1
                            {
                                self.limitedStock = productHeader
                                if(self.limitedStock == 0){
                                    self.QtyBtn.hidden = true
                                    self.outOfstockLable.hidden = false
                                    self.notificationBtn.hidden = false
                                    self.addCrtBtn.hidden = true
                                    self.buybtn.hidden = true
                                    self.buyNowView.hidden = true
                                    self.addcartbuynwView.hidden = true
                                }else{
                                    
                                    self.notificationBtn.hidden = true
                                    self.QtyBtn.hidden = true           // false
                                    self.outOfstockLable.hidden = true
                                    self.addCrtBtn.hidden = false
                                    self.buybtn.hidden = false
                                    self.buyNowView.hidden = false
                                    self.addcartbuynwView.hidden = false
                                }
                                
                            }
                            if let productHeader : Int = forecast["avaliableQuantity"] as? Int where index == 1
                            {
                                self.availabilty = productHeader
                                
                            }
                            
                            if let productHeader1 : String = forecast["skuNumber"] as? String where index == 1
                            {
                                self.skuno = productHeader1
                               // self.similarProd()
                                
                            }
                            if let productHeader : Int = forecast["maxQuantity"] as? Int where index == 0
                            {
                                self.maximumQuantity = productHeader
                                
                            }
                            if let productHeader : String = forecast["vendorCode"] as? String where index == 0
                            {
                                self.vendorCode = productHeader
                                
                            }
                            if let productHeader : String = forecast["imageURLHigh"] as? String where index == 0
                            {
                                let imageurl : AnyObject  = forecast["imageURLHigh"] as! NSString
                                self.imageurl = imageurl as! NSString
                                
                            }
                            if let productHeader : String = forecast["mpn"] as? String where index == 1
                            {
                                self.vendorPartNumber = productHeader
                                let wsm : WebServiceClass = WebServiceClass.sharedInstance
                                wsm.delegates=self
                                wsm.getOthersreviewDetails(self.vendorPartNumber as String, PageIndex: "0", onSearchPage: false, onProductPage: true, onReviewPage: false, onAdminPage: false)
                                
                            }
                            
                            if let sellerName : String = forecast["sellerName"] as? String where index == 1
                            {
                                //self.sellernamelbl.text = UIEdgeInsetsMake(10, 0, 10, 0);
                                self.sellernamelbl.text = "By \(sellerName)"
                                self.sellerName = sellerName
                            }
                             if let pricetag : String = forecast["netPrice"] as? String where index == 1 {
                              // self.nprice  = pricetag
                                self.netPrc = pricetag
                             }
                             else
                             {
                                self.netPrc = "Price Not Available"
                            }
                            //rishikesh
                            if let netpricetag : String = forecast["netPriceDisplayString"] as? String where index == 1 {
                                // self.nprice  = pricetag
                                self.priceforcart = netpricetag
                            }
                            else
                            {
                                self.priceforcart = "Price Not Available"
                            }
                            
                             shwdsc = forecast["showPerc"] as! Bool
                            if(shwdsc == true){
                                self.discountLbl.hidden = false
                                self.discountLbl.text = String(format:"%@ Off  ",forecast["percentage"] as! String)
                                
                                let grossPrice1  =  "₹ \(forecast["grossPriceDisplayString"] as! String)"
                                let netPrice2  =  "₹ \(forecast["netPriceDisplayString"] as! String)"
                                self.nprice = netPrice2
                                self.gprice = grossPrice1
                                let labelstring : NSString = "\(netPrice2)  \(grossPrice1)"
                                
                                let string_to_color = "\(netPrice2)"
                                let string2 = "\(grossPrice1)"
                                
                                let range = (labelstring as NSString).rangeOfString(string_to_color)
                                let range2 = (labelstring as NSString).rangeOfString(string2)
                                
                                
                                
                                let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
                                
                                attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Bold", size: 14)!], range: range)
                                attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Bold", size: 11)!], range: range2)
                                attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
                                attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
                                
                                self.pricelabel.attributedText = attributedText
                            }else{
                                self.discountLbl.hidden = true
                                // cell.DescriptionLbl.text = String(format:"%@Off  ",prod.percentage!)
                                
                                if let netPrice2  =  forecast["netPriceDisplayString"] as? String where index == 1{
                                    
                                    if (netPrice2 == "Price Not Available")
                                    {
                                    self.pricelabel.text = "\(forecast["netPriceDisplayString"] as! String)"
                                    }
                                    else
                                    {
                                     self.pricelabel.text = "₹ \(forecast["netPriceDisplayString"] as! String)"
                                    }
                                }else{
                                    self.pricelabel.text = "Price Not Available"
                                }
                                self.nprice = self.pricelabel.text
                                self.gprice = ""
                              
                            }
                            
                           showBool = forecast["isNewProd"] as! Bool
                            if(showBool!){
                                print("true")
                                self.newProductImageView.hidden = false
                            }else{
                                print("false")
                                self.newProductImageView.hidden = true
                            }
                            
                            
          
                            // nsmutablearray to nsarray changed 
                            if let imagelist  = forecast["imageGalleryURLHigh"] as? NSArray
                            {
                                for imagelink in imagelist
                                {
                                    self.imagelinkArr.addObject(imagelink)
                                }
                                print(self.imagelinkArr)
                                if(self.imagelinkArr.count > 0){
                                    self.bannerView.hidden = false
                                    self.contentImages = NSArray.init(array: self.imagelinkArr)
                                    self.pageController = UIPageViewController()
                                    self.createPageViewController()
                                    self.setupPageControl()
                                }else{
                                    self.bannerView.hidden = true
                                }
                                
                                
                                
                            }
                            else
                            {
                                if(self.imagelinkArr.count == 0){
                                    self.bannerView.hidden = true
                                }else{
                                    self.bannerView.hidden = false
                                }
                            }
                              if let teststring  = forecast["groupedSpecification"] as? NSMutableDictionary
                            {
                            
                                
                                self.imageURLMedium =  forecast["imageURLMedium"] as! NSString
                                let productName : AnyObject  = forecast["description"] as! NSString
                                self.productName.text = "\(productName)"
                                 print("\(self.imageurl)")
                                var newDict1 : NSMutableArray = NSMutableArray()
                                for g1 in teststring
                                {
                                  
                                    //newDict1  = g1.value as! NSMutableArray
                                  newDict1  =  NSMutableArray(array: g1.value as! [AnyObject])
                                    print(g1.key)
                                    print(g1.value)
                                    self.sectionheader.addObject(g1.key)
                                    var newDict2 : NSMutableArray = NSMutableArray()
                                    
                                    
                                    for v1 in newDict1
                                    {
                                        newDict2 .addObject(v1)
                                        
                                        print(v1["specificationType"]!)
                                        print(v1["specificationTypeDetails"]!)
                                        
                                    }
                                    
                                    self.newDict3["\(g1.key)"] = newDict2
                                }
                                
                                for g2 in self.newDict3
                                {
                                    let  valueobject  = g2.value as! NSMutableArray
                                    print(g2.key)
                                   
                                    var  values  = [String]()
                                    for g3 in valueobject
                                    {
                                        let a = g3.valueForKey("specificationType")!
                                        print(a)
                                        let b = g3.valueForKey("specificationTypeDetails")!
                                        
                                        let first = (a as! String) + ":" + (b as! String)
                                        let second = "\(a), \(b)"
                                        
                                        if (a as! String == "Marketing Text")
                                        {
                                            //var text: NSString = "Description\n\n\(b)"
                                             var text: NSString = "\n\(b)"
                                            var string_to_color = "Description"
                                            var string2 = "\(b)"
                                            
                                            var range = (text as NSString).rangeOfString(string_to_color)
                                            var range2 = (text as NSString).rangeOfString(string2)
                                            var attributedText: NSMutableAttributedString = NSMutableAttributedString(string: text as String)
                                            attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0) , range: range)
                                            attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 16)!], range: range)
                                            attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 16)!], range: range2)

                                            self.prodDescr = attributedText
                                        }
                                        else
                                        {
                                            values.append(first)
                                        }
                                    }
                                    //                                print(values)
                                    self.rowsinheader.append(values)
                                    //                                print(self.rowsinheader)
                                    self.rowsectionname.addObject(valueobject)
                                    
                                }
                                
                                let sectionheaderarr = [self.sectionheader]
                                
                                
                                if let myStringArray = self.sectionheader.objectEnumerator().allObjects as? [String] {
                                    // print(myStringArray)
                                    
                                    self.sheader = myStringArray
                                    //  print(self.sheader)
                                }
//
                            }
                            
                            if let similarproduct : NSArray = forecast["similarProductsSkuList"] as? NSArray where index == 0
                            {
                               
                                for prdt in similarproduct
                                {
                                    self.sno += "\(prdt);"
                                   
                                }
                                self.similarproductitem()
                                
                                
                                  // print(c)
                            }
                            else{
                                self.similarProdView.hidden = false
                                self.similarProdView.translatesAutoresizingMaskIntoConstraints = true
                                self.similarProdView.frame = CGRectMake(0, 0, screenWidth, 0)
                                self.ratingInnerVC.translatesAutoresizingMaskIntoConstraints = true
                                self.ratingInnerVC.frame = CGRectMake(0, 0, screenWidth, 162)

                                if(self.attributeDetailsArray.count > 0){
                                    self.similarProdView.hidden = false
//                                    self.mainVc.translatesAutoresizingMaskIntoConstraints = true
//                                    self.mainVc.frame = CGRectMake(0, 0, screenWidth, 657)
                                    self.ScrollView1.contentSize = CGSizeMake(screenWidth, 657)
                                    self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
                                    self.reviewRatingView.frame=CGRectMake(0, 487, self.boundss.width, 170)
                                }else{
                                    self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
                                    self.reviewRatingView.frame=CGRectMake(0, 317, self.boundss.width, 170)
                                    self.similarProdView.hidden = false
//                                    self.mainVc.translatesAutoresizingMaskIntoConstraints = true
//                                    self.mainVc.frame = CGRectMake(0, 0, screenWidth, 657)
                                    self.ScrollView1.contentSize = CGSizeMake(screenWidth, 657)
                                   
                                }
                                if(self.attributeDetailsArray.count > 0){
                                    self.similarProdView.hidden = false
                                    //            self.mainVc.translatesAutoresizingMaskIntoConstraints = true
                                    //            self.mainVc.frame = CGRectMake(0, 0, screenWidth, 915)
                                    
                                    self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
                                    self.reviewRatingView.frame=CGRectMake(0, 487, self.boundss.width, 428)
                                    self.allReviewBtn.addTarget(self, action:#selector(self.allReviewBtnClk), forControlEvents: .TouchUpInside)
                                    // allReviewBtnClk
//                                    self.similarProdView.translatesAutoresizingMaskIntoConstraints = true
//                                    self.similarProdView.frame=CGRectMake(0, 0, self.boundss.width, 300)
                                    self.ScrollView1.contentSize = CGSizeMake(screenWidth, 915)
                                }else{
                                    self.similarProdView.hidden = false
//                                    self.mainVc.translatesAutoresizingMaskIntoConstraints = true
//                                    self.mainVc.frame = CGRectMake(0, 0, screenWidth, 718)
                                    self.ScrollView1.contentSize = CGSizeMake(screenWidth, 718)
                                    //            self.mainVc.translatesAutoresizingMaskIntoConstraints = true
                                    //            self.mainVc.frame = CGRectMake(0, 0, screenWidth, 915)
                                    self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
                                    self.reviewRatingView.frame=CGRectMake(0, 317, self.boundss.width, 428)
                                    self.allReviewBtn.addTarget(self, action:#selector(self.allReviewBtnClk), forControlEvents: .TouchUpInside)
//                                    // allReviewBtnClk
//                                    self.similarProdView.translatesAutoresizingMaskIntoConstraints = true
//                                    self.similarProdView.frame=CGRectMake(0, 0, boundss.width, 300)
                                }
                                
                                self.view.setNeedsDisplay()
                                self.view.setNeedsLayout()
                                self.view.layoutIfNeeded()
                            }

                            
                            
                            
                        }
                        var bottomBorder = CALayer()
                       // bottomBorder.frame = CGRectMake(0.0,82, self.descView.frame.size.width, 1.0);
                        bottomBorder.backgroundColor = UIColor (red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0).CGColor
                        
                        // self.descView.layer.addSublayer(bottomBorder)
                        if(self.newDict3.count <= 0 ){
                            // self.descView.backgroundColor = UIColor.redColor()
                           // self.descView.translatesAutoresizingMaskIntoConstraints = true
                           // self.descView.frame = CGRectZero
                            self.innerVc.translatesAutoresizingMaskIntoConstraints = true
                            self.innerVc.frame = CGRectMake(0, 0, self.boundss.width, 371-83)
                        }else{
                            var isfound:Bool = false
                            for g2 in self.newDict3
                            {
                                let  valueobject  = g2.value as! NSMutableArray
                                print(g2.key)
                                if(g2.key as! String == "general Information"){
                                    print("9999999")
                                    isfound = true
                                                                  
                                }
                             
                                if(isfound == false){
                                   // self.descView.translatesAutoresizingMaskIntoConstraints = true
                                   // self.descView.frame = CGRectZero
                                    self.innerVc.translatesAutoresizingMaskIntoConstraints = true
                                    self.innerVc.frame = CGRectMake(0, 0, self.boundss.width+10, 371-82)
                                }
                            }
                        }
                        dispatch_async(dispatch_get_main_queue())
                        {
                            let appDelegate =
                                UIApplication.sharedApplication().delegate as! AppDelegate
                            
                            let managedContext = appDelegate.managedObjectContext
                            let searchpredicate = NSPredicate(format: "sku = %@", self.skuNumber)
                            let fetchRequest = NSFetchRequest(entityName: "RecentlyViewed")
                            fetchRequest.predicate = searchpredicate
                            do {
                                let results =
                                    try managedContext.executeFetchRequest(fetchRequest)
                                if let people : [NSManagedObject] = results as? [NSManagedObject]
                                {
                                    if (people .isEmpty)
                                    {
//                                        print(self.gprice)
//                                        print(self.nprice)
                                        //  print(self.imageurl)
                                        print(self.skuNumber)
                                        if self.gprice.characters.count != 0 {
                                            if self.imageurl != nil
                                            {
                                                print("productName \(self.productName.text!) sku\(self.skuNumber) netPrice \(self.nprice)  grossPrice \(self.gprice)  ")
                                                
//                                                self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: self.nprice, grossPrice: self.gprice, imageURLHigh: self.imageurl as String, showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                self.saveName(self.skuNumber)
                                             }
                                            else
                                            {
//                                                self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: self.nprice, grossPrice: self.gprice, imageURLHigh: "",showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                self.saveName(self.skuNumber)
                                            }
                                            
                                        }
                                        else
                                        {
                                
                                            if self.imageurl != nil
                                            {
                                                print("productName \(self.productName.text!), sku\(self.skuNumber) ,netPrice \(self.nprice),  grossPrice \(self.gprice)  ")
                                                if(self.nprice != nil){
//                                                    self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: self.nprice, grossPrice: "", imageURLHigh: self.imageurl as String,showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                    self.saveName(self.skuNumber)
                                                }else{
//                                                    self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: "", grossPrice: "", imageURLHigh: self.imageurl as String,showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                    self.saveName(self.skuNumber)
                                                }
                                                
                                            }
                                            else
                                            {
                                                if(self.nprice != nil){
//                                                    self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: self.nprice, grossPrice: "", imageURLHigh: "",showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                    self.saveName(self.skuNumber)
                                                }else{
//                                                    self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: "", grossPrice: "", imageURLHigh: "",showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                    self.saveName(self.skuNumber)
                                                }
                                            }
                                        }
                                    }
                                        
                                    else
                                    {
                                        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                                        let context:NSManagedObjectContext = appDel.managedObjectContext
                                        context.deleteObject(people.last!)
                                        
                                        do {
                                            try context.save()
                                            
                                          
                                            if self.gprice.characters.count != 0 {
                                                if self.imageurl != nil {
                                                    print("productName \(self.productName.text!) sku\(self.skuNumber) netPrice \(self.nprice)  grossPrice \(self.gprice)  ")
                                                    
//                                                    self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: self.nprice, grossPrice: self.gprice, imageURLHigh: self.imageurl as String,showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                    self.saveName(self.skuNumber)
                                                }else{
//                                                    self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: self.nprice, grossPrice: self.gprice, imageURLHigh: "",showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                    self.saveName(self.skuNumber)
                                                }
                                        
                                            }else{
                                                
                                                if self.imageurl != nil {
                                                    print("productName \(self.productName.text!) sku\(self.skuNumber) netPrice \(self.nprice)  grossPrice \(self.gprice)  ")
                                                    if(self.nprice != nil){
//                                                       self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: self.nprice, grossPrice: "", imageURLHigh: self.imageurl as String,showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                        self.saveName(self.skuNumber)
                                                    }else{
//                                                          self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: "", grossPrice: "", imageURLHigh: self.imageurl as String,showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                        self.saveName(self.skuNumber)
                                                    }
                                                    
                                                }else{
                                                    if(self.nprice != nil){
//                                                        self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: self.nprice, grossPrice: "", imageURLHigh: "",showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                        self.saveName(self.skuNumber)
                                                    }else{
//                                                        self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: "", grossPrice: "", imageURLHigh: "",showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                        self.saveName(self.skuNumber)
                                                    }
                                                }
                                            }
                                            let appDelegate =
                                                UIApplication.sharedApplication().delegate as! AppDelegate
                                            
                                            let managedContext = appDelegate.managedObjectContext
                                            
                                            //2
                                            let fetchRequest = NSFetchRequest(entityName: "RecentlyViewed")
                                            
                                            3
                                            do {
                                                let results =
                                                    try managedContext.executeFetchRequest(fetchRequest)
                                                if let people : [NSManagedObject] = results as? [NSManagedObject]
                                                {
                                                    for searchstring in people
                                                    {
//                                                        print(searchstring.valueForKey("desc"))
                                                        print(searchstring.valueForKey("sku"))
//                                                        print(searchstring.valueForKey("netPrice"))
//                                                        print(searchstring.valueForKey("grossPrice"))
//                                                        print(searchstring.valueForKey("imageURLHigh"))
//                                                        
//                                                        let str  = searchstring.valueForKey("desc") as! String
                                                        
                                                        // data1.append(str)
                                                        
                                                        //data1.append(s)
                                                    }
                                                    
                                                }
                                                
                                            } catch let error as NSError {
                                                print("Could not fetch \(error), \(error.userInfo)")
                                            }
                                            
                                            
                                        }
                                        catch _
                                        {
                                        }
                                        
                                        
                                    }
                                    
                                    
                                }
                                
                            } catch let error as NSError {
                                print("Could not fetch \(error), \(error.userInfo)")
                            }
                            
                            self.PincodechkV1.hidden = false
                            self.QtyChkV2.hidden = false
                            // self.addcartbuynwView.hidden = false
                          //  self.tbl1.hidden = false
                            //  self.descView.hidden = false
                            // self.descView.translatesAutoresizingMaskIntoConstraints = true
                            // self.descView.frame = CGRectMake(0, 285, self.boundss.size.width+10, 83)
                           /// self.tbl1.reloadData()
                         
                            LoadingOverlay.shared.hideOverlayView()
                            
                            
                            
                        }
                        
                        
                    }
                }
                
                if(response.result.isFailure){
                    LoadingOverlay.shared.hideOverlayView()
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = ""
                    alertView.message = ConstantsFile.requestFail_msg
                    alertView.delegate = nil
                    alertView.addButtonWithTitle("OK")
                    
                    alertView.show()
                }
                
                
                
                self.dataLayer.push(["event": "openScreen", "screenName": "ProdDetailiOS"])
        }
    }
    else{
            self.noInternetVC.translatesAutoresizingMaskIntoConstraints = true
            self.noInternetVC.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
            self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
            self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
            self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
            self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
            self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
            self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)
            self.view.addSubview(self.noInternetVC)
    }
        //self.navigationController?.navigationBar.hidden = true
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        tap.delegate = self
        ratingImg.addGestureRecognizer(tap)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:"onContentSizeChange:",
                                                         name: UIContentSizeCategoryDidChangeNotification,
                                                         object: nil)
        
    
        let keyboardDoneButtonView = UIToolbar.init()
        keyboardDoneButtonView.sizeToFit()
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done,
                                              target: self,
                                              action: #selector(doneClicked))
        let doneButton1 = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace,
                                               target: nil,
                                               action: nil)
        doneButton1.width = screenWidth-80
        
        keyboardDoneButtonView.items = [doneButton1,doneButton]
        pincode.inputAccessoryView = keyboardDoneButtonView
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageClick))
        gesture.delegate = self
        self.bannerView.addGestureRecognizer(gesture)
        

        productAttributVc.hidden = true
        
        innerView.translatesAutoresizingMaskIntoConstraints = true
        innerView.frame = CGRectMake((screenWidth-280)/2, (screenHeight-280)/2, 280, 280)

        
    }
    

    @IBAction func moreDetailsClk(){
        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("specifitn") as! ProductSpecificationViewController
        secondViewController.rowsinheader = rowsinheader
        secondViewController.sheader = sheader
        secondViewController.imgStr = self.imageurl as! String
        secondViewController.descProd = self.prodDescr
        secondViewController.prodTitleStr = self.productName.text
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
      
    }
    
    func registerKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unregisterKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo!
        let keyboardSize = userInfo.objectForKey(UIKeyboardFrameBeginUserInfoKey)!.CGRectValue.size
        if(screenHeight == 320){
        let contentInsets = UIEdgeInsetsMake(0, 0, 350, 0)
            self.ratingScroll.contentInset = contentInsets
            self.ratingScroll.scrollIndicatorInsets = contentInsets
        }else if(screenHeight == 568){
        let contentInsets = UIEdgeInsetsMake(0, 0, 240, 0)
            self.ratingScroll.contentInset = contentInsets
            self.ratingScroll.scrollIndicatorInsets = contentInsets
        }else{
            let contentInsets = UIEdgeInsetsMake(0, 0, 200, 0)
            self.ratingScroll.contentInset = contentInsets
            self.ratingScroll.scrollIndicatorInsets = contentInsets
        }
       
        
        var viewRect = view.frame
        viewRect.size.height -= keyboardSize.height
        
    }
    
    
    func keyboardWillHide(notification: NSNotification) {
        if(screenHeight == 320){
         let contentInsets = UIEdgeInsetsMake(0, 0, 200, 0)
        }else if(screenHeight == 568){
         let contentInsets = UIEdgeInsetsMake(0, 0, -200, 0)
        }else{
            let contentInsets = UIEdgeInsetsMake(0, 0, -200, 0) 
        }
        self.ratingScroll.contentInset = UIEdgeInsetsZero
        self.ratingScroll.scrollIndicatorInsets = UIEdgeInsetsZero
    }

    
func doneClicked(sender: AnyObject) {
    self.view.endEditing(true)
   
   //  ScrollView1.contentSize = scrHeight
}
    func similarproductitem()
    {
    let headers = [
        "Authorization":authorizationWithoutLogin,
        "Accept": "application/json"
    ]
        print(self.sno)
    let url = NSURL(string:"\(baseUrl)product?txtSearch=\(self.sno)")
    
        
        if let url = NSURL(string:"\(baseUrl)product?txtSearch=\(self.sno)")
        {
   // print(url!.absoluteString, terminator: "")
    
    
    Alamofire.request(.GET, url,headers: headers).validate(contentType: ["application/json"])
    
    .responseJSON { response in
    //.responseObject { (response: Response<ProductDetails, NSError>) in      //responseJSON { response in
    print(response.request)  // original URL request
    print(response.response) // URL response
    print(response.data)     // server data
    print(response.result)
    if let JSON = response.result.value {
    print(JSON)
        //self.similarProdArray = JSON as! NSMutableArray
      self.similarProdArray =   NSMutableArray(array: JSON as! [AnyObject])
        print(self.similarProdArray)
        self.prodCollectionView.reloadData()
        
        
        
        if(self.similarProdArray.count > 0)
        {

            if(self.attributeDetailsArray.count > 0){
                self.similarProdView.hidden = false
//                self.mainVc.translatesAutoresizingMaskIntoConstraints = true
//                self.mainVc.frame = CGRectMake(0, 0, screenWidth, 915)
                self.ScrollView1.contentSize = CGSizeMake(screenWidth, 915)
                self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
                self.reviewRatingView.frame=CGRectMake(0, 487, self.boundss.width, 419)
            }else{
                self.similarProdView.hidden = false
//                self.mainVc.translatesAutoresizingMaskIntoConstraints = true
//                self.mainVc.frame = CGRectMake(0, 0, screenWidth, 718)
                self.ScrollView1.contentSize = CGSizeMake(screenWidth, 718)
                self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
                self.reviewRatingView.frame=CGRectMake(0, 317, self.boundss.width, 419)
            }
//            self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
//            self.reviewRatingView.frame=CGRectMake(0, 487, self.boundss.width, 419)
            self.similarProdView.translatesAutoresizingMaskIntoConstraints = true
            self.similarProdView.frame=CGRectMake(0, 0, self.boundss.width, 257)
            self.ratingInnerVC.translatesAutoresizingMaskIntoConstraints = true
            self.ratingInnerVC.frame = CGRectMake(0, 257, screenWidth, 162)
//            self.tbl1.tableFooterView = self.reviewRatingView
//            self.tbl1.reloadData()
            self.view.setNeedsDisplay()
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()

        }
        else
        {
            //self.similarProdView.hidden = true
            self.similarProdView.translatesAutoresizingMaskIntoConstraints = true
            self.similarProdView.frame = CGRectMake(0, 0, screenWidth, 0)
            self.ratingInnerVC.translatesAutoresizingMaskIntoConstraints = true
            self.ratingInnerVC.frame = CGRectMake(0, 0, screenWidth, 162)
            if(self.attributeDetailsArray.count > 0){
                self.similarProdView.hidden = false
//                self.mainVc.translatesAutoresizingMaskIntoConstraints = true
//                self.mainVc.frame = CGRectMake(0, 0, screenWidth, 657)
                self.ScrollView1.contentSize = CGSizeMake(screenWidth, 657)
                self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
                self.reviewRatingView.frame=CGRectMake(0, 487, self.boundss.width, 170)
            }else{
                self.similarProdView.hidden = false
//                self.mainVc.translatesAutoresizingMaskIntoConstraints = true
//                self.mainVc.frame = CGRectMake(0, 0, screenWidth, 657)
                self.ScrollView1.contentSize = CGSizeMake(screenWidth, 657)
                self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
                self.reviewRatingView.frame=CGRectMake(0, 317, self.boundss.width, 170)
            }
//            self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
//            self.reviewRatingView.frame = CGRectMake(0, 487, screenWidth, 170)
//            self.tbl1.tableFooterView = self.reviewRatingView
//            self.tbl1.reloadData()
            self.view.setNeedsDisplay()
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
        

    }
        else
    {
        self.similarProdView.translatesAutoresizingMaskIntoConstraints = true
        self.similarProdView.frame = CGRectMake(0, 0, screenWidth, 0)
        self.ratingInnerVC.translatesAutoresizingMaskIntoConstraints = true
        self.ratingInnerVC.frame = CGRectMake(0, 0, screenWidth, 162)
//        self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
//        self.reviewRatingView.frame = CGRectMake(0,487 , screenWidth, 170)
        if(self.attributeDetailsArray.count > 0){
            self.similarProdView.hidden = false
//            self.mainVc.translatesAutoresizingMaskIntoConstraints = true
//            self.mainVc.frame = CGRectMake(0, 0, screenWidth, 657)
            self.ScrollView1.contentSize = CGSizeMake(screenWidth, 657)
            self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
            self.reviewRatingView.frame=CGRectMake(0, 487, self.boundss.width, 170)
        }else{
            self.similarProdView.hidden = false
//            self.mainVc.translatesAutoresizingMaskIntoConstraints = true
//            self.mainVc.frame = CGRectMake(0, 0, screenWidth, 657)
            self.ScrollView1.contentSize = CGSizeMake(screenWidth, 657)
            self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
            self.reviewRatingView.frame=CGRectMake(0, 317, self.boundss.width, 170)
        }
//        self.tbl1.tableFooterView = self.reviewRatingView
//        self.tbl1.reloadData()
        self.view.setNeedsDisplay()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
        }
    
    }
        }
        /*else
        {
            self.similarProdView.translatesAutoresizingMaskIntoConstraints = true
            self.similarProdView.frame = CGRectMake(0, 0, screenWidth, 0)
            self.ratingInnerVC.translatesAutoresizingMaskIntoConstraints = true
            self.ratingInnerVC.frame = CGRectMake(0, 0, screenWidth, 162)
            //        self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
            //        self.reviewRatingView.frame = CGRectMake(0,487 , screenWidth, 170)
            if(self.attributeDetailsArray.count > 0){
                self.similarProdView.hidden = false
                //            self.mainVc.translatesAutoresizingMaskIntoConstraints = true
                //            self.mainVc.frame = CGRectMake(0, 0, screenWidth, 657)
                self.ScrollView1.contentSize = CGSizeMake(screenWidth, 657)
                self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
                self.reviewRatingView.frame=CGRectMake(0, 487, self.boundss.width, 170)
            }else{
                self.similarProdView.hidden = false
                //            self.mainVc.translatesAutoresizingMaskIntoConstraints = true
                //            self.mainVc.frame = CGRectMake(0, 0, screenWidth, 657)
                self.ScrollView1.contentSize = CGSizeMake(screenWidth, 657)
                self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
                self.reviewRatingView.frame=CGRectMake(0, 317, self.boundss.width, 170)
            }
            //        self.tbl1.tableFooterView = self.reviewRatingView
            //        self.tbl1.reloadData()
            self.view.setNeedsDisplay()
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        
        }*/
    
//}
}

    func similarProd() {
        let  appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
        let headers = [
            "Authorization": authorizationWithoutLogin,
            "Content-Type" : "application/json"
        ]
        
        var url : NSURL!
        
            url = NSURL(string:"\(baseUrl)SimilarProduct?strSKU=\(self.sno)")
           
        
        Alamofire.request(.GET, url, headers: headers)
            
            .validate(contentType: ["application/json"])
            
            .responseJSON { response in
                print(response.request)
                print(response.response)
                print(response.data)
                print(response.result.value)
                
//                if(response.result.isSuccess)
//                {       let alertView:UIAlertView = UIAlertView()
//                    alertView.title = ""
//                    alertView.message = "We will notify you once product is available"
//                    alertView.delegate = nil
//                    alertView.addButtonWithTitle("OK")
//                    alertView.show()
//                }else{
//                    let alertView:UIAlertView = UIAlertView()
//                    alertView.title = ""
//                    alertView.message = "Technical glitch."
//                    alertView.delegate = nil
//                    alertView.addButtonWithTitle("OK")
//                    alertView.show()
//                }
                if let JSON = response.result.value {
                    print(JSON)
                    
                    if let resultDict = JSON["result"] as? NSDictionary{
                        if let lstProdArry = resultDict["lstProducts"] as? NSArray{
                            if (lstProdArry.count > 0){
                                let prod = lstProdArry.objectAtIndex(0)
                                self.similarProdArray = NSMutableArray()
                                if let similarArray = prod["similarProd"] as? NSArray{
                                    self.similarProdArray = similarArray.mutableCopy() as! NSMutableArray
                                    self.similarProdPriceArr = NSMutableArray()
                                    self.similarProdNameArr = NSMutableArray()
                                    self.similProdImgArr = NSMutableArray()
                                    
                                    if(self.similarProdArray.count > 0)
                                    {
                                        self.similarProdView.hidden = false
                                        for prod in self.similarProdArray{
                                            if let img = prod["imageUrl"] as? String{
                                                self.similProdImgArr.addObject(img)
                                            }else{
                                                self.similProdImgArr.addObject("")
                                            }
                                            if let img = prod["description"] as? String{
                                                self.similarProdNameArr.addObject(img)
                                            }else{
                                                self.similarProdNameArr.addObject("")
                                            }

                                            if let img = prod["netPrice"] as? String{
                                                self.similarProdPriceArr.addObject(img)
                                            }else{
                                                self.similarProdPriceArr.addObject("")
                                            }

                                        }
                                    }
                                    else
                                    {
                                        //self.similarProdView.hidden = true
                                        self.similarProdView.translatesAutoresizingMaskIntoConstraints = true
                                        self.similarProdView.frame = CGRectMake(0, 0, screenWidth, 0)
                                        self.ratingInnerVC.translatesAutoresizingMaskIntoConstraints = true
                                        self.ratingInnerVC.frame = CGRectMake(0, 0, screenWidth, 162)
//                                        self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
//                                        self.reviewRatingView.frame = CGRectMake(0,487, screenWidth, 170)
//                                        self.tbl1.tableFooterView = self.reviewRatingView
//                                        self.tbl1.reloadData()
                                        if(self.attributeDetailsArray.count > 0){
                                            self.similarProdView.hidden = false
//                                            self.mainVc.translatesAutoresizingMaskIntoConstraints = true
//                                            self.mainVc.frame = CGRectMake(0, 0, screenWidth, 657)
                                           self.ScrollView1.contentSize = CGSizeMake(screenWidth, 657)
                                            self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
                                            self.reviewRatingView.frame=CGRectMake(0, 487, self.boundss.width, 170)
                                        }else{
                                            self.similarProdView.hidden = false
//                                            self.mainVc.translatesAutoresizingMaskIntoConstraints = true
//                                            self.mainVc.frame = CGRectMake(0, 0, screenWidth, 657)
                                            self.ScrollView1.contentSize = CGSizeMake(screenWidth, 657)
                                            self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
                                            self.reviewRatingView.frame=CGRectMake(0, 317, self.boundss.width, 170)
                                        }
                                        self.view.setNeedsDisplay()
                                        self.view.setNeedsLayout()
                                        self.view.layoutIfNeeded()
                                    }
                                    
                                }
                            }
                        }
                    }
                    //lstProducts  result
                    //similarProd
                    
                    
                    //var resp = ""
                }
                
        }
    }else{
    let alertView:UIAlertView = UIAlertView()
    alertView.title = ""
    alertView.message = ConstantsFile.noInternet_msg
    alertView.delegate = nil
    alertView.addButtonWithTitle("OK")
    alertView.show()
    }

}

    @IBAction func noInternetClk(){
       let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            let window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            self.noInternetVC.removeFromSuperview()
        let headers = [
            "Authorization": authorizationWithoutLogin,
            "Accept": "application/json"
        ]
        //
        Alamofire.request(.GET, "\(baseUrl)product?id=\(self.skuNumber)&offers=X", headers: headers)
            
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)
                let strData = NSString(data: response.data!, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)")// server data
                print(response.result)   // result of response serialization
                // self.productSellerArray.removeAllObjects()
                if let JSON : NSArray = response.result.value as? NSArray {
                    let  sellerArr : NSMutableArray! = NSMutableArray()
                    for (index, seller) in JSON.enumerate() {
                        let prodDet:NSMutableDictionary!=NSMutableDictionary()
                        
                        if let sellerName : String = seller["sellerName"] as? String where index > 0
                        {
                            sellerArr.addObject(sellerName)
                            
                        }
                        
                    }
                    if(sellerArr.count > 1){
                        self.sellersBtn.hidden = false
                    self.sellersBtn.setTitle("\(sellerArr.count-1) other sellers", forState: UIControlState.Normal)
                    }else if(sellerArr.count == 1){
                        self.sellersBtn.hidden = false
                        self.sellersBtn.setTitle("\(sellerArr.count-1) other seller", forState: UIControlState.Normal)
                    }else{
                        self.sellersBtn.hidden = true
                    }
                    
                }
        }
        print(self.skuNumber)
            var shwdsc:Bool!
            let escapedAddress1 = self.skuNumber.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            var url : NSURL!
            url = NSURL(string:"\(baseUrl)product?id=\(escapedAddress1!)")
            print(url)
            Alamofire.request(.GET, url!, headers: headers)
                .validate(contentType: ["application/json"])
                
                .responseJSON { response in
                    print(response.request)  // original URL request
                    print(response.response) // URL response
                    print(response.data)
                    let strData = NSString(data: response.data!, encoding: NSUTF8StringEncoding)
                    print("Body: \(strData)")// server data
                    print(response.result)
                    
                    if(response.result.isSuccess){
                        let defaults = NSUserDefaults.standardUserDefaults()
                        
                        if let userId = defaults.objectForKey("userId") as? Int{
                            self.favBtn.hidden = false
                        }else{
                            self.favBtn.hidden = true
                        }
                        
                        if let JSON : NSArray = response.result.value as? NSArray {
                            print(JSON.count)
                            
                            self.prodStr = ""
                            if(JSON.count > 1){
                                if let indexobj = JSON.objectAtIndex(1) as AnyObject?
                                {
                                    
                                }
                                else
                                {
                                    self.PincodechkV1.hidden = true
                                    self.QtyChkV2.hidden = true
                                    self.addcartbuynwView.hidden = true
                                    
                                    
                                }
                            }
                            for (index, forecast) in JSON.enumerate()
                            {
                                // self.favBtn.hidden = false
                                print("testing123\(forecast["skuNumber"] as? String)")
                                if let offers : Int = forecast["offers"] as? Int where index == 1
                                {
                                    if(offers > 1){
                                        self.sellersBtn.setTitle("\(offers) other sellers", forState: UIControlState.Normal)
                                    }else{
                                        self.sellersBtn.setTitle("\(offers) other seller", forState: UIControlState.Normal)
                                    }
                                }
                                if let productHeader = forecast["attributeDetails"] as? NSArray where index == 0
                                {
                                    if(productHeader.count > 0){
                                        self.attributeDetailsArray = productHeader as! NSMutableArray
                                    }
                                    
                                    
                                }
                                self.moreInfoBtn.hidden = false
                                if(self.attributeDetailsArray.count > 0){
                                    self.productAttributVc.hidden = false
                                    self.productAttributVc.translatesAutoresizingMaskIntoConstraints = true
                                    self.productAttributVc.frame = CGRectMake(0, 290, screenWidth, 168)
                                    self.moreInfoBtn.translatesAutoresizingMaskIntoConstraints = true
                                    self.moreInfoBtn.frame = CGRectMake(4, 458, 109, 27)
                                    if let attr = self.attributeDetailsArray[0] as? NSDictionary{
                                        self.prodAttr1Lbl.text = "• \(attr["name"] as! String): \(attr["value"] as! String)"
                                    }
                                    
                                    if let attr = self.attributeDetailsArray[1] as? NSDictionary{
                                        self.prodAttr2Lbl.text = "• \(attr["name"] as! String): \(attr["value"] as! String)"
                                    }
                                    
                                    if let attr = self.attributeDetailsArray[2] as? NSDictionary{
                                        self.prodAttr3Lbl.text = "• \(attr["name"] as! String): \(attr["value"] as! String)"
                                    }
                                    
                                    if let attr = self.attributeDetailsArray[3] as? NSDictionary{
                                        self.prodAttr4Lbl.text = "• \(attr["name"] as! String): \(attr["value"] as! String)"
                                    }
                                    if let attr = self.attributeDetailsArray[4] as? NSDictionary{
                                        self.prodAttr5Lbl.text = "• \(attr["name"] as! String): \(attr["value"] as! String)"
                                    }
                                }else{
                                    self.productAttributVc.translatesAutoresizingMaskIntoConstraints = true
                                    self.productAttributVc.frame = CGRectMake(0, 290, screenWidth, 0)
                                    self.moreInfoBtn.translatesAutoresizingMaskIntoConstraints = true
                                    self.moreInfoBtn.frame = CGRectMake(4, 290, 109, 27)
                                }
                                
                                if let productHeader : String = forecast["description"] as? String where index == 0
                                {
                                    self.productName.text = productHeader
                                    
                                }
                                if let productHeader : String = forecast["sellerNumber"] as? String where index == 1
                                {
                                    self.sellerNumber = productHeader
                                    
                                }
                                if let productHeader : String = forecast["productId"] as? String where index == 0
                                {
                                    self.productId = productHeader
                                    
                                }
                                if let productHeader : Int = forecast["avaliableQuantity"] as? Int where index == 1
                                {
                                    self.limitedStock = productHeader
                                    if(self.limitedStock == 0){
                                        self.QtyBtn.hidden = true
                                        self.outOfstockLable.hidden = false
                                        self.notificationBtn.hidden = false
                                        self.addCrtBtn.hidden = true
                                        self.buybtn.hidden = true
                                        self.buyNowView.hidden = true
                                        self.addcartbuynwView.hidden = true
                                    }else{
                                        
                                        self.notificationBtn.hidden = true
                                        self.QtyBtn.hidden = true           // false
                                        self.outOfstockLable.hidden = true
                                        self.addCrtBtn.hidden = false
                                        self.buybtn.hidden = false
                                        self.buyNowView.hidden = false
                                        self.addcartbuynwView.hidden = false
                                    }
                                    
                                }
                                if let productHeader : Int = forecast["avaliableQuantity"] as? Int where index == 1
                                {
                                    self.availabilty = productHeader
                                    
                                }
                                
                                if let productHeader1 : String = forecast["skuNumber"] as? String where index == 1
                                {
                                    self.skuno = productHeader1
                                    // self.similarProd()
                                    
                                }
                                if let productHeader : Int = forecast["maxQuantity"] as? Int where index == 0
                                {
                                    self.maximumQuantity = productHeader
                                    
                                }
                                if let productHeader : String = forecast["vendorCode"] as? String where index == 0
                                {
                                    self.vendorCode = productHeader
                                    
                                }
                                if let productHeader : String = forecast["imageURLHigh"] as? String where index == 0
                                {
                                    let imageurl : AnyObject  = forecast["imageURLHigh"] as! NSString
                                    self.imageurl = imageurl as! NSString
                                    
                                }
                                if let productHeader : String = forecast["mpn"] as? String where index == 1
                                {
                                    self.vendorPartNumber = productHeader
                                    let wsm : WebServiceClass = WebServiceClass.sharedInstance
                                    wsm.delegates=self
                                    wsm.getOthersreviewDetails(self.vendorPartNumber as String, PageIndex: "0", onSearchPage: false, onProductPage: true, onReviewPage: false, onAdminPage: false)
                                    
                                }
                                
                                if let sellerName : String = forecast["sellerName"] as? String where index == 1
                                {
                                    //self.sellernamelbl.text = UIEdgeInsetsMake(10, 0, 10, 0);
                                    self.sellernamelbl.text = "By \(sellerName)"
                                    self.sellerName = sellerName
                                }
                                //                             if let pricetag : String = forecast["netPrice"] as? String where index == 1 {
                                //                                self.nprice  = pricetag
                                //                                self.netPrc = self.nprice
                                //                            }
                                
                                shwdsc = forecast["showPerc"] as! Bool
                                if(shwdsc == true){
                                    self.discountLbl.hidden = false
                                    self.discountLbl.text = String(format:"%@ Off  ",forecast["percentage"] as! String)
                                    
                                    let grossPrice1  =  "₹ \(forecast["grossPriceDisplayString"] as! String)"
                                    let netPrice2  =  "₹ \(forecast["netPriceDisplayString"] as! String)"
                                    self.nprice = netPrice2
                                    self.gprice = grossPrice1
                                    let labelstring : NSString = "\(netPrice2)  \(grossPrice1)"
                                    
                                    let string_to_color = "\(netPrice2)"
                                    let string2 = "\(grossPrice1)"
                                    
                                    let range = (labelstring as NSString).rangeOfString(string_to_color)
                                    let range2 = (labelstring as NSString).rangeOfString(string2)
                                    
                                    
                                    
                                    let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
                                    
                                    attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Bold", size: 14)!], range: range)
                                    attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Bold", size: 11)!], range: range2)
                                    attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
                                    attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
                                    
                                    self.pricelabel.attributedText = attributedText
                                }else{
                                    self.discountLbl.hidden = true
                                    // cell.DescriptionLbl.text = String(format:"%@Off  ",prod.percentage!)
                                    
                                    if let netPrice2  =  forecast["netPriceDisplayString"] as? String where index == 1{
                                        self.pricelabel.text = "₹ \(forecast["netPriceDisplayString"] as! String)"
                                    }else{
                                        self.pricelabel.text = "Price Not Available"
                                    }
                                    self.nprice = self.pricelabel.text
                                    self.gprice = ""
                                    
                                }
                                
                                
                                if let pricetag : String = forecast["netPrice"] as? String where index == 1
                                {
                                    // self.nprice  = pricetag
                                    print(pricetag)
                                    self.netPrc = pricetag
                                    
                                }
                                
                                
                                if let imagelist  = forecast["imageGalleryURLHigh"] as? NSMutableArray
                                {
                                    for imagelink in imagelist
                                    {
                                        self.imagelinkArr.addObject(imagelink)
                                    }
                                    print(self.imagelinkArr)
                                    if(self.imagelinkArr.count > 0){
                                        self.bannerView.hidden = false
                                        self.contentImages = NSArray.init(array: self.imagelinkArr)
                                        self.pageController = UIPageViewController()
                                        self.createPageViewController()
                                        self.setupPageControl()
                                    }else{
                                        self.bannerView.hidden = true
                                    }
                                    
                                    
                                    
                                }
                                else
                                {
                                    if(self.imagelinkArr.count == 0){
                                        self.bannerView.hidden = true
                                    }else{
                                        self.bannerView.hidden = false
                                    }
                                }
                                if let teststring  = forecast["groupedSpecification"] as? NSMutableDictionary
                                {
                                    
                                    
                                    self.imageURLMedium =  forecast["imageURLMedium"] as! NSString
                                    let productName : AnyObject  = forecast["description"] as! NSString
                                    self.productName.text = "\(productName)"
                                    print("\(self.imageurl)")
                                    var newDict1 : NSMutableArray = NSMutableArray()
                                    for g1 in teststring
                                    {
                                        newDict1  = g1.value as! NSMutableArray
                                        
                                        print(g1.key)
                                        print(g1.value)
                                        self.sectionheader.addObject(g1.key)
                                        var newDict2 : NSMutableArray = NSMutableArray()
                                        
                                        
                                        for v1 in newDict1
                                        {
                                            newDict2 .addObject(v1)
                                            
                                            print(v1["specificationType"]!)
                                            print(v1["specificationTypeDetails"]!)
                                            
                                        }
                                        
                                        self.newDict3["\(g1.key)"] = newDict2
                                    }
                                    
                                    for g2 in self.newDict3
                                    {
                                        let  valueobject  = g2.value as! NSMutableArray
                                        print(g2.key)
                                        
                                        var  values  = [String]()
                                        for g3 in valueobject
                                        {
                                            let a = g3.valueForKey("specificationType")!
                                            print(a)
                                            let b = g3.valueForKey("specificationTypeDetails")!
                                            
                                            let first = (a as! String) + ":" + (b as! String)
                                            let second = "\(a), \(b)"
                                            
                                            if (a as! String == "Marketing Text")
                                            {
                                                var text: NSString = "Description\n\n\(b)"
                                                var string_to_color = "Description"
                                                var string2 = "\(b)"
                                                
                                                var range = (text as NSString).rangeOfString(string_to_color)
                                                var range2 = (text as NSString).rangeOfString(string2)
                                                var attributedText: NSMutableAttributedString = NSMutableAttributedString(string: text as String)
                                                attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0) , range: range)
                                                attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 16)!], range: range)
                                                attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 12)!], range: range2)
                                                
                                                self.prodDescr = attributedText
                                            }
                                            else
                                            {
                                                values.append(first)
                                            }
                                        }
                                        //                                print(values)
                                        self.rowsinheader.append(values)
                                        //                                print(self.rowsinheader)
                                        self.rowsectionname.addObject(valueobject)
                                        
                                    }
                                    
                                    let sectionheaderarr = [self.sectionheader]
                                    
                                    
                                    if let myStringArray = self.sectionheader.objectEnumerator().allObjects as? [String] {
                                        // print(myStringArray)
                                        
                                        self.sheader = myStringArray
                                        //  print(self.sheader)
                                    }
                                    //
                                }
                                
                                if let similarproduct : NSArray = forecast["similarProductsSkuList"] as? NSArray where index == 0
                                {
                                    
                                    for prdt in similarproduct
                                    {
                                        self.sno += "\(prdt);"
                                        
                                    }
                                    self.similarproductitem()
                                    
                                    
                                    // print(c)
                                }
                                else{
                                    self.similarProdView.hidden = false
                                    self.similarProdView.translatesAutoresizingMaskIntoConstraints = true
                                    self.similarProdView.frame = CGRectMake(0, 0, screenWidth, 0)
                                    self.ratingInnerVC.translatesAutoresizingMaskIntoConstraints = true
                                    self.ratingInnerVC.frame = CGRectMake(0, 0, screenWidth, 162)
                                    
                                    if(self.attributeDetailsArray.count > 0){
                                        self.similarProdView.hidden = false
                                        //                                    self.mainVc.translatesAutoresizingMaskIntoConstraints = true
                                        //                                    self.mainVc.frame = CGRectMake(0, 0, screenWidth, 657)
                                         self.ScrollView1.contentSize = CGSizeMake(screenWidth, 657)
                                        self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
                                        self.reviewRatingView.frame=CGRectMake(0, 487, self.boundss.width, 170)
                                        self.ScrollView1.contentSize = CGSizeMake(screenWidth, 657)
                                    }else{
                                        self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
                                        self.reviewRatingView.frame=CGRectMake(0, 317, self.boundss.width, 170)
                                        self.similarProdView.hidden = false
                                        //                                    self.mainVc.translatesAutoresizingMaskIntoConstraints = true
                                        //                                    self.mainVc.frame = CGRectMake(0, 0, screenWidth, 657)
                                        //                                    self.ScrollView1.contentSize = CGSizeMake(screenWidth, 657)
                                        self.ScrollView1.contentSize = CGSizeMake(screenWidth, 657)
                                    }
                                    if(self.attributeDetailsArray.count > 0){
                                        self.similarProdView.hidden = false
                                        //            self.mainVc.translatesAutoresizingMaskIntoConstraints = true
                                        //            self.mainVc.frame = CGRectMake(0, 0, screenWidth, 915)
                                        
                                        self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
                                        self.reviewRatingView.frame=CGRectMake(0, 487, self.boundss.width, 428)
                                        self.allReviewBtn.addTarget(self, action:#selector(self.allReviewBtnClk), forControlEvents: .TouchUpInside)
                                        // allReviewBtnClk
                                        //                                    self.similarProdView.translatesAutoresizingMaskIntoConstraints = true
                                        //                                    self.similarProdView.frame=CGRectMake(0, 0, self.boundss.width, 300)
                                        self.ScrollView1.contentSize = CGSizeMake(screenWidth, 915)
                                    }else{
                                        self.similarProdView.hidden = false
                                        self.mainVc.translatesAutoresizingMaskIntoConstraints = true
                                        self.mainVc.frame = CGRectMake(0, 0, screenWidth, 718)
                                        self.ScrollView1.contentSize = CGSizeMake(screenWidth, 718)
                                        //            self.mainVc.translatesAutoresizingMaskIntoConstraints = true
                                        //            self.mainVc.frame = CGRectMake(0, 0, screenWidth, 915)
                                        self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
                                        self.reviewRatingView.frame=CGRectMake(0, 317, self.boundss.width, 428)
                                        self.allReviewBtn.addTarget(self, action:#selector(self.allReviewBtnClk), forControlEvents: .TouchUpInside)
                                        //                                    // allReviewBtnClk
                                        //                                    self.similarProdView.translatesAutoresizingMaskIntoConstraints = true
                                        //                                    self.similarProdView.frame=CGRectMake(0, 0, boundss.width, 300)
                                    }
                                    
                                    self.view.setNeedsDisplay()
                                    self.view.setNeedsLayout()
                                    self.view.layoutIfNeeded()
                                }
                                
                                
                                
                                
                            }
                            var bottomBorder = CALayer()
                            // bottomBorder.frame = CGRectMake(0.0,82, self.descView.frame.size.width, 1.0);
                            bottomBorder.backgroundColor = UIColor (red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0).CGColor
                            
                            // self.descView.layer.addSublayer(bottomBorder)
                            if(self.newDict3.count <= 0 ){
                                // self.descView.backgroundColor = UIColor.redColor()
                                // self.descView.translatesAutoresizingMaskIntoConstraints = true
                                // self.descView.frame = CGRectZero
                                self.innerVc.translatesAutoresizingMaskIntoConstraints = true
                                self.innerVc.frame = CGRectMake(0, 0, self.boundss.width, 371-83)
                            }else{
                                var isfound:Bool = false
                                for g2 in self.newDict3
                                {
                                    let  valueobject  = g2.value as! NSMutableArray
                                    print(g2.key)
                                    if(g2.key as! String == "general Information"){
                                        print("9999999")
                                        isfound = true
                                        
                                    }
                                    
                                    if(isfound == false){
                                        // self.descView.translatesAutoresizingMaskIntoConstraints = true
                                        // self.descView.frame = CGRectZero
                                        self.innerVc.translatesAutoresizingMaskIntoConstraints = true
                                        self.innerVc.frame = CGRectMake(0, 0, self.boundss.width+10, 371-82)
                                    }
                                }
                            }
                            dispatch_async(dispatch_get_main_queue())
                            {
                                let appDelegate =
                                    UIApplication.sharedApplication().delegate as! AppDelegate
                                
                                let managedContext = appDelegate.managedObjectContext
                                let searchpredicate = NSPredicate(format: "sku = %@", self.skuNumber)
                                let fetchRequest = NSFetchRequest(entityName: "RecentlyViewed")
                                fetchRequest.predicate = searchpredicate
                                do {
                                    let results =
                                        try managedContext.executeFetchRequest(fetchRequest)
                                    if let people : [NSManagedObject] = results as? [NSManagedObject]
                                    {
                                        if (people .isEmpty)
                                        {
                                            //                                        print(self.gprice)
                                            //                                        print(self.nprice)
                                            //  print(self.imageurl)
                                            print(self.skuNumber)
                                            if self.gprice.characters.count != 0 {
                                                if self.imageurl != nil {
                                                    print("productName \(self.productName.text!) sku\(self.skuNumber) netPrice \(self.nprice)  grossPrice \(self.gprice)  ")
                                                    
//                                                    self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: self.nprice, grossPrice: self.gprice, imageURLHigh: self.imageurl as String, showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                    self.saveName(self.skuNumber)
                                                }else{
//                                                    self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: self.nprice, grossPrice: self.gprice, imageURLHigh: "",showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                    self.saveName(self.skuNumber)
                                                }
                                                
                                            }else{
                                                
                                                if self.imageurl != nil {
                                                    print("productName \(self.productName.text!), sku\(self.skuNumber) ,netPrice \(self.nprice),  grossPrice \(self.gprice)  ")
                                                    if(self.nprice != nil){
//                                                        self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: self.nprice, grossPrice: "", imageURLHigh: self.imageurl as String,showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                        self.saveName(self.skuNumber)
                                                    }else{
//                                                        self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: "", grossPrice: "", imageURLHigh: self.imageurl as String,showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                        self.saveName(self.skuNumber)
                                                    }
                                                    
                                                }else{
                                                    if(self.nprice != nil){
//                                                        self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: self.nprice, grossPrice: "", imageURLHigh: "",showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                        self.saveName(self.skuNumber)
                                                    }else{
//                                                        self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: "", grossPrice: "", imageURLHigh: "",showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                        self.saveName(self.skuNumber)
                                                    }
                                                }
                                            }
                                        }
                                            
                                        else
                                        {
                                            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                                            let context:NSManagedObjectContext = appDel.managedObjectContext
                                            context.deleteObject(people.last!)
                                            
                                            do {
                                                try context.save()
                                                
                                                
                                                if self.gprice.characters.count != 0 {
                                                    if self.imageurl != nil {
                                                        print("productName \(self.productName.text!) sku\(self.skuNumber) netPrice \(self.nprice)  grossPrice \(self.gprice)  ")
                                                        
//                                                        self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: self.nprice, grossPrice: self.gprice, imageURLHigh: self.imageurl as String,showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                        self.saveName(self.skuNumber)
                                                    }else{
//                                                        self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: self.nprice, grossPrice: self.gprice, imageURLHigh: "",showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                        self.saveName(self.skuNumber)
                                                    }
                                                    
                                                }else{
                                                    
                                                    if self.imageurl != nil {
                                                        print("productName \(self.productName.text!) sku\(self.skuNumber) netPrice \(self.nprice)  grossPrice \(self.gprice)  ")
                                                        if(self.nprice != nil){
//                                                            self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: self.nprice, grossPrice: "", imageURLHigh: self.imageurl as String,showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                            self.saveName(self.skuNumber)
                                                        }else{
//                                                            self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: "", grossPrice: "", imageURLHigh: self.imageurl as String,showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                            self.saveName(self.skuNumber)
                                                        }
                                                        
                                                    }else{
                                                        if(self.nprice != nil){
//                                                            self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: self.nprice, grossPrice: "", imageURLHigh: "",showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                            self.saveName(self.skuNumber)
                                                        }else{
//                                                            self.saveName(self.productName.text!, sku: self.skuNumber, netPrice: "", grossPrice: "", imageURLHigh: "",showPrc: shwdsc, percnt: self.discountLbl.text!)
                                                            self.saveName(self.skuNumber)
                                                        }
                                                    }
                                                }
                                                let appDelegate =
                                                    UIApplication.sharedApplication().delegate as! AppDelegate
                                                
                                                let managedContext = appDelegate.managedObjectContext
                                                
                                                //2
                                                let fetchRequest = NSFetchRequest(entityName: "RecentlyViewed")
                                                
                                                3
                                                do {
                                                    let results =
                                                        try managedContext.executeFetchRequest(fetchRequest)
                                                    if let people : [NSManagedObject] = results as? [NSManagedObject]
                                                    {
                                                        for searchstring in people
                                                        {
//                                                            print(searchstring.valueForKey("desc"))
                                                            print(searchstring.valueForKey("sku"))
//                                                            print(searchstring.valueForKey("netPrice"))
//                                                            print(searchstring.valueForKey("grossPrice"))
//                                                            print(searchstring.valueForKey("imageURLHigh"))
                                                            
                                                           // let str  = searchstring.valueForKey("desc") as! String
                                                            
                                                            // data1.append(str)
                                                            
                                                            //data1.append(s)
                                                        }
                                                        
                                                    }
                                                    
                                                } catch let error as NSError {
                                                    print("Could not fetch \(error), \(error.userInfo)")
                                                }
                                                
                                                
                                            } catch _ {
                                            }
                                            
                                            
                                        }
                                        
                                        
                                    }
                                    
                                } catch let error as NSError {
                                    print("Could not fetch \(error), \(error.userInfo)")
                                }
                                
                                self.PincodechkV1.hidden = false
                                self.QtyChkV2.hidden = false
                                // self.addcartbuynwView.hidden = false
                                //  self.tbl1.hidden = false
                                //  self.descView.hidden = false
                                // self.descView.translatesAutoresizingMaskIntoConstraints = true
                                // self.descView.frame = CGRectMake(0, 285, self.boundss.size.width+10, 83)
                                /// self.tbl1.reloadData()
                                
                                LoadingOverlay.shared.hideOverlayView()
                                
                                
                                
                            }
                            
                            
                        }
                    }
                    
                    if(response.result.isFailure){
                        LoadingOverlay.shared.hideOverlayView()
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = ""
                        alertView.message = ConstantsFile.requestFail_msg
                        alertView.delegate = nil
                        alertView.addButtonWithTitle("OK")
                        
                        alertView.show()
                    }
                    
                    
                    
                    self.dataLayer.push(["event": "openScreen", "screenName": "ProdDetailiOS"])
            }
        }
        else{
            self.noInternetVC.translatesAutoresizingMaskIntoConstraints = true
            self.noInternetVC.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
            self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
            self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
            self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
            self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
            self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
            self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)
            self.view.addSubview(self.noInternetVC)
        }
    }
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        // handling code
       
          view.endEditing(true)
        self.addRatingView.hidden = true
        
    }
    func addmyReview(notification: NSNotification)  {
        ratingReviewArray.removeAllObjects()
        let alertView:UIAlertView = UIAlertView()
        alertView.title = ""
        alertView.message = ConstantsFile.review_msg
        alertView.delegate = nil
        alertView.addButtonWithTitle("OK")
        alertView.show()
        let wsm : WebServiceClass = WebServiceClass.sharedInstance
        wsm.delegates=self
        wsm.getOthersreviewDetails(self.vendorPartNumber as String, PageIndex: "0", onSearchPage: false, onProductPage: true, onReviewPage: false, onAdminPage: false)
    }
    func getmyReview(notification: NSNotification)  {
         print(notification)
        var ratingcommentArray:NSMutableArray!=NSMutableArray()
        let dict : AnyObject = notification.userInfo!
        let ratingReviewDict = dict["ratingReview"] as! NSArray
        //ratingReviewArray = ratingCountDict.mutableCopy() as! NSMutableArray
        for firstReview in ratingReviewDict{
            ratingcommentArray.addObject(firstReview)
          // ratingReviewArray.addObject(firstReview)
        }
        let pred = NSPredicate(format: "mpn = %@",self.vendorPartNumber)
        var filterArr = ratingcommentArray.filteredArrayUsingPredicate(pred)
        if(filterArr.count > 0){
        var review = filterArr[0]
        giveRatingView.rating = review["rating"] as! Float
             NoReviewsLbl.hidden = true
             reviewRatingView.hidden = false
            allReviewBtn.hidden = false
        
            
        }else{
            giveRatingView.rating = 0.0
        }
        
    }
    @IBAction func submitReview(){
        self.view.endEditing(true)
        if(givRatingView.rating == 0.0){
            errorLbl.hidden = false
        }else{
            errorLbl.hidden = true
            addRatingView.hidden = true
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
           wsm.sendRatingDetails(self.vendorPartNumber as String, Review: (self.decrLbl?.text)!, Rating: givRatingView.rating, firstName: (titileLbl?.text)!)
          //  wsm.getMyownreviewDetails(self.vendorPartNumber as String, PageIndex: "0", onSearchPage: false, onProductPage: false, onReviewPage: true, onAdminPage: false)
            //ratingReview
        }
    }
    @IBAction func givMyRatingClk(){
     print(giveRatingView.rating)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId"){
        if(giveRatingView.rating == 0.0){
            givRatingView.rating = 0.0
            errorLbl.hidden = true
            decrLbl.text = ""
            titileLbl.text = ""
            let border = CALayer()
            let width = CGFloat(1.0)
            border.borderColor = UIColor.lightGrayColor().CGColor
            border.frame = CGRect(x: 0, y: titileLbl.frame.size.height - width, width:  titileLbl.frame.size.width, height: titileLbl.frame.size.height)
            
            border.borderWidth = width
            titileLbl.layer.addSublayer(border)
            titileLbl.layer.masksToBounds = true
            
            let border1 = CALayer()
            let width1 = CGFloat(1.0)
            border1.borderColor = UIColor.lightGrayColor().CGColor
            border1.frame = CGRect(x: 0, y: decrLbl.frame.size.height - width1, width:  decrLbl.frame.size.width, height: decrLbl.frame.size.height)
            
            border1.borderWidth = width1
            decrLbl.layer.addSublayer(border1)
            decrLbl.layer.masksToBounds = true
           addRatingView.hidden = false
          //  ratingImg.translatesAutoresizingMaskIntoConstraints = true
           // ratingImg.frame = CGRectMake(0, 0, boundss.width, boundss.height)
        }else{
            let alertView:UIAlertView = UIAlertView()
            alertView.title = ""
            alertView.message = ConstantsFile.alreadyRated_msg
            alertView.delegate = nil
            alertView.addButtonWithTitle("OK")
            alertView.show()
            }
        }else{
            let LoginViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("LoginView") as? LoginView
            LoginViewControllerObj?.isCalledFrm = "other"
            let NavigationController = UINavigationController(rootViewController: LoginViewControllerObj!)
            self.presentViewController(NavigationController, animated: true, completion: nil)

        }
    }
    
    
    @IBAction func notifyActionBtn(sender: AnyObject) {
        
        var window :UIWindow = UIApplication.sharedApplication().keyWindow!
        LoadingOverlay.shared.showOverlay(window)
       let  appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
        var headers : [String : String]!
        let defaults = NSUserDefaults.standardUserDefaults()
        if let data = defaults.objectForKey("LoginObject") as? NSData
            
        {
            if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                
            {
                let authorization = authorizationWithLogin
                
                print(authorization)
                headers = [
                    
                    "Authorization" : authorization,
                    
                    "Content-Type ": "application/json"
                    
                ]
                
            }
            
        }
       //  let escapepercent = self.vendorPartNumber.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
      // let escapepercent = self.vendorPartNumber.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        //LoadingOverlay.shared.showOverlay(self.view)
      
         var url: NSURL!
        let unencodedString = self.vendorPartNumber
        
        let allowedCharacters = NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSMutableCharacterSet
        allowedCharacters.removeCharactersInString("+/=")
        
        if let encodedString = unencodedString.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters) {
            print(encodedString)
             url = NSURL(string: "\(baseUrl)product?mpn=\(encodedString)&mpnn=\(encodedString)&mp=\(encodedString)")
           //url = NSURL(string: "http://immarketapi-stg1.azurewebsites.net/api/product?mpn=\(self.vendorPartNumber)&mpnn=\(self.vendorPartNumber)&mp=\(self.vendorPartNumber)")
        }

       //var url: NSURL!
       
        print(url)
        
//        let encodedHost = url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//
//        print(encodedHost)
        
        Alamofire.request(.GET, url, headers: headers)
            
            .validate(contentType: ["application/json"])
            
            .responseJSON { response in
                self.dismissViewControllerAnimated(true, completion: nil)
                print(response.request)
                print(response.response)
                print(response.data)
                print(response.result.value)
                
                if(response.result.isSuccess)
                { LoadingOverlay.shared.hideOverlayView()
                      let alertView:UIAlertView = UIAlertView()
                        alertView.title = ""
                        alertView.message = ConstantsFile.notify_msg
                        alertView.delegate = nil
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                }else{
                    LoadingOverlay.shared.hideOverlayView()
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = ""
                    alertView.message = ConstantsFile.requestFail_msg
                    alertView.delegate = nil
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
                
        }
        }else{
            LoadingOverlay.shared.hideOverlayView()
            let alertView:UIAlertView = UIAlertView()
            alertView.title = ""
            alertView.message = ConstantsFile.noInternet_msg
            alertView.delegate = nil
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
    }
    func getOtherReviewFail(notification: NSNotification) {
        userratingview.rating = 0.0
        // reviewView.hidden = true
        allReviewBtn.hidden = true
        NoReviewsLbl.hidden = false
    }
    
    
    func getOtherReview(notification: NSNotification)  {
       // print(jsonstr)
        let dict : AnyObject = notification.userInfo!
        print(dict["ratingCount"])
        
        let ratingCountDict = dict["ratingCount"] as! NSArray
        print(ratingCountDict.count)
         let ratingReviewDict = dict["ratingReview"] as! NSArray
        print(ratingReviewDict.count)
        if(ratingCountDict.count > 0){
          NoReviewsLbl.hidden = true
        for forecast in ratingCountDict
        {
            if(ratingReviewDict.count > 1){
                if  forecast["totalProductCount"]! != nil
                {
                    totalReviewCnt = forecast["totalProductCount"] as! Int
                    userratingview.rating = forecast["overallRating"] as! Float
                    // let rtng = round(forecast["overallRating"] as! Float)
                    totalReviewCntLbl.text =  "\(totalReviewCnt) Reviews"
                }
            
          //  totalReviewLable.text =  "\(totalReviewCnt) Reviews"
      //  print(forecast["totalCount"] as! Int)
               
            }else{
                print(forecast["totalProductCount"]!)
                if  forecast["totalProductCount"]! != nil
                {
                //    print(ttlcount)
                totalReviewCnt = forecast["totalProductCount"] as! Int
                    print(totalReviewCnt)
                userratingview.rating = forecast["overallRating"] as! Float
                // let rtng = round(forecast["overallRating"] as! Float)
                totalReviewCntLbl.text =  "\(totalReviewCnt) Review"
             //   totalReviewLable.text =  "\(totalReviewCnt) Review"
                print(forecast["totalProductCount"] as! Int)
                }
            }
        }
        }else{
             userratingview.rating = 0.0
           // reviewView.hidden = true
            allReviewBtn.hidden = true
            NoReviewsLbl.hidden = false
        }
        if(ratingReviewDict.count > 0){
        let ratingArray:NSMutableArray!=NSMutableArray()
        let ratingdateArray:NSMutableArray!=NSMutableArray()
        let ratingtitleArray:NSMutableArray!=NSMutableArray()
        let ratingcommentArray:NSMutableArray!=NSMutableArray()
          //ratingReviewArray = ratingCountDict.mutableCopy() as! NSMutableArray
        for firstReview in ratingReviewDict{
            ratingReviewArray.addObject(firstReview)
            ratingArray.addObject(firstReview["rating"] as! Int)
           ratingdateArray.addObject(firstReview["createdOn"] as! String)
            ratingtitleArray.addObject(firstReview["firstName"] as! String)
            ratingcommentArray.addObject(firstReview["review"] as! String)
        }
        if(ratingArray.count > 0)
        {
             // reviewView.hidden = false
//            let pred = NSPredicate(format: "SELF = 1")
//             let pred2 = NSPredicate(format: "SELF = 2")
//             let pred3 = NSPredicate(format: "SELF = 3")
//             let pred4 = NSPredicate(format: "SELF = 4")
//             let pred5 = NSPredicate(format: "SELF = 5")
//            var filterArr = ratingArray.filteredArrayUsingPredicate(pred)
//            var filterArr2 = ratingArray.filteredArrayUsingPredicate(pred2)
//            var filterArr3 = ratingArray.filteredArrayUsingPredicate(pred3)
//            var filterArr4 = ratingArray.filteredArrayUsingPredicate(pred4)
//            var filterArr5 = ratingArray.filteredArrayUsingPredicate(pred5)
//            
//            self.fivestarRatingLbl.text = String(filterArr5.count)
//             self.fourstarratingLbl.text = String(filterArr4.count)
//             self.threestarratingLbl.text = String(filterArr3.count)
//             self.twostarratingLbl.text = String(filterArr2.count)
//             self.onestarratingLbl.text = String(filterArr.count)
//            
//            print(filterArr.count)
//             print(filterArr2.count)
//             print(filterArr3.count)
//            print(filterArr4.count)
//            print(filterArr5.count)
//            var arcnt = filterArr.count
//            star1Slider.progress = (Float(arcnt)/Float(totalReviewCnt)) as Float
//            star2Slider.progress = (Float(filterArr2.count)/Float(totalReviewCnt)) as Float
//            star3Slider.progress = (Float(filterArr3.count)/Float(totalReviewCnt)) as Float
//            star4Slider.progress = (Float(filterArr4.count)/Float(totalReviewCnt)) as Float
//            star5Slider.progress = (Float(filterArr5.count)/Float(totalReviewCnt)) as Float
        }else{
            //reviewView.hidden = true
            }
        
//        if let frstReview = ratingtitleArray[0] as? String{
//            review1view.hidden = false
//            review1Title.text = ratingtitleArray[0] as? String
//            review1Commnt.text = ratingcommentArray[0] as? String
//            review1stars.rating = ratingArray[0] as!Float
//            let deFormatter = NSDateFormatter()
//            var string = ratingdateArray[0] as! String
//            if let reverseIndex = string.characters.reverse().indexOf(".") {
//                print(string[string.startIndex ..< reverseIndex.base.advancedBy(-1)])
//                string = string[string.startIndex ..< reverseIndex.base.advancedBy(-1)]
//            }
//
//        deFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//       
//        let startTime = deFormatter.dateFromString(string)
//        print(startTime!) // 2015-06-25 23:10:00 +0000
//
//
//            let formatter = NSDateFormatter()
//            formatter.dateFormat = "dd MMM yyyy"
//            let timeString = formatter.stringFromDate(startTime!)
//            print(timeString)
//            review1DateLbl.text = timeString
//        }else{
//            review1view.hidden = true
//            }
//            
            
//        if  ratingtitleArray.count > 1{
//            review2View.hidden = false
//            review2Title.text = ratingtitleArray[1] as? String
//            review2Commnt.text = ratingcommentArray[1] as? String
//            review2stars.hidden = false
//            review2stars.rating = ratingArray[1] as!Float
//            let deFormatter = NSDateFormatter()
//            var string = ratingdateArray[1] as! String
//            if let reverseIndex = string.characters.reverse().indexOf(".") {
//                print(string[string.startIndex ..< reverseIndex.base.advancedBy(-1)])
//                string = string[string.startIndex ..< reverseIndex.base.advancedBy(-1)]
//            }
//            
//            deFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//            
//            let startTime = deFormatter.dateFromString(string)
//            print(startTime!) // 2015-06-25 23:10:00 +0000
//            
//            
//            let formatter = NSDateFormatter()
//            formatter.dateFormat = "dd MMM yyyy"
//            let timeString = formatter.stringFromDate(startTime!)
//            print(timeString)
//            review2DateLbl.text = timeString
//            if(totalReviewCnt == 2){
//                review2View.hidden = false
//                 allReviewBtn.hidden = true
//                self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
//                self.reviewRatingView.frame=CGRectMake(0, 0, boundss.width, 504+256)
//                self.tbl1.tableFooterView = self.reviewRatingView
//                self.tbl1.reloadData()
//            }else{
//                review2View.hidden = false
//                 allReviewBtn.hidden = false
//                self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
//                self.reviewRatingView.frame=CGRectMake(0, 0, boundss.width, 504-168+256)
//                self.tbl1.tableFooterView = self.reviewRatingView
//                self.tbl1.reloadData()
//            }
//           
//        }else{
//            review2View.hidden = true
//            review2Commnt.text = ""
//            review2Title.text = ""
//            review2stars.hidden = true
//            review2DateLbl.text = ""
//            allReviewBtn.hidden = true
//            self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
//            self.reviewRatingView.frame=CGRectMake(0, 0, boundss.width, 504-168+256)
//             self.tbl1.tableFooterView = self.reviewRatingView
//            self.tbl1.reloadData()
//        }
        }else{
//           reviewView.hidden = true
//            review1view.hidden = true
//            review2View.hidden = true
       //      allReviewBtn.hidden = true
//            self.reviewRatingView.translatesAutoresizingMaskIntoConstraints = true
//            self.reviewRatingView.frame=CGRectMake(0, 0, boundss.width, 123+256)
//            self.tbl1.tableFooterView = self.reviewRatingView
//            self.tbl1.reloadData()

        }
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId"){
        let wsm : WebServiceClass = WebServiceClass.sharedInstance
        wsm.delegates=self
      //  wsm.getOthersreviewDetails(self.vendorPartNumber as String, PageIndex: "0", onSearchPage: false, onProductPage: true, onReviewPage: false, onAdminPage: false)
        
        wsm.getMyownreviewDetails(self.vendorPartNumber as String, PageIndex: "0", onSearchPage: false, onProductPage: false, onReviewPage: true, onAdminPage: false)
        //ratingReview
        }
    }
    override func viewWillDisappear(animated: Bool) {

        
        self.title = ""
         self.tabBarController?.tabBar.hidden = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "othersReview", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "myReview", object: nil)
         NSNotificationCenter.defaultCenter().removeObserver(self, name: "addReview", object: nil)
        
        unregisterKeyboardNotifications()
    }
//    func saveName(Desc: String, sku: String, netPrice: String, grossPrice: String, imageURLHigh: String, showPrc: Bool, percnt:String)
//    {
//        
//        print("\(Desc)\n\(sku)\n\(netPrice)\n\(grossPrice)\n\(imageURLHigh)")
//        //1
//        let appDelegate =
//            UIApplication.sharedApplication().delegate as! AppDelegate
//        
//        let managedContext = appDelegate.managedObjectContext
//        
//        //2
//        let entity =  NSEntityDescription.entityForName("RecentlyViewed",
//                                                        inManagedObjectContext:managedContext)
//        
//        let recentsearch = NSManagedObject(entity: entity!,
//                                           insertIntoManagedObjectContext: managedContext)
//        
//        //3
//        recentsearch.setValue(showPrc, forKey: "showPerc")
//        recentsearch.setValue(percnt, forKey: "percentage")
//        recentsearch.setValue(Desc, forKey: "desc")
//        recentsearch.setValue(sku, forKey: "sku")
//        recentsearch.setValue(netPrice, forKey: "netPrice")
//        recentsearch.setValue(grossPrice, forKey: "grossPrice")
//        recentsearch.setValue(imageURLHigh, forKey: "imageURLHigh")
//        
//        
//        //4
//        do {
//            try managedContext.save()
//            let appDelegate =
//                UIApplication.sharedApplication().delegate as! AppDelegate
//            
//            let managedContext = appDelegate.managedObjectContext
//            
//            //2
//            let fetchRequest = NSFetchRequest(entityName: "RecentlyViewed")
//            
//            // 3
//            do {
//                let results =
//                    try managedContext.executeFetchRequest(fetchRequest)
//                if let people : [NSManagedObject] = results as? [NSManagedObject]
//                {
//                    for searchstring in people
//                    {
//                        print(searchstring.valueForKey("desc")!)
//                        print(searchstring.valueForKey("sku"))
//                        print(searchstring.valueForKey("netPrice"))
//                        print(searchstring.valueForKey("grossPrice"))
//                        print(searchstring.valueForKey("imageURLHigh"))
//                        
//                        let str  = searchstring.valueForKey("desc") as! String
//                        
//                        // data1.append(str)
//                        
//                        //data1.append(s)
//                    }
//                    //                    print(data1)
//                    //                    filteredData = data1
//                    //                    tableView.reloadData()
//                }
//                //                data.append(people)
//            } catch let error as NSError {
//                print("Could not fetch \(error), \(error.userInfo)")
//            }
//            
//        } catch let error as NSError
//        {
//            print("Could not save \(error), \(error.userInfo)")
//        }
//    }
    func saveName( sku: String)
    {
        
        print("\(sku)")
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("RecentlyViewed",
                                                        inManagedObjectContext:managedContext)
        
        let recentsearch = NSManagedObject(entity: entity!,
                                           insertIntoManagedObjectContext: managedContext)
        
        //3
//        recentsearch.setValue(showPrc, forKey: "showPerc")
//        recentsearch.setValue(percnt, forKey: "percentage")
//        recentsearch.setValue(Desc, forKey: "desc")
        recentsearch.setValue(sku, forKey: "sku")
//        recentsearch.setValue(netPrice, forKey: "netPrice")
//        recentsearch.setValue(grossPrice, forKey: "grossPrice")
//        recentsearch.setValue(imageURLHigh, forKey: "imageURLHigh")
        
        
        //4
        do {
            try managedContext.save()
            let appDelegate =
                UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            //2
            let fetchRequest = NSFetchRequest(entityName: "RecentlyViewed")
            
            // 3
            do {
                let results =
                    try managedContext.executeFetchRequest(fetchRequest)
                if let people : [NSManagedObject] = results as? [NSManagedObject]
                {
                    for searchstring in people
                    {
//                        print(searchstring.valueForKey("desc")!)
                        print(searchstring.valueForKey("sku"))
//                        print(searchstring.valueForKey("netPrice"))
//                        print(searchstring.valueForKey("grossPrice"))
//                        print(searchstring.valueForKey("imageURLHigh"))
//                        
//                        let str  = searchstring.valueForKey("desc") as! String
                        
                        // data1.append(str)
                        
                        //data1.append(s)
                    }
                    //                    print(data1)
                    //                    filteredData = data1
                    //                    tableView.reloadData()
                }
                //                data.append(people)
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
            
        } catch let error as NSError
        {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        
               textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChange(textField: UITextField) {
        
        self.pincodestatuslbl.textColor = UIColor (red: 8.0/255.0, green: 100.0/255.0, blue: 3.0/255.0, alpha: 1.0)
         self.pincodestatuslbl.text = "Enter Pincode to check availability"
    }
    
    
    @IBAction func pincodechk(sender: AnyObject) {
        
        
          //  Crashlytics.sharedInstance().crash()
        let pincode1 = self.pincode.text!
        let productprice = self.pricelabel.text!
        //  self.checkBtn.userInteractionEnabled = false
        
//        if self.pincode.text!.isEmpty {
//            self.pincodestatuslbl.textColor = UIColor (red: 8.0/255.0, green: 100.0/255.0, blue: 3.0/255.0, alpha: 1.0)
//            
//            self.pincodestatuslbl.text = "Enter Pincode to check availability"
//        }
//       else
            if self.pincode.text!.characters.count != 6 && self.pincode.text?.characters.count >= 0
            {
            self.pincodestatuslbl.textColor = UIColor.redColor()
            
            self.pincodestatuslbl.text = "Invalid Pincode"
        }
        else
        {
           // self.pincodestatuslbl.textColor = UIColor (red: 8.0/255.0, green: 100.0/255.0, blue: 3.0/255.0, alpha: 1.0)
            //  self.pincodestatuslbl.text = "Enter pincode to check availability"
            
            
            if let ntprice = self.nprice
            {
            
            let trimmedProductprice = self.nprice.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            let  text2 = self.nprice.stringByReplacingOccurrencesOfString("₹", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            var trimmedProductprice1 = text2.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            print(trimmedProductprice1)
            
            print(pincode1)
            print(trimmedProductprice)
            
            let headers = [
                "Authorization": authorizationWithoutLogin,
                "Content-Type": "application/json"
            ]
        //  http://immarketapi-stg2
            
            if(trimmedProductprice1 == "Price Not Available"){
                trimmedProductprice1 = ""
            }
            var url : NSURL!
            url = NSURL(string:"\(baseUrl)address?pincode=\(pincode1)&total=\(trimmedProductprice1)&stateCode=MH&expand=1")
            
            Alamofire.request(.GET, url!, headers: headers)
                .validate(contentType: ["application/json"])
                
                .responseJSON { response in
                    print(response.result)
                     print(response)
                    if let JSON = response.result.value
                    {
                        
                        if let COD : AnyObject  = JSON["isCOD"]
                        {
                            
                            let codstr = "\(COD)"
                            
                            print("COD:\(codstr)")
                            if let isdelievraable: AnyObject  = JSON["isDeliverable"]
                            {
                                
                                
                                let freeDeliverystr = "\(isdelievraable)"
                                print("DELIVERIABLE:\(freeDeliverystr)")
                                
                                if (codstr == "1"  && freeDeliverystr == "1")
                                {
                                    self.pincodestatuslbl.textColor = UIColor (red: 8.0/255.0, green: 100.0/255.0, blue: 3.0/255.0, alpha: 1.0)
                                    self.pincodestatuslbl.text = "COD | Free Delivery"
                                    self.checkBtn.userInteractionEnabled = true
                                }
                                    
                                else if(codstr == "1"  && freeDeliverystr == "0")
                                {
                                    self.pincodestatuslbl.textColor = UIColor (red: 8.0/255.0, green: 100.0/255.0, blue: 3.0/255.0, alpha: 1.0)
                                    self.pincodestatuslbl.text = "COD"
                                    self.checkBtn.userInteractionEnabled = true
                                }
                                    
                                else if(codstr == "0"  && freeDeliverystr == "1")
                                {
                                    self.pincodestatuslbl.textColor = UIColor (red: 8.0/255.0, green: 100.0/255.0, blue: 3.0/255.0, alpha: 1.0)
                                    self.pincodestatuslbl.text = "Free Delivery"
                                    self.checkBtn.userInteractionEnabled = true
                                }else if(codstr == "0"  && freeDeliverystr == "0"){
                                    self.pincodestatuslbl.textColor = UIColor (red: 227.0/255.0, green: 0, blue: 2.0/255.0, alpha: 1.0)
                                    self.pincodestatuslbl.text = "Product cannot be delivered."
                                    self.checkBtn.userInteractionEnabled = true
                                }
                                
                                
                            }
                        }
                        
                        
                    }
                    
                    
            }
            
        }
            else
            {
            
                self.pincodestatuslbl.textColor = UIColor (red: 227.0/255.0, green: 0, blue: 2.0/255.0, alpha: 1.0)
                self.pincodestatuslbl.text = "Product cannot be delivered."
                self.checkBtn.userInteractionEnabled = true
            
            }
            
            
        }
    }
    
    func update() {
        
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:"onContentSizeChange:",
                                                         name: UIContentSizeCategoryDidChangeNotification,
                                                         object: nil)
        // self.tbl1.reloadData()
        
    }
    override func viewDidAppear(animated: Bool) {
       // self.tbl1.rowHeight = UITableViewAutomaticDimension
       // self.tbl1.estimatedRowHeight = 20
        
        // self.tbl1.reloadData()
        self.view.setNeedsDisplay()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
    }
    
    func imageClick(sender:UITapGestureRecognizer){
        let imageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("previewVC") as! PreviewViewController
//        let imageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("imgSlider") as! ImageSliderViewController
      //  self.navigationController?.pushViewController(imageViewController, animated: true)
       // let LoginViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("freebieVC") as? FreebieViewController
        imageViewController.slideImgArray = self.contentImages.mutableCopy() as! NSArray
        let NavigationController = UINavigationController(rootViewController: imageViewController)
        self.presentViewController(NavigationController, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.title = "IMOL"
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(ViewController.getOtherReview(_:)),
                                                         name: "othersReview",
                                                         object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(ViewController.getOtherReviewFail(_:)),
                                                         name: "othersReviewFail",
                                                         object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(ViewController.getmyReview(_:)),
                                                         name: "myReview",
                                                         object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(ViewController.addmyReview(_:)),
                                                         name: "addReview",
                                                         object: nil)
        //othersReviewFail
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]

        
        self.tabBarController?.tabBar.hidden = true
        
         self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        
         NSNotificationCenter.defaultCenter().removeObserver(self, name: "buylocal", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(ViewController.buynowSendToServer(_:)),
                                                         name:"buylocal",
                                                         object: nil)
        
        
        prodCollectionView.translatesAutoresizingMaskIntoConstraints = true
        prodCollectionView.frame = CGRectMake(0, 47.0, boundss.width, 200.0)
        
//        pricelabel.translatesAutoresizingMaskIntoConstraints = true
//        pricelabel.frame = CGRectMake(8, 63, 180, 16)
        
        if(screenSize.width == 320){
        QtyBtn.translatesAutoresizingMaskIntoConstraints = true
        QtyBtn.frame = CGRectMake(72, 8, 46, 25)
        QtyBtn.titleLabel?.font = UIFont(name: "MyriadPro-Regular", size: 14.0)

            
        }

        allReviewBtn.titleLabel?.textAlignment = NSTextAlignment.Center
        
        registerKeyboardNotifications()
        ratingScroll.alwaysBounceHorizontal = false
        
        QtyBtn.hidden = true
        
        pincode.attributedPlaceholder = NSAttributedString(string: "Pincode", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        
//        if let imagelist  = forecast["imageGalleryURLHigh"] as? NSMutableArray
//        {
//            for imagelink in imagelist
//            {
//                self.imagelinkArr.addObject(imagelink)
//            }
//            print(self.imagelinkArr)
//            if(self.imagelinkArr.count > 0){
//                self.bannerView.hidden = false
//                self.contentImages = NSArray.init(array: self.imagelinkArr)
//                self.pageController = UIPageViewController()
//                self.createPageViewController()
//                self.setupPageControl()
//            }else{
//                self.bannerView.hidden = true
//            }
//            
//            
//            
//        }
//        else
//        {
//            if(self.imagelinkArr.count == 0){
//                self.bannerView.hidden = true
//            }else{
//                self.bannerView.hidden = false
//            }
//   
        if(self.imagelinkArr.count > 0){
            self.setupPageControl()
        }
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        
//        dispatch_async(dispatch_get_main_queue()) {
//            self.tbl1.layoutIfNeeded()
//            //
//            let testSize : CGSize = CGSizeMake(self.tbl1.bounds.size.width, CGFloat.max)
//            let tableHeight : CGFloat = self.tbl1.sizeThatFits(testSize).height
//            //            print(tableHeight)
//            self.tableViewHeightConstraint.constant = tableHeight
//            //
//            self.view.layoutIfNeeded()
//            //
//            self.containerViewHeightConstraint.constant = tableHeight + self.innerVc.frame.size.height  // this is the fixed height of the image
//            //
//            self.view.layoutIfNeeded()
//            //
//            self.tbl1.reloadData()
//            
//        }
//        
//        self.descView.setContentOffset(CGPointZero, animated: false)
        
    }
    
//    private func onContentSizeChange(notification: NSNotification) {
//        
//        self.tbl1.reloadData()
//    }
//    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        
//        return self.sheader [section].uppercaseString
//        
//    }
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int
//    {
//        
//        return self.sheader.count
//    }
//    
//    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
//    {
//        var title = UILabel()
//        //title.frame = CGRectMake(-80, 0, 100, 30)
//        title.font = UIFont(name: "Myriad Pro", size: 12)!
//        title.textColor = UIColor (red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
//        
//        let header = view as! UITableViewHeaderFooterView
//        // header.frame   = CGRectMake(0, 0, 100, 30)
//        header.textLabel?.font=title.font
//        header.textLabel?.textColor=title.textColor
//        header.contentView.backgroundColor = UIColor .whiteColor()
//    }
//    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if(self.rowsinheader [section ].count ==  0){
//            return 0.0
//        }
//        return 23.0
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        // return self.items [section ].count
//        
//        
//        return self.rowsinheader [section ].count
//        
//    }
//    
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        tableView.registerNib(UINib(nibName: "CustomViewCell", bundle: nil), forCellReuseIdentifier:"cell")
//        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomViewCell
//        
//        cell.selectionStyle = UITableViewCellSelectionStyle.None
//        
//        // cell.lbl.text = self.items[indexPath.section][indexPath.row]
//        cell.lbl.text = self.rowsinheader[indexPath.section][indexPath.row]
//        var myString: String = self.rowsinheader[indexPath.section][indexPath.row]
//        var myStringArr = myString.componentsSeparatedByString(":")
//        
//        
//        let a =  myStringArr [1]
//        let b =  myStringArr [0]
//        
//        let first = "    " + a
//        let second = "    " + b
//        
//        cell.lbl.text =  "     " + myStringArr [1]
//        cell.valuelbl.text = "     " + myStringArr [0]
//        
//        cell.bounds = CGRect(x: 0, y: 0, width: CGRectGetWidth(tableView.bounds), height: 99999)
//        cell.contentView.bounds = cell.bounds
//        cell.layoutIfNeeded()
//        
//        cell.lbl.preferredMaxLayoutWidth = CGRectGetWidth(cell.lbl.frame)
//        cell.valuelbl.preferredMaxLayoutWidth = CGRectGetWidth(cell.valuelbl.frame)
//        
//        
//        cell.contentView.layer.borderWidth = 0.4
//        cell.contentView.layer.borderColor = UIColor (red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0).CGColor
//        return cell
//    }
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
//    {
//        
//        //         self.prototypeCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(self.prototypeCell.bounds));
//        return tableView.estimatedRowHeight//Choose your custom row height
//    }
//    func numberOfItemsInCarousel(carousel: iCarousel) -> Int
//    {
//        
//        return self.imageArr1.count
//    }
//    
//    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView
//    {
//        var label: UILabel
//        var itemView: UIImageView
//        
//        //create new view if no view is available for recycling
//        if (view == nil)
//        {
//            itemView = UIImageView(frame:CGRect(x:0, y:0, width:350, height:300))
//            itemView.image = self.imageArr1[index]
//            //itemView.image = self.image
//            itemView.backgroundColor = UIColor.clearColor()
//            itemView.contentMode = .Center
//            
//            label = UILabel(frame:itemView.bounds)
//            label.backgroundColor = UIColor.clearColor()
//            label.textColor =  UIColor.clearColor()
//            label.textAlignment = .Center
//            label.font = label.font.fontWithSize(50)
//            label.tag = 1
//            itemView.addSubview(label)
//        }
//        else
//        {
//            //get a reference to the label in the recycled view
//            itemView = view as! UIImageView;
//            label = itemView.viewWithTag(1) as! UILabel!
//        }
//        
//        //set item label
//        //remember to always set any properties of your carousel item
//        //views outside of the `if (view == nil) {...}` check otherwise
//        //you'll get weird issues with carousel item content appearing
//        //in the wrong place in the carousel
//        label.text = "\(itemcarousel[index])"
//        
//        return itemView
//    }
//    
//    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
//    {
//        if (option == .Spacing)
//        {
//            return value * 1.1
//        }
//        return value
//    }
    
    @IBAction func seleactQuantity(sender: AnyObject) {
        
        
        let alert = UIAlertController(title: ConstantsFile.selectQty_msg, message:"", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "1", style: UIAlertActionStyle.Default, handler:  { (action) -> Void in
            self.QtyBtn.setTitle("Qty:1", forState: UIControlState.Normal)
        }))
        alert.addAction(UIAlertAction(title: "2", style: UIAlertActionStyle.Default, handler:{ (action) -> Void in
            self.QtyBtn.setTitle("Qty:2", forState: UIControlState.Normal)
        }))
        alert.addAction(UIAlertAction(title: "3", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.QtyBtn.setTitle("Qty:3", forState: UIControlState.Normal)
        }))
        alert.addAction(UIAlertAction(title: "4", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.QtyBtn.setTitle("Qty:4", forState: UIControlState.Normal)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        switch buttonIndex{
        case 0:
            self.checkBtn.setTitle("Qty:1", forState: UIControlState.Normal)
        case 1:
            self.checkBtn.setTitle("Qty:2", forState: UIControlState.Normal)
        case 2:
            self.checkBtn.setTitle("Qty:3", forState: UIControlState.Normal)
        case 3:
            self.checkBtn.setTitle("Qty:4", forState: UIControlState.Normal)
        default:
            print("cancel")
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerDataSource[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        // self.qtyPickerView.hidden = true
        //        if(row == 0)
        //        {
        //            self.view.backgroundColor = UIColor.whiteColor();
        //        }
        //        else if(row == 1)
        //        {
        //            self.view.backgroundColor = UIColor.redColor();
        //        }
        //        else if(row == 2)
        //        {
        //            self.view.backgroundColor =  UIColor.greenColor();
        //        }
        //        else
        //        {
        //            self.view.backgroundColor = UIColor.blueColor();
        //        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool
    {
        print(string)
        print(textField.text?.characters.count)
        if textField.text!.characters.count == 1 {
            self.pincodestatuslbl.textColor = UIColor (red: 8.0/255.0, green: 100.0/255.0, blue: 3.0/255.0, alpha: 1.0)
            
            self.pincodestatuslbl.text = "Enter Pincode to check availability"
        }
        var maxLength = 6
        
        if (textField == self.titileLbl) {
            maxLength = 100;
        }
        else if  (textField == self.decrLbl)
        {
            maxLength = 500;
        }
        let currentString: NSString = textField.text!
        let newString: NSString =
            currentString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength
    }
    
    @IBAction func SellerBtnClick(sender: AnyObject)
    {
        self.productDict=NSMutableDictionary()
        if let np = self.netPrc {
            self.productDict.setValue(Int(np), forKey: "placedPrice")
        }
        var qnt = self.QtyBtn.titleLabel?.text
        var arqnt = qnt?.componentsSeparatedByString(":")
        qnt = arqnt![1]
        qnt = qnt!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        self.productDict.setValue(qnt, forKey: "quantity")
        self.productDict.setValue(self.skuNumber, forKey: "productId")
        self.productDict.setValue(self.vendorPartNumber, forKey: "vendorPartNumber")
        
         print("net price \(self.netPrc.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil))")
        print("net price \(self.netPrc.stringByReplacingOccurrencesOfString(".00", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil))")
        let str = self.netPrc.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
         let str2 = str.stringByReplacingOccurrencesOfString(".00", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
       // var a = Int(self.netPrc)
         var a = Int(str2)
        var b = Int(qnt!)
        print("price \(a) qnt \(b)")
        let exprsdf = a! * b! as Int
        self.productDict.setValue(exprsdf, forKey: "extendedPrice")
        self.productDict.setValue("hp", forKey: "vendorCode")
        self.productDict.setValue(self.productName.text, forKey: "description")
        self.productDict.setValue(self.imageURLMedium, forKey: "imageURLMedium")
        self.productDict.setValue(self.sellerName, forKey: "sellerName")
        self.productDict.setValue(self.sellerNumber, forKey: "sellerNumber")
        self.productDict.setValue(self.skuno, forKey: "skuNumber")
        self.productDict.setValue(self.limitedStock, forKey: "limitedStock")
        self.productDict.setValue(self.maximumQuantity, forKey: "maximumQuantity")
        self.productDict.setValue(self.availabilty, forKey: "avaliableQuantity")
        self.productDict.setValue("", forKey: "modifiedBy")
        self.tabBarController?.tabBar.hidden = false
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "buylocal", object: nil)
        let mapViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("ResellerView") as? ResellerViewController
        mapViewControllerObj?.productDictin = self.productDict
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
        
        
    }
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("1234567890".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addTocartClk(){
        if(self.addToCartBtn.titleLabel?.text == "GO TO CART"){
            self.navigationController?.popViewControllerAnimated(true)
            self.tabBarController?.selectedIndex = 2
        }else{
        
         dataLayer.push(["event": "ButtonPressed", "eventAction": "add to cart clicked ios"])
        var window :UIWindow = UIApplication.sharedApplication().keyWindow!
        LoadingOverlay.shared.showOverlay(window)
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true)
        {
        isClick="cart"
        self.productDict=NSMutableDictionary()
        if let np = self.netPrc {
            self.productDict.setValue(Int(np), forKey: "placedPrice")
        }
        var qnt = self.QtyBtn.titleLabel?.text
        var arqnt = qnt?.componentsSeparatedByString(":")
        qnt = arqnt![1]
        qnt = qnt!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        self.productDict.setValue(qnt, forKey: "quantity")
        self.productDict.setValue(self.skuNumber, forKey: "productId")
        self.productDict.setValue(self.vendorPartNumber, forKey: "vendorPartNumber")
        print("net price \(self.netPrc)")
             print("price label \(self.pricelabel.text)")
        var a = Int(self.netPrc)
        var b = Int(qnt!)
        print("price \(a) qnt \(b)")
        let exprsdf = a! * b! as Int
        self.productDict.setValue(exprsdf, forKey: "extendedPrice")
        //self.productDict.setValue(self.pricelabel.text, forKey: "extendedPrice")
        self.productDict.setValue("hp", forKey: "vendorCode")
        self.productDict.setValue(self.productName.text, forKey: "description")
        self.productDict.setValue(self.imageURLMedium, forKey: "imageURLMedium")
        self.productDict.setValue(self.sellerName, forKey: "sellerName")
        self.productDict.setValue(self.sellerNumber, forKey: "sellerNumber")
        self.productDict.setValue(self.skuno, forKey: "skuNumber")
        self.productDict.setValue(self.limitedStock, forKey: "limitedStock")
        self.productDict.setValue(self.maximumQuantity, forKey: "maximumQuantity")
        self.productDict.setValue(self.availabilty, forKey: "avaliableQuantity")
        self.productDict.setValue("", forKey: "modifiedBy")
          //   self.productDict.setValue("y", forKey: "runSalesOrder")
        //"runSalesOrder":"y"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId"){
            
                let wsm : WebServiceClass = WebServiceClass.sharedInstance
                wsm.delegates=self
                wsm.addToBasketOnlineDetails(usernm as! Int, sitecode: "IN", productDet: self.productDict)
        }else{
            LoadingOverlay.shared.hideOverlayView()
            print("sku no  \(skuno)")
            addToLocalcart(Int(self.netPrc)!, quantity: qnt!, productId: self.skuNumber, vendorPartNumber: self.vendorPartNumber as String, extendedPrice: exprsdf, vendorCode: self.vendorCode as String, description: self.productName.text!, imageURLMedium: self.imageURLMedium as String, sellerName: self.sellerName, sellerNumber: self.sellerNumber as String, limitedStock: self.limitedStock, maximumQuantity: self.maximumQuantity, availabilty: self.availabilty, skuNumber: self.skuno,prodDic: self.productDict,basketId: "",lineItemId: "",cartprice : self.priceforcart!)
            
            // addToLocalcart(prc as! Int, quantity: String(qnt), productId: String(productDictin["productId"]!), vendorPartNumber: String(productDictin["vendorPartNumber"]!), extendedPrice: exprsdf, vendorCode: String(productDictin["vendorCode"]!), description: String(productDictin["description"]!), /Users/administrator/Documents/MarketPlaceNew_2phase/Archive/scrolltableView/scrolltableView/ViewController.swiftimageURLMedium: "", sellerName: String(productDictin["sellerName"]!), sellerNumber: String(productDictin["sellerNumber"]!), limitedStock:limitedStock , maximumQuantity: maximumQuantity, availabilty: avaliableQuantity1, skuNumber: String(productDictin["skuNumber"]!),prodDic: productDictin,basketId: "",lineItemId: "")
            self.addCrtBtn.setTitle("GO TO CART", forState: UIControlState.Normal)
//            let alertView:UIAlertView = UIAlertView()
//            alertView.title = ""
//            alertView.message = "Product added to cart."
//            alertView.delegate = nil
//            alertView.addButtonWithTitle("OK")
//            alertView.show()
            
//            self.navigationController?.popViewControllerAnimated(true)
//            tabBarController?.selectedIndex = 2
        }
        }else{
            LoadingOverlay.shared.hideOverlayView()
            let alertView:UIAlertView = UIAlertView()
            alertView.title = ""
            alertView.message = ConstantsFile.noInternet_msg
            alertView.delegate = nil
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        }
        
    }
    @IBAction func buyNowClk(){
        var window :UIWindow = UIApplication.sharedApplication().keyWindow!
         dataLayer.push(["event": "ButtonPressed", "eventAction": "buy now clicked ios"])
        LoadingOverlay.shared.showOverlay(window)
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true)
        {
        isClick="buynow"
        self.productDict=NSMutableDictionary()
        if let np = self.netPrc {
            self.productDict.setValue(Int(np), forKey: "placedPrice")
        }
        var qnt = self.QtyBtn.titleLabel?.text
        var arqnt = qnt?.componentsSeparatedByString(":")
        qnt = arqnt![1]
        qnt = qnt!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        self.productDict.setValue(qnt, forKey: "quantity")
        self.productDict.setValue(self.skuNumber, forKey: "productId")
        self.productDict.setValue(self.vendorPartNumber, forKey: "vendorPartNumber")
        print("net price \(self.netPrc)")
        var str = self.netPrc.stringByReplacingOccurrencesOfString(",", withString: "")
            str = str.stringByReplacingOccurrencesOfString(".00", withString: "")
        var a = Int(str)
        
            
        var b = Int(qnt!)
        print("price \(a) qnt \(b)")
        let exprsdf = a! * b! as Int
        self.productDict.setValue(exprsdf, forKey: "extendedPrice")
        self.productDict.setValue("hp", forKey: "vendorCode")
        self.productDict.setValue(self.productName.text, forKey: "description")
        self.productDict.setValue(self.imageURLMedium, forKey: "imageURLMedium")
        self.productDict.setValue(self.sellerName, forKey: "sellerName")
        self.productDict.setValue(self.sellerNumber, forKey: "sellerNumber")
        self.productDict.setValue(self.skuno, forKey: "skuNumber")
        self.productDict.setValue(self.limitedStock, forKey: "limitedStock")
        self.productDict.setValue(self.maximumQuantity, forKey: "maximumQuantity")
        self.productDict.setValue(self.availabilty, forKey: "avaliableQuantity")
        self.productDict.setValue("", forKey: "modifiedBy")
         self.productDict.setValue("y", forKey: "runSalesOrder")
       
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId"){
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
            wsm.addToBasketOnlineDetails(usernm as! Int, sitecode: "IN", productDet: self.productDict)
        }else{
//             NSNotificationCenter.defaultCenter().removeObserver(self, name: "buynowlocal", object: nil)
           
            LoadingOverlay.shared.hideOverlayView()
            let LoginViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("LoginView") as? LoginView
            LoginViewControllerObj?.isCalledFrm = "buynow"
            let NavigationController = UINavigationController(rootViewController: LoginViewControllerObj!)
            
            self.presentViewController(NavigationController, animated: true, completion: nil)
        }
        }else{
            LoadingOverlay.shared.hideOverlayView()
            let alertView:UIAlertView = UIAlertView()
            alertView.title = ""
            alertView.message = ConstantsFile.noInternet_msg
            alertView.delegate = nil
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
    }
    func buynowSendToServer(notification:NSNotification){
       // let string : AnyObject = notification.userInfo!
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId"){
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
             var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            wsm.addToBasketOnlineDetails(usernm as! Int, sitecode: "IN", productDet: self.productDict)
        }
    }
    @IBAction func allReviewBtnClk(){
        let LoginViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("reviewVC") as? ReviewRatingViewController
    
        LoginViewControllerObj?.mpn = self.vendorPartNumber as String
        self.navigationController?.pushViewController(LoginViewControllerObj!, animated: true)
    }
    func addToLocalcart(placedPrice:Int,quantity:String,productId:String,vendorPartNumber:String,extendedPrice:Int,vendorCode:String,description:String,imageURLMedium:String,sellerName:String,sellerNumber:String,limitedStock:Int,maximumQuantity:Int,availabilty:Int,skuNumber:String,prodDic:NSMutableDictionary,basketId:String,lineItemId:String,cartprice : String)  {
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        var placePrice = 2000000
        let managedContext = appDelegate.managedObjectContext
        let searchpredicate = NSPredicate(format: "skuNumber == %@",self.skuno)
        let searchpredicate1 = NSPredicate(format: "sellerName == %@",self.sellerName)
        var compound = NSCompoundPredicate.init(andPredicateWithSubpredicates:[searchpredicate,searchpredicate1])
        let fetchRequest = NSFetchRequest(entityName: "MyCart")
        fetchRequest.predicate = compound
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            if let people : [NSManagedObject] = results as? [NSManagedObject]
            {
                if (people .isEmpty)
                {
                    
                    let entity =  NSEntityDescription.entityForName("MyCart",
                                                                    inManagedObjectContext:managedContext)
                    
                    let recentsearch = NSManagedObject(entity: entity!,
                                                       insertIntoManagedObjectContext: managedContext)
                    
                    //3
                    print(self.pricelabel.text)
                    recentsearch.setValue(placedPrice, forKey: "placedPrice")
                    recentsearch.setValue(cartprice, forKey: "cartPrice")
                    //recentsearch.setValue(self.pricelabel.text, forKey: "placedPrice")
                    recentsearch.setValue(quantity, forKey: "quantity")
                    recentsearch.setValue(productId, forKey: "productId")
                    recentsearch.setValue(vendorPartNumber, forKey: "vendorPartNumber")
                    recentsearch.setValue(extendedPrice, forKey: "extendedPrice")
                    recentsearch.setValue(vendorCode, forKey: "vendorCode")
                    recentsearch.setValue(description, forKey: "mdescription")
                    
                    recentsearch.setValue(imageURLMedium, forKey: "imageURLMedium")
                    recentsearch.setValue(sellerName, forKey: "sellerName")
                    recentsearch.setValue(sellerNumber, forKey: "sellerNumber")
                    recentsearch.setValue(limitedStock, forKey: "limitedStock")
                    recentsearch.setValue(maximumQuantity, forKey: "maximumQuantity")
                    recentsearch.setValue(availabilty, forKey: "availabilty")
                    recentsearch.setValue(self.prodStr, forKey: "allData")
                    recentsearch.setValue(skuNumber, forKey: "skuNumber")
                  
                    do {
                        try managedContext.save()
                        
                        
                    } catch let error as NSError  {
                        print("Could not save \(error), \(error.userInfo)")
                    }
                }  else
                {
                    let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//                    let context:NSManagedObjectContext = appDel.managedObjectContext
//                    context.deleteObject(people.last!)
                    let person = results[0] as! NSManagedObject
                    var qnt:String!=""
                    if let qntt = person.valueForKey("quantity") as? String{
                       qnt = person.valueForKey("quantity") as! String
                    }

                    var qnty:Int = Int(qnt)!
                    qnty = qnty + 1
                    do {
                        print(placedPrice)
                        person.setValue(placedPrice, forKey: "placedPrice")
                        person.setValue(cartprice, forKey: "cartPrice")
                       // person.setValue(self.pricelabel.text, forKey: "placedPrice")
                        person.setValue(String(qnty), forKey: "quantity")
                        person.setValue(productId, forKey: "productId")
                        person.setValue(vendorPartNumber, forKey: "vendorPartNumber")
                        person.setValue(extendedPrice, forKey: "extendedPrice")
                        person.setValue(vendorCode, forKey: "vendorCode")
                        person.setValue(description, forKey: "mdescription")
                        
                        person.setValue(imageURLMedium, forKey: "imageURLMedium")
                        person.setValue(sellerName, forKey: "sellerName")
                        person.setValue(sellerNumber, forKey: "sellerNumber")
                        person.setValue(limitedStock, forKey: "limitedStock")
                        person.setValue(maximumQuantity, forKey: "maximumQuantity")
                        person.setValue(availabilty, forKey: "availabilty")
                        person.setValue(skuNumber, forKey: "skuNumber")
                        person.setValue(self.prodStr, forKey: "allData")
                      
                        do {
                            try managedContext.save()
                            
                            
                        } catch let error as NSError  {
                            print("Could not save \(error), \(error.userInfo)")
                        }
                        
                    } catch _ {
                        
                    }
                 
                }
            
            }
            let appDelegate =
                UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            //2
            let fetchRequest = NSFetchRequest(entityName: "MyCart")
            
            // 3
            do {
                let results =
                    try managedContext.executeFetchRequest(fetchRequest)
                if let people : [NSManagedObject] = results as? [NSManagedObject]
                {
                    let tabArray = self.tabBarController?.tabBar.items as NSArray!
                    let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
                    tabItem.badgeValue = String(people.count)
                    if(tabItem.badgeValue == "0" || tabItem.badgeValue == "" ){
                        tabItem.badgeValue = nil
                       
                        let defaults = NSUserDefaults.standardUserDefaults()
                        defaults.setObject("", forKey: "badge")
                    }else{
                        let defaults = NSUserDefaults.standardUserDefaults()
                        defaults.setObject(String(people.count), forKey: "badge")
                        
                    }
 
                 }
                //                data.append(people)
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    
    
    }
    
    func addTocartSuccess(string:NSDictionary)
    {
        if(isClick == "buynow"){
            if let cnt = string.valueForKey("lineCount") as? String{
                //  if(){
                let tabArray = self.tabBarController?.tabBar.items as NSArray!
                let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
                tabItem.badgeValue = cnt
                if(tabItem.badgeValue == "0" || tabItem.badgeValue == ""){
                    tabItem.badgeValue = nil
                      let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.removeObjectForKey("badge")
                }else{
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setObject(cnt, forKey: "badge")
                }
                // }
            }
            let chkVC = self.storyboard?.instantiateViewControllerWithIdentifier("checkoutVc") as! CheckoutViewController
            var qnt = self.QtyBtn.titleLabel?.text
            var arqnt = qnt?.componentsSeparatedByString(":")
            qnt = arqnt![1]
            qnt = qnt!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            self.productDict.setValue(qnt, forKey: "quantity")
            self.productDict.setValue(self.skuNumber, forKey: "productId")
            self.productDict.setValue(self.vendorPartNumber, forKey: "vendorPartNumber")
            print("net price \(self.netPrc)")
            let a = Int(self.netPrc!)
            let b = Int(qnt!)
            print("price \(a!) qnt \(b!)")
            let exprsdf = a! * b!
             // chkVC.TotalPrice = "₹ \(String(exprsdf))"
            if let totalstring = string.valueForKey("buyNowGrossTotalDisplayString") as? String{
            chkVC.TotalPrice = "₹ \(totalstring)"
            }
           chkVC.netAmount = self.netPrc
            chkVC.sellerNo = "\(sellerNumber)"
            chkVC.quantity = "\(qnt!)"
            chkVC.skuNo = "\(skuno)"
            chkVC.isCalled = "buy"
            chkVC.cartItemArray = NSArray()
            //   secondViewController.ratingfloat = 0
            
            self.navigationController?.pushViewController(chkVC, animated: true)
            
        }else{
        self.addCrtBtn.setTitle("GO TO CART", forState: UIControlState.Normal)

        if let cnt = string.valueForKey("lineCount") as? String{
          //  if(){
        let tabArray = self.tabBarController?.tabBar.items as NSArray!
        let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
        tabItem.badgeValue = cnt
            if(tabItem.badgeValue == "0" || tabItem.badgeValue == ""){
                tabItem.badgeValue = nil
                 let defaults = NSUserDefaults.standardUserDefaults()
                defaults.removeObjectForKey("badge")
            }else{
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(cnt, forKey: "badge")
            }
           // }
        }
        print(string.valueForKey("lineCount"))
        
        }
    }
    
   @IBAction func mycartDelegateFunction(sender:DOFavoriteButton){
    let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    if (appdelegate.isReachable == true){
        if sender.selected {
            // deselect
            sender.deselect()
            wishLstGlobalArray.removeObject(self.skuNumber)
            
            let alldta = wishLstGlobalArray.componentsJoinedByString(",") as NSString
           //  JHProgressHUD.sharedHUD.showInView(self.view)
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
            wsm.addToWishListDetails(alldta)
            
        } else {
            // select with animation
            wishLstGlobalArray.addObject(self.skuNumber)
            let alldta = wishLstGlobalArray.componentsJoinedByString(",") as NSString
            // JHProgressHUD.sharedHUD.showInView(self.view)
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
            wsm.addToWishListDetails(alldta)
            sender.select()
            
        }
    }else{
        let alertView:UIAlertView = UIAlertView()
        alertView.title = ""
        alertView.message = ConstantsFile.noInternet_msg
        alertView.delegate = nil
        alertView.addButtonWithTitle("OK")
        alertView.show()
    }
    }
     func addWishListSuccess(wishList:NSDictionary){
      LoadingOverlay.shared.hideOverlayView()
    }
    
    private func createPageViewController() {
        
        pageController.removeFromParentViewController()
        pageController.view.removeFromSuperview()
        pageController = UIPageViewController.init(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        //pageController
        // pageController.view.backgroundColor = UIColor.clearColor()
        pageController.view.sizeToFit()
        pageController.delegate = self
        pageController.dataSource = self
        
        if contentImages.count >= 0 {
            let firstController = getItemController(0)!
            // firstController.view.frame=CGRectMake(0, 0, boundss.width, self.bannerView.frame.size.height+40)
            let startingViewControllers = [firstController]
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        pageViewController!.view.frame = CGRectMake(0, 0, boundss.width, self.bannerView.frame.size.height+44)
        addChildViewController(pageViewController!)
        self.bannerView.addSubview(pageViewController!.view)
        //view.bringSubviewToFront(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func setupPageControl() {
        if(contentImages.count <= 1){
            let appearance = UIPageControl.appearance()
            
            appearance.pageIndicatorTintColor = UIColor.clearColor()
            appearance.currentPageIndicatorTintColor = UIColor.clearColor()
            
            appearance.backgroundColor = UIColor.clearColor()
            appearance.bounds = CGRectMake(0, 30, 0, 0)

        }else{
            let appearance = UIPageControl.appearance()
            
            appearance.pageIndicatorTintColor = UIColor.lightGrayColor()
            appearance.currentPageIndicatorTintColor = bluedarkColor
            
            appearance.backgroundColor = UIColor.clearColor()
            appearance.bounds = CGRectMake(0, 30, 0, 0)

        }
            }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! NewPageItemController
        itemController.view.translatesAutoresizingMaskIntoConstraints = true
        itemController.view.frame=CGRectMake(0, 0, boundss.width, self.bannerView.frame.size.height)
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }else{
            return getItemController(contentImages.count-1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! NewPageItemController
        itemController.view.translatesAutoresizingMaskIntoConstraints = true
        itemController.view.frame=CGRectMake(0, 0, boundss.width, self.bannerView.frame.size.height)
        if itemController.itemIndex+1 < contentImages.count {
            return getItemController(itemController.itemIndex+1)
        }else{
            return getItemController(0)
        }
        
        return nil
    }
    
    private func getItemController(itemIndex: Int) -> NewPageItemController? {
        
        if itemIndex < contentImages.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemControllerNew") as! NewPageItemController
            pageItemController.view.translatesAutoresizingMaskIntoConstraints = true
            pageItemController.view.frame=CGRectMake(0, 0, boundss.width, self.bannerView.frame.size.height)
            pageItemController.contentImageView!.translatesAutoresizingMaskIntoConstraints = true
            pageItemController.contentImageView!.frame=CGRectMake(0, 0, boundss.width, pageItemController.view.frame.size.height)
            pageItemController.itemIndex = itemIndex
            if(contentImages.count > 0){
                pageItemController.imageName = contentImages[itemIndex] as! String

            }else{
               // pageItemController.imageName = contentImages[itemIndex] as! String

            }
                        // pageItemController.view.backgroundColor = UIColor.yellowColor()
            //pageViewController?.view.backgroundColor = UIColor.clearColor()
            pageItemController.view.bringSubviewToFront(pageItemController.contentImageView!)
            return pageItemController
        }
        
        return nil
    }
    
    // MARK: - Page Indicator
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        //if(contentImages.count > 0){
             return contentImages.count
       // }
     //  return 1
    }
    func setViewControllers(viewControllers: [UIViewController]?, direction: UIPageViewControllerNavigationDirection, animated: Bool, completion: ((Bool) -> Void)?){
        
    }
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
extension UITextField {
    
    func useUnderline() {
        
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.lightGrayColor().CGColor
        border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.similarProdArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("SimilarProduct", forIndexPath: indexPath) as! SimilarProdCollectionViewCell
        
      //  cell.ImgViewSimilarProd.image = UIImage(named: similProdImgArr[indexPath.row] as! String)
        var proddetail = similarProdArray.objectAtIndex(indexPath.row) as! NSDictionary
     
        
        cell.ImgViewSimilarProd.translatesAutoresizingMaskIntoConstraints = true
        cell.ImgViewSimilarProd.frame = CGRectMake(8, 8, 144, 105)
        
        
        cell.prodNameSimilarProd.translatesAutoresizingMaskIntoConstraints = true
        cell.prodNameSimilarProd.frame = CGRectMake(8, 123, 144, 21)

        cell.priceLbSimilarProd.translatesAutoresizingMaskIntoConstraints = true
        cell.priceLbSimilarProd.frame = CGRectMake(8, 154, 144, 21)

        
        //let url = similProdImgArr[indexPath.row] as! String
        let url =   proddetail["imageURLMedium"] as! String
        let imgURL: NSURL = NSURL(string: url)!
        print(imgURL.absoluteString)
        
        if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
        {
            print("IN cache")
            cell.ImgViewSimilarProd.image = image
            
        }
        else
        {
            Alamofire.request(.GET, imgURL)
                .responseImage { response in
                    debugPrint(response)
                    
                    print(response.request)
                    print(response.response)
                    debugPrint(response.result)
                    
                    
                    
                    
                    if let image = response.result.value {
                        print(imgURL.absoluteString)
                        cell.ImgViewSimilarProd.image = image
                        photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                    }
                    else
                    {
                        let image : UIImage = UIImage(named:"placeholder")!
                        cell.ImgViewSimilarProd.image = image
                        photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                    }
            }
        }

        
        //cell.prodNameSimilarProd.text = similarProdNameArr[indexPath.row] as! String
        cell.prodNameSimilarProd.text =  proddetail["description"] as! String
//        cell.priceLbSimilarProd.text = "₹ \(similarProdPriceArr[indexPath.row] as! String)"
        if let netpriceDisplayString  = proddetail["netPriceDisplayString"] as? String
        {
        if (proddetail["netPriceDisplayString"] as! String == "Price Not Available")
        {
        cell.priceLbSimilarProd.text = "\(proddetail["netPriceDisplayString"] as! String)"
        }
        else
        {
        cell.priceLbSimilarProd.text = "₹ \(proddetail["netPriceDisplayString"] as! String)"
        }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
         var proddetail = similarProdArray.objectAtIndex(indexPath.row) as! NSDictionary
        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("prodDet") as! ViewController
        secondViewController.skuNumber = proddetail["sku"] as! String
        secondViewController.ratingfloat = 0
        self.navigationController?.pushViewController(secondViewController, animated: true)    }
}
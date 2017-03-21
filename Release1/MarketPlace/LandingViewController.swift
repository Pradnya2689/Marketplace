//
//  LandingViewController.swift
//  MarketPlace
//
//  Created by vedashree on 08/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher
import AlamofireImage
import AlamofireImage
import CoreData

class ImgList:NSObject,Mappable {
    
    var bannerList: BannerList?
    // var threeDayForecast: [Forecast]?
    //
    required init?(_ map: Map){
        
    }
    //
    func mapping(map: Map) {
        
        bannerList <- map["bannerList"]
    }
}
class BannerList: Mappable {
    
    var homeSlot1: HomeSlot1?
    // var threeDayForecast: [Forecast]?
    //
    required init?(_ map: Map){
        
    }
    //
    func mapping(map: Map) {
        
        homeSlot1 <- map["homeSlot1"]
    }
}
class HomeSlot1: Mappable {
    //  var bannerID: Int?
    //    var m_RichContent: String?
    //    var name: String?
    var richContent: String?
    //    var title: String?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        //        bannerID <- map["bannerID"]
        //        m_RichContent <- map["m_RichContent"]
        //        name <- map["name"]
        richContent <- map["m_RichContent"]
        //   title <- map["title"]
    }
}

class ConfigurationArray: Mappable {
    
    var marketPlaceConfigurationLibrary: MarketPlaceConfigurationLibrary?
    // var threeDayForecast: [Forecast]?
    //
    required init?(_ map: Map){
        
    }
    //
    func mapping(map: Map) {
        
        marketPlaceConfigurationLibrary <- map["marketPlaceConfigurationLibrary"]
    }
}
class MarketPlaceConfigurationLibrary: Mappable {
    
    var featuredProduct_DisplayLimit: FeaturedProduct_DisplayLimit?
    var featuredProducts: FeaturedProduct_DisplayLimit?
    var newArrival_DisplayLimit: FeaturedProduct_DisplayLimit?
    var newArrivals: FeaturedProduct_DisplayLimit?
    // var threeDayForecast: [Forecast]?
    //
    required init?(_ map: Map){
        
    }
    //
    func mapping(map: Map) {
        featuredProducts  <- map["featuredProducts"]
        newArrival_DisplayLimit  <- map["newArrival_DisplayLimit"]
        featuredProduct_DisplayLimit <- map["featuredProduct_DisplayLimit"]
        newArrivals <- map["newArrivals"]
        
    }
}
class FeaturedProduct_DisplayLimit: Mappable {
    var configurationKey: String?
    var configurationKeyValue: String?
    var configurationKeyValueComment: String?
    var id: Int?
    var status: Int?
    // var validToDate: String?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        configurationKey <- map["configurationKey"]
        configurationKeyValue <- map["configurationKeyValue"]
        configurationKeyValueComment <- map["configurationKeyValueComment"]
        id <- map["id"]
        status <- map["status"]
        //validToDate <- map["validToDate"]
    }
}

class VendorLogoList: Mappable {
    var featuredVendorLogo: String?
    var featuredVendorName: String?
    var featuredVendorSiteURL: String?
    var marketPlaceFeaturedVendorsID: Int?
    var validFromDate: String?
    var validToDate: String?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        featuredVendorLogo <- map["featuredVendorLogo"]
        featuredVendorName <- map["featuredVendorName"]
        featuredVendorSiteURL <- map["featuredVendorSiteURL"]
        marketPlaceFeaturedVendorsID <- map["marketPlaceFeaturedVendorsID"]
        validFromDate <- map["validFromDate"]
        validToDate <- map["validToDate"]
    }
}


class ProductDetails: Mappable {
    var description: String?
    var imageURLHigh: String?
    var netPrice: String?
    var grossPrice: String?
    var productId: String?
     var pnaSuccess: String?
    var sku:String?
    var showPerc: Bool?
    var percentage:String?
    var grossPriceDisplayString:String?
    var netPriceDisplayString:String?
    var isNewProd:Bool?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        description <- map["description"]
        imageURLHigh <- map["imageURLHigh"]
        netPrice <- map["netPrice"]
        grossPrice <- map["grossPrice"]
        productId <- map["productId"]
          pnaSuccess <- map["pnaSuccess"]
        netPriceDisplayString <- map["netPriceDisplayString"]
        sku <- map["sku"]
        showPerc <- map["showPerc"]
        percentage <- map["percentage"]
        netPriceDisplayString <- map["netPriceDisplayString"]
        grossPriceDisplayString <- map["grossPriceDisplayString"]
        isNewProd <- map["isNewProd"]
        
        
    }
}



class LandingViewController: UIViewController,vendorLogocellDelegate,webServiceDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate {
    
    @IBOutlet  var recentViewCollection: UICollectionView!
    @IBOutlet var featureViewCollection: UICollectionView!
    @IBOutlet var newArrivalViewCollection: UICollectionView!
    @IBOutlet var brandViewCollection: UICollectionView!
    @IBOutlet var recentView:UIView!
    @IBOutlet var feturedView:UIView!
    @IBOutlet var newArrivalView:UIView!
    @IBOutlet var brandlogoView:UIView!
    @IBOutlet var rcentBtn: UIButton!
    @IBOutlet var featurdBtn:UIButton!
    @IBOutlet var newArrBtn:UIButton!
    @IBOutlet var DescriptionLbl: UILabel!
    let boundss = UIScreen.mainScreen().bounds
    @IBOutlet var scroll:UIScrollView!
    var refreshControl : UIRefreshControl!
    var vendorArray:NSMutableArray!
    var featuredArray:NSArray!
    var featuredDataArray:NSMutableArray!
    var featuredArrayViewAll:NSMutableArray!
    var NewArrArrayViewAll:NSMutableArray!
    var newArrivalArray:NSArray!
    var RecentSkuArray:NSMutableArray!
    var RecentArray:NSMutableArray!
    var newArrivalDataArray:NSMutableArray!
    
    var recencetlyDataArray:NSMutableArray!
    
    var recentlyViewedArray:NSMutableArray!
    var recentlyViewARR:NSMutableArray!
    var noOfFeatureProd:Int?
    var noOfNewArrival:Int?
    var noOfRecentViewed:Int?
    @IBOutlet var bannerView:UIView!
    private var pageViewController: UIPageViewController?
    var contentImages : NSArray!=NSArray()
    
   
   
    var imgString:NSString?
    var imgArray:NSArray?
    var imgArrTemp:NSMutableArray?
    var keywordsArrTemp:NSMutableArray?
    var pageController:UIPageViewController!
    let wsm : WebServiceClass = WebServiceClass.sharedInstance
    var currntIndex : Int! = 0
    @IBOutlet var searchTxt:UISearchBar!
    @IBOutlet var searchBtn:UIButton!
    @IBOutlet var noInternetView:UIView!
    @IBOutlet var wifiImg:UIImageView!
    @IBOutlet var noconnetinlbl:UILabel!
    @IBOutlet var retryBtn:UIButton!
    var myTimer:NSTimer!
     var dataLayer: TAGDataLayer = TAGManager.instance().dataLayer
    
    
    
    var attrs = [
        NSFontAttributeName : UIFont.systemFontOfSize(13.0),
        NSForegroundColorAttributeName : UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1),
        NSUnderlineStyleAttributeName : 1]
    
    
    
    var attributedString = NSMutableAttributedString(string:"")
    
    @IBOutlet var NewArrivalVLbtn: UIButton!
    @IBOutlet var FeaturedProductVLBtn: UIButton!
    @IBOutlet var RecentlyVIewedVLBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        
//        let logo = UIImage(named: "titleImage")
//        let imageView = UIImageView(image:logo)
//        self.navigationItem.titleView = imageView
        
        
//         var returnValue : [String]? = NSUserDefaults.standardUserDefaults().objectForKey("Location") as! [String]
//        print(returnValue)
//        
//        for (index, element) in returnValue!.enumerate() {
//            print("Item \(index): \(element)")
//        }
//     let LoginViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("cartVC") as? SecondViewController
//        let tabArray = self.tabBarController?.tabBar.items as NSArray!
//        let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
//        tabItem.badgeValue = "2"
      //var myViewController = SecondViewController.initialize()
        //self.tabBarController?.selectedIndex = 3
       // LoginViewControllerObj?.registerNotification()
        //NSNotificationCenter.defaultCenter().postNotificationName("basketDetails", object: nil, userInfo: nil )
        //self.tabBarController?.selectedIndex = 0
        let buttonTitleStr = NSMutableAttributedString(string:"View All", attributes:attrs)
        attributedString.appendAttributedString(buttonTitleStr)
       self.RecentlyVIewedVLBtn.setAttributedTitle(attributedString, forState: .Normal)
         self.FeaturedProductVLBtn.setAttributedTitle(attributedString, forState: .Normal)
         self.NewArrivalVLbtn.setAttributedTitle(attributedString, forState: .Normal)
        
        
        
     FeaturedProductVLBtn.translatesAutoresizingMaskIntoConstraints = true
        FeaturedProductVLBtn.frame = CGRectMake((screenWidth-70), 23, 63, 25)
        NewArrivalVLbtn.translatesAutoresizingMaskIntoConstraints = true
        NewArrivalVLbtn.frame = CGRectMake((screenWidth-79), 23, 63, 25)
        RecentlyVIewedVLBtn.translatesAutoresizingMaskIntoConstraints = true
        RecentlyVIewedVLBtn.frame = CGRectMake((screenWidth-79), 24, 63, 25)
        
       // self.fetchRecentlyViewedData()
        // self.recentViewCollection.translatesAutoresizingMaskIntoConstraints = true;
        // self.recentViewCollection.frame = CGRectMake(0, 152, 400, 0)
        // Do any additional setup after loading the view.
        //self.title = "IMOL"
      //  NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(LandingViewController.animateBanner), userInfo: nil, repeats: true)
        scroll.hidden = true
        searchBtn.hidden = true
        vendorArray = NSMutableArray()
        newArrivalDataArray=NSMutableArray()
        featuredDataArray = NSMutableArray()
        recentlyViewedArray = NSMutableArray()
        recencetlyDataArray = NSMutableArray()
        recentlyViewARR = NSMutableArray()
        
        featuredArrayViewAll = NSMutableArray()
        NewArrArrayViewAll = NSMutableArray()
        featuredArray = []
        newArrivalArray = []
        
        noOfNewArrival=0
        noOfFeatureProd=0
        noOfRecentViewed = 0
        if boundss.width == 320
        {
            self.rcentBtn.translatesAutoresizingMaskIntoConstraints = true
            self.rcentBtn.frame=CGRectMake((boundss.width - 153)/2, 4, 153, 30)
            self.featurdBtn.translatesAutoresizingMaskIntoConstraints = true
            self.featurdBtn.frame=CGRectMake((boundss.width - 192)/2, 4, 192, 30)
            self.newArrBtn.translatesAutoresizingMaskIntoConstraints = true
            self.newArrBtn.frame=CGRectMake((boundss.width - 116)/2, 4, 116, 30)
            
        }
        
        self.pageViewController?.view.userInteractionEnabled = true
        self.pageViewController?.dataSource = self
        self.pageViewController?.delegate = self
        
        
       //self.pageViewController!.gestureRecognizers
        
//        for gr in (self.pageViewController?.view.gestureRecognizers)!
//        {
//            gr.delegate = self
//        }
        
        rcentBtn.layer.cornerRadius = 2
        rcentBtn.layer.borderWidth = 1
        rcentBtn.layer.borderColor = UIColor (red: 31/255.0, green: 75/255.0, blue: 164/255.0, alpha: 1.0).CGColor

        
        featurdBtn.layer.cornerRadius = 2
        featurdBtn.layer.borderWidth = 1
        featurdBtn.layer.borderColor = bluedarkColor.CGColor
        
        newArrBtn.layer.cornerRadius = 2
        newArrBtn.layer.borderWidth = 1
        newArrBtn.layer.borderColor = bluedarkColor.CGColor
        
         searchBtn.layer.cornerRadius = 3
        searchBtn.layer.borderWidth = 1
        searchBtn.layer.borderColor = bluedarkColor.CGColor
       
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(LandingViewController.loadPostsIntoCards), forControlEvents: UIControlEvents.ValueChanged)
        self.scroll.addSubview(self.refreshControl)
        
        self.view.addSubview(self.scroll)
         dataLayer.push(["event": "openScreen", "screenName": "HomeScreenios"])
        
        //var url = NSURL(string:"http://immarketapi-stg2.azurewebsites.net/api/MarketPlaceCMS?itemtype=banner&page=Home&key=banner")
        let tabArray = self.tabBarController?.tabBar.items as NSArray!
        let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
            tabItem.badgeValue = nil
       
       self.badgecount()
        CallApI()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(LandingViewController.stateChangeResponse(_:)),
                                                         name: "stateChange",
                                                         object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(LandingViewController.stateChangeResponse1(_:)),
                                                         name: "stateChange1",
                                                         object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                             selector:#selector(LandingViewController.badgecountResponse(_:)),
                                                         name: "basketDetailsLandingPage",
                                                         object: nil)
        //NSNotificationCenter.defaultCenter().postNotificationName("basketDetails", object: nil, userInfo: nil )
        
    }
    func badgecount()
    {
        let  appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true){
        //NSNotificationCenter.defaultCenter().postNotificationName("basketDetails", object: nil, userInfo: nil )
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId"){
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates = nil
            wsm.delegates=self
            wsm.getBasketDetailslandingpage(usernm  as! Int , contryId: "IN")
            
        }
        }
        else
        {
            let tabArray = self.tabBarController?.tabBar.items as NSArray!
            let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
            tabItem.badgeValue = nil
        
        
        }
    }
    func badgecountResponse(notification: NSNotification)
    {
       // print(notification.userInfo)
        let string : AnyObject = notification.userInfo!
        var cartCnt : NSMutableArray! = NSMutableArray()
     //   cartCnt.removeAllObjects()
        if let bastetcartarry = string.valueForKey("lstBasket") as? NSArray{
            
            for forecast in bastetcartarry
            {
                // var lst:lstBasket = forecast as! lstBasket
                cartCnt.addObject(forecast)
                
            }
           // print(String(bastetcartarry.count))
            let tabArray = self.tabBarController?.tabBar.items as NSArray!
           
              
            if (tabArray != nil)
            {
            //let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
            if let tabItem = tabArray.objectAtIndex(2) as? UITabBarItem
            {
            tabItem.badgeValue = String(bastetcartarry.count)
            if(tabItem.badgeValue == "0" || tabItem.badgeValue == ""){
                tabItem.badgeValue = nil
            }
            }
            }
            
            
//            if let viewWithTag = self.view.viewWithTag(2) {
//              
//                viewWithTag.removeFromSuperview()
//            }
//            else {
//                print("tag not found")
//            }
//            dispatch_async(dispatch_get_main_queue())
//            {
//                LoadingOverlay.shared.hideOverlayView()
//            
//            }
         LoadingOverlay.shared.hideOverlayView()
//            LoadingOverlay.shared.hideOverlayView()
//            LoadingOverlay.shared.hideOverlayView()
        
//            LoadingOverlay.shared.activityIndicator.stopAnimating()
//            dispatch_async(dispatch_get_main_queue(), { // This makes the code run on the main thread
//                LoadingOverlay.shared.hideOverlayView()
//                LoadingOverlay.shared.hideOverlayView()
//                LoadingOverlay.shared.hideOverlayView()
//                LoadingOverlay.shared.hideOverlayView()
//                LoadingOverlay.shared.hideOverlayView()
//                LoadingOverlay.shared.hideOverlayView()
//                LoadingOverlay.shared.hideOverlayView()
//                LoadingOverlay.shared.hideOverlayView()
//                LoadingOverlay.shared.hideOverlayView()
//                
//                LoadingOverlay.shared.hideOverlayView()
//                LoadingOverlay.shared.hideOverlayView()
//                
//            })
//            for forecast in bastetcartarry
//            {
//               // cartCnt .addObject(forecast)
//                // var lst:lstBasket = forecast as! lstBasket
//               // self.basketArray.addObject(forecast)
//                
//            }
            //print(bastetcartarry.count)
           // }
           
        }
        
//                    if(tabItem.badgeValue == "0" || tabItem.badgeValue == "")
//        {
////            tabItem.badgeValue = nil
////            self.bottomVc.hidden = true
////            self.noResultVc.hidden=false
////            if(screenHeight == 480){
////                self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
////                self.noResultLbl.translatesAutoresizingMaskIntoConstraints = true
////                self.noResultImg.frame = CGRectMake((screenSize.width - 150 )/2, 50, 150, 150)
////                self.noResultLbl.frame = CGRectMake(10, 230, screenWidth-20, 21)
////                self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
////                self.noResultVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
////                self.continueBtn.translatesAutoresizingMaskIntoConstraints = true
////                self.continueBtn.frame = CGRectMake((screenWidth-214)/2, 270, 214, 30)
////            }else{
////                self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
////                // self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
////                self.noResultLbl.translatesAutoresizingMaskIntoConstraints = true
////                self.noResultImg.frame = CGRectMake((screenSize.width - 120 )/2, 150, 120, 120)
////                self.noResultLbl.frame = CGRectMake((screenSize.width - 248 )/2, 330, 248, 21)
////                self.continueBtn.translatesAutoresizingMaskIntoConstraints = true
////                self.continueBtn.frame = CGRectMake((screenSize.width - 270 )/2, 370, 270, 30)
////            }
////            let defaults = NSUserDefaults.standardUserDefaults()
////            defaults.setObject("", forKey: "badge")
//        }
    }
    static func instantiate() -> SecondViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("cartVC") as! SecondViewController
    }
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if let _ = gestureRecognizer as? UITapGestureRecognizer {
            let touchPoint = touch .locationInView(self.pageViewController!.view)
            if (touchPoint.y > 40 ){
                
               // print("index touched ")
                return false
            }else{
               // print("index touched ")
                return true
            }
        }
        return true
    }

    func stateChangeResponse(notification: NSNotification){
        self.badgecount()
        CallApI()
        
    }
    //For state change through Accountviewcontroller
    func stateChangeResponse1(notification: NSNotification){
        self.badgecount()
        CallApI1()
        
    }
    func requestFailDelegate(){
        let alert=UIAlertController(title: "", message:ConstantsFile.requestFail_msg, preferredStyle: UIAlertControllerStyle.Alert);
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil));
        //event handler with closure
        alert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default, handler: {(action:UIAlertAction) in
           // let wsm : WebServiceClass = WebServiceClass.sharedInstance
            self.wsm.delegates=self       //grpDetail.masterProfileID
            self.wsm.callVendorApi("banner", page: "Home", key: "banner")
        }));
        
        self.presentViewController(alert, animated: true, completion: nil);
    }
    func myDelegateFunction(string:ImgList)
    {
        //print(string)
        self.imgArrTemp = NSMutableArray()
        self.keywordsArrTemp = NSMutableArray()
        if let threeDayForecast = string.bannerList {
            if let threeDayForecast1 = threeDayForecast.homeSlot1 {
               // print(threeDayForecast1.richContent)
                self.imgArray = threeDayForecast1.richContent!.componentsSeparatedByString(";")
               // print(self.imgArray?.count)
               // print(self.imgArray?.objectAtIndex(0))
                for str in self.imgArray!
                {
//                    if (str.length != nil)
//                    {
                   if let str1 : String = str as! String where !str1.isEmpty {
                    
                  //  let str1 : String = str as! String
                let fullNameArr = str1.characters.split{$0 == "~"}.map(String.init)
                    imgArrTemp?.addObject(fullNameArr[0])
                   
                   if (fullNameArr.count > 1)
                   {
                    keywordsArrTemp?.addObject(fullNameArr[1])
                    }
                    else
                    {
                    keywordsArrTemp?.addObject("")
                    }
                 }
                    
                }
               // print(imgArrTemp)
               // print(keywordsArrTemp)
                contentImages = NSArray.init(array: imgArrTemp!)
                //contentImages = NSArray.init(array: self.imgArray!)
                pageController = UIPageViewController()
                createPageViewController()
               setupPageControl()
//               myTimer =  NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(LandingViewController.animateBanner), userInfo: nil, repeats: false)
               //animateBanner()
            }
        }
        
    }
    func getWishListSuccess(wishList:NSDictionary){
       LoadingOverlay.shared.hideOverlayView()
        wishLstGlobalArray.removeAllObjects()
       // self.wishListArray.removeAllObjects()
        if let COD : AnyObject  = wishList["product"]
        {
           // print(COD)
            
            if let customer : Array<LstProducts> = Mapper<LstProducts>().mapArray(COD["lstProducts"])! {
                //  if let customer = COD["lstProducts"]{
                for prodt in customer
                {
                    wishLstGlobalArray.addObject(prodt.sku!)
                 //   self.wishListArray .addObject(prodt)
                  //  print("testing   \(prodt)")
                    //print("testing2")
                    
                }
            }
        }
        
       
    }
    func searchClk()  {
        //SearchViewController
       // let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchViewController") as! SearchViewController
       // secondViewController.comingfrom = "Search"
        //self.navigationController?.pushViewController(secondViewController, animated: true)
      
    }
    override func viewWillDisappear(animated: Bool) {
        
        // myTimer.invalidate()
      //  let wsm : WebServiceClass = WebServiceClass.sharedInstance
         self.navigationController?.navigationBarHidden = false
       self.tabBarController?.tabBar.hidden = false
        self.title = ""
        //myTimer.invalidate()
        myTimer = nil
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "reachable", object: nil)
       // wsm.delegates=nil
        
    }
   
    @IBAction func FeaturedProductVL(sender: AnyObject)
    {
        
        let collectionViewPush = self.storyboard?.instantiateViewControllerWithIdentifier("productList") as! CollectionViewController
        collectionViewPush.comingfrom = "ViewAll"
        collectionViewPush.keyWords = "Featured Product"
        collectionViewPush.skuarrayVL = self.featuredArray
        self.navigationController?.pushViewController(collectionViewPush, animated: true)

       // self.callfeaturedproduct()
     // print("KN")
//          performSegueWithIdentifier("ViewAll", sender: self)
     //   let collectionViewPush = self.storyboard?.instantiateViewControllerWithIdentifier("productList") as! CollectionViewController
      //  collectionViewPush.comingfrom = "ViewAll"

    }
    
    @IBAction func NewArrivalVL(sender: AnyObject) {
        
      // self.newArrivalproduct()
        
        let collectionViewPush = self.storyboard?.instantiateViewControllerWithIdentifier("productList") as! CollectionViewController
        collectionViewPush.comingfrom = "ViewAll"
        collectionViewPush.keyWords = "New Arrival"
        collectionViewPush.skuarrayVL = self.newArrivalArray
        self.navigationController?.pushViewController(collectionViewPush, animated: true)
        
        
    }
    @IBAction func RecentlyViewedVL(sender: AnyObject)
    {
        
        RecentSkuArray = NSMutableArray()
        
        var data : String = ""
     // print(self.recentlyViewedArray)
        for result in self.recentlyViewedArray
        {
//            if let skuno = result.valueForKey("sku")
//            {
                //data += "\(skuno);"
                self.RecentSkuArray.addObject(result)
                
            //}
        }
        let swiftArray = NSArray(array: self.RecentSkuArray) as? [String]
        
        let collectionViewPush = self.storyboard?.instantiateViewControllerWithIdentifier("productList") as! CollectionViewController
        collectionViewPush.comingfrom = "ViewAll"
        collectionViewPush.keyWords = "Recently Viewed"
        collectionViewPush.skuarrayVL = swiftArray!
        self.navigationController?.pushViewController(collectionViewPush, animated: true)
        
      //  self.recentlyViewedProduct()
//        let collectionViewPush = self.storyboard?.instantiateViewControllerWithIdentifier("productList") as! CollectionViewController
//        collectionViewPush.comingfrom = "ViewAll"
     //   print(self.recentlyViewedArray.objectAtIndex(0))
      //  let customer1 : Array<LstProducts> = Mapper<LstProducts>().mapArray(self.recentlyViewedArray)!
    
        //collectionViewPush.CollectionData = customer1
      //  self.navigationController?.pushViewController(collectionViewPush, animated: true)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        
        if (segue.identifier == "ViewAll")
        {
            
            
        }
        
        
    }
    func CallApI()  {
        
      let  appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
           LoadingOverlay.shared.showOverlay(window)//rishikesh edit
           //  self.noInternetView.hidden = true
            self.imgArray = NSArray()
            vendorArray = NSMutableArray()
            newArrivalDataArray=NSMutableArray()
            recencetlyDataArray=NSMutableArray()
            featuredDataArray = NSMutableArray()
            recentlyViewedArray = NSMutableArray()
            featuredArray = []
            newArrivalArray = []
        wsm.delegates=self
        let defaults = NSUserDefaults.standardUserDefaults()
        if let userId = defaults.objectForKey("userId") as? Int{
          //  JHProgressHUD.sharedHUD.showInView(self.view)
            let backgroundQueue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
            dispatch_async(backgroundQueue) { () -> Void in
               self.wsm.getWishListDetails()
                
            }
        
        }
        wsm.delegates = self
        wsm.callVendorApi("banner", page: "Home", key: "banner")//&page=Home&key=banner
        
        
        let headers = [
            "Authorization":authorizationWithoutLogin,
            "Accept": "application/json"
        ]
        
        
        Alamofire.request(.GET, "\(baseUrl)MarketPlaceCMS?itemtype=featuredvendors&page=Home&key=featuredvendors",headers: headers).validate(contentType: ["application/json"])
            
            .responseJSON { response in        //responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)
                if let JSON = response.result.value {
                    print(JSON)
                    let vendorlogo : Array<VendorLogoList> = Mapper<VendorLogoList>().mapArray(JSON)!
                   // print(self.vendorArray)
                    for forecast in vendorlogo
                    {
                        self.vendorArray .addObject(forecast)
                        print("featured logo name:\(forecast.featuredVendorLogo!)")
                        
                    }
                    
                    self.brandViewCollection.reloadData()
                    
                }
        }
        
        Alamofire.request(.GET, "\(baseUrl)MarketPlaceCMS?itemtype=maketplaceconfiguration&page=Home&key=banner",headers: headers).validate(contentType: ["application/json"])
            //.responseJSON { response in
            .responseObject { (response: Response<ConfigurationArray, NSError>) in      //responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)
                if let JSON = response.result.value {
                    print(JSON.toJSONString())
                    if let marketPlace = JSON.marketPlaceConfigurationLibrary {
                        if let featureCont = marketPlace.featuredProduct_DisplayLimit{
                            self.noOfFeatureProd = Int(featureCont.configurationKeyValue!)
                        }
                        if let featureCont = marketPlace.newArrival_DisplayLimit{
                           // print(marketPlace.newArrival_DisplayLimit)
                            self.noOfNewArrival = Int(featureCont.configurationKeyValue!)
                        }
                        if let featuredProducts = marketPlace.featuredProducts{
                           // print(featuredProducts.configurationKeyValue)
                            self.featuredArray = featuredProducts.configurationKeyValue!.componentsSeparatedByString(";")
                           // print("featuredArray:-",self.featuredArray.count)
                            //print("featuredArray:-",self.featuredArray)
                          //  self.callfeaturedproduct()
                            self.featureViewCollection.reloadData()
                        }
                        if let featuredProducts = marketPlace.newArrivals{
                           // print(featuredProducts.configurationKeyValue)
                            self.newArrivalArray = featuredProducts.configurationKeyValue!.componentsSeparatedByString(";")
                           // self.newArrivalproduct()
                           // print("newArrivalArray:-",self.newArrivalArray)
                            self.newArrivalViewCollection.reloadData()
                        }
                       // print(self.newArrivalArray)
                    }
                    LoadingOverlay.shared.hideOverlayView()
                    self.scroll.hidden = false
                    self.searchBtn.hidden = false
                }
        }
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
          /*  if let data = defaults.objectForKey("badge") as? String
            {
                let tabArray = self.tabBarController?.tabBar.items as NSArray!
                let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
                tabItem.badgeValue = data
                if(tabItem.badgeValue == "0" || tabItem.badgeValue == ""){
                    tabItem.badgeValue = nil
                    
                }
                
            }*/
            
            self.noInternetView.hidden = false
            self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
            self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
            self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
            self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
            self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
            self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)

        }
    }
    
    func CallApI1()  {
        
        let  appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            // LoadingOverlay.shared.showOverlay(window)//rishikesh edit
            //  self.noInternetView.hidden = true
            self.imgArray = NSArray()
            vendorArray = NSMutableArray()
            newArrivalDataArray=NSMutableArray()
            recencetlyDataArray=NSMutableArray()
            featuredDataArray = NSMutableArray()
            recentlyViewedArray = NSMutableArray()
            featuredArray = []
            newArrivalArray = []
            wsm.delegates=self
            let defaults = NSUserDefaults.standardUserDefaults()
            if let userId = defaults.objectForKey("userId") as? Int{
                //  JHProgressHUD.sharedHUD.showInView(self.view)
                let backgroundQueue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
                dispatch_async(backgroundQueue) { () -> Void in
                    self.wsm.getWishListDetails()
                    
                }
                
            }
            wsm.delegates = self
            wsm.callVendorApi("banner", page: "Home", key: "banner")//&page=Home&key=banner
            
            
            let headers = [
                "Authorization":authorizationWithoutLogin,
                "Accept": "application/json"
            ]
            
            
            Alamofire.request(.GET, "\(baseUrl)MarketPlaceCMS?itemtype=featuredvendors&page=Home&key=featuredvendors",headers: headers).validate(contentType: ["application/json"])
                
                .responseJSON { response in        //responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response) // URL response
//                    print(response.data)     // server data
//                    print(response.result)
                    if let JSON = response.result.value {
                        print(JSON)
                        let vendorlogo : Array<VendorLogoList> = Mapper<VendorLogoList>().mapArray(JSON)!
                       // print(self.vendorArray)
                        for forecast in vendorlogo
                        {
                            self.vendorArray .addObject(forecast)
                            print("featured logo name:\(forecast.featuredVendorLogo!)")
                            
                        }
                        
                        self.brandViewCollection.reloadData()
                        
                    }
            }
            
            Alamofire.request(.GET, "\(baseUrl)MarketPlaceCMS?itemtype=maketplaceconfiguration&page=Home&key=banner",headers: headers).validate(contentType: ["application/json"])
                //.responseJSON { response in
                .responseObject { (response: Response<ConfigurationArray, NSError>) in      //responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response) // URL response
//                    print(response.data)     // server data
//                    print(response.result)
                    if let JSON = response.result.value {
                        print(JSON.toJSONString())
                        if let marketPlace = JSON.marketPlaceConfigurationLibrary {
                            if let featureCont = marketPlace.featuredProduct_DisplayLimit{
                                self.noOfFeatureProd = Int(featureCont.configurationKeyValue!)
                            }
                            if let featureCont = marketPlace.newArrival_DisplayLimit{
                                //print(marketPlace.newArrival_DisplayLimit)
                                self.noOfNewArrival = Int(featureCont.configurationKeyValue!)
                            }
                            if let featuredProducts = marketPlace.featuredProducts{
                               // print(featuredProducts.configurationKeyValue)
                                self.featuredArray = featuredProducts.configurationKeyValue!.componentsSeparatedByString(";")
                               // print("featuredArray:-",self.featuredArray.count)
                               // print("featuredArray:-",self.featuredArray)
                                //  self.callfeaturedproduct()
                                self.featureViewCollection.reloadData()
                            }
                            if let featuredProducts = marketPlace.newArrivals{
                                //print(featuredProducts.configurationKeyValue)
                                self.newArrivalArray = featuredProducts.configurationKeyValue!.componentsSeparatedByString(";")
                                // self.newArrivalproduct()
                                //print("newArrivalArray:-",self.newArrivalArray)
                                self.newArrivalViewCollection.reloadData()
                            }
                            //print(self.newArrivalArray)
                        }
                        LoadingOverlay.shared.hideOverlayView()
                        self.scroll.hidden = false
                        self.searchBtn.hidden = false
                    }
            }
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
            /*  if let data = defaults.objectForKey("badge") as? String
             {
             let tabArray = self.tabBarController?.tabBar.items as NSArray!
             let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
             tabItem.badgeValue = data
             if(tabItem.badgeValue == "0" || tabItem.badgeValue == ""){
             tabItem.badgeValue = nil
             
             }
             
             }*/
            
            self.noInternetView.hidden = false
            self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
            self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
            self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
            self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
            self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
            self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
       //self.tabBarController?.tabBar.set
        //self.title="IMOL"
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
        imageView.contentMode = .ScaleAspectFit
        let image = UIImage(named: "titleImage")
        imageView.image = image
        navigationItem.titleView = imageView
        
       // self.navigationController?.navigationBar.titl
        let items = self.tabBarController?.tabBar.items
        let tabItem = items![0]
        tabItem.title = ""
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
         self.tabBarController?.tabBar.hidden = false
        self.navigationController?.navigationBar.tintColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
         self.navigationController?.interactivePopGestureRecognizer?.enabled = false

         self.navigationController?.navigationBarHidden = false
        //self.navigationController.popt
//        let camera = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(LandingViewController.searchClk))
//      //  self.navigationItem.leftBarButtonItem = camera
//        let someFrame = CGRect(x: 0.0, y: 0.0, width: boundss.width - 50, height: 30.0)
//        
//        let text = UITextField(frame: someFrame)
//        text.borderStyle = .None;
//        text.placeholder = "Search for products"
//        text.tag = 12
//        text.delegate = self
//      //  self.navigationItem.titleView = text
        self.fetchRecentlyViewedData()
        setupPageControl()
//        let defaults = NSUserDefaults.standardUserDefaults()
//        if let data = defaults.objectForKey("badge") as? String
//        {
//            let tabArray = self.tabBarController?.tabBar.items as NSArray!
//            let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
//            tabItem.badgeValue = data
//            if(tabItem.badgeValue == "0" || tabItem.badgeValue == ""){
//                tabItem.badgeValue = nil
//                
//            }
//            
//        }
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(LandingViewController.internetReachable(_:)),
                                                         name: "reachable",
                                                         object: nil)
        
        if(screenSize.width == 320)
        {
            searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 45)
            searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20)
        }
        
        myTimer =  NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(LandingViewController.animateBanner), userInfo: nil, repeats: true)
        
       // NSNotificationCenter.defaultCenter().postNotificationName("basketDetails", object: nil, userInfo: nil )
    }
    
    func  callfeaturedproduct ()
    {
        //print("data is not available")
        let headers = [
            "Authorization": authorizationWithoutLogin,
            "Accept": "application/json"
        ]
        
        
        var data : String = ""
        for str in self.featuredArray
        {
            data += "\(str);"
        }
       // print(data)
        //                let data = self.featuredArray.objectAtIndex(indexPath.row).stringByTrimmingCharactersInSet(
        //                    NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        let url = NSURL(string:"\(baseUrl)product?txtSearch=\(data)")
        //print(url!.absoluteString, terminator: "")
        
        Alamofire.request(.GET, url!,headers: headers).validate(contentType: ["application/json"])
            .responseJSON { response in
                //.responseObject { (response: Response<ProductDetails, NSError>) in      //responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)
                if let JSON = response.result.value {
                    print(JSON)
                    let customer : Array<ProductDetails> = Mapper<ProductDetails>().mapArray(JSON)!
                    let customer1 : Array<LstProducts> = Mapper<LstProducts>().mapArray(JSON)!
//                    print(customer)
//                    print(customer1)
                    self.featuredArrayViewAll.removeAllObjects()
                    
                    for product in customer1
                    {
                    self.featuredArrayViewAll .addObject(product)
                    //print(product.description)
                    }
                   // print(self.featuredArrayViewAll)
                    
                    let collectionViewPush = self.storyboard?.instantiateViewControllerWithIdentifier("productList") as! CollectionViewController
                    collectionViewPush.comingfrom = "ViewAll"
                    collectionViewPush.keyWords = "Featured Product"
                    collectionViewPush.CollectionData = self.featuredArrayViewAll
                    self.navigationController?.pushViewController(collectionViewPush, animated: true)

                  /*  if customer1.count != 0
                    {
                        if let prod1 = customer1[0] as? LstProducts
                        {
                            self.featuredArrayViewAll .addObject(prod1)
                        }
                    }
                    if customer.count != 0
                    {
                        if let prod = customer[0] as? ProductDetails{
                            
                            self.featuredDataArray .addObject(prod)
                            
                            print(prod.description)
                            cell.categoryLabl.text = prod.description
                            cell.sku = prod.sku
                            // cell.priceLabel.text = String("₹ \(prod.netPrice!)")
                            let pna =  prod.pnaSuccess!
                            if  ( pna == "true")
                            {
                                let grossPrice  =  "\(prod.grossPrice!)"
                                
                                if (grossPrice == "null")
                                {
                                    
                                    cell.priceLabel.text = "₹ \(prod.netPrice!)"
                                    cell.DescriptionLbl.hidden = true
                                }
                                else
                                {
                                    let  ntprice = prod.netPrice!.stringByReplacingOccurrencesOfString(",", withString: "")
                                    let  grprice = prod.grossPrice!.stringByReplacingOccurrencesOfString(",", withString: "")
                                    let  nprice1:Float? = Float(ntprice)
                                    let  gprice1:Float? = Float(grprice)
                                    let discountper1 :Float? = 100 - ((nprice1!/gprice1!)*100)
                                    
                                    if(Int(discountper1!) == 0){
                                        cell.DescriptionLbl.hidden = true
                                        cell.DescriptionLbl.text = String(format:"%@%% Off  ",String(Int(discountper1!)))
                                    }else{
                                        cell.DescriptionLbl.hidden = false
                                        cell.DescriptionLbl.text = String(format:"%@%% Off  ",String(Int(discountper1!)))
                                    }
                                    
                                    
                                    
                                    let grossPrice1  =  "₹ \(prod.grossPrice!)"
                                    let netPrice2  =  "₹ \(prod.netPrice!)"
                                    let labelstring : NSString = "\(netPrice2)  \(grossPrice1)"
                                    
                                    let string_to_color = "\(netPrice2)"
                                    let string2 = "\(grossPrice1)"
                                    
                                    let range = (labelstring as NSString).rangeOfString(string_to_color)
                                    let range2 = (labelstring as NSString).rangeOfString(string2)
                                    
                                    
                                    
                                    let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
                                    
                                    attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
                                    attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 11)!], range: range2)
                                    attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
                                    attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
                                    
                                    cell.priceLabel.attributedText = attributedText
                                    
                                }
                                
                            }
                            else
                            {
                                if(prod.netPrice! == "Price Not Available"){
                                    cell.priceLabel.text = "\(prod.netPrice!)"
                                }else{
                                    cell.priceLabel.text = "₹ \(prod.netPrice!)"
                                }
                            }
                            let url =  prod.imageURLHigh
                            let imgURL: NSURL = NSURL(string: url!)!
                            print("########\(imgURL.absoluteString)")
                            
                            if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
                            {
                                print("IN cache")
                                cell.prodImg.image = image
                                
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
                                            cell.prodImg.image = image
                                            photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                                        }
                                        else
                                        {
                                            let image : UIImage = UIImage(named:"placeholder")!
                                            cell.prodImg.image = image
                                            //photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                                        }
                                }
                            }
                        }
                    }*/
                }
                
        }

    }
    
    func  newArrivalproduct ()
    {
        
        //print("data is not available")
        
        let headers = [
            "Authorization":authorizationWithoutLogin,
            "Accept": "application/json"
        ]
//        let data = self.newArrivalArray.objectAtIndex(indexPath.row).stringByTrimmingCharactersInSet(
//            NSCharacterSet.whitespaceAndNewlineCharacterSet())
//        let url = NSURL(string:"\(baseUrl)product?txtSearch=\(data)")
//        print(url!.absoluteString, terminator: "")
//
//        
//        let headers = [
//            "Authorization": authorizationWithoutLogin,
//            "Accept": "application/json"
//        ]
//        
//        
        var data : String = ""
        for str in self.newArrivalArray
        {
            data += "\(str);"
        }
        let trimmedString = data.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
         let trimmedString2 = trimmedString.stringByReplacingOccurrencesOfString("\r\n", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let trimmedString3 = trimmedString2.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
//        print(data)
//        print(trimmedString3)

        
        let url = NSURL(string:"\(baseUrl)product?txtSearch=\(trimmedString3)")
       // print(url!.absoluteString, terminator: "")
        
        Alamofire.request(.GET, url!,headers: headers).validate(contentType: ["application/json"])
            .responseJSON { response in
                //.responseObject { (response: Response<ProductDetails, NSError>) in      //responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)
                if let JSON = response.result.value {
                    print(JSON)
                    self.NewArrArrayViewAll.removeAllObjects()
                  //  let customer : Array<ProductDetails> = Mapper<ProductDetails>().mapArray(JSON)!
                    
                    let customer1 : Array<LstProducts> = Mapper<LstProducts>().mapArray(JSON)!
                   // print(customer)
                   // print(customer1)
                    
                    for product in customer1
                    {
                        self.NewArrArrayViewAll .addObject(product)
                        //print(product.description)
                    }
                    
                   

                   // print(self.NewArrArrayViewAll)
    }
        }
    }
    func  recentlyViewedProduct ()
    {
        self.recentlyViewARR.removeAllObjects()
        //print("data is not available")
        
        let headers = [
            "Authorization":authorizationWithoutLogin,
            "Accept": "application/json"
        ]
        
         var data : String = ""
        for result in self.recentlyViewedArray
        {
            if let skuno = result.valueForKey("sku")
            {
                data += "\(skuno);"
                self.RecentSkuArray.addObject(data)
            }
        }
        let swiftArray = NSArray(array: self.RecentSkuArray) as? [String]
//        for str in self.recentlyViewedArray
//        {
//            data += "\(str);"
//        }
        let trimmedString = data.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let trimmedString2 = trimmedString.stringByReplacingOccurrencesOfString("\r\n", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let trimmedString3 = trimmedString2.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
//        print(data)
//        print(trimmedString3)
        
        
        let url = NSURL(string:"\(baseUrl)product?txtSearch=\(trimmedString3)")
        // print(url!.absoluteString, terminator: "")
        
        Alamofire.request(.GET, url!,headers: headers).validate(contentType: ["application/json"])
            .responseJSON { response in
                //.responseObject { (response: Response<ProductDetails, NSError>) in      //responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)
                if let JSON = response.result.value {
                   // print(JSON)
                    
                    //  let customer : Array<ProductDetails> = Mapper<ProductDetails>().mapArray(JSON)!
                    
                    let customer1 : Array<LstProducts> = Mapper<LstProducts>().mapArray(JSON)!
                    // print(customer)
                   // print(customer1)
                    
                    for product in customer1
                    {
                        self.recentlyViewARR .addObject(product)
                        
                    }
                    
                    
                    
                   // print(self.NewArrArrayViewAll)
                }
        }
    }
    
    func internetReachable(notification:NSNotification){
        retryBtnClk()
        //print("in landing via reachable")
    }
    override func viewDidAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
        
    }
    @IBAction func searchbtnClk(){
        
        let  appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("productList") as! CollectionViewController
        // secondViewController.skuNumber = self.recentlyViewedArray[indexPath.row].valueForKey("sku")! as! String
        secondViewController.comingfrom = "Search"
        //secondViewController.keyWords = cell.vendorDet.featuredVendorName
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }else{
            let alertView:UIAlertView = UIAlertView()
            alertView.title = ""
            alertView.message = ConstantsFile.noInternet_msg
            alertView.delegate = nil
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
    }
    
    @IBAction func retryBtnClk()
    {
        self.noInternetView.hidden = true
        //LoadingOverlay.shared.showOverlay()
        self.badgecount()
        CallApI()
        self.fetchRecentlyViewedData()
    }
    func loadPostsIntoCards()
    {
        let  appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
        CallApI()
        self.fetchRecentlyViewedData()
        self.refreshControl.endRefreshing()
        }else{
              self.refreshControl.endRefreshing()
        }
    }
    
    func fetchRecentlyViewedData()
    {
        recentlyViewedArray = []
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
                
                if(people.count == 0){
//                    self.recentView.translatesAutoresizingMaskIntoConstraints = true
//                    self.recentView.frame=CGRectMake(0, 152, boundss.width, 0)
                    self.recentView.translatesAutoresizingMaskIntoConstraints = true
                    self.recentView.frame=CGRectMake(0, 632, boundss.width, 0)
                }else{
                    if(people.count <= 5){
                        noOfRecentViewed = people.count
                    }else{
                    noOfRecentViewed = 5
                    }
//                    self.recentView.translatesAutoresizingMaskIntoConstraints = true
//                    self.recentView.frame=CGRectMake(0, 152, boundss.width, 240)
                    self.recentView.translatesAutoresizingMaskIntoConstraints = true
                    self.recentView.frame=CGRectMake(0, 632, boundss.width, 240)
                    var arr : NSMutableArray! = NSMutableArray()
                for searchstring in people
                {
                    arr.addObject(searchstring.valueForKey("sku")!)
                    
                   // print(searchstring.valueForKey("desc")!)
                  // print(searchstring.valueForKey("sku"))
//                   print(searchstring.valueForKey("netPrice"))
//                    print(searchstring.valueForKey("grossPrice"))
//                    print(searchstring.valueForKey("imageURLHigh"))
                    
                   // let str  = searchstring.valueForKey("desc") as! String
                    
                    
                }
                   recentlyViewedArray =  NSMutableArray(array: arr.reverseObjectEnumerator().allObjects).mutableCopy() as! NSMutableArray
                }
                self.recentViewCollection.reloadData()
            }
           
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
       
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == recentViewCollection){
            return noOfRecentViewed!
        }
        if(collectionView == newArrivalViewCollection){
            return self.newArrivalArray.count
        }
        if(collectionView == brandViewCollection){
            return self.vendorArray.count
        }
        return self.featuredArray.count
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == recentViewCollection
        {
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("recentView", forIndexPath: indexPath) as! RecentViewCell
          //  let people : [NSManagedObject] =  self.recentlyViewedArray.objectAtIndex(indexPath.row) as? NSManagedObject
            
            
            cell.categoryLabl.lineBreakMode = .ByWordWrapping // or NSLineBreakMode.ByWordWrapping
            cell.categoryLabl.numberOfLines = 0
            
            
            let image : UIImage = UIImage(named:"placeholder")!
            cell.prodImg.image = image
            cell.categoryLabl.text = ""
            cell.priceLabel.text = ""
            cell.DescriptionLbl.hidden = true

           // cell.categoryLabl.text = self.recentlyViewedArray[indexPath.row].valueForKey("desc")! as? String
           // print("val \(self.recentlyViewedArray[indexPath.row].valueForKey("desc"))")
            //cell.sku = self.recentlyViewedArray[indexPath.row].valueForKey("sku")! as! String
            self.recencetlyDataArray.removeAllObjects()
            if (self.recencetlyDataArray.count > indexPath.row)
            {
                //print("data is available")
             //   print("newArrivalDataArray:",self.newArrivalDataArray.description)
                let prod = self.recencetlyDataArray.objectAtIndex(indexPath.row) as! ProductDetails
                cell.categoryLabl.text = prod.description
                cell.sku = prod.sku
                if(prod.showPerc!){
                    cell.DescriptionLbl.hidden = false
                    cell.DescriptionLbl.text = String(format:"%@Off  ",prod.percentage!)
                    
                    let grossPrice1  =  "₹ \(prod.grossPriceDisplayString!)"
                    let netPrice2  =  "₹ \(prod.netPriceDisplayString!)"
                    let labelstring : NSString = "\(netPrice2)  \(grossPrice1)"
                    
                    let string_to_color = "\(netPrice2)"
                    let string2 = "\(grossPrice1)"
                    
                    let range = (labelstring as NSString).rangeOfString(string_to_color)
                    let range2 = (labelstring as NSString).rangeOfString(string2)
                    
                    
                    
                    let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
                    
                    attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
                    attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 11)!], range: range2)
                    attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
                    attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
                    
                    cell.priceLabel.attributedText = attributedText
                }else{
                    cell.DescriptionLbl.hidden = true
                    // cell.DescriptionLbl.text = String(format:"%@Off  ",prod.percentage!)
                    
                    if let netPrice2  =  prod.netPriceDisplayString{
                        if (netPrice2 == "Price Not Available")
                        {
                            cell.priceLabel.text = "Price Not Available"
                        }else{
                            cell.priceLabel.text = "₹ \(prod.netPriceDisplayString!)"
                        }
                    }else{
                        cell.priceLabel.text = "Price Not Available"
                    }
                }
                
                if(prod.isNewProd!){
                    cell.newProdImgView.hidden = false
                }else{
                    cell.newProdImgView.hidden = true
                    
                }
                //               let pna =  prod.pnaSuccess!
                //                if  ( pna == "true")
                //                {
                //                    let grossPrice  =  "\(prod.grossPrice!)"
                //
                //                    if (grossPrice == "null")
                //                    {
                //                       // cell.actualPriceLbl.text = ""
                //                      //  cell.DiscountLbl.hidden = true
                //                        cell.priceLabel.text = "₹ \(prod.netPrice!)"
                //                         cell.DescriptionLbl.hidden = true
                //                    }
                //                    else
                //                    {
                //                        //discount offers label
                //                      var  ntprice = prod.netPrice!.stringByReplacingOccurrencesOfString(",", withString: "")
                //                      var  grprice = prod.grossPrice!.stringByReplacingOccurrencesOfString(",", withString: "")
                //                        var  nprice1:Float? = Float(ntprice)
                //                        var  gprice1:Float? = Float(grprice)
                //                        let discountper1 :Float? = 100 - ((nprice1!/gprice1!)*100)
                //
                //
                ////                        cell.DescriptionLbl.hidden = false
                ////                        cell.DescriptionLbl.text = String(format:"%@%% Off  ",String(Int(discountper1!)))
                //                        //end
                //
                //                        let grossPrice1  =  "₹ \(prod.grossPrice!)"
                //                        let netPrice2  =  "₹ \(prod.netPrice!)"
                //                        let labelstring : NSString = "\(netPrice2)  \(grossPrice1)"
                //
                //                        let string_to_color = "\(netPrice2)"
                //                        let string2 = "\(grossPrice1)"
                //
                //                        let range = (labelstring as NSString).rangeOfString(string_to_color)
                //                        let range2 = (labelstring as NSString).rangeOfString(string2)
                //
                //
                //
                //                        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
                //
                //                        attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
                //                        attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 11)!], range: range2)
                //                        attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
                //                        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
                //
                //                        cell.priceLabel.attributedText = attributedText
                //
                //                    }
                //
                //
                //
                //                }
                //                else
                //                {
                //                    if(prod.netPrice! == "Price Not Available"){
                //                        cell.priceLabel.text = "\(prod.netPrice!)"
                //                    }else{
                //                        cell.priceLabel.text = "₹ \(prod.netPrice!)"
                //                    }
                //                   // cell.actualPriceLbl.text = ""
                //                    //cell.priceLabel.text = "₹ \(prod.netPrice!)"
                //                }
                
                let url =  prod.imageURLHigh
                let imgURL: NSURL = NSURL(string: url!)!
                //print(imgURL.absoluteString)
                
                if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
                {
                   // print("IN cache")
                    cell.prodImg.image = image
                    
                }
                else
                {
                    Alamofire.request(.GET, imgURL)
                        .responseImage { response in
                            debugPrint(response)
                            
//                            print(response.request)
//                            print(response.response)
                            debugPrint(response.result)
                            
                            
                            
                            
                            if let image = response.result.value {
                                //print(imgURL.absoluteString)
                                cell.prodImg.image = image
                                photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                            }
                            else
                            {
                                let image : UIImage = UIImage(named:"placeholder")!
                                cell.prodImg.image = image
                                //photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                            }
                    }
                }
                
            }else
            {
                //print("data is not available")
                let headers = [
                    "Authorization":authorizationWithoutLogin,
                    "Accept": "application/json"
                ]
                let data = self.recentlyViewedArray.objectAtIndex(indexPath.row) as! String
              //  let url = NSURL(string:"\(baseUrl)product?txtSearch=\(data)")
              //  print(url!.absoluteString, terminator: "")
                if  let url = NSURL(string:"\(baseUrl)product?txtSearch=\(data)")
                {
                
                Alamofire.request(.GET, url,headers: headers).validate(contentType: ["application/json"])
                    
                    .responseJSON { response in
                        //.responseObject { (response: Response<ProductDetails, NSError>) in      //responseJSON { response in
//                        print(response.request)  // original URL request
//                        print(response.response) // URL response
//                        print(response.data)     // server data
//                        print(response.result)
                        if let JSON = response.result.value {
                            
                            let customer : Array<ProductDetails> = Mapper<ProductDetails>().mapArray(JSON)!
                          //  print(customer)
                            if customer.count != 0{
                                if let prod = customer[0] as? ProductDetails{
                                    self.recencetlyDataArray .addObject(prod)
                                   // print(prod.description)
                                    // print(prod.netPriceDisplayString!)
                                    cell.categoryLabl.text = prod.description
                                    cell.sku = prod.sku
                                    
                                    if(prod.showPerc!){
                                        cell.DescriptionLbl.hidden = false
                                        cell.DescriptionLbl.text = String(format:"%@Off  ",prod.percentage!)
                                        
                                        let grossPrice1  =  "₹ \(prod.grossPriceDisplayString!)"
                                        let netPrice2  =  "₹ \(prod.netPriceDisplayString!)"
                                        let labelstring : NSString = "\(netPrice2)  \(grossPrice1)"
                                        
                                        let string_to_color = "\(netPrice2)"
                                        let string2 = "\(grossPrice1)"
                                        
                                        let range = (labelstring as NSString).rangeOfString(string_to_color)
                                        let range2 = (labelstring as NSString).rangeOfString(string2)
                                        
                                        
                                        
                                        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
                                        
                                        attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
                                        attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 11)!], range: range2)
                                        attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
                                        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
                                        
                                        cell.priceLabel.attributedText = attributedText
                                        
                                    }else{
                                        cell.DescriptionLbl.hidden = true
                                        //cell.DescriptionLbl.text = String(format:"%@Off  ",prod.percentage!)
                                        
                                        if let netPrice2  =  prod.netPriceDisplayString{
                                            if (netPrice2 == "Price Not Available")
                                            {
                                                cell.priceLabel.text = "Price Not Available"
                                            }else{
                                                cell.priceLabel.text = "₹ \(prod.netPriceDisplayString!)"
                                            }
                                        }else{
                                            cell.priceLabel.text = "Price Not Available"
                                        }
                                    }
                                    
                                    if(prod.isNewProd!){
                                        cell.newProdImgView.hidden = false
                                    }else{
                                        cell.newProdImgView.hidden = true
                                    }
                                    // cell.priceLabel.text = String("₹ \(prod.netPrice!)")
                                    //                                let pna =  prod.pnaSuccess!
                                    //                                if  ( pna == "true")
                                    //                                {
                                    //                                    let grossPrice  =  "\(prod.grossPrice!)"
                                    //
                                    //                                    if (grossPrice == "null")
                                    //                                    {
                                    //
                                    //                                        cell.priceLabel.text = "₹ \(prod.netPrice!)"
                                    //                                         cell.DescriptionLbl.hidden = true
                                    //
                                    //                                    }
                                    //                                    else
                                    //                                    {
                                    //
                                    //                                        var  ntprice = prod.netPrice!.stringByReplacingOccurrencesOfString(",", withString: "")
                                    //                                        var  grprice = prod.grossPrice!.stringByReplacingOccurrencesOfString(",", withString: "")
                                    //                                        //discount offers label
                                    //                                        var  nprice1:Float? = Float(ntprice)
                                    //                                        var  gprice1:Float? = Float(grprice)
                                    //                                        let discountper1 :Float? = 100 - ((nprice1!/gprice1!)*100)
                                    //
                                    //
                                    //
                                    //
                                    //
                                    //                                       let grossPrice1  =  "₹ \(prod.grossPrice!)"
                                    //                                        let netPrice2  =  "₹ \(prod.netPrice!)"
                                    //                                        let labelstring : NSString = "\(netPrice2)  \(grossPrice1)"
                                    //
                                    //                                        let string_to_color = "\(netPrice2)"
                                    //                                        let string2 = "\(grossPrice1)"
                                    //
                                    //                                        let range = (labelstring as NSString).rangeOfString(string_to_color)
                                    //                                        let range2 = (labelstring as NSString).rangeOfString(string2)
                                    //
                                    //
                                    //
                                    //                                        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
                                    //
                                    //                                        attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
                                    //                                        attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 11)!], range: range2)
                                    //                                        attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
                                    //                                        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
                                    //
                                    //                                        cell.priceLabel.attributedText = attributedText
                                    //                                        
                                    //                                    }
                                    //                                    
                                    //                                    
                                    //                                    
                                    //                                }
                                    //                                else
                                    //                                {
                                    //                                    if(prod.netPrice! == "Price Not Available"){
                                    //                                        cell.priceLabel.text = "\(prod.netPrice!)"
                                    //                                    }else{
                                    //                                        cell.priceLabel.text = "₹ \(prod.netPrice!)"
                                    //                                    }
                                    //                                    //cell.priceLabel.text = "₹ \(prod.netPrice!)"
                                    //                                }
                                    let url =  prod.imageURLHigh
                                    let imgURL: NSURL = NSURL(string: url!)!
                                    //print(imgURL.absoluteString)
                                    
                                    if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
                                    {
                                        print("IN cache")
                                        cell.prodImg.image = image
                                        
                                    }
                                    else
                                    {
                                        Alamofire.request(.GET, imgURL)
                                            .responseImage { response in
                                                debugPrint(response)
                                                
//                                                print(response.request)
//                                                print(response.response)
                                                debugPrint(response.result)
                                                
                                                
                                                
                                                
                                                if let image = response.result.value {
                                                   // print(imgURL.absoluteString)
                                                    cell.prodImg.image = image
                                                    photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                                                }
                                                else
                                                {
                                                    let image : UIImage = UIImage(named:"placeholder")!
                                                    cell.prodImg.image = image
                                                    //photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                                                }
                                        }
                                    }
                                }
                            }
                        }
                        
                }
                }
            }
            //let grossPrice  =  "\(prod.grossPrice!)"
          //  if  ( pna == "true")
           // {
//                let grossPrice  =  self.recentlyViewedArray[indexPath.row].valueForKey("grossPrice")! as! String
//                let netPrice = self.recentlyViewedArray[indexPath.row].valueForKey("netPrice")! as! String
//            print("gross price \(grossPrice)")
//                if (grossPrice == "null" || grossPrice.characters.count == 0)
//                {
//                    
//                    if(netPrice == "Price Not Available")
//                    {
//                        cell.priceLabel.text = "\(netPrice)"
//                    }
//                    else
//                    {
//                        if(netPrice == ""){
//                            cell.priceLabel.text = "\(netPrice)"
//                        }else{
//                            cell.priceLabel.text = "₹ \(netPrice)"
//                        }
//                        
//                    }
//                      cell.DescriptionLbl.hidden = true
//                }
//                else
//                {
//                    print(netPrice)
//                    print(grossPrice)
//                    var   ntprice  : String = netPrice.stringByReplacingOccurrencesOfString("₹ ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
//                    
//                    var   grprice  : String = grossPrice.stringByReplacingOccurrencesOfString("₹ ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
//
//                    ntprice = ntprice.stringByReplacingOccurrencesOfString(",", withString: "")
//                    grprice = grprice.stringByReplacingOccurrencesOfString(",", withString: "")
//                    //discount offers label
//                    var  nprice:Float? = Float(ntprice)
//                    var  gprice:Float? = Float(grprice)
////                    if (nprice! .isZero) {
////                         cell.DescriptionLbl.hidden = true
////                    }
////                    else {
//                    let discountper :Float? = 100 - ((nprice!/gprice!)*100)
//                    if(Int(discountper!) == 0)
//                    {
//                        cell.DescriptionLbl.hidden = true
//                        cell.DescriptionLbl.text = String(format:"%@%% Off  ",String(Int(discountper!)))
//                    }
//                    else{
//                        cell.DescriptionLbl.hidden = false
//                        cell.DescriptionLbl.text = String(format:"%@%% Off  ",String(Int(discountper!)))
//                    }
                   // }
                    
//                    cell.DescriptionLbl.hidden = false
//                    cell.DescriptionLbl.text = String(format:"%@%% Off  ",String(Int(discountper!)))
                    //end

            
            
                    
//                    let labelstring : NSString = "\(netPrice)  \(grossPrice)"
//                    
//                    let string_to_color = "\(netPrice)"
//                    let string2 = "\(grossPrice)"
//                    
//                    let range = (labelstring as NSString).rangeOfString(string_to_color)
//                    let range2 = (labelstring as NSString).rangeOfString(string2)
//                    
//                    
//                    
//                    let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
//                    
//                    attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
//                    attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 11)!], range: range2)
//                    attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
//                    attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
//                    
//                    cell.priceLabel.attributedText = attributedText
            
               // }
        /*   var shwprc = self.recentlyViewedArray[indexPath.row].valueForKey("showPerc")! as! Bool
            if(shwprc){
                cell.DescriptionLbl.hidden = false
                cell.DescriptionLbl.text = String(format:"%@",self.recentlyViewedArray[indexPath.row].valueForKey("percentage")! as! String)
                
                let grossPrice1  =  "\(self.recentlyViewedArray[indexPath.row].valueForKey("grossPrice")! as! String)"
                let netPrice2  =  "\(self.recentlyViewedArray[indexPath.row].valueForKey("netPrice")! as! String)"
                let labelstring : NSString = "\(netPrice2)  \(grossPrice1)"
                
                let string_to_color = "\(netPrice2)"
                let string2 = "\(grossPrice1)"
                
                let range = (labelstring as NSString).rangeOfString(string_to_color)
                let range2 = (labelstring as NSString).rangeOfString(string2)
                
                
                
                let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
                
                attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
                attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 11)!], range: range2)
                attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
                attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
                
                cell.priceLabel.attributedText = attributedText
            }else{
                cell.DescriptionLbl.hidden = true
                // cell.DescriptionLbl.text = String(format:"%@Off  ",prod.percentage!)
                
                if let netPrice2  =  self.recentlyViewedArray[indexPath.row].valueForKey("netPrice")! as? String{
                    cell.priceLabel.text = "\(netPrice2)"
                }else{
                    cell.priceLabel.text = "Price Not Available"
                }
            }
            
            
            
//  let grossPrice  =  self.recentlyViewedArray[indexPath.row].valueForKey("grossPrice")! as! String
            
            let url =  self.recentlyViewedArray[indexPath.row].valueForKey("imageURLHigh")! as! String
            let imgURL: NSURL = NSURL(string: url)!
            print("$$$$$$$$$$$ \(imgURL.absoluteString)")
            
            if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
            {
                print("IN cache")
                cell.prodImg.image = image
                
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
                            cell.prodImg.image = image
                            photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                        }
                        else
                        {
                            let image : UIImage = UIImage(named:"placeholder")!
                            cell.prodImg.image = image
                           // photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                        }
                }
            }*/
            
            return cell
        }
        else if collectionView == newArrivalViewCollection
        {
            // get a reference to our storyboard cell
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("newarrival", forIndexPath: indexPath) as! RecentViewCell
            cell.categoryLabl.lineBreakMode = .ByWordWrapping // or NSLineBreakMode.ByWordWrapping
            cell.categoryLabl.numberOfLines = 0
            let image : UIImage = UIImage(named:"placeholder")!
            cell.prodImg.image = image
            cell.categoryLabl.text = ""
            cell.priceLabel.text = ""
            cell.DescriptionLbl.hidden = true
            
            if (self.newArrivalDataArray.count > indexPath.row){
//                print("data is available")
//                print("newArrivalDataArray:",self.newArrivalDataArray.description)
                let prod = self.newArrivalDataArray.objectAtIndex(indexPath.row) as! ProductDetails
                cell.categoryLabl.text = prod.description
                cell.sku = prod.sku
                if(prod.showPerc!){
                    cell.DescriptionLbl.hidden = false
                    cell.DescriptionLbl.text = String(format:"%@Off  ",prod.percentage!)
                    
                    let grossPrice1  =  "₹ \(prod.grossPriceDisplayString!)"
                    let netPrice2  =  "₹ \(prod.netPriceDisplayString!)"
                    let labelstring : NSString = "\(netPrice2)  \(grossPrice1)"
                    
                    let string_to_color = "\(netPrice2)"
                    let string2 = "\(grossPrice1)"
                    
                    let range = (labelstring as NSString).rangeOfString(string_to_color)
                    let range2 = (labelstring as NSString).rangeOfString(string2)
                    
                    
                    
                    let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
                    
                    attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
                    attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 11)!], range: range2)
                    attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
                    attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
                    
                    cell.priceLabel.attributedText = attributedText
                }else{
                    cell.DescriptionLbl.hidden = true
                   // cell.DescriptionLbl.text = String(format:"%@Off  ",prod.percentage!)
                    
                    if let netPrice2  =  prod.netPriceDisplayString{
                        if (netPrice2 == "Price Not Available")
                        {
                            cell.priceLabel.text = "Price Not Available"
                        }else{
                        cell.priceLabel.text = "₹ \(prod.netPriceDisplayString!)"
                    }
                    }else{
                        cell.priceLabel.text = "Price Not Available"
                    }
                }

                if(prod.isNewProd!){
                    cell.newProdImgView.hidden = false
                }else{
                    cell.newProdImgView.hidden = true
                    
                }
//               let pna =  prod.pnaSuccess!
//                if  ( pna == "true")
//                {
//                    let grossPrice  =  "\(prod.grossPrice!)"
//                    
//                    if (grossPrice == "null")
//                    {
//                       // cell.actualPriceLbl.text = ""
//                      //  cell.DiscountLbl.hidden = true
//                        cell.priceLabel.text = "₹ \(prod.netPrice!)"
//                         cell.DescriptionLbl.hidden = true
//                    }
//                    else
//                    {
//                        //discount offers label
//                      var  ntprice = prod.netPrice!.stringByReplacingOccurrencesOfString(",", withString: "")
//                      var  grprice = prod.grossPrice!.stringByReplacingOccurrencesOfString(",", withString: "")
//                        var  nprice1:Float? = Float(ntprice)
//                        var  gprice1:Float? = Float(grprice)
//                        let discountper1 :Float? = 100 - ((nprice1!/gprice1!)*100)
//                        
//                        
////                        cell.DescriptionLbl.hidden = false
////                        cell.DescriptionLbl.text = String(format:"%@%% Off  ",String(Int(discountper1!)))
//                        //end
//                        
//                        let grossPrice1  =  "₹ \(prod.grossPrice!)"
//                        let netPrice2  =  "₹ \(prod.netPrice!)"
//                        let labelstring : NSString = "\(netPrice2)  \(grossPrice1)"
//                        
//                        let string_to_color = "\(netPrice2)"
//                        let string2 = "\(grossPrice1)"
//                        
//                        let range = (labelstring as NSString).rangeOfString(string_to_color)
//                        let range2 = (labelstring as NSString).rangeOfString(string2)
//                        
//                        
//                        
//                        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
//                        
//                        attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
//                        attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 11)!], range: range2)
//                        attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
//                        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
//                        
//                        cell.priceLabel.attributedText = attributedText
//                        
//                    }
//                    
//                    
//                    
//                }
//                else
//                {
//                    if(prod.netPrice! == "Price Not Available"){
//                        cell.priceLabel.text = "\(prod.netPrice!)"
//                    }else{
//                        cell.priceLabel.text = "₹ \(prod.netPrice!)"
//                    }
//                   // cell.actualPriceLbl.text = ""
//                    //cell.priceLabel.text = "₹ \(prod.netPrice!)"
//                }
                
                let url =  prod.imageURLHigh
                let imgURL: NSURL = NSURL(string: url!)!
               // print(imgURL.absoluteString)
                
                if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
                {
                    //print("IN cache")
                    cell.prodImg.image = image
                    
                }
                else
                {
                    Alamofire.request(.GET, imgURL)
                        .responseImage { response in
                            debugPrint(response)
                            
//                            print(response.request)
//                            print(response.response)
                            debugPrint(response.result)
                            
                            
                            
                            
                            if let image = response.result.value {
                                //print(imgURL.absoluteString)
                                cell.prodImg.image = image
                                photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                            }
                            else
                            {
                                let image : UIImage = UIImage(named:"placeholder")!
                                cell.prodImg.image = image
                                //photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                            }
                    }
                }
               
            }else
            {
               // print("data is not available")
                let headers = [
                    "Authorization":authorizationWithoutLogin,
                    "Accept": "application/json"
                ]
                let data = self.newArrivalArray.objectAtIndex(indexPath.row).stringByTrimmingCharactersInSet(
                    NSCharacterSet.whitespaceAndNewlineCharacterSet())
                let url = NSURL(string:"\(baseUrl)product?txtSearch=\(data)")
               // print(url!.absoluteString, terminator: "")
                
                
                Alamofire.request(.GET, url!,headers: headers).validate(contentType: ["application/json"])
                    
                    .responseJSON { response in
                        //.responseObject { (response: Response<ProductDetails, NSError>) in      //responseJSON { response in
//                        print(response.request)  // original URL request
//                        print(response.response) // URL response
//                        print(response.data)     // server data
//                        print(response.result)
                        if let JSON = response.result.value {
                            
                            let customer : Array<ProductDetails> = Mapper<ProductDetails>().mapArray(JSON)!
                            //print(customer)
                            if customer.count != 0{
                           if let prod = customer[0] as? ProductDetails{
                                self.newArrivalDataArray .addObject(prod)
                                //print(prod.description)
                            // print(prod.netPriceDisplayString!)
                                cell.categoryLabl.text = prod.description
                                cell.sku = prod.sku
                            
                            if(prod.showPerc!){
                                cell.DescriptionLbl.hidden = false
                                cell.DescriptionLbl.text = String(format:"%@Off  ",prod.percentage!)
                                
                                let grossPrice1  =  "₹ \(prod.grossPriceDisplayString!)"
                                let netPrice2  =  "₹ \(prod.netPriceDisplayString!)"
                                let labelstring : NSString = "\(netPrice2)  \(grossPrice1)"
                                
                                let string_to_color = "\(netPrice2)"
                                let string2 = "\(grossPrice1)"
                                
                                let range = (labelstring as NSString).rangeOfString(string_to_color)
                                let range2 = (labelstring as NSString).rangeOfString(string2)
                                
                                
                                
                                let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
                                
                                attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
                                attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 11)!], range: range2)
                                attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
                                attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
                                
                                cell.priceLabel.attributedText = attributedText
                                
                            }else{
                                cell.DescriptionLbl.hidden = true
                                //cell.DescriptionLbl.text = String(format:"%@Off  ",prod.percentage!)
                                
                                if let netPrice2  =  prod.netPriceDisplayString{
                                    if (netPrice2 == "Price Not Available")
                                    {
                                        cell.priceLabel.text = "Price Not Available"
                                    }else{
                                        cell.priceLabel.text = "₹ \(prod.netPriceDisplayString!)"
                                    }
                                }else{
                                    cell.priceLabel.text = "Price Not Available"
                                }
                            }
                            
                            if(prod.isNewProd!){
                                cell.newProdImgView.hidden = false
                            }else{
                                cell.newProdImgView.hidden = true
                            }
                               // cell.priceLabel.text = String("₹ \(prod.netPrice!)")
//                                let pna =  prod.pnaSuccess!
//                                if  ( pna == "true")
//                                {
//                                    let grossPrice  =  "\(prod.grossPrice!)"
//                                    
//                                    if (grossPrice == "null")
//                                    {
//                                       
//                                        cell.priceLabel.text = "₹ \(prod.netPrice!)"
//                                         cell.DescriptionLbl.hidden = true
//                                        
//                                    }
//                                    else
//                                    {
//                                        
//                                        var  ntprice = prod.netPrice!.stringByReplacingOccurrencesOfString(",", withString: "")
//                                        var  grprice = prod.grossPrice!.stringByReplacingOccurrencesOfString(",", withString: "")
//                                        //discount offers label
//                                        var  nprice1:Float? = Float(ntprice)
//                                        var  gprice1:Float? = Float(grprice)
//                                        let discountper1 :Float? = 100 - ((nprice1!/gprice1!)*100)
//                                        
//                                        
//
//
//                                        
//                                       let grossPrice1  =  "₹ \(prod.grossPrice!)"
//                                        let netPrice2  =  "₹ \(prod.netPrice!)"
//                                        let labelstring : NSString = "\(netPrice2)  \(grossPrice1)"
//                                        
//                                        let string_to_color = "\(netPrice2)"
//                                        let string2 = "\(grossPrice1)"
//                                        
//                                        let range = (labelstring as NSString).rangeOfString(string_to_color)
//                                        let range2 = (labelstring as NSString).rangeOfString(string2)
//                                        
//                                        
//                                        
//                                        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
//                                        
//                                        attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
//                                        attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 11)!], range: range2)
//                                        attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
//                                        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
//                                        
//                                        cell.priceLabel.attributedText = attributedText
//                                        
//                                    }
//                                    
//                                    
//                                    
//                                }
//                                else
//                                {
//                                    if(prod.netPrice! == "Price Not Available"){
//                                        cell.priceLabel.text = "\(prod.netPrice!)"
//                                    }else{
//                                        cell.priceLabel.text = "₹ \(prod.netPrice!)"
//                                    }
//                                    //cell.priceLabel.text = "₹ \(prod.netPrice!)"
//                                }
                                let url =  prod.imageURLHigh
                                let imgURL: NSURL = NSURL(string: url!)!
                               // print(imgURL.absoluteString)
                                
                                if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
                                {
                                    //print("IN cache")
                                    cell.prodImg.image = image
                                    
                                }
                                else
                                {
                                    Alamofire.request(.GET, imgURL)
                                        .responseImage { response in
                                            debugPrint(response)
                                            
//                                            print(response.request)
//                                            print(response.response)
                                            debugPrint(response.result)
                                            
                                            
                                            
                                            
                                            if let image = response.result.value {
                                               // print(imgURL.absoluteString)
                                                cell.prodImg.image = image
                                                photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                                            }
                                            else
                                            {
                                                let image : UIImage = UIImage(named:"placeholder")!
                                                cell.prodImg.image = image
                                                //photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                                            }
                                    }
                                }
                            }
                        }
                        }
                        
                }
                }
            
            
            return cell
        }
        else if collectionView == brandViewCollection
        {
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("brandcell", forIndexPath: indexPath) as! BrandLogoCell
            let vendor = self.vendorArray.objectAtIndex(indexPath.row) as! VendorLogoList
            //cell.delegates = self
            cell.vendorDet = vendor
            let image : UIImage = UIImage(named:"placeholder")!
            cell.logoImg.image = image
            let imgURL: NSURL = NSURL(string: vendor.featuredVendorLogo!)!
            //print(imgURL.absoluteString)
            
            if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
            {
               // print("IN cache")
                cell.logoImg.image = image
                
            }
            else
            {
                Alamofire.request(.GET, imgURL)
                    .responseImage { response in
                        debugPrint(response)
                        
//                        print(response.request)
//                        print(response.response)
                        debugPrint(response.result)
                        
                        
                        
                        
                        if let image = response.result.value {
                           // print(imgURL.absoluteString)
                            cell.logoImg.image = image
                            photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                        }
                        else
                        {
                            let image : UIImage = UIImage(named:"placeholder")!
                            cell.logoImg.image = image
                           // photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                        }
                }
                
            }
            
            
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("featuredview", forIndexPath: indexPath) as! RecentViewCell
            
            let image : UIImage = UIImage(named:"placeholder")!
            cell.prodImg.image = image
            cell.categoryLabl.text = ""
            cell.priceLabel.text = ""
            cell.DescriptionLbl.hidden = true
            
            if (self.featuredDataArray.count > indexPath.row)
            {
                //print("data is available")
                
                let prod = self.featuredDataArray.objectAtIndex(indexPath.row) as! ProductDetails
                cell.categoryLabl.text = prod.description
                cell.sku = prod.sku
//                 print("net price:",prod.netPrice)
//                print("net price:",prod.grossPrice)
                
//                let showPercentage = self.featuredDataArray[indexPath.row].valueForKey("showPerc")!
//                print(showPercentage)
                let showPercentage = self.featuredDataArray.objectAtIndex(indexPath.row) as! ProductDetails
               // cell.categoryLabl.text = prod.description
               // print(showPercentage.showPerc)
                if(prod.showPerc!){
                    cell.DescriptionLbl.hidden = false
                    cell.DescriptionLbl.text = String(format:"%@Off  ",prod.percentage!)
                    
                    let grossPrice1  =  "₹ \(prod.grossPriceDisplayString!)"
                    let netPrice2  =  "₹ \(prod.netPriceDisplayString!)"
                    let labelstring : NSString = "\(netPrice2)  \(grossPrice1)"
                    
                    let string_to_color = "\(netPrice2)"
                    let string2 = "\(grossPrice1)"
                    
                    let range = (labelstring as NSString).rangeOfString(string_to_color)
                    let range2 = (labelstring as NSString).rangeOfString(string2)
                    
                    let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
                    
                    attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
                    attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 11)!], range: range2)
                    attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
                    attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
                    
                    cell.priceLabel.attributedText = attributedText
                    
                }else{
                    cell.DescriptionLbl.hidden = true
                   // cell.DescriptionLbl.text = String(format:"%@Off  ",prod.percentage!)
                    
                    
                    if let netPrice2  =  prod.netPriceDisplayString{
                        if (netPrice2 == "Price Not Available")
                        {
                            cell.priceLabel.text = "Price Not Available"
                        }else{
                            cell.priceLabel.text = "₹ \(prod.netPriceDisplayString!)"
                        }
                    }else{
                        cell.priceLabel.text = "Price Not Available"
                    }
                }

//                for showpercent in self.featuredDataArray
//                {
//
//                print(showpercent.valueForKey("showPerc"))
//                }
                
                //cell.priceLabel.text = String("₹ \(prod.netPrice!)")
//                let pna =  prod.pnaSuccess!
//                if  ( pna == "true")
//                {
//                    let grossPrice  =  "\(prod.grossPrice!)"
//                    
//                    if (grossPrice == "null")
//                    {
//                
//                        cell.priceLabel.text = "₹ \(prod.netPrice!)"
//                        cell.DescriptionLbl.hidden = true
//                    }
//                    else
//                    {
//                        var  ntprice = prod.netPrice!.stringByReplacingOccurrencesOfString(",", withString: "")
//                        var  grprice = prod.grossPrice!.stringByReplacingOccurrencesOfString(",", withString: "")
//                        var  nprice1:Float? = Float(ntprice)
//                        var  gprice1:Float? = Float(grprice)
////                        let discountper1 :Float? = 100 - ((nprice1!/gprice1!)*100)
//                       
//                        
////                        cell.DescriptionLbl.hidden = false
////                        cell.DescriptionLbl.text = String(format:"%@%% Off  ",String(Int(discountper1!)))
//                        
//                        let grossPrice1  =  "₹ \(prod.grossPrice!)"
//                        let netPrice2  =  "₹ \(prod.netPrice!)"
//                        let labelstring : NSString = "\(netPrice2)  \(grossPrice1)"
//                        
//                        let string_to_color = "\(netPrice2)"
//                        let string2 = "\(grossPrice1)"
//                        
//                        let range = (labelstring as NSString).rangeOfString(string_to_color)
//                        let range2 = (labelstring as NSString).rangeOfString(string2)
//                        
//                        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
//                        
//                        attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
//                        attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 11)!], range: range2)
//                        attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
//                        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
//                        
//                        cell.priceLabel.attributedText = attributedText
//                        
//                    }
//                    
//                }
//                else
//                {
//                    if(prod.netPrice! == "Price Not Available"){
//                        cell.priceLabel.text = "\(prod.netPrice!)"
//                    }else{
//                        cell.priceLabel.text = "₹ \(prod.netPrice!)"
//                    }
//                    //cell.priceLabel.text = "₹ \(prod.netPrice!)"
//                    cell.DescriptionLbl.hidden = true
//                }
                let url =  prod.imageURLHigh
                let imgURL: NSURL = NSURL(string: url!)!
               // print("img url **** \(imgURL.absoluteString)")
                
                if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
                {
                   // print("IN cache")
                    cell.prodImg.image = image
                    
                }
                else
                {
                    Alamofire.request(.GET, imgURL)
                        .responseImage { response in
                            debugPrint(response)
                            
//                            print(response.request)
//                            print(response.response)
                            debugPrint(response.result)
                            
                            if let image = response.result.value {
                                //print(imgURL.absoluteString)
                                cell.prodImg.image = image
                                photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                            }
                            else
                            {
                                let image : UIImage = UIImage(named:"placeholder")!
                                cell.prodImg.image = image
                                //photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                            }
                    }
                }
                
            }
            else
            {
                //print("data is not available")
                let headers = [
                    "Authorization": authorizationWithoutLogin,
                    "Accept": "application/json"
                ]
              
                
//                var data : String = ""
//                for str in self.featuredArray
//                {
//                    data += "\(str);"
//                }
//                print(data)
                let data = self.featuredArray.objectAtIndex(indexPath.row).stringByTrimmingCharactersInSet(
                    NSCharacterSet.whitespaceAndNewlineCharacterSet())
                
                let url = NSURL(string:"\(baseUrl)product?txtSearch=\(data)")
               // print(url!.absoluteString, terminator: "")
                
                Alamofire.request(.GET, url!,headers: headers).validate(contentType: ["application/json"])
                    .responseJSON { response in
                        //.responseObject { (response: Response<ProductDetails, NSError>) in      //responseJSON { response in
//                        print(response.request)  // original URL request
//                        print(response.response) // URL response
//                        print(response.data)     // server data
//                        print(response.result)
                        if let JSON = response.result.value {
                            //print(JSON)
                            let customer : Array<ProductDetails> = Mapper<ProductDetails>().mapArray(JSON)!
                            let customer1 : Array<LstProducts> = Mapper<LstProducts>().mapArray(JSON)!
//                            print(customer)
//                             print(customer1)
                          /*  if customer1.count != 0
                            {
                                if let prod1 = customer1[0] as? LstProducts
                                {
                                        self.featuredArrayViewAll .addObject(prod1)
                                }
                            }*/
                             if customer.count != 0
                             {
                            if let prod = customer[0] as? ProductDetails{
                                
                                self.featuredDataArray .addObject(prod)
                               
//                                print(prod.description)
//                                print(prod.showPerc!)
                                cell.categoryLabl.text = prod.description
                                cell.sku = prod.sku
                                if(prod.showPerc!){
                                    cell.DescriptionLbl.hidden = false
                                    cell.DescriptionLbl.text = String(format:"%@Off  ",prod.percentage!)
                                    
                                    let grossPrice1  =  "₹ \(prod.grossPriceDisplayString!)"
                                    let netPrice2  =  "₹ \(prod.netPriceDisplayString!)"
                                    let labelstring : NSString = "\(netPrice2)  \(grossPrice1)"
                                    
                                    let string_to_color = "\(netPrice2)"
                                    let string2 = "\(grossPrice1)"
                                    
                                    let range = (labelstring as NSString).rangeOfString(string_to_color)
                                    let range2 = (labelstring as NSString).rangeOfString(string2)
                                    
                                    
                                    
                                    let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
                                    
                                    attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
                                    attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 11)!], range: range2)
                                    attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
                                    attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
                                    
                                    cell.priceLabel.attributedText = attributedText
                                    
                                }else{
                                    cell.DescriptionLbl.hidden = true
                                    //cell.DescriptionLbl.text = String(format:"%@Off  ",prod.percentage!)
                                    
                                    if let netPrice2  =  prod.netPriceDisplayString{
                                        if (netPrice2 == "Price Not Available")
                                        {
                                            cell.priceLabel.text = "Price Not Available"
                                        }else{
                                            cell.priceLabel.text = "₹ \(prod.netPriceDisplayString!)"
                                        }
                                    }else{
                                        cell.priceLabel.text = "Price Not Available"
                                    }
                                }

                               // cell.priceLabel.text = String("₹ \(prod.netPrice!)")
//                                let pna =  prod.pnaSuccess!
//                                if  ( pna == "true")
//                                {
//                                    let grossPrice  =  "\(prod.grossPrice!)"
//                                    
//                                    if (grossPrice == "null")
//                                    {
//                                       
//                                        cell.priceLabel.text = "₹ \(prod.netPrice!)"
//                                        cell.DescriptionLbl.hidden = true
//                                    }
//                                    else
//                                    {
//                                        let  ntprice = prod.netPrice!.stringByReplacingOccurrencesOfString(",", withString: "")
//                                        let  grprice = prod.grossPrice!.stringByReplacingOccurrencesOfString(",", withString: "")
//                                        let  nprice1:Float? = Float(ntprice)
//                                        let  gprice1:Float? = Float(grprice)
//                                        let discountper1 :Float? = 100 - ((nprice1!/gprice1!)*100)
//                                        
//                                        
//                                        
//                                        
////                                        let grossPrice1  =  "₹ \(prod.grossPrice!)"
////                                        let netPrice2  =  "₹ \(prod.netPrice!)"
////                                        let labelstring : NSString = "\(netPrice2)  \(grossPrice1)"
////                                        
////                                        let string_to_color = "\(netPrice2)"
////                                        let string2 = "\(grossPrice1)"
////                                        
////                                        let range = (labelstring as NSString).rangeOfString(string_to_color)
////                                        let range2 = (labelstring as NSString).rangeOfString(string2)
////                                        
////                                        
////                                        
////                                        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
////                                        
////                                        attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
////                                        attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 11)!], range: range2)
////                                        attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
////                                        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
////                                        
////                                        cell.priceLabel.attributedText = attributedText
//                                        
//                                    }
//                                    }
//                                else
//                                {
//                                    if(prod.netPrice! == "Price Not Available"){
//                                        cell.priceLabel.text = "\(prod.netPrice!)"
//                                    }else{
//                                    cell.priceLabel.text = "₹ \(prod.netPrice!)"
//                                    }
//                                }
                                let url =  prod.imageURLHigh
                                let imgURL: NSURL = NSURL(string: url!)!
                               // print("########\(imgURL.absoluteString)")
                                
                                if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
                                {
                                    //print("IN cache")
                                    cell.prodImg.image = image
                                    
                                }
                                else
                                {
                                    Alamofire.request(.GET, imgURL)
                                        .responseImage { response in
                                            debugPrint(response)
                                            
//                                            print(response.request)
//                                            print(response.response)
                                            debugPrint(response.result)
                                            
                                            
                                            
                                            
                                            if let image = response.result.value {
                                               // print(imgURL.absoluteString)
                                                cell.prodImg.image = image
                                                photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                                            }
                                            else
                                            {
                                                let image : UIImage = UIImage(named:"placeholder")!
                                                cell.prodImg.image = image
                                                //photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                                            }
                                    }
                                }
                            }
                            }
                        }
                        
                }
            }
            return cell
        }
        //brandcell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        
        //print("You selected cell #\(indexPath.item)!")
        if(collectionView == recentViewCollection){
          // let cell = self.recentlyViewedArray.objectAtIndex(indexPath.row) as! RecentViewCell
//            print(recencetlyDataArray)
//            print(recentlyViewedArray)
//            if let rvc = self.recencetlyDataArray[indexPath.row].valueForKey("sku")! as? String {
             if let rvc = self.recentlyViewedArray.objectAtIndex(indexPath.row) as? String
             {
                let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("prodDet") as! ViewController
//                secondViewController.skuNumber = self.recentlyViewedArray[indexPath.row].valueForKey("sku")! as! String
               // print(rvc)
                secondViewController.skuNumber = rvc 
                secondViewController.ratingfloat = 0
                self.navigationController?.pushViewController(secondViewController, animated: true)
            }
            
            
        }
        else if(collectionView == featureViewCollection){
            
            var cell = collectionView.cellForItemAtIndexPath(indexPath) as! RecentViewCell
            // let prod = self.featuredDataArray.objectAtIndex(indexPath.row) as! ProductDetails
            if let fvc = cell.sku{
            let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("prodDet") as! ViewController
            secondViewController.skuNumber = cell.sku
            secondViewController.ratingfloat = 0
            self.navigationController?.pushViewController(secondViewController, animated: true)
            }
        }
        else if(collectionView == newArrivalViewCollection){
            var cell = collectionView.cellForItemAtIndexPath(indexPath) as! RecentViewCell
            if let nvc = cell.sku{
            let prod = self.newArrivalDataArray.objectAtIndex(indexPath.row) as! ProductDetails
            let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("prodDet") as! ViewController
            secondViewController.skuNumber = cell.sku
            secondViewController.ratingfloat = 0
            
            self.navigationController?.pushViewController(secondViewController, animated: true)
            }
        }
        else if(collectionView == brandViewCollection){
            //productList
            var cell = collectionView.cellForItemAtIndexPath(indexPath) as! BrandLogoCell
            let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("productList") as! CollectionViewController
           
            secondViewController.comingfrom = "landing"
            secondViewController.keyWords = cell.vendorDet.featuredVendorName
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        
        
    }
    //    (void) vendorBtnClk:vendrDet: VendorLogoList{
    //        print(vendrDet.marketPlaceFeaturedVendorsID)
    //    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    private func createPageViewController() {
        
        // let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        // self.pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        pageController.removeFromParentViewController()
        pageController.view.removeFromSuperview()
        pageController = UIPageViewController.init(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        let tapgesture = UITapGestureRecognizer()
        tapgesture.addTarget(self, action:#selector(LandingViewController.handleOffTap))
        self.pageController?.view.addGestureRecognizer(tapgesture)
        //pageController
       // pageController.view.backgroundColor = UIColor.clearColor()
        pageController.view.sizeToFit()
        pageController.delegate = self
        pageController.dataSource = self
    
        if contentImages.count > 0 {
            let firstController = getItemController(0)!
           // firstController.view.frame=CGRectMake(0, 0, boundss.width, self.bannerView.frame.size.height+40)
            let startingViewControllers = [firstController]
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
//        pageViewController!.delegate = self
//        pageViewController!.dataSource = self
        pageViewController!.view.frame = CGRectMake(0, 0, boundss.width, self.bannerView.frame.size.height+40)
        addChildViewController(pageViewController!)
        self.bannerView.addSubview(pageViewController!.view)
        //view.bringSubviewToFront(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    func handleOffTap() {
        
        
        //print(currntIndex)
       let  inx = currentControllerIndex()
       /* print(contentImages.objectAtIndex(currntIndex))
        let p :String = contentImages.objectAtIndex(currntIndex) as! String
        
        if p.rangeOfString("~") != nil{
            
            let fullNameArr = p.characters.split{$0 == "~"}.map(String.init)
            // or simply:
            // let fullNameArr = fullName.characters.split{" "}.map(String.init)
            
            fullNameArr[0] // First
            fullNameArr[1]
            print(fullNameArr[0],fullNameArr[1])
            let p1 :String = fullNameArr[1] as! String
             let fullNameArr1 = p1.characters.split{$0 == "="}.map(String.init)
            //let keywordsstr = fullNameArr1[1]
            print(fullNameArr1.count)
            if fullNameArr1.count > 1
            {
            print(fullNameArr1[1])
            let decodedString = fullNameArr1[1].stringByRemovingPercentEncoding!
            print(decodedString)*/
            
        if ((self.keywordsArrTemp?.objectAtIndex(inx))! as! String == "")
            
        {
            
            
            
        }
            
        else{
            
            if let emptyKeywords = self.keywordsArrTemp?.objectAtIndex(inx) as? String
                
            {
                
                
                
                if ( self.verifyUrl(emptyKeywords))
                    
                {
                    
                    UIApplication.sharedApplication().openURL(NSURL(string:emptyKeywords)!)
                    
                    
                    
                }
                    
                else
                    
                {
                    
                    let productlistview = self.storyboard?.instantiateViewControllerWithIdentifier("productList") as? CollectionViewController
                    
                    productlistview?.keyWords = self.keywordsArrTemp?.objectAtIndex(inx) as! String
                    
                    productlistview?.comingfrom = "landing"
                    
                    self.navigationController?.pushViewController(productlistview!, animated: true)
                    
                }
                
            }
            
        }
      //  }
           // }
       //     NSLog(@"decodedString %@", decoded);

        //}
    
        
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        
        if let urlString = urlString {
            
            if let url  = NSURL(string: urlString) {
                
                return UIApplication.sharedApplication().canOpenURL(url)
                
            }
            
        }
        
        return false
        
    }
    private func setupPageControl() {
        if(contentImages.count == 1){
            let appearance = UIPageControl.appearance()
            appearance.pageIndicatorTintColor = UIColor.clearColor()
            appearance.currentPageIndicatorTintColor = UIColor.clearColor()
            
            appearance.backgroundColor = UIColor.clearColor()
            appearance.bounds = CGRectMake(0, 30, 0, 0)
        }else{
        
        let appearance = UIPageControl.appearance()
          appearance.pageIndicatorTintColor = UIColor.lightGrayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
      
        appearance.backgroundColor = UIColor.clearColor()
        appearance.bounds = CGRectMake(0, 30, 0, 0)
        }
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
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
        
        let itemController = viewController as! PageItemController
        //print(itemController.itemIndex)
        itemController.view.translatesAutoresizingMaskIntoConstraints = true
        itemController.view.frame=CGRectMake(0, 0, boundss.width, self.bannerView.frame.size.height)
        if itemController.itemIndex+1 < contentImages.count {
            return getItemController(itemController.itemIndex+1)
        }else{
            return getItemController(0)
        }
        
        return nil
    }
    
//    func pageViewController(pageViewController: UIPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
//        <#code#>
//    }
   
//    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController])
//    {
//        // 1
////        if let viewController = pendingViewControllers[0] as? MyPageViewController {
////            // 2
////            self.lastPendingViewControllerIndex = viewController.index
////        }
//    }
//    
//    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
//    {
//        if (!completed)
//        {
//            return
//        }
//        print(pageViewController.viewControllers!.first!.view.tag)
//        //  pageViewController.currentPageIndex = pageViewController.viewControllers!.first!.view.tag //Page Index
//    }
    
    private func getItemController(itemIndex: Int) -> PageItemController? {
        //print(contentImages.count)
        if itemIndex < contentImages.count {
            if let img = contentImages[itemIndex] as? String{
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as! PageItemController
            pageItemController.view.translatesAutoresizingMaskIntoConstraints = true
            pageItemController.view.frame=CGRectMake(0, 0, boundss.width, self.bannerView.frame.size.height)
            pageItemController.contentImageView!.translatesAutoresizingMaskIntoConstraints = true
//                let tapgesture = UITapGestureRecognizer()
//                     tapgesture.addTarget(self, action:"handleOffTap")
//               pageItemController.contentImageView?.addGestureRecognizer(tapgesture)
            pageItemController.contentImageView!.frame=CGRectMake(0, 0, boundss.width, pageItemController.view.frame.size.height)
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = img
                
           // pageItemController.view.backgroundColor = UIColor.yellowColor()
            //pageViewController?.view.backgroundColor = UIColor.clearColor()
           pageItemController.view.bringSubviewToFront(pageItemController.contentImageView!)
            return pageItemController
            }
        }
        
        return nil
    }
    
    // MARK: - Page Indicator
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return contentImages.count
    }
    func setViewControllers(viewControllers: [UIViewController]?, direction: UIPageViewControllerNavigationDirection, animated: Bool, completion: ((Bool) -> Void)?){
        
    }
    
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return currntIndex
    }
    func animateBanner()  {
        if(contentImages.count > 0)
        {  
            currntIndex = currentControllerIndex()
            currntIndex = currntIndex + 1
           // print("currntIndex  \(currntIndex)")
            if(currntIndex < self.contentImages.count){
                let firstController = getItemController(currntIndex)!
                pageController.setViewControllers([firstController], direction: .Forward, animated: true, completion: nil)
            }else{
                currntIndex=0
                let firstController = getItemController(0)!
                pageController.setViewControllers([firstController], direction: .Forward, animated: true, completion: nil)
            }
//          myTimer =  NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(LandingViewController.animateBanner), userInfo: nil, repeats: false)
        }
        

        // firstController.view.frame=CGRectMake(0, 0, boundss.width, self.bannerView.frame.size.height+40)
     //   let startingViewControllers = [firstController]
       
        //animateBanner()
    }
    // MARK: - Additions
    
    func currentControllerIndex() -> Int {
        
        let pageItemController = self.currentController()
        
        if let controller = pageItemController as? PageItemController {
           // print("itemIndex",controller.itemIndex)
            return controller.itemIndex
        }
        
        return -1
    }
    
    func currentController() -> UIViewController? {
        
        if self.pageViewController?.viewControllers?.count > 0 {
            return self.pageViewController?.viewControllers![0]
        }
        
        return nil
    }
    

    
}


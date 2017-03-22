//
//  CollectionViewController.swift
//  TabBar
//
//  Created by inpanr07 on 23/06/16.
//  Copyright (c) 2016 inpanr07. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import AlamofireImage


let reuseIdentifier = "Cell"
let screenSize: CGRect = UIScreen.mainScreen().bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
var wishLstGlobalArray:NSMutableArray!=NSMutableArray()
let photoCache = AutoPurgingImageCache(
    memoryCapacity: 100 * 1024 * 1024,
    preferredMemoryUsageAfterPurge: 60 * 1024 * 1024
)

class Product: NSObject,Mappable {
    var id: String?
    var exception: String?
    var status: String?
    var isCanceled: String?
    var isCompleted: String?
    var creationOptions: String?
    var asyncState: String?
    var isFaulted: String?
    
    var result: Result?
    
    required init?(_ map: Map){
        
    }
    
    
    func mapping(map: Map)
    {
        id <- map["id"]
        exception <- map["exception"]
        status <- map["status"]
        isCanceled <- map["isCanceled"]
        isCompleted <- map["isCompleted"]
        creationOptions <- map["creationOptions"]
        asyncState <- map["asyncState"]
        isFaulted <- map["isFaulted"]
        
        result <- map["result"]
    }
}



class Result: Mappable {
    var product: productObj?
    var  appliedFilters : [appldFilters]?
    
    var   vendorFacet : VndrFacet?
    
    
    
    var pageSize: Int?
    
    var totalCount: Int?
    
    var pageIndex :Int?
    
    var page:String?
    
    var firstItemOnPage:String?
    
    var lastItemOnPage:String?
    
    var netPrice:String?
    
    var grossPrice:String?
    
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        product <- map["product"]
        appliedFilters <- map["appliedFilters"]
        vendorFacet <- map["vendorFacet"]
        pageSize <- map["pageSize"]
        totalCount <- map["totalCount"]
        pageIndex <- map["pageIndex"]
        page <- map["page"]
        firstItemOnPage <- map["firstItemOnPage"]
        
        
    }
}
class LstTechSpecs: Mappable {
    
    var lstTechOptions: [LstTechOptions]?
    var techName :String?
    var techId :String?
    var techCount :String?
    //techCount
    
    required init?(_ map: Map){
        
    }
    func mapping(map: Map)
    {
        lstTechOptions <- map["lstTechOptions"]
        techName <- map["techName"]
        techId <- map["techId"]
        techCount <- map["techCount"]
        
    }
}
class LstTechOptions: Mappable
{
    var dimensionValueId : String?
    var specName : String?
    var recordCount : String?
    //  var checkedVendor : String?
    
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map)
    {
        dimensionValueId <- map["dimensionValueId"]
        specName <- map["specName"]
        recordCount <- map["recordCount"]
        //  checkedVendor <- map["checkedVendor"]
    }
    
}

class VndrFacet: Mappable {
    
    var vendorList: [VndrList]?
    
    required init?(_ map: Map){
        
    }
    
    
    func mapping(map: Map)
    {
        vendorList <- map["vendorList"]
        
    }
}
class VndrList: Mappable
{
    var name : String?
    var vendorId : String?
    var vendorCount : String?
    var checkedVendor : String?
    
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map)
    {
        name <- map["name"]
        vendorId <- map["vendorId"]
        vendorCount <- map["vendorCount"]
        checkedVendor <- map["checkedVendor"]
    }
    
}


class appldFilters: Mappable
{
    var filterName : String?
    var filterType : String?
    var filterId : String?
    
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map)
    {
        filterName <- map["filterName"]
        filterType <- map["filterType"]
        filterId <- map["filterId"]
    }
    
}
class productObj: Mappable {
    var lstProducts: [LstProducts]?
    var lstPrices : [LstPices]?
    var  lstTechSpecs:[LstTechSpecs]?
    var lstUserReview:[LstUserReview]?
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        lstProducts <- map["lstProducts"]
        lstPrices <- map["lstPrices"]
        lstTechSpecs <- map["lstTechSpecs"]
         lstUserReview <- map["lstUserReview"]
    }
}
class LstUserReview: Mappable
{
    var name : String?
    var productCount : Float?
    var rid : Int?
    var reviewCount : String?
    var avgUserReviews : String?
    var isSelected : String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map)
    {
        name <- map["name"]
        productCount <- map["productCount"]
        rid <- map["rid"]
        reviewCount <- map["reviewCount"]
        avgUserReviews <- map["avgUserReviews"]
        isSelected <- map["isSelected"]
    }
    
}
//
//
//
class LstProducts: Mappable {
    var description: String?
    var imageURLHigh: String?
    var dealerPrice: String?
    var netPrice: String?
    var pnaSuccess: String?
    var grossPrice: String?
    var sku: String?
    var ratingCount:[Ratings]?
    var offers:Int?
    var showPerc: Bool?
    var percentage:String?
    var grossPriceDisplayString:String?
    var netPriceDisplayString:String?
    var isNewProd:Bool?
    var reviewCount:Int?
    var avgUserReviews:Float?
    
    required init?(_ map: Map)
    {
        
    }
    
    func mapping(map: Map)
    {
        reviewCount <- map["reviewCount"]
        avgUserReviews <- map["avgUserReviews"]
        description <- map["description"]
        imageURLHigh <- map["imageURLHigh"]
        dealerPrice <- map["dealerPrice"]
        netPrice <- map["netPrice"]
        pnaSuccess <- map["pnaSuccess"]
        grossPrice <- map["grossPrice"]
        sku <- map["sku"]
        ratingCount <- map["ratingCount"]
        offers <- map["offers"]
        showPerc <- map["showPerc"]
        percentage <- map["percentage"]
        netPriceDisplayString <- map["netPriceDisplayString"]
        grossPriceDisplayString <- map["grossPriceDisplayString"]
        isNewProd <- map["isNewProd"]
        
    }
}

class Ratings: Mappable
{
    var overallRating : Int?
    var totalCount : Int?
    var mpn : String?
    
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map)
    {
        overallRating <- map["overallRating"]
        totalCount <- map["totalCount"]
        mpn <- map["mpn"]
    }
    
}
class LstPices: Mappable
{
    // var overallRating : Int?
    var name : String?
    var priceCount : String?
    var pid : Int?
    
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map)
    {
        name <- map["name"]
        priceCount <- map["priceCount"]
        pid <- map["pid"]
        //mpn <- map["mpn"]
    }
    
}
extension UIScrollView {
    /// Sets content offset to the top.
    func resetScrollPositionToTop() {
        self.contentOffset = CGPoint(x: -contentInset.left, y: -contentInset.top)
    }
}

//lstPrices
class CollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate,filterDElegate,myFavDelegate,webServiceDelegate,UITableViewDelegate,UITableViewDataSource,myProdFavDelegate {
    
    @IBOutlet var collectionViewProd: UICollectionView!
    // private let reuseIdentifier = "footer"
    var  headerView : HeaderReusableView!
    
    var URLString:String!
    var filterAppliedLast:NSString!
    var CollectionData : NSMutableArray = NSMutableArray ()
    var globcategoryArray : NSMutableArray = NSMutableArray()
    
     var skuarrayVL : NSArray = NSArray ()
    
    var comingfrom : String!
    
    var searchValue : String!
    
    var setflag : String!
    
    var noDataFlag : String!
    
    var url : NSURL!
    
    var DynamicView : UIView!
    
    var pages : Int!
    
    var activity  : UIActivityIndicatorView!
    
    var activityIndicator: UIActivityIndicatorView!
    
    var skuno : String!
    
    var ratings  : Float!
    
    @IBOutlet var OfferView: UILabel!
    
    @IBOutlet var floatRatingView: FloatRatingView!
    var keyWords:String?
    
    @IBOutlet var sortTable:UITableView!
    @IBOutlet var sortView:UIView!
    let boundss = UIScreen.mainScreen().bounds
    var sortArray:NSArray!
    @IBOutlet var sortHeaderVC:UIView!
    
    var vendorList:VndrFacet!
    var priceArray:NSArray!
    var techSpecArray : NSMutableArray!
    var reviewArray : NSArray!
    
     var selreviewArray : NSMutableArray!
    var selBrandArray : NSMutableArray!
    var selCatArray : NSMutableArray!
    var selPriceArray : NSMutableArray!
    var seltechSpecArray : NSMutableArray!
    var lastAppliedFilter:NSString! = ""
    var serachCalled:String=""
    var currentPage:Int=1
    var totalPages:Int=0
    var pagesize:Int=0
    var totalCount:Int=0
    var callApi:String!=""
    var searchText : String! = ""
    var sortIds:Int!=0
    var appliedfilter:String! = "sort"
    @IBOutlet var noInternetVc:UIView!
    @IBOutlet var noresultLbl:UILabel!
    var dataLayer: TAGDataLayer = TAGManager.instance().dataLayer
    var oldFilter:String=""
    @IBOutlet var noResultVc:UIView!
    @IBOutlet var noResultImg:UIImageView!
    var catId:String=""
    var subCatId:String=""
    var finalCatId:String=""
    @IBOutlet var productListTable:UITableView!
    var hideView : UIView!
    
    @IBOutlet weak var shoppingOutlet: UIButton!
    var showList : Bool = true
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        //self.collectionViewProd.addObserver(self, forKeyPath:"contentSize" , options: NSKeyValueObservingOptions.Old, context: nil)
        
        //        self.navigationController?.navigationBar.titleTextAttributes =
        //            [NSForegroundColorAttributeName : headerColor,
        //             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
        self.navigationController?.interactivePopGestureRecognizer!.enabled = false;
        URLString = ""
        searchText = ""
        url=NSURL.init(string: "")
        techSpecArray = NSMutableArray()
        reviewArray = NSMutableArray()
        
        selBrandArray = NSMutableArray()
        selPriceArray = NSMutableArray()
        selCatArray = NSMutableArray()
        seltechSpecArray = NSMutableArray()
        selreviewArray = NSMutableArray()
        
        
        self.tabBarController?.tabBar.hidden = false
        self.sortArray = ["Relevance","Price High to Low","Price Low to High"]
        self.sortHeaderVC.translatesAutoresizingMaskIntoConstraints = true
        self.sortHeaderVC.frame = CGRectMake(0, 0, 100, 40)
        sortTable.tableHeaderView = sortHeaderVC
        self.collectionView?.registerClass(FooterReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "Footer")
        //      self.collectionView?.registerClass(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
        //print(comingfrom)
        
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0.00000000000000001
        layout.minimumLineSpacing = 0
        // let flow = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        if #available(iOS 9.0, *)
        {
            layout.sectionHeadersPinToVisibleBounds = true
        } else {
            // Fallback on earlier versions
        }
        self.collectionView?.collectionViewLayout = layout
        
        
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.automaticallyAdjustsScrollViewInsets = true
        
        //print(glblArr)
        
        if let b = comingfrom
        {
            if self.comingfrom == "Category"
            {
                if let ttle = keyWords
                {
                    self.title = ttle
                }
               // print(glblArr, terminator: "")
                let catid :AnyObject = glblArr.objectAtIndex(0).valueForKey("categoryID")!
                // http://immarketapi-stg2.azurewebsites.net/api/product?pageNumber=1&searchCriteria=&categoryId=4294967081&priceRange=%3E%205000&filterAppliedLast=price
                catId = catid as! String
                URLString = "\(baseUrl)product?searchCriteria=&categoryId=\(catid)"
                url = NSURL(string:"\(baseUrl)product?searchCriteria=&categoryId=\(catid)")
                //print(url.absoluteString, terminator: "")
            }
            else if self.comingfrom == "SubCategory"
            {
                
                if let ttle = keyWords
                {
                    self.title = ttle
                }
                //print(glblArr, terminator: "")
                let catid :AnyObject = glblArr.objectAtIndex(0).valueForKey("categoryID")!
                let subcatid : AnyObject = glblArr.objectAtIndex(1).valueForKey("categoryID")!
                //           url = NSURL(string:"http://immarketapi-dev.azurewebsites.net/api/product?searchCriteria=&categoryId=\(catid)&subCategoryId=\(subcatid)&pageNumber=1")
                URLString = "\(baseUrl)product?searchCriteria=&categoryId=\(catid)&subCategoryId=\(subcatid)"
//                url = NSURL(string:"\(baseUrl)product?pageNumber=1&searchCriteria=&categoryId=\(catid)&subCategoryId=\(subcatid)")
                url = NSURL(string:"\(baseUrl)product?&searchCriteria=&categoryId=\(catid)&subCategoryId=\(subcatid)")
                catId = catid as! String
                subCatId = subcatid as! String
                //print(url.absoluteString, terminator: "")
               // print("from SubCategory", terminator: "")
            }
                
            else if self.comingfrom == "FinalCategory"
            {
                
                
                if let ttle = keyWords
                {
                    self.title = ttle
                }
                
                var dictry : NSMutableDictionary = NSMutableDictionary ()
                
                
                for (index, element) in glblArr.enumerate()
                {
                    dictry["cat\(index)"] = glblArr[index].valueForKey("categoryID")
                    
                   // print(dictry["cat0"]!, terminator: "")
                    
                    
                }
                
                let catid : AnyObject = dictry["cat0"]!
                //print("\(catid)", terminator: "")
                var subcatid  : AnyObject  = dictry["cat1"]!
                var level3catid:AnyObject!=""
                if let  le3catid : AnyObject = dictry["cat2"]!{
                    level3catid = le3catid
                }
                
                //        let url = NSURL(string:"http://immarketapi-dev.azurewebsites.net/api/product?searchCriteria=&categoryId=\(catid)&subCategoryId=\(subcatid)&category3Id=\(level3catid)&pageNumber=1")
                
                //            url = NSURL(string:"http://immarketapi-dev.azurewebsites.net/api/product?searchCriteria=&categoryId=\(catid)&subCategoryId=\(subcatid)&category3Id=\(level3catid)&pageNumber=1")
                
                catId = catid as! String
                subCatId = subcatid as! String
                finalCatId = level3catid as! String
                URLString = "\(baseUrl)product?searchCriteria=&categoryId=\(catid)&subCategoryId=\(subcatid)&category3Id=\(level3catid)"
                //print("url str \(URLString)")
                url = NSURL(string:"\(baseUrl)product?searchCriteria=&categoryId=\(catid)&subCategoryId=\(subcatid)&category3Id=\(level3catid)")
                
            }
            else if self.comingfrom == "Search"
            {
                catId = ""
                subCatId = ""
                finalCatId = ""
                NSNotificationCenter.defaultCenter().removeObserver(self, name: "refresh", object: nil)
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CollectionViewController.refreshList(_:)), name: "refresh", object: nil)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("SearchViewController") as UIViewController
                self.presentViewController(vc, animated: true , completion: nil)
      
            }
            else if self.comingfrom == "landing"
            {
                catId = ""
                subCatId = ""
                finalCatId = ""
                //print("coming from tag is nil", terminator: "")
                if let ttle = keyWords
                {
                self.title = ttle
                }
                searchText = keyWords
                self.noDataFlag = nil
                let escapepercent = searchText!.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
                // url = NSURL(string:"http://immarketapi-dev.azurewebsites.net/api/product?searchCriteria=\(escapepercent)&pageNumber=1")
                URLString = "\(baseUrl)product?searchCriteria=\(escapepercent)"
                url = NSURL(string:"\(baseUrl)product?searchCriteria=\(escapepercent)")// nope
                //print("url ----- \(url)")
            }
             else if self.comingfrom == "ViewAll"
            {
               // print("url ----- \(url)")
                var window :UIWindow = UIApplication.sharedApplication().keyWindow!
                LoadingOverlay.shared.showOverlay(window)
                self.newArrivalproduct()
//                print(self.CollectionData.description)
               //self.collectionViewProd.reloadData()
                
            }
        
        }
        else
            
        {
            //print("coming from tag is nil", terminator: "")
            self.noDataFlag = nil
          
        }
        
        //print(url, terminator: "")
        
//        if (self.comingfrom == "ViewAll")
//        {
////            var gridlistBtn : UIBarButtonItem = UIBarButtonItem(title: "grid", style: UIBarButtonItemStyle.Plain, target: self, action: "GridBtnClicked")
////            
////            let button = UIButton()
////            button.frame = CGRectMake(0, 0, 51, 31) //won't work if you don't set frame
////            button.setImage(UIImage(named: "gridImg"), forState: .Normal)
////            button.addTarget(self, action: Selector("GridBtnClicked"), forControlEvents: .TouchUpInside)
////            
////            let barButton = UIBarButtonItem()
////            barButton.customView = button
////            self.navigationItem.rightBarButtonItem = barButton
//           // gridlistBtn.setBackgroundImage(, forState: UIControlState.Normal, barMetrics: nil)
//            
//            if let ttle = keyWords
//            {
//                self.title = ttle
//            }
//            
//           // self.navigationItem.rightBarButtonItem = gridlistBtn
////            self.collectionViewProd.contentInset = UIEdgeInsetsZero
////            self.collectionViewProd.scrollIndicatorInsets = UIEdgeInsetsZero;
//
//
//         self.collectionView?.reloadData()
//        }
//        else
//        {
            self.CollectionData.removeAllObjects()
           
            callApi = "view"
            dataLayer.push(["event": "openScreen", "screenName": "prodCatalogScreeniOS"])
            
            if( URLString != ""){
                callGetProductAPI(url!,isCalled: callApi)
            }
            
            collectionViewProd.clipsToBounds = true
            collectionViewProd.layer.masksToBounds = true
       // }
        
        self.productListTable.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
        
        //self.collectionViewProd.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
       
    }
    
    
    @IBAction func pordSearchContBtn(sender: AnyObject) {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "refresh", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshList:", name: "refresh", object: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("SearchViewController") as UIViewController
        self.presentViewController(vc, animated: true , completion: nil)
        
    }
    
    
    
//    - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary  *)change context:(void *)context
//    {
//    // You will get here when the reloadData finished
//    }
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
       //  LoadingOverlay.shared.hideOverlayView()
    }
//    func GridBtnClicked ()
//    {
//        
////    print("gridbtn")
//        let button = UIButton()
//        button.frame = CGRectMake(0, 0, 51, 31) //won't work if you don't set frame
//        button.setImage(UIImage(named: "listImg"), forState: .Normal)
//        button.addTarget(self, action: Selector("ListBtnClicked"), forControlEvents: .TouchUpInside)
//        
//        let barButton = UIBarButtonItem()
//        barButton.customView = button
//        self.navigationItem.rightBarButtonItem = barButton
//    self.listbuttonAction()
//        
//    }
//    func ListBtnClicked ()
//    {
//        let button = UIButton()
//        button.frame = CGRectMake(0, 0, 51, 31) //won't work if you don't set frame
//        button.setImage(UIImage(named: "gridImg"), forState: .Normal)
//        button.addTarget(self, action: Selector("GridBtnClicked"), forControlEvents: .TouchUpInside)
//        
//        let barButton = UIBarButtonItem()
//        barButton.customView = button
//        self.navigationItem.rightBarButtonItem = barButton
//        self.listbuttonAction()
//    }
    func callGetProductAPI(url:NSURL,isCalled:NSString) {
        serachCalled = "no"
        
        
        
       //self.headerView.hidden = false
        //print(self.title)
        if(self.view.subviews.contains(self.noResultVc)){
           // self.noresultLbl.removeFromSuperview()
            self.noResultVc.removeFromSuperview()
        }
        
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            self.noInternetVc.removeFromSuperview()
            if(currentPage == 1 ){
                var window :UIWindow = UIApplication.sharedApplication().keyWindow!
                LoadingOverlay.shared.showOverlay(window)
            }
            if(appliedfilter == ""){
                appliedfilter = "sort"
            }
            
            let headers = [
                "Authorization": authorizationWithoutLogin,
                "Accept": "application/json"
            ]
            let urlstr = "\(url)&pageNumber=\(currentPage)&sortIds=\(sortIds)&filterAppliedLast=\(appliedfilter)&productConditions=\("")"
            //print(appliedfilter)
            Alamofire.request(.GET, NSURL(string:urlstr)!,headers: headers).responseObject { (response: Response<Product, NSError>) in
                
                let productResponse = response.result.value
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)
                var strData = NSString(data: response.data!, encoding: NSUTF8StringEncoding)
//                print("Body: \(strData)")// server data
//                print(response.result)
                
                if(isCalled != "filter"){
                    self.techSpecArray.removeAllObjects()
                    if let techSpecs = productResponse?.result?.product?.lstTechSpecs{
                        for prodt in techSpecs
                        {
                            
                            self.techSpecArray .addObject(prodt)
//                            print("testing")
//                            print("testing2")
                            
                        }
                    }else{
                        self.techSpecArray = NSMutableArray()
                    }
                    
                    //print(productResponse?.result?.product?.lstPrices)
                    if let pricelist = productResponse?.result?.product?.lstPrices{
                        self.priceArray = NSArray.init(array: pricelist)
                        //print("pricelist \(pricelist)")
                    }else{
                        self.priceArray = NSArray()
                    }
                    
                    if let vendorFacet = productResponse?.result?.vendorFacet{
                        //print("applied \(vendorFacet.vendorList)")
                        self.vendorList = vendorFacet
                    }
                    if let reviewlist = productResponse?.result?.product?.lstUserReview{
                        self.reviewArray = NSArray.init(array: reviewlist)
                       // print("pricelist \(reviewlist)")
                    }else{
                        self.reviewArray = NSArray()
                    }
                }
                if let productList1 = productResponse?.result
                {
                    self.totalCount   = productList1.totalCount!
                    let pagecount   = productList1.pageSize!
                    self.pagesize = productList1.pageSize!
                    let roundof  = ceil(Double(self.totalCount)/Double(pagecount))
                    //
                    let introundof = Int(roundof)
//                    print(introundof, terminator: "")
//                    print(productList1.pageIndex!)
                    self.totalPages  = introundof
                    // self.currentPage   = productList1.pageIndex!
                    
                    
                }
                if let appliedFilterList = productResponse?.result?.appliedFilters{
                    //print("applied \(appliedFilterList)")
                    
                    
                    if(appliedFilterList.count > 0){
                        let prodt = appliedFilterList[appliedFilterList.count-1] as appldFilters
                        if(isCalled != "filter"){
                            self.oldFilter = prodt.filterName!
                        self.title = "\(prodt.filterName!)  \(productResponse!.result!.totalCount!) results"

                            let labelstring : NSString = "\(prodt.filterName!)  \(productResponse!.result!.totalCount!) results".stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                            let string_to_color = "\(prodt.filterName!)".stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                            let string2 = "\(productResponse!.result!.totalCount!) results"
                            
                            let range = (labelstring as NSString).rangeOfString(string_to_color)
                            let range2 = (labelstring as NSString).rangeOfString(string2)
                            
                            let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
                            
                            attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Bold", size: 16)!], range: range)
                            attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Bold", size: 14)!], range: range2)
                            //  attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
                            attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
//                            self.navigationController?.title = attributedText
                            let lbl:UILabel=UILabel.init(frame: CGRectMake(0, 0, 200, 30))
                            lbl.attributedText = attributedText
                            lbl.sizeToFit()
                            lbl.lineBreakMode = .ByTruncatingMiddle
                   
                            self.navigationItem.titleView = lbl
                        }else{
                          //  let oldTitle = self.title
                            let string1 = "\(self.oldFilter)  \(productResponse!.result!.totalCount!) results"
                            let  text2 = string1.stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                            self.title = text2

                           //self.title = "\(self.oldFilter)  \(productResponse!.result!.totalCount!) results"
                            let labelstring : NSString = "\(self.oldFilter)  \(productResponse!.result!.totalCount!) results".stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                            let string_to_color = "\(self.oldFilter)".stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                            let string2 = "\(productResponse!.result!.totalCount!) results"
                            
                            let range = (labelstring as NSString).rangeOfString(string_to_color)
                            let range2 = (labelstring as NSString).rangeOfString(string2)
                            
                            
                            
                            let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
                            
                            attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Bold", size: 16)!], range: range)
                            attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Bold", size: 14)!], range: range2)
                            //  attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
                            attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
                            //self.navigationController?.title = attributedText
                            let lbl:UILabel=UILabel.init(frame: CGRectMake(0, 0, 200, 30))
                            lbl.attributedText = attributedText
                            lbl.sizeToFit()
                            lbl.lineBreakMode = .ByTruncatingMiddle
                            self.navigationItem.titleView = lbl;
                        }
                       
                        
                    }else{
                        self.title = "IMOL"
                    }
                    
                }
                if let productList = productResponse?.result?.product?.lstProducts
                {
                    
                    for prodt in productList
                    {
                        
                        self.CollectionData .addObject(prodt)
//                        print("testing")
//                        print("testing2")
                        
                    }
                    
                    if(self.CollectionData.count <= 0)
                    {
                        if(self.callApi != "filter"){
                        LoadingOverlay.shared.hideOverlayView()
                            if(screenHeight == 480)
                            {
                                self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
                                self.noresultLbl.translatesAutoresizingMaskIntoConstraints = true
                                self.noResultImg.frame = CGRectMake((screenSize.width - 120 )/2, 50, 120, 120)
                                self.noresultLbl.frame = CGRectMake(10, 200, screenWidth-20, 21)
                                self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                                self.noResultVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
                                self.shoppingOutlet.translatesAutoresizingMaskIntoConstraints = true
                                self.shoppingOutlet.frame = CGRectMake((screenWidth-214)/2, 240, 214, 30)
                            }
                            else if(screenHeight == 568)
                            {
                                self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
                                self.noresultLbl.translatesAutoresizingMaskIntoConstraints = true
                                self.noResultImg.frame = CGRectMake((screenSize.width - 120 )/2, 100, 120, 120)
                                self.noresultLbl.frame = CGRectMake(10, 250, screenWidth-20, 21)
                                self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                                self.noResultVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
                                self.shoppingOutlet.translatesAutoresizingMaskIntoConstraints = true
                                self.shoppingOutlet.frame = CGRectMake((screenWidth-214)/2, 290, 214, 30)
                            }
                            else
                            {
                        //                        self.noresultLbl = UILabel.init(frame: CGRectMake(0, 150, screenSize.width, 40))
//                        self.noresultLbl.textAlignment = .Center
//                        self.noresultLbl.text = "No Products found for selected category."
                        self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
                        // self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                        self.noresultLbl.translatesAutoresizingMaskIntoConstraints = true
                        self.noResultImg.frame = CGRectMake((screenSize.width - 120 )/2, 150, 120, 120)
                        self.noresultLbl.frame = CGRectMake(10, 330, screenWidth-20, 21)
                        self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                        self.noResultVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
                            }
                        self.view.addSubview(self.noResultVc)
                        self.activity.stopAnimating()
                        }else
                        {
                            self.collectionView?.reloadData()
                            //self.hideView.removeFromSuperview()
                        }
                    }
                    else
                    {
                        if (self.comingfrom == "ViewAll")
                        {
                        
                        }
                        else
                        {
                        self.headerView.listBtn.hidden = false
                            
                        if(self.showList){
//                            self.hideView = UIView(frame: CGRectMake(0, 48, screenWidth, screenHeight-48))
//                            self.hideView.backgroundColor = UIColor.whiteColor()
//                            self.collectionViewProd.addSubview(self.hideView)
//                       // self.headerView.listBtn.setTitle("Grid", forState: .Normal)
                          self.headerView.listBtn.setImage(UIImage.init(named: "gridImg"), forState: .Normal)
                        self.headerView.listDividerLbl.hidden = false
                        self.productListTable.delegate = self
                        self.productListTable.dataSource = self
                        self.productListTable.translatesAutoresizingMaskIntoConstraints = true
                        self.productListTable.frame = CGRectMake(0, 50, screenSize.width, screenSize.height-110)
                           
                        
                            
                        self.view.addSubview(self.productListTable)
                        self.productListTable.reloadData()
                        }
//                            if(self.view.subviews.contains(self.hideView)){
//                                self.hideView.removeFromSuperview()
//                            }
                        self.collectionView?.reloadData()
                        LoadingOverlay.shared.hideOverlayView()
                        //self.noresultLbl.removeFromSuperview()
                        if(self.view.subviews.contains(self.noResultVc)){
                            self.noResultVc.removeFromSuperview()
                            
                        }
                        }
//                        self.productListTable.delegate = self
//                        self.productListTable.dataSource = self
//                        self.productListTable.translatesAutoresizingMaskIntoConstraints = true
//                        self.productListTable.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
//                        self.view.addSubview(self.productListTable)
//                        self.productListTable.reloadData()
                    }
                }
                if(response.result.isFailure)
                {
                    LoadingOverlay.shared.hideOverlayView()
                    if(screenHeight == 480){
                        self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
                        self.noresultLbl.translatesAutoresizingMaskIntoConstraints = true
                        self.noResultImg.frame = CGRectMake((screenSize.width - 120 )/2, 50, 120, 120)
                        self.noresultLbl.frame = CGRectMake(10, 200, screenWidth-20, 21)
                        self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                        self.noResultVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
                        self.shoppingOutlet.translatesAutoresizingMaskIntoConstraints = true
                        self.shoppingOutlet.frame = CGRectMake((screenWidth-214)/2, 240, 214, 30)
                }
                    else if(screenHeight == 568){
                        self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
                        self.noresultLbl.translatesAutoresizingMaskIntoConstraints = true
                        self.noResultImg.frame = CGRectMake((screenSize.width - 120 )/2, 100, 120, 120)
                        self.noresultLbl.frame = CGRectMake(10, 250, screenWidth-20, 21)
                        self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                        self.noResultVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
                        self.shoppingOutlet.translatesAutoresizingMaskIntoConstraints = true
                        self.shoppingOutlet.frame = CGRectMake((screenWidth-214)/2, 290, 214, 30)
                    }else{
                    self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
                    // self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                    self.noresultLbl.translatesAutoresizingMaskIntoConstraints = true
                    self.noResultImg.frame = CGRectMake((screenSize.width - 120 )/2, 150, 120, 120)
                    self.noresultLbl.frame = CGRectMake(10, 330, screenWidth-20, 21)
                    self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                    self.noResultVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
                }
                    self.view.addSubview(self.noResultVc)
                }
                if(self.CollectionData.count <= 0)
                {
                    if(self.callApi != "filter")
                    {
                    LoadingOverlay.shared.hideOverlayView()
                        if(screenHeight == 480)
                        {
                            self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
                            self.noresultLbl.translatesAutoresizingMaskIntoConstraints = true
                            self.noResultImg.frame = CGRectMake((screenSize.width - 120 )/2, 50, 120, 120)
                            self.noresultLbl.frame = CGRectMake(10, 200, screenWidth-20, 21)
                            self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                            self.noResultVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
                            self.shoppingOutlet.translatesAutoresizingMaskIntoConstraints = true
                            self.shoppingOutlet.frame = CGRectMake((screenWidth-214)/2, 240, 214, 30)
                        }
                        else if(screenHeight == 568)
                        {
                            self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
                            self.noresultLbl.translatesAutoresizingMaskIntoConstraints = true
                            self.noResultImg.frame = CGRectMake((screenSize.width - 120 )/2, 100, 120, 120)
                            self.noresultLbl.frame = CGRectMake(10, 250, screenWidth-20, 21)
                            self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                            self.noResultVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
                            self.shoppingOutlet.translatesAutoresizingMaskIntoConstraints = true
                            self.shoppingOutlet.frame = CGRectMake((screenWidth-214)/2, 290, 214, 30)
                        }
                        else
                        {
                    self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
                    // self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                    self.noresultLbl.translatesAutoresizingMaskIntoConstraints = true
                    self.noResultImg.frame = CGRectMake((screenSize.width - 120 )/2, 150, 120, 120)
                    self.noresultLbl.frame = CGRectMake(10, 330, screenWidth-20, 21)
                    self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                    self.noResultVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
                        }
                    self.view.addSubview(self.noResultVc)
                    self.activity.stopAnimating()
                    }
                    else
                    {
                        self.collectionView?.reloadData()
                        LoadingOverlay.shared.hideOverlayView()
                        if(screenHeight == 480){
                            self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
                            self.noresultLbl.translatesAutoresizingMaskIntoConstraints = true
                            self.noResultImg.frame = CGRectMake((screenSize.width - 120 )/2, 50, 120, 120)
                            self.noresultLbl.frame = CGRectMake(10, 200, screenWidth-20, 21)
                            self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                            self.noResultVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
                            self.shoppingOutlet.translatesAutoresizingMaskIntoConstraints = true
                            self.shoppingOutlet.frame = CGRectMake((screenWidth-214)/2, 240, 214, 30)
                        }
                        else if(screenHeight == 568){
                            self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
                            self.noresultLbl.translatesAutoresizingMaskIntoConstraints = true
                            self.noResultImg.frame = CGRectMake((screenSize.width - 120 )/2, 100, 120, 120)
                            self.noresultLbl.frame = CGRectMake(10, 250, screenWidth-20, 21)
                            self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                            self.noResultVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
                            self.shoppingOutlet.translatesAutoresizingMaskIntoConstraints = true
                            self.shoppingOutlet.frame = CGRectMake((screenWidth-214)/2, 290, 214, 30)
                        }else{
                        self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
                        // self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                        self.noresultLbl.translatesAutoresizingMaskIntoConstraints = true
                        self.noResultImg.frame = CGRectMake((screenSize.width - 120 )/2, 50, 120, 120)
                        self.noresultLbl.frame = CGRectMake(10, 230, screenWidth-20, 21)
                        self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                        self.noResultVc.frame = CGRectMake(0, 100, screenSize.width, screenSize.height)
                        }
                        self.view.addSubview(self.noResultVc)
                        self.activity.stopAnimating()

                    }
                }
                else
                {
                    self.noResultVc.removeFromSuperview()
                    self.collectionView?.reloadData()
                   
                    LoadingOverlay.shared.hideOverlayView()
                    //self.noresultLbl.removeFromSuperview()
                    if(self.view.subviews.contains(self.noResultVc)){
                        self.noResultVc.removeFromSuperview()
                        
                    }
                    if(self.view.subviews.contains(self.productListTable)){
                        self.productListTable.reloadData()
                        
                    }
                }
               // print(productResponse?.result)
                if(response.result.isSuccess){
//                     self.activity.stopAnimating()
//                    LoadingOverlay.shared.hideOverlayView()
                }
                
                 self.productListTable.reloadData()
               // LoadingOverlay.shared.hideOverlayView()
                self.collectionView?.reloadData()
                self.collectionView?.performBatchUpdates({
                    //Cell.layer.cornerRadius = 200
                    return
                })
                {
                    completed in
                   //print("completedLoading")
                    self.activity.stopAnimating()
                    LoadingOverlay.shared.hideOverlayView()
                  
                }
                
//                self.activity.stopAnimating()
//                 LoadingOverlay.shared.hideOverlayView()
                
               
            }
            //            self.noInternetVc.translatesAutoresizingMaskIntoConstraints = true
            //            self.noInternetVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
            //            self.view.addSubview(self.noInternetVc)
            
            //  }
        }
        else
        {
            // JHProgressHUD.sharedHUD.hide()
            LoadingOverlay.shared.hideOverlayView()
            self.noInternetVc.translatesAutoresizingMaskIntoConstraints = true
            self.noInternetVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
            self.view.addSubview(self.noInternetVc)
           
        }
    }
    
     func listbuttonAction(){
       // var indx = NSIndexPath.init(forRow: 0, inSection: 0)
       // let headerView = collectionView?.supplementaryViewForElementKind(UICollectionElementKindSectionHeader, atIndexPath: indx) as! HeaderReusableView
        
        
      // if(self.view.subviews.contains(self.productListTable)){
      if(!self.productListTable.hidden){
        
        //self.collectionViewProd.hidden = false
            showList = false
            if let headerviewimage = headerView
            {
           headerView.listBtn.setImage(UIImage.init(named: "listImg"), forState: .Normal)
            }
       // self.headerView.hidden = false
        self.productListTable.hidden = true
            //self.productListTable.removeFromSuperview()
            //self.hideView.removeFromSuperview()
         // self.collectionViewProd.hidden = false
         //self.collectionViewProd.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
            self.collectionViewProd.setContentOffset(self.productListTable.contentOffset, animated: false)
        
        //self.collectionViewProd.setContentOffset(CGPointMake(0, 1000), animated: false)
//            var item = self.collectionView(self.collectionView!, numberOfItemsInSection: 0) - 1
//            var lastItemIndex = NSIndexPath(forItem: item, inSection: 0)
//            self.collectionView?.scrollToItemAtIndexPath(lastItemIndex, atScrollPosition: UICollectionViewScrollPosition.Top, animated: false)
        }
      else{
            showList = true
            if let headerviewimage = headerView
            {
            headerView.listBtn.setImage(UIImage.init(named: "gridImg"), forState: .Normal)
            }
       // self.collectionViewProd.hidden = true
           // headerView.listBtn.setTitle("Grid", forState: .Normal)
             self.headerView.hidden = false
           //self.collectionViewProd.hidden = true
//            self.hideView = UIView(frame: CGRectMake(0, 48, screenWidth, screenHeight-50))
//            self.hideView.backgroundColor = UIColor.whiteColor()
//            self.collectionViewProd.addSubview(self.hideView)
            //self.collectionViewProd = nil
      //  self.productListTable.setContentOffset(self.collectionViewProd.contentOffset, animated: false)
        self.collectionViewProd.setContentOffset(CGPointZero, animated: false)
           //self.productListTable.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
            self.productListTable.delegate = self
            self.productListTable.dataSource = self
            self.productListTable.translatesAutoresizingMaskIntoConstraints = true
            if (self.comingfrom == "ViewAll" )
            {
//                self.collectionViewProd.hidden = true
             self.productListTable.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
            }
            else
            {
//                self.collectionViewProd.hidden = false
            self.productListTable.frame = CGRectMake(0, 50, screenSize.width, screenSize.height-100)
            }
        self.productListTable.hidden = false
           // self.view.addSubview(self.productListTable)
//            self.CollectionData.removeAllObjects()
//            self.collectionViewProd.reloadData()
//            if CollectionData.count == 0
//            {
//            }
//            else
//            {
            self.productListTable.reloadData()
           // }
            
        }
        
        
    }
    func returnDataToPrev(vendrDet:NSMutableArray,priceArray:NSMutableArray,techSpecAray:NSMutableArray,categoryArray:NSMutableArray,fileteApplied:NSString,reviewArray:NSMutableArray){
       // print(self.navigationController?.title)
        if let ttle = self.keyWords
        {
            // self.title = "\(ttle)"
            let titleview : UILabel = UILabel(frame: CGRectMake(10, 0, 200, 30))
            titleview.text = ttle
            titleview.sizeToFit()
            titleview.lineBreakMode = .ByTruncatingMiddle
            self.navigationItem.titleView = titleview
            //self.navigationController?.title = "\(ttle)"
        }
        
       
       // print(self.title)
        selBrandArray = vendrDet
        selPriceArray = priceArray
        selreviewArray = reviewArray
        seltechSpecArray = techSpecAray
        selCatArray = categoryArray
        lastAppliedFilter = fileteApplied
        appliedfilter = fileteApplied as String
        currentPage = 1
        self.CollectionData.removeAllObjects()
        self.collectionView?.reloadData()
        
        //print("filter \(lastAppliedFilter)")
        LoadingOverlay.shared.hideOverlayView()
        //print("selBrandArray \(selBrandArray.count)  selPriceArray \(selPriceArray.count)  seltechSpecArray \(seltechSpecArray.count)  selCatArray \(selCatArray.count) ")
        
        let dictry : NSMutableDictionary = NSMutableDictionary ()
        
        for (index, element) in glblArr.enumerate()
        {
            dictry["cat\(index)"] = glblArr[index].valueForKey("categoryID")
            
            //print(dictry["cat0"]!, terminator: "")
            
            
        }
        var catid : String!=""
        var subcatid  : String!=""
        var level3catid : String!=""
        var cat3id:String=""
        if(dictry.count > 0){
            if let cat = dictry["cat0"]{
                catid  = cat as! String
            }else{
                catid = catId
            }
            // print("\(catid)", terminator: "")
            if let subcat = dictry["cat1"]{
                subcatid  = subcat as! String
            }else{
                subcatid = subCatId
            }
            
            if let cat3 = dictry["cat2"]{
                level3catid  = cat3 as! String
                cat3id = cat3 as! String
            }else{
               cat3id = finalCatId
            }
            
            
            // print("vendor arra \(vendrDet.count)")
        }
        else
        {
            catid  = catId
        //level3catid = ""
            subcatid = subCatId
            
            
        }
        
        
        var vendor:String=""
        
        if(vendrDet.count > 0){
            vendor = vendrDet.componentsJoinedByString(",")
        }else{
            vendor = ""
        }
        
        var revwstr:String=""
        
        if(selreviewArray.count > 0){
            revwstr = selreviewArray.componentsJoinedByString(",")
        }else{
            revwstr = ""
        }
        
        var price:String=""
        if(priceArray.count > 0){
            price =  priceArray.componentsJoinedByString(",")
            price = price.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
          //  price = price.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
           //price = price.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        }else{
            price = ""
        }
        
        if(categoryArray.count > 0){
            cat3id  =  categoryArray.componentsJoinedByString(",")
            cat3id = cat3id.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLUserAllowedCharacterSet())!
        }else{
            cat3id = finalCatId
        }
        var techspec:String=""
        if(techSpecAray.count > 0){
            techspec =  techSpecAray.componentsJoinedByString(",")
            techspec = techspec.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLUserAllowedCharacterSet())!
        }else{
            techspec = ""
        }
        
        //appliedfilter = fileteApplied as String
        URLString = "\(baseUrl)product?pageNumber=1&searchCriteria=\(searchText)&categoryId=\(catid)&subCategoryId=\(subcatid)&category3Id=\(cat3id)&vendorIds=\(vendor)&priceRange=\(price)&techIds=\(techspec)&ReviewId=\(revwstr)"

        
        let urlwithPercentEscapes = "\(baseUrl)product?searchCriteria=\(searchText)&categoryId=\(catid)&subCategoryId=\(subcatid)&category3Id=\(cat3id)&vendorIds=\(vendor)&priceRange=\(price)&techIds=\(techspec)&ReviewId=\(revwstr)".stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet.URLQueryAllowedCharacterSet())
//        let searchtextformat = searchText.stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet.URLQueryAllowedCharacterSet())
      url = NSURL(string:urlwithPercentEscapes!)


        //print(url!)
         self.activity.stopAnimating()
        currentPage = 1
        callApi = "filter"
        
        callGetProductAPI(url!,isCalled: callApi)
        
        
    }
    @IBAction func filterBtnClk(){
      
        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("filterVC") as! FilterViewController
        secondViewController.brandArray = self.vendorList.vendorList
        secondViewController.priceRangeArray = self.priceArray
        secondViewController.techSpecArray = self.techSpecArray.mutableCopy() as! NSMutableArray
        secondViewController.categoryArray = self.globcategoryArray
        secondViewController.delegates=self
        secondViewController.selectedCategoryArray = selCatArray
        secondViewController.selectedPriceArray = selPriceArray
        secondViewController.selectedBrandValArray = selBrandArray
        secondViewController.selectedTechSpecArray = seltechSpecArray
        secondViewController.filterApplied = lastAppliedFilter
        secondViewController.titlewithoutCount = self.keyWords
        secondViewController.selReviewArray = selreviewArray
        secondViewController.reviewArray = reviewArray
        let navigationController = UINavigationController(rootViewController: secondViewController)
        self.presentViewController(navigationController, animated: true, completion: nil)
        
    }
    @IBAction func sortBtnClick(){
        
        self.sortView.translatesAutoresizingMaskIntoConstraints = true
        self.sortView.frame = CGRectMake(0, 0, boundss.width, boundss.height)
        self.view .addSubview(self.sortView)
        
//        print(sortTable.bounds.width)
//        print(boundss.width)
//        print(boundss.height)
    }
    @IBAction func handleTap() {
        //print("tap working")
        self.sortView.removeFromSuperview()
        //view1.removeFromSuperview()
        // view1.alpha = 0.1
    }
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        if scrollView.panGestureRecognizer.translationInView(scrollView).y < 0
        {
           // print("scrolled up", terminator: "")
            
            changeTabBar(true, animated: true)
            
            if (self.CollectionData.count > 0)
            {
                
                let scrollViewHeight = scrollView.frame.size.height;
                let scrollContentSizeHeight = scrollView.contentSize.height;
                let scrollOffset = scrollView.contentOffset.y;
                
                if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
                    if let nonull = self.noDataFlag
                    {
                        
                        //                if ( self.noDataFlag == "noData")
                        //                {
                       // print("No more data", terminator: "")
                        
                        
                        
                    }
                    else
                    {
                        DynamicView=UIView(frame: CGRectMake(0  , 600, screenWidth ,100))
                        DynamicView.backgroundColor = UIColor.clearColor()
                        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
                        myActivityIndicator.color = UIColor.blackColor()
                        
                        myActivityIndicator.transform = CGAffineTransformMakeScale(2.0, 2.0);
                        myActivityIndicator.center = CGPointMake(180.5, 38.0);
                        
                        DynamicView.hidden=true
                        //print(self.CollectionData.count, terminator: "")
                        //                if indexPath.row == self.CollectionData.count-1
                        //                {
                        DynamicView.hidden=false
                        
                        
                    }
                    
                }
                
                
                
            }
        }
        else{
            //print("scrolled down", terminator: "")
            changeTabBar(false, animated: true)
        }
    }
    
   
    override  func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            //reach bottom
            if(currentPage < totalPages){
                
                currentPage = currentPage + 1
                
                if(self.view.subviews.contains(self.productListTable)){
                
                var DynamicView=UIView(frame: CGRectMake(0, 0, boundss.width, 60))
                DynamicView.backgroundColor=UIColor.whiteColor()
                activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
                activity.color = UIColor.init(colorLiteralRed: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                activity.startAnimating()
                activity.hidesWhenStopped = true
                activity.tag = 42
                
                activity.center = CGPointMake(DynamicView.center.x,30)
                DynamicView.addSubview(activity)
                productListTable.tableFooterView = DynamicView
                }
                
                callGetProductAPI(url!, isCalled: callApi)
            }
           
            //print("reach end")
        }
        //self.productListTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        changeTabBar(false, animated: true)
    }
    
    
    func changeTabBar (hidden:Bool , animated:Bool )
    {
       // let tabBar = self.tabBarController?.tabBar
        self.tabBarController?.tabBar.hidden = hidden
        //self.productListTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        //if tabBar!.hidden == hidden{ return }
        
//        let frame = tabBar?.frame
//        
//        let offset = (hidden ? (frame?.size.height)! : -(frame?.size.height)!)
//        
//        let duration:NSTimeInterval = (animated ? 0.3 : 0.0)
//        tabBar?.hidden = false
//        if frame != nil
//        {
//            UIView.animateWithDuration(duration,
//                                       animations: {tabBar!.frame = CGRectOffset(frame!, 0, offset)},
//                                       completion: {
//                                        print($0)
//                                        if $0 {tabBar?.hidden = hidden}
//            })
//        }
        
    }
    
    override func  viewWillAppear(animated: Bool)
    {
        if (self.comingfrom == "ViewAll")
        {
//            var gridlistBtn : UIBarButtonItem = UIBarButtonItem(title: "grid", style: UIBarButtonItemStyle.Plain, target: self, action: "GridBtnClicked")
//            
//            
//           // self.navigationItem.rightBarButtonItem = gridlistBtn
//            
//            let button = UIButton()
//            button.frame = CGRectMake(0, 0, 51, 31) //won't work if you don't set frame
//            button.setImage(UIImage(named: "gridImg"), forState: .Normal)
//            button.addTarget(self, action: Selector("GridBtnClicked"), forControlEvents: .TouchUpInside)
//            
//            let barButton = UIBarButtonItem()
//            barButton.customView = button
//            self.navigationItem.rightBarButtonItem = barButton
//            // gridlistBtn.setBackgroundImage(, forState: UIControlState.Normal, barMetrics: nil)
            
            if let ttle = keyWords
            {
                self.title = ttle
            }
            
            
//            self.collectionViewProd.contentInset = UIEdgeInsetsZero
//            self.collectionViewProd.scrollIndicatorInsets = UIEdgeInsetsZero;
//            // self.collectionView?.reloadData()
//
//            
//            self.collectionView?.reloadData()
        }
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName : headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        
        self.tabBarController?.tabBar.hidden = false

        NSNotificationCenter.defaultCenter().removeObserver(self, name: "cancel", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CollectionViewController.cancelFunctn), name: "cancel", object: nil)
        
         NSNotificationCenter.defaultCenter().removeObserver(self, name: "hideResultCount", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(CollectionViewController.hideResult(_:)),
                                                         name: "hideResultCount",
                                                         object: nil)

        self.collectionView?.reloadData()
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(CollectionViewController.internetReachable(_:)),
                                                         name: "reachable",
                                                         object: nil)

        
        let btnName = UIButton()
        btnName.setImage(UIImage(named: "backButton"), forState: .Normal)
        btnName.frame = CGRectMake(0, 0, 40, 40)
        btnName.addTarget(self, action:#selector(CollectionViewController.btnOpenCamera), forControlEvents: .TouchUpInside)
        
        //.... Set Right/Left Bar Button item
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnName
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        self.productListTable.reloadData()
     
        
     }
    func btnOpenCamera(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    func hideResult(notification:NSNotification)
    {
    //self.title = self.keyWords
        //print(self.title)
    }
    func internetReachable(notification:NSNotification){
       noInternetClk()
        //print("in collection via reachable")
    }
    override func   viewDidAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
        
        
    }
    
    @IBAction func searchSubView(sender: AnyObject)
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "refresh", object: nil)
           NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CollectionViewController.refreshList(_:)), name: "refresh", object: nil)
        // comingfrom = "sameView"
//        print(self.comingfrom)
//        if (self.comingfrom == "ViewAll"){
//            self.headerView.hidden = false
//        }
        setflag = "sameview"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("SearchViewController") as UIViewController
        self.presentViewController(vc, animated: true , completion: nil)
        
    }
    
    
    func refreshList(notification: NSNotification)
    {
        self.comingfrom = "Search"
      LoadingOverlay.shared.hideOverlayView()
        catId = ""
        subCatId = ""
        finalCatId = ""
        serachCalled = "yes"
        sortIds = 0
        appliedfilter = "sort"
        sortTable.reloadData()
        self.CollectionData.removeAllObjects()
        collectionView?.reloadData()
        self.navigationController?.navigationBarHidden = false
        self.noDataFlag = nil
        techSpecArray = NSMutableArray()
        
        selBrandArray = NSMutableArray()
        selPriceArray = NSMutableArray()
        selCatArray = NSMutableArray()
        seltechSpecArray = NSMutableArray()
            self.globcategoryArray.removeAllObjects()
            let dict : AnyObject = notification.userInfo!
            let receivednumber : String = dict["valueToPass"] as! String
            var escapepercent = receivednumber.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            searchText = escapepercent
            self.navigationItem.titleView = nil
            self.title = receivednumber
            // url = NSURL(string:"http://immarketapi-dev.azurewebsites.net/api/product?searchCriteria=\(escapepercent)&pageNumber=1")
            url = NSURL(string:"\(baseUrl)product?searchCriteria=\(escapepercent)")
            URLString = "\(baseUrl)product?searchCriteria=\(escapepercent)"
            callApi = "view"
            currentPage = 1
            dataLayer.push(["event": "openScreen", "screenName": "searchProdScreeniOS"])
            callGetProductAPI(url!,isCalled: callApi)
            NSNotificationCenter.defaultCenter().removeObserver(self, name: "refresh", object: nil)
      //  }
  
    }
  func  newArrivalproduct ()
    {
        
        //LoadingOverlay.shared.showOverlay(window)
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
        //print(self.skuarrayVL)
        var data : String = ""
        for str in self.skuarrayVL
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
                   // print(JSON)
                    self.CollectionData.removeAllObjects()
                    //  let customer : Array<ProductDetails> = Mapper<ProductDetails>().mapArray(JSON)!
                    LoadingOverlay.shared.hideOverlayView()
                    let customer1 : Array<LstProducts> = Mapper<LstProducts>().mapArray(JSON)!
                    // print(customer)
                    //print(customer1)
                    
                    for product in customer1
                    {
                        self.CollectionData .addObject(product)
                        //print(product.description)
                    }
                    
//                    let collectionViewPush = self.storyboard?.instantiateViewControllerWithIdentifier("productList") as! CollectionViewController
//                    collectionViewPush.comingfrom = "ViewAll"
//                    collectionViewPush.keyWords = "New Arrival"
//                    collectionViewPush.CollectionData = self.NewArrArrayViewAll
//                    self.navigationController?.pushViewController(collectionViewPush, animated: true)
                    
                    //print(self.NewArrArrayViewAll)
                }
              self.collectionViewProd.reloadData()
        }
    }

    func cancelFunctn()
    {
        LoadingOverlay.shared.hideOverlayView()
        serachCalled = "no"
        self.navigationController?.navigationBarHidden = false
        if let cancel = setflag
        {
            if(setflag == "sameview")
            {
                //print("same collection view again", terminator: "")
                
            }
        }
        else
        {
            self.navigationController?.popViewControllerAnimated(true)
        }
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "refresh", object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
         self.navigationController?.navigationBar.backItem?.hidesBackButton = false
        // NSNotificationCenter.defaultCenter().removeObserver(self, name: "refresh", object: nil)
        if (self.comingfrom == "ViewAll")
        {
        self.comingfrom = "ViewAll"
        }
        else
        {
        self.comingfrom = ""
        
        }
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "reachable", object: nil)
         self.title = ""
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        // glblArr .removeObjectAtIndex(2)
        
    }
    
    override  func viewDidDisappear(animated: Bool)
    {
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: "refresh", object: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit
    {
       // self.removeObserver(self, forKeyPath: "contentSize")
       // NSNotificationCenter.defaultCenter().removeObserver(self, name: "refresh", object: nil)

       // print("deallocated", terminator: "")
        glblArr .removeLastObject()
        // NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 01
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return self.CollectionData.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        //cell.layer.borderColor = UIColor.gray().CGColor
        let refreshControl : UIActivityIndicatorView = UIActivityIndicatorView ()
        
        cell.delegates = self
      
        let prodt  = self.CollectionData.objectAtIndex(indexPath.row) as! LstProducts
       // print(prodt.imageURLHigh!)
       //ratings
        cell.skuNumber = prodt.sku!
        
        cell.floatRatingView.hidden = false
        cell.ratingLbl.hidden = false
    
        
        if let ratingsc = prodt.reviewCount
        {
            cell.ratingLbl.text = String(format:"(%@)",String(prodt.reviewCount!))
            cell.floatRatingView.rating = prodt.avgUserReviews!
            
//            for productrati in prodt.reviewCount! {
//
//                cell.floatRatingView.hidden = false
//                cell.ratingLbl.hidden = false
//                if let rate = productrati.avg
//                {
//                    //self.ratings = Float(rate)
//                    cell.floatRatingView.rating = Float(rate)
//                    
//                    
//                }
//                else
//                {
//                    // self.ratings = 0
//                    cell.floatRatingView.rating = 0
//                }
//                
//                if let overallRate = productrati.totalCount
//                {
//                    
//                    //    cell.ratingLbl.text = "\((String(overallRate)))"
//                    cell.ratingLbl.text =  String(format:"(%@)",String(overallRate))
//                }
//                else
//                {
//                    cell.ratingLbl.text = String(format:"(0)")
//                }
//            }
        
        }
       cell.productImage.image = nil
        let image : UIImage = UIImage(named:"placeholder")!
        cell.productImage.image = image
        //caching image
        let imgURL: NSURL = NSURL(string: prodt.imageURLHigh!)!
        //print(imgURL.absoluteString)
        
        if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
        {
            //print("IN cache")
            cell.productImage.image = image
            
        }
        else
        {
            Alamofire.request(.GET, imgURL)
                .responseImage { response in
                    debugPrint(response)
                    
//                    print(response.request)
//                    print(response.response)
                    debugPrint(response.result)
                    
                    
                    
                    
                    if let image = response.result.value {
                       // print(imgURL.absoluteString)
                        cell.productImage.image = image
                        photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                    }
                    else
                    {
                        var image : UIImage = UIImage(named:"placeholder")!
                        cell.productImage.image = image
                       // photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                    }
            }
            
        }
        
        
        
        cell.productName.text = prodt.description!
        //end
        
        
        //net price, gross price and discount  label
        if(prodt.showPerc!){
            cell.DiscountLbl.hidden = false
            cell.DiscountLbl.text = String(format:"%@ Off  ",String(prodt.percentage!))
            
            let grossPrice1  =  "₹ \(prodt.grossPriceDisplayString!)"
            let netPrice2  =  "₹ \(prodt.netPriceDisplayString!)"
            let labelstring : NSString = "\(netPrice2)  \(grossPrice1)"
            
            var string_to_color = "\(netPrice2)"
            var string2 = "\(grossPrice1)"
            
            var range = (labelstring as NSString).rangeOfString(string_to_color)
            var range2 = (labelstring as NSString).rangeOfString(string2)
            
            
            
            var attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
            
            attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
            attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 11)!], range: range2)
            attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
            attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
            
            cell.priceLbl.attributedText = attributedText
        }else{
            cell.DiscountLbl.hidden = true

            
            if let percentage = prodt.percentage
            {
//            cell.DiscountLbl.text = String(format:"%@Off  ",String(prodt.percentage!))
                cell.DiscountLbl.text = String(format:"%@ Off  ",String(percentage))
            }
       
            
            if let netPrice2  =  prodt.netPriceDisplayString{
                if (netPrice2 == "Price Not Available")
                {
                    cell.priceLbl.text = "Price Not Available"
                }else{
                    cell.priceLbl.text = "₹ \(prodt.netPriceDisplayString!)"
                }
            }else{
                cell.priceLbl.text = "Price Not Available"
            }
        }
        
        if(prodt.isNewProd!){
            cell.newProdIV.hidden = false
        }else{
            cell.newProdIV.hidden = true
            
        }

        
//        var pna =  prodt.pnaSuccess!
//        if  ( pna == "true")
//        {
//            var grossPrice  =  ""
//            // "\(prodt.grossPrice!)"
//            if let grpr = prodt.grossPrice
//            {
//                grossPrice = grpr
//                
//                
//            }
//            print(grossPrice)
//            
//            if (grossPrice == "null" || grossPrice .isEmpty)
//                
//            {
//                cell.DiscountLbl.hidden = true
//                if let nepr = prodt.netPrice
//                {
//                    if(prodt.netPrice! == "Price Not Available"){
//                        cell.priceLbl.text = "\(prodt.netPrice!)"
//                    }else{
//                        cell.priceLbl.text = "₹ \(prodt.netPrice!)"
//                    }
//                }
//                else
//                {
//                    cell.priceLbl.text = "Price Not Available"
//                    cell.actualPriceLbl.text = ""
//                    cell.DiscountLbl.hidden = true
//                }
//                
//            }
//    
//            else
//            {
//                //discount offers label
//                let  ntprice = prodt.netPrice!.stringByReplacingOccurrencesOfString(",", withString: "")
//                let  grprice = prodt.grossPrice!.stringByReplacingOccurrencesOfString(",", withString: "")
//                let  nprice:Float? = Float(ntprice)
//                let  gprice:Float? = Float(grprice)
//                //let discountper :Float? = 100 - ((nprice!/gprice!)*100)
//                
////                if(Int(discountper!) == 0){
////                    cell.DiscountLbl.hidden = true
////                    cell.DiscountLbl.text = String(format:"%@%% Off  ",String(Int(discountper!)))
////                }else{
////                    cell.DiscountLbl.hidden = false
////                    cell.DiscountLbl.text = String(format:"%@%% Off  ",String(Int(discountper!)))
////                }
//                
//                
//                
//                let grossPrice1  =  "₹ \(prodt.grossPrice!)"
//                let netPrice2  =  "₹ \(prodt.netPrice!)"
//                let labelstring : NSString = "\(netPrice2)  \(grossPrice1)"
//                
//                var string_to_color = "\(netPrice2)"
//                var string2 = "\(grossPrice1)"
//                
//                var range = (labelstring as NSString).rangeOfString(string_to_color)
//                var range2 = (labelstring as NSString).rangeOfString(string2)
//                
//                
//                
//                var attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
//                
//                attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
//                attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 11)!], range: range2)
//                attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
//                attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
//                
//                cell.priceLbl.attributedText = attributedText
//                
//            }
//            
//            
//            
//        }        else
//        {
//            cell.DiscountLbl.hidden = true
//            cell.actualPriceLbl.text = ""
//            //cell.priceLbl.text = "₹ \(prodt.netPrice!)"
//            if(prodt.netPrice! == "Price Not Available"){
//                cell.priceLbl.text = "\(prodt.netPrice!)"
//            }else{
//                cell.priceLbl.text = "₹ \(prodt.netPrice!)"
//            }
//        }
        
        cell.favBtn.tag = indexPath.row
        //end
        
        if wishLstGlobalArray.containsObject(prodt.sku!){
            cell.favBtn.selected = true
        }else{
            cell.favBtn.selected = false
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        if let userId = defaults.objectForKey("userId") as? Int{
            cell.favBtn.hidden = false
        }
        else{
            cell.favBtn.hidden = true
        }
        
        return cell
       
    }
    
    func mycartDelegateFunction(tagInfo:Int,sender:DOFavoriteButton,sku:String){
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true){
        if sender.selected {
            // deselect
            sender.deselect()
            wishLstGlobalArray.removeObject(sku)
            
            let alldta = wishLstGlobalArray.componentsJoinedByString(",") as NSString
            // JHProgressHUD.sharedHUD.showInView(self.view)
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
            wsm.addToWishListDetails(alldta)
            
        } else {
            // select with animation
            wishLstGlobalArray.addObject(sku)
             dataLayer.push(["event": "ButtonPressed", "eventAction": "added to wishlist"])
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
    
    func tapped(sender: DOFavoriteButton) {
        if sender.selected {
            // deselect
            sender.deselect()
            
        } else {
            // select with animation
            sender.select()
            
        }
    }
    func addWishListSuccess(wishList:NSDictionary){
       // print("wishData   \(wishList.valueForKey("wishData"))")
        LoadingOverlay.shared.hideOverlayView()
        //        let wishStr = wishList.valueForKey("wishData")! as! NSString
        //        let array = wishStr.componentsSeparatedByString(",")
        //        wishLstGlobalArray.removeAllObjects()
        //        wishLstGlobalArray = NSMutableArray.init(array: array)
        //        self.collectionView?.reloadData()
    }
    
    
    override func collectionView(collectionView: UICollectionView,
                                 didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
        let prodt  = self.CollectionData.objectAtIndex(indexPath.row) as! LstProducts
        //print(prodt.sku!)
        self.skuno = prodt.sku!
        
        if (self.comingfrom == "ViewAll")
        {
        
        }
        else
        {
            if let ratingsc = prodt.ratingCount
            {

        for productrati in prodt.ratingCount!
        {
            if let rate = productrati.overallRating
            {
                self.ratings = Float(rate)
                //print(self.ratings)
            }
        }
            }
        
        }
        //        if(segue.identifier == "ProductDetail")
        //        {
        //            let viewController = (segue.destinationViewController as! ViewController)
        //            viewController.skuNumber = self.skuno
        //            //  print(self.ratings)
        //            if let ratingsvalue = self.ratings
        //            {
        //                viewController.ratingfloat = self.ratings
        //            }
        //            else
        //            {
        //                viewController.ratingfloat = 0
        //            }
        //        }
        
        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("prodDet") as! ViewController
        secondViewController.skuNumber = self.skuno
        if let ratingsvalue = self.ratings
        {
            secondViewController.ratingfloat = self.ratings
        }
        else
        {
            secondViewController.ratingfloat = 0
        }
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // that -16 is because I have 8px for left and right spacing constraints for the label.
        if (self.comingfrom == "ViewAll")
        {
        return CGSizeZero;
        
        }
        
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, collectionView.frame.width - 16, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        //        //here, be sure you set the font type and size that matches the one set in the storyboard label
        label.font = UIFont(name: "Helvetica", size: 17.0)
        label.text = "Set some extra pixels for height due to the margins of the header section."
        label.sizeToFit()
        
        // Set some extra pixels for height due to the margins of the header section.
        //This value should be the sum of the vertical spacing you set in the autolayout constraints for the label. + 16 worked for me as I have 8px for top and bottom constraints.
        return CGSize(width: collectionView.frame.width, height: 45)
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2.0, height: collectionView.bounds.width/1.5);
        
    }
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath)
    {
        if self.comingfrom == "ViewAll"
        {
        
        }
        else
        {
        if indexPath.row == (self.CollectionData.count-1)
        {
            //print("last item visible")
            self.activity.removeFromSuperview()
        }
        if(self.CollectionData.count == 0){
            self.activity.removeFromSuperview()
        }
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeMake(60.0, 100.0)
    }
    
    
   

        
    
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            //print("now showing suppl view")
            
             headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as! HeaderReusableView
            let filter = UIImage(named: "Filter")!
            let sort = UIImage(named: "Sort")!
            
            headerView.filterBtn.setImage(filter, forState: UIControlState.Normal)
            
            headerView.filterBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
            headerView.filterBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            headerView.filterBtn.tintColor = UIColor (red: 31/255.0, green: 75/255.0, blue: 164/255.0, alpha: 1.0)
            
            headerView.SortBtn.setImage(sort, forState: UIControlState.Normal)
            headerView.SortBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
            headerView.SortBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            headerView.SortBtn.tintColor = UIColor (red: 31/255.0, green: 75/255.0, blue: 164/255.0, alpha: 1.0)
            
            headerView.listBtn.addTarget(self, action: #selector(listbuttonAction), forControlEvents: .TouchUpInside)
            
            
            
            if (self.comingfrom == "ViewAll")
            {
            headerView.hidden = true
//            collectionView.contentInset = UIEdgeInsetsZero
//            collectionView.scrollIndicatorInsets = UIEdgeInsetsZero;
               // self.collectionView?.reloadData()
                //if(self.comingfrom == "Search")
            }
            else
            {
                headerView.hidden = false
            if(self.CollectionData.count > 0){
                headerView.filterBtn.hidden = false
                headerView.SortBtn.hidden = false
                headerView.dividerLbl.hidden = false
                headerView.listDividerLbl.hidden = false
                //headerView.listBtn.hidden = false
            }else{
                if(callApi != "filter"){
                    headerView.filterBtn.hidden = true
                    headerView.SortBtn.hidden = true
                    headerView.dividerLbl.hidden = true
                    headerView.listBtn.hidden = true
                    headerView.listDividerLbl.hidden = true
                }else{
                    headerView.filterBtn.hidden = false
                    headerView.SortBtn.hidden = false
                    headerView.dividerLbl.hidden = false
                    headerView.listDividerLbl.hidden = false
                }
                
            }
            
            
            if(self.CollectionData.count > 0){
            headerView.layer.shadowColor = UIColor.blackColor().CGColor
            headerView.layer.shadowOpacity = 0.3
            headerView.layer.shadowOffset = CGSizeMake(0.0, 1.0)
            headerView.layer.masksToBounds = false
            headerView.clipsToBounds = false
            }else{
                if(callApi != "filter"){
                   headerView.layer.shadowColor = UIColor.clearColor().CGColor
                    //headerView.layer.shadowColor = UIColor.blackColor().CGColor
                    headerView.layer.shadowOpacity = 0.3
                    headerView.layer.shadowOffset = CGSizeMake(0.0, 1.0)
                    headerView.layer.masksToBounds = false
                    headerView.clipsToBounds = false
                }
                else{
                headerView.layer.shadowColor = UIColor.blackColor().CGColor
                headerView.layer.shadowOpacity = 0.3
                headerView.layer.shadowOffset = CGSizeMake(0.0, 1.0)
                headerView.layer.masksToBounds = false
                headerView.clipsToBounds = false
                }
            }
            }
            
            return headerView
            
            
        case UICollectionElementKindSectionFooter:
            //print("now showing suppl view")
            let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Footer", forIndexPath: indexPath) as! FooterReusableView
            
            activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
            activity.color = UIColor.init(colorLiteralRed: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
            activity.startAnimating()
            activity.hidesWhenStopped = true
            activity.tag = 42
           // print(footerView.center)
            activity.center = CGPointMake(footerView.center.x,30)
            
            
            if(totalCount <= pagesize){
                activity.stopAnimating()
            }else{
                activity.startAnimating()
            }
            
            if(CollectionData.count <= 0){
                activity.stopAnimating()
            }
            if(currentPage >= totalPages){
                activity.stopAnimating()
            }
//            if(currentPage == 1 && callApi == "filter"){
//                
//                activity.stopAnimating()
//            }
            footerView.addSubview(activity)
            footerView.backgroundColor = UIColor.whiteColor();
            return footerView
            
            
        default:
            
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as! HeaderReusableView
            return headerView
            //return HeaderReusableView
           // assert(false, "Unexpected element kind")
        }
        
        //Activity Indicator
        
        
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, atIndexPath indexPath: NSIndexPath)
        
    {
        //print("did end showing ")
        
    }
    
    func loadmoredata (pageno:Int)
    {
        
//        print(pageno)
//        print(self.CollectionData.count)
//        print(self.CollectionData)
        let articleString = url?.absoluteString
        var name: String = articleString!
        let stringLength = name.characters.count
        let substringIndex = stringLength - 1
        var editingstr: String = name.substringToIndex(name.startIndex.advancedBy(substringIndex))
        editingstr+="\(pageno)"
        
       // print(editingstr)
        var newurl = NSURL(string:editingstr)
        //        if lastComponent == "App Store.app" {
        //            println("Yes")
        //        }
        
//        print(url!, terminator: "")
//        print(newurl!, terminator: "")
        
        
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            
            let headers = [
                "Authorization": authorizationWithoutLogin,
                "Accept": "application/json"
            ]
            
            Alamofire.request(.GET, newurl!,headers: headers).responseObject { (response: Response<Product, NSError>) in
                
                let productResponse = response.result.value
                
                
                
                
                if let productList1 = productResponse?.result
                {
                    
                   // print(productList1.pageSize!)
                    let totalcount   = productList1.totalCount!
                    let pagecount   = productList1.pageSize!
                    let roundof  = ceil(Double(totalcount)/Double(pagecount))
                    //
                    let introundof = Int(roundof)
                   // print(introundof, terminator: "")
                    //
                    self.pages = introundof
                    
                }
                
                if let productList = productResponse?.result?.product?.lstProducts
                {
                    for prodt in productList
                    {
                        
                        self.CollectionData .addObject(prodt)
                        
                    }
                }
                dispatch_async(dispatch_get_main_queue()) {
                    self.collectionView!.reloadData()
                    self.collectionView?.scrollsToTop = true
                }
            }
        }else{
            LoadingOverlay.shared.hideOverlayView()
        }
        
        
        
    }
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        collectionView .scrollToItemAtIndexPath(indexPath, atScrollPosition:UICollectionViewScrollPosition.Top, animated: true)
        
        // [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "Search")
        {
            let viewController = (segue.destinationViewController as! CollectionViewController)
            viewController.comingfrom = "Collection"
        }
        
        if(segue.identifier == "ProductDetail")
        {
            let viewController = (segue.destinationViewController as! ViewController)
            viewController.skuNumber = self.skuno
            //  print(self.ratings)
            if let ratingsvalue = self.ratings
            {
                viewController.ratingfloat = self.ratings
            }
            else
            {
                viewController.ratingfloat = 0
            }
        }
        
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == productListTable)
        {
            if CollectionData.count == 0
            {
//                headerView.layer.shadowColor = UIColor.blackColor().CGColor
//                headerView.layer.shadowOpacity = 0.3
//                headerView.layer.shadowOffset = CGSizeMake(0.0, 1.0)
//                headerView.layer.masksToBounds = false
//                headerView.clipsToBounds = false
             //  self.view.addSubview(self.noResultVc)
            }
            else
            {
//                headerView.layer.shadowColor = UIColor.blackColor().CGColor
//                headerView.layer.shadowOpacity = 0.3
//                headerView.layer.shadowOffset = CGSizeMake(0.0, 1.0)
//                headerView.layer.masksToBounds = false
//                headerView.clipsToBounds = false
//                headerView.layer.shadowColor = UIColor.clearColor().CGColor
//                headerView.layer.shadowOpacity = 0.3
//                headerView.layer.shadowOffset = CGSizeMake(0.0, 1.0)
//                headerView.layer.masksToBounds = false
//                headerView.clipsToBounds = false
            
            }
            return CollectionData.count
        }else{
            return sortArray.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(tableView == productListTable){
             let cell = tableView.dequeueReusableCellWithIdentifier("prodcell", forIndexPath: indexPath) as! ProdDetailCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            if(screenWidth == 320){
            cell.productName.translatesAutoresizingMaskIntoConstraints = true
            cell.productName.frame = CGRectMake(0, 0, 175, 42)
            }
            
            let prodt  = self.CollectionData.objectAtIndex(indexPath.row) as! LstProducts
            //print(prodt.imageURLHigh!)
            //ratings
            cell.skuNumber = prodt.sku!
            cell.delegates = self
            cell.floatRatingView.hidden = false
            cell.ratingLbl.hidden = false
            
            if (self.comingfrom == "ViewAll")
            {
            
            }
            else
            {
                if let ratingsc = prodt.reviewCount        {
                   cell.ratingLbl.text = String(format:"(%@)",String(prodt.reviewCount!))
                   
                    
                }
            }
             cell.floatRatingView.rating = prodt.avgUserReviews!
            cell.productImage.image = nil
            let image : UIImage = UIImage(named:"placeholder")!
            cell.productImage.image = image
            //caching image
            let imgURL: NSURL = NSURL(string: prodt.imageURLHigh!)!
            //print(imgURL.absoluteString)
            
            if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
            {
                //print("IN cache")
                cell.productImage.image = image
                
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
                            //print(imgURL.absoluteString)
                            cell.productImage.image = image
                            photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                        }
                        else
                        {
                            let image : UIImage = UIImage(named:"placeholder")!
                            cell.productImage.image = image
                           // photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                        }
                }
                
            }
            
            
            
            cell.productName.text = prodt.description!
            //end
            
            if(prodt.showPerc!){
                cell.DiscountLbl.hidden = false
                cell.DiscountLbl.text = String(format:"%@ Off ",String(prodt.percentage!))
                
                let grossPrice1  =  "₹ \(prodt.grossPriceDisplayString!)"
                let netPrice2  =  "₹ \(prodt.netPriceDisplayString!)"
                let labelstring : NSString = "\(netPrice2)  \(grossPrice1)"
                
                let string_to_color = "\(netPrice2)"
                var string2 = "\(grossPrice1)"
                
                var range = (labelstring as NSString).rangeOfString(string_to_color)
                var range2 = (labelstring as NSString).rangeOfString(string2)
                
                
                
                var attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelstring as String)
                
                attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
                attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 11)!], range: range2)
                attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: range2)
                attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) , range: range2)
                
                cell.priceLbl.attributedText = attributedText
            }else{
                cell.DiscountLbl.hidden = true
                cell.DiscountLbl.text = String(format:"%@ Off  ",String(prodt.percentage!))
                
                if let netPrice2  =  prodt.netPriceDisplayString{
                    if (netPrice2 == "Price Not Available")
                    {
                        cell.priceLbl.text = "Price Not Available"
                    }else{
                        cell.priceLbl.text = "₹ \(prodt.netPriceDisplayString!)"
                    }
                }else{
                    cell.priceLbl.text = "Price Not Available"
                }
            }
            
            if(prodt.isNewProd!){
                cell.newProdIV.hidden = false
            }else{
                cell.newProdIV.hidden = true
                
            }
            
            cell.favBtn.tag = indexPath.row
            //end
            
            if wishLstGlobalArray.containsObject(prodt.sku!){
                cell.favBtn.selected = true
            }else{
                cell.favBtn.selected = false
            }
            let defaults = NSUserDefaults.standardUserDefaults()
            if let userId = defaults.objectForKey("userId") as? Int{
                cell.favBtn.hidden = false
            }
            else{
                cell.favBtn.hidden = true
            }

            return cell
        }else{
        let cell = tableView.dequeueReusableCellWithIdentifier("sortcell", forIndexPath: indexPath) as! SortViewCell
        if(sortIds == indexPath.row){
           // let cell = tableView.cellForRowAtIndexPath(indexPath) as! SortViewCell
            cell.accessoryType = .Checkmark
        }else{
           // var indx = NSIndexPath.init(forRow: i, inSection: 0)
           // let cell = tableView.cellForRowAtIndexPath(indx) as! SortViewCell
            cell.accessoryType = .None
        }
        
        cell.selectionStyle = .None
        cell.sortLabel.translatesAutoresizingMaskIntoConstraints = true
        cell.sortLabel.frame = CGRectMake(0, 50, sortTable.frame.width, 1)
            cell.sortTypeLbl.translatesAutoresizingMaskIntoConstraints = true
            cell.sortTypeLbl.frame = CGRectMake(0, 17, sortTable.frame.width, 18)
       // cell.accessoryType = .DisclosureIndicator
        cell.sortTypeLbl.text = sortArray[indexPath.row] as? String
        return cell
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //sortIds=0&filterAppliedLast=sort
        if(tableView == productListTable){
            let prodt  = self.CollectionData.objectAtIndex(indexPath.row) as! LstProducts
            //print(prodt.sku!)
            self.skuno = prodt.sku!
            if (self.comingfrom == "ViewAll")
            {
                
            }
            else
            {
               if let prodrating = prodt.ratingCount
               {
            for productrati in prodt.ratingCount! {
                if let rate = productrati.overallRating
                {
                    self.ratings = Float(rate)
                   // print(self.ratings)
                }
            }
                }
            }
            let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("prodDet") as! ViewController
            secondViewController.skuNumber = self.skuno
            if let ratingsvalue = self.ratings
            {
                secondViewController.ratingfloat = self.ratings
            }
            else
            {
                secondViewController.ratingfloat = 0
            }
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }else{
        for(var i=0;i<sortArray.count;i++){
            if(i == indexPath.row){
                let cell = tableView.cellForRowAtIndexPath(indexPath) as! SortViewCell
                cell.accessoryType = .Checkmark
            }else{
                var indx = NSIndexPath.init(forRow: i, inSection: 0)
                let cell = tableView.cellForRowAtIndexPath(indx) as! SortViewCell
                cell.accessoryType = .None
            }
        }
        totalPages = 0
        currentPage = 1
        self.sortView.removeFromSuperview()
        self.CollectionData.removeAllObjects()
        self.collectionView?.reloadData()
       sortIds = indexPath.row
        appliedfilter = "sort"
      //  URLString = "\(URLString)&sortIds=\(indexPath.row)&filterAppliedLast=sort"
       // print(URLString)
       // url = NSURL(string: URLString)
         currentPage = 1
        callApi = "filter"
         self.activity.stopAnimating()
        // JHProgressHUD.sharedHUD.showInView(self.view)
        //        var window :UIWindow = UIApplication.sharedApplication().keyWindow!
        //        LoadingOverlay.shared.showOverlay(window)
        callGetProductAPI(url!,isCalled: callApi)
        // JHProgressHUD.sharedHUD.hide()
        }
    }
    
    
//    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        if(tableView == productListTable){
////        var footerView = UIView.init(frame: CGRectMake(0, 275, screenWidth, 200))
////            print(footerView.frame.height)
////       var activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
////        activity.color = UIColor.init(colorLiteralRed: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
////        activity.startAnimating()
////        activity.hidesWhenStopped = true
////        activity.tag = 42
////        print(footerView.center)
////        activity.center = CGPointMake(footerView.center.x,30)
//            
//                            var footerView=UIView(frame: CGRectMake(0, 0, boundss.width, 60))
//                            //footerView.backgroundColor=UIColor.whiteColor()
//                            activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
//                            activity.color = UIColor.init(colorLiteralRed: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
//                            activity.startAnimating()
//                            activity.hidesWhenStopped = true
//                            activity.tag = 42
//            
//                            activity.center = CGPointMake(footerView.center.x,30)
//                           // DynamicView.addSubview(activity)
//                            //productListTable.tableFooterView = DynamicView
//        
//        
//        if(totalCount <= pagesize){
//            activity.stopAnimating()
//        }else{
//            activity.startAnimating()
//        }
//        
//        if(CollectionData.count <= 0){
//            activity.stopAnimating()
//        }
//        if(currentPage >= totalPages){
//            activity.stopAnimating()
//        }
//        //            if(currentPage == 1 && callApi == "filter"){
//        //
//        //                activity.stopAnimating()
//        //            }
//        footerView.addSubview(activity)
//        footerView.backgroundColor = UIColor.whiteColor()
//        return footerView
//        }else{
//            return nil
//        }
//        
//        
//        
//        
//        //                var DynamicView=UIView(frame: CGRectMake(0, 0, boundss.width, 60))
//        //                DynamicView.backgroundColor=UIColor.whiteColor()
//        //                activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
//        //                activity.color = UIColor.init(colorLiteralRed: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
//        //                activity.startAnimating()
//        //                activity.hidesWhenStopped = true
//        //                activity.tag = 42
//        //
//        //                activity.center = CGPointMake(DynamicView.center.x,30)
//        //                DynamicView.addSubview(activity)
//        //                productListTable.tableFooterView = DynamicView
//        
//    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 0.0
    }
    
    @IBAction func noInternetClk(){
        callGetProductAPI(url!,isCalled: callApi)
    }
    //sortIds=0&filterAppliedLast=sort
    
    //    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
    //        
    //        let vc = UIView()
    //        vc.frame =  CGRectMake(0, 0, boundss.width, 60)
    //        
    //        let lbl:UILabel=UILabel.init(frame: CGRectMake(0, 0, boundss.width, 30))
    //        lbl.text = "Sort By"
    //        lbl.textAlignment = .Center
    //        lbl.textColor = UIColor.darkGrayColor()
    //        return vc
    //    }
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
     
     }
     */
    
}

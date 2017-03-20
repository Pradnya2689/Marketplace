
//
//  SecondViewController.swift
//  MarketPlace
//
//  Created by inpanr07 on 24/06/16.
//  Copyright (c) 2016 inpanr07. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireImage
import CoreData

let  bluedarkColor = UIColor.init(colorLiteralRed: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
let grayLightColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1)
let headerColor = UIColor.init(colorLiteralRed: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)

public class LoadingOverlay{
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    public func showOverlay(view: UIView!) {
        overlayView = UIView(frame: UIScreen.mainScreen().bounds)
       // overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        activityIndicator.center = overlayView.center
        activityIndicator.color =  UIColor.init(colorLiteralRed: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
        overlayView.addSubview(activityIndicator)
       // overlayView.tag = 2
        activityIndicator.startAnimating()
        view.addSubview(overlayView)
    }
    
    public func hideOverlayView() {
        var window :UIWindow = UIApplication.sharedApplication().keyWindow!
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
       // window.r
    }
}

class lstBasket: Mappable {
    var avaliableQuantity: String?
    var basketId: String?
    var customerLineNumber: String?
    var customerNumber: Int?
    var customerPOType: String?
    var description: String?
    var discountperc: String?
    var distributionChannel: String?
    var division: String?
    var extendedPrice: Int?
    var globalPriceClass: String?
    var grossPrice: String?
    var imageURLHigh: String?
    var imageURLLow: String?
    var imageURLMedium: String?
    var ingramPartNumber: Int?
    var limitedStock: String?
    var lineItemId: String?
    var lineNumber: String?
    var maximumQuantity: String?
    var orderType: String?
    var placedPrice: Int?
    var productId: String?
    var quantity: String?
    var requestedQuantity: String?
    var salesOrganization: String?
    var sellerName: String?
    var sellerNumber: String?
    var sku: Int?
    var totalAmount: String?
    var vendorCode: String?
    var vpn: String?
    var showPerc: Bool?
    var percentage:String?
    var grossPriceDisplayString:String?
    var netPriceDisplayString:String?
    var extendedPriceDisplayString:String?
    var placedPriceDisplayString:String?
    var grossAmountDisplayString:String?
    var totalShippingAmountDisplayString:String?
    var totalDisplayString:String?
   
   
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        avaliableQuantity <- map["avaliableQuantity"]
        basketId <- map["basketId"]
        customerLineNumber <- map["customerLineNumber"]
        customerNumber <- map["customerNumber"]
        customerPOType <- map["customerPOType"]
        description <- map["description"]
        discountperc <- map["discountperc"]
        distributionChannel <- map["distributionChannel"]
        division <- map["division"]
        extendedPrice <- map["extendedPrice"]
        globalPriceClass <- map["globalPriceClass"]
        grossPrice <- map["grossPrice"]
        imageURLHigh <- map["imageURLHigh"]
        imageURLLow <- map["imageURLLow"]
        imageURLMedium <- map["imageURLMedium"]
        ingramPartNumber <- map["ingramPartNumber"]
        limitedStock <- map["limitedStock"]
        lineItemId <- map["lineItemId"]
        lineNumber <- map["lineNumber"]
        maximumQuantity <- map["maximumQuantity"]
        orderType <- map["orderType"]
        placedPrice <- map["placedPrice"]
        productId <- map["productId"]
        quantity <- map["quantity"]
        requestedQuantity <- map["requestedQuantity"]
        salesOrganization <- map["salesOrganization"]
        sellerName <- map["sellerName"]
        sellerNumber <- map["sellerNumber"]
        sku <- map["sku"]
        totalAmount <- map["totalAmount"]
        vendorCode <- map["vendorCode"]
        vpn <- map["vpn"]
        showPerc <- map["showPerc"]
        percentage <- map["percentage"]
        netPriceDisplayString <- map["netPriceDisplayString"]
        grossPriceDisplayString <- map["grossPriceDisplayString"]
        extendedPriceDisplayString <- map["extendedPriceDisplayString"]
        placedPriceDisplayString <- map["placedPriceDisplayString"]
        grossAmountDisplayString <- map["grossAmountDisplayString"]
        totalShippingAmountDisplayString <- map["totalShippingAmountDisplayString"]
        totalDisplayString <- map["totalDisplayString"]

    }
}



class SecondViewController: UIViewController,webServiceDelegate,mycartDelegate {
    @IBOutlet var mycartTable:UITableView!
    var basketArray:NSMutableArray!=NSMutableArray()
    @IBOutlet weak var subTotalLbl:UILabel!
    @IBOutlet weak var shippingLbl:UILabel!
    @IBOutlet weak var totalLbl:UILabel!
    @IBOutlet var bottomVc:UIView!
    @IBOutlet var noResultLbl:UILabel!
    
    @IBOutlet var noInternetVc:UIView!
    @IBOutlet var wifiImg:UIImageView!
    @IBOutlet var noconnetinlbl:UILabel!
    @IBOutlet var retryBtn:UIButton!
    @IBOutlet var noResultVc:UIView!
    @IBOutlet var noResultImg:UIImageView!
    
    @IBOutlet weak var checkOutBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    
    var dataLayer: TAGDataLayer = TAGManager.instance().dataLayer
    override func viewWillAppear(animated: Bool) {
        
         self.tabBarController?.tabBar.hidden = false
         self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        self.basketArray.removeAllObjects()
         self.bottomVc.hidden = true
        self.checkOutBtn.hidden = true
        self.noResultVc.hidden=true
        mycartTable.reloadData()
        self.title="My Cart"
        let items = self.tabBarController?.tabBar.items
        let tabItem = items![2]
        tabItem.title = ""
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName:
                headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
      // self.noResultLbl.hidden=true
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(SecondViewController.basketdetailSucce(_:)),
                                                         name: "basketDetails",
                                                         object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(SecondViewController.internetReachable(_:)),
                                                         name: "reachable",
                                                         object: nil)
        
       // basketDetails
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId"){
            
          var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates = nil
            wsm.delegates=self
            
           let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            if (appdelegate.isReachable == true) {
            self.noInternetVc.hidden = true
            wsm.getBasketDetails(usernm  as! Int , contryId: "IN")
            }else{
                LoadingOverlay.shared.hideOverlayView()
                self.noInternetVc.hidden = false
                self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
                self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
                self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
                self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
                self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
                self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)
            }
        }else{
            self.checkOutBtn.hidden = false
            self.bottomVc.hidden = true
            fetchValFromCore()
        }
        
        if(screenHeight == 480){
            self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
            self.noResultLbl.translatesAutoresizingMaskIntoConstraints = true
            self.noResultImg.frame = CGRectMake((screenSize.width - 150 )/2, 50, 150, 150)
            self.noResultLbl.frame = CGRectMake(10, 230, screenWidth-20, 21)
            self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
            self.noResultVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
            self.continueBtn.translatesAutoresizingMaskIntoConstraints = true
            self.continueBtn.frame = CGRectMake((screenWidth-214)/2, 270, 214, 30)
        }
        
//        if(screenHeight == 480){
//        self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
//        self.noResultImg.frame = CGRectMake((screenWidth-150)/2, 50, 150, 150)
//         self.noResultLbl.translatesAutoresizingMaskIntoConstraints = true
//          self.noResultLbl.frame = CGRectMake((screenWidth-200)/2, 225, 200, 21)
//            self.continueBtn.translatesAutoresizingMaskIntoConstraints = true
//            self.continueBtn.frame = CGRectMake((screenWidth-200)/2, 270, 200, 30)
//        }
        
        if(screenHeight == 568){
            self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
            self.noResultImg.frame = CGRectMake((screenWidth-150)/2, 100, 150, 150)
            self.noResultLbl.translatesAutoresizingMaskIntoConstraints = true
            self.noResultLbl.frame = CGRectMake((screenWidth-200)/2, 275, 200, 21)
            self.continueBtn.translatesAutoresizingMaskIntoConstraints = true
            self.continueBtn.frame = CGRectMake((screenWidth-200)/2, 320, 200, 30)
        }
        
    }
    @IBAction func noInternetClk(){
        
        self.basketArray.removeAllObjects()
        self.bottomVc.hidden = true
        mycartTable.reloadData()
        self.noResultVc.hidden=true
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId"){
            
            
            
            let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            if (appdelegate.isReachable == true) {
                self.noInternetVc.hidden = true
                var window :UIWindow = UIApplication.sharedApplication().keyWindow!
                LoadingOverlay.shared.showOverlay(window)
                let wsm : WebServiceClass = WebServiceClass.sharedInstance
                wsm.delegates = nil
                wsm.delegates = self
                
                wsm.getBasketDetails(usernm  as! Int , contryId: "IN")
            }else{
                self.noInternetVc.hidden = false
            }
        }else{
             self.checkOutBtn.hidden = false
            self.bottomVc.hidden = true
            fetchValFromCore()
        }
        
    }
    
    @IBAction func continueShoppingAction(sender: AnyObject) {

        self.tabBarController?.selectedIndex = 0
    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        self.title = ""
        
        LoadingOverlay.shared.hideOverlayView()
        //reachable
         NSNotificationCenter.defaultCenter().removeObserver(self, name: "basketDetails", object: nil)
         NSNotificationCenter.defaultCenter().removeObserver(self, name: "reachable", object: nil)
    }
    
    func registerNotification()
    {
         NSNotificationCenter.defaultCenter().postNotificationName("basketDetails", object: nil, userInfo: nil )
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId"){
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates = nil
            wsm.delegates=self
            wsm.getBasketDetails(usernm  as! Int , contryId: "IN")
        
       }
    }
    func fetchValFromCore() {
        self.basketArray.removeAllObjects()
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
                if(tabItem.badgeValue == "0" || tabItem.badgeValue == ""){
                    tabItem.badgeValue = nil
                   //  self.bottomVc.hidden = true
                    self.noResultVc.hidden=false
                    if(screenHeight == 480){
                    self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
                    self.noResultLbl.translatesAutoresizingMaskIntoConstraints = true
                    self.noResultImg.frame = CGRectMake((screenSize.width - 150 )/2, 50, 150, 150)
                    self.noResultLbl.frame = CGRectMake(10, 230, screenWidth-20, 21)
                    self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                    self.noResultVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
                    self.continueBtn.translatesAutoresizingMaskIntoConstraints = true
                    self.continueBtn.frame = CGRectMake((screenWidth-214)/2, 270, 214, 30)
                }else{
                    self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
                    // self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                    self.noResultLbl.translatesAutoresizingMaskIntoConstraints = true
                    self.noResultImg.frame = CGRectMake((screenSize.width - 120 )/2, 150, 120, 120)
                    self.noResultLbl.frame = CGRectMake((screenSize.width - 248 )/2, 330, 248, 21)
                    self.continueBtn.translatesAutoresizingMaskIntoConstraints = true
                    self.continueBtn.frame = CGRectMake((screenSize.width - 270 )/2, 370, 270, 30)
                    }
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setObject("", forKey: "badge")
                }else{
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setObject(String(people.count), forKey: "badge")
                   // self.bottomVc.hidden = false
                    self.noResultVc.hidden=true
                }
                for searchstring in people{
                    
                    print(searchstring.valueForKey("placedPrice"))
                    self.basketArray.addObject(searchstring)
                }
                
               self.mycartTable.reloadData()
         
            }
          
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                //Price
        return self.basketArray.count
    }
 
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    
            let cell = mycartTable.dequeueReusableCellWithIdentifier("mycart", forIndexPath: indexPath) as! MyCartCell
        let image : UIImage = UIImage(named:"placeholder")!
        cell.productImg.image = image
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId"){
            if(self.basketArray.valueForKey("avaliableQuantity").objectAtIndex(indexPath.row) as! Int == 0)
            {
                cell.outOfstockLbl.hidden = false
            }
            else
            {
                cell.outOfstockLbl.hidden = true
            }
            
            cell.prodTitleLabel.text = self.basketArray.valueForKey("description").objectAtIndex(indexPath.row) as? String
            print(self.basketArray)
            print(self.basketArray.valueForKey("placedPrice").objectAtIndex(indexPath.row) as! String)
            cell.prodPriceLabel.text = "₹ \(self.basketArray.valueForKey("placedPriceDisplayString").objectAtIndex(indexPath.row) as! String)"
            cell.placedPrice = self.basketArray.valueForKey("placedPriceDisplayString").objectAtIndex(indexPath.row) as! String
            cell.quantityBtn.setTitle("Qty : \(self.basketArray.valueForKey("quantity").objectAtIndex(indexPath.row) as! Int)", forState: UIControlState.Normal)
            cell.quantity = self.basketArray.valueForKey("quantity").objectAtIndex(indexPath.row) as! Int
            cell.lineItemId = self.basketArray.valueForKey("lineItemId").objectAtIndex(indexPath.row) as! Int
            cell.BasketId = self.basketArray.valueForKey("basketId").objectAtIndex(indexPath.row) as! Int
            cell.oldQntity = "Qty : \(self.basketArray.valueForKey("quantity").objectAtIndex(indexPath.row) as! Int)"
        }else{
            cell.prodTitleLabel.text = self.basketArray.valueForKey("mdescription").objectAtIndex(indexPath.row) as? String
            cell.oldQntity = "Qty : \(self.basketArray.valueForKey("quantity").objectAtIndex(indexPath.row) as! String)"
           // cell.prodPriceLabel.text = "₹ \(self.basketArray.valueForKey("placedPrice").objectAtIndex(indexPath.row))"
            cell.prodPriceLabel.text = "₹ \(self.basketArray.valueForKey("cartPrice").objectAtIndex(indexPath.row))"
            cell.quantityBtn.setTitle("Qty : \(self.basketArray.valueForKey("quantity").objectAtIndex(indexPath.row) as! String)", forState: UIControlState.Normal)
            cell.quantity = Int(self.basketArray.valueForKey("quantity").objectAtIndex(indexPath.row) as! String)
         
        }
       
        cell.quantityBtn.tag = indexPath.row
        cell.delegates = self
        cell.quantityBtn.layer.borderWidth = 1
        
        cell.quantityBtn.layer.borderColor = UIColor (red: 31/255.0, green: 75/255.0, blue: 164/255.0, alpha: 1.0).CGColor
        cell.quantityBtn.titleLabel?.textAlignment = NSTextAlignment.Center
        
        
        let url =  self.basketArray.valueForKey("imageURLMedium").objectAtIndex(indexPath.row) as? String
        let imgURL: NSURL = NSURL(string: url!)!
        print(imgURL.absoluteString)
        
        if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
        {
            print("IN cache")
            cell.productImg.image = image
            
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
                        cell.productImg.image = image
                        photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                    }
                    else
                    {
                        let image : UIImage = UIImage(named:"placeholder")!
                        cell.productImg.image = image
                        photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                    }
            }
        }

        return cell
         
    }
  func internetReachable(notification:NSNotification){
    
    print("in cart via reachable")
    self.noInternetClk()
    }
    var totalNetVal:String!
    func basketdetailSucce(notification:NSNotification){
         let string : AnyObject = notification.userInfo!
         self.bottomVc.hidden = false
         self.checkOutBtn.hidden = false
       // dispatch_async(dispatch_get_main_queue()) {
       
        
        dataLayer.push(["event": "openScreen", "screenName": "cartScreeniOS"])
            self.basketArray.removeAllObjects()
            if let subtotal = string.valueForKey("grossAmountDisplayString") as? String{
                self.subTotalLbl.text = "₹ \(subtotal)"
            }
            if let shipping = string.valueForKey("totalShippingAmountDisplayString") as? String{
                self.shippingLbl.text = "₹ \(shipping)"
            }
            if let shipping = string.valueForKey("totalDisplayString") as? String{
                self.totalLbl.text = "₹ \(shipping)"
            }
        if let shipping = string.valueForKey("total") as? String{
            self.totalNetVal = shipping
        }
         LoadingOverlay.shared.hideOverlayView()
            if let bastetcartarry = string.valueForKey("lstBasket") as? NSArray{
                for forecast in bastetcartarry
                {
                    // var lst:lstBasket = forecast as! lstBasket
                    self.basketArray.addObject(forecast)
                    
                }
                print(self.basketArray)
                self.mycartTable.reloadData()
            }
        
            let defaults = NSUserDefaults.standardUserDefaults()
            if let usernm = defaults.valueForKey("email"){
                 self.bottomVc.hidden = false
            }else{
                self.bottomVc.hidden = true
            }
            let tabArray = self.tabBarController?.tabBar.items as NSArray!
            let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
            tabItem.badgeValue = String(self.basketArray.count)
            if(tabItem.badgeValue == "0" || tabItem.badgeValue == "")
            {
                tabItem.badgeValue = nil
                self.bottomVc.hidden = true
                self.noResultVc.hidden=false
                if(screenHeight == 480){
                    self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
                    self.noResultLbl.translatesAutoresizingMaskIntoConstraints = true
                    self.noResultImg.frame = CGRectMake((screenSize.width - 150 )/2, 50, 150, 150)
                    self.noResultLbl.frame = CGRectMake(10, 230, screenWidth-20, 21)
                    self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                    self.noResultVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
                    self.continueBtn.translatesAutoresizingMaskIntoConstraints = true
                    self.continueBtn.frame = CGRectMake((screenWidth-214)/2, 270, 214, 30)
                }else{
                self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
                // self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
                self.noResultLbl.translatesAutoresizingMaskIntoConstraints = true
                self.noResultImg.frame = CGRectMake((screenSize.width - 120 )/2, 150, 120, 120)
                self.noResultLbl.frame = CGRectMake((screenSize.width - 248 )/2, 330, 248, 21)
                self.continueBtn.translatesAutoresizingMaskIntoConstraints = true
                self.continueBtn.frame = CGRectMake((screenSize.width - 270 )/2, 370, 270, 30)
                }
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject("", forKey: "badge")
            }else{
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(String(self.basketArray.count), forKey: "badge")
                self.bottomVc.hidden = false
                self.noResultVc.hidden=true
            }
        
                 
    }
    func mycartdeleteDelegateFunction(tagInfo:Int){
        let alert = UIAlertController(title: "", message:ConstantsFile.removeItemCart_msg, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler:  { (action) -> Void in
          // JHProgressHUD.sharedHUD.showInView(self.view)
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            let indxPath : NSIndexPath = NSIndexPath(forRow: tagInfo, inSection: 0)
            let cell = self.mycartTable.cellForRowAtIndexPath(indxPath) as! MyCartCell
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
            let defaults = NSUserDefaults.standardUserDefaults()
            if let usernm = defaults.valueForKey("userId"){
                wsm.DeleteBasketDetails(String(tagInfo), lineItemId: String(cell.lineItemId), BasketId: String(cell.BasketId), quantity: String(cell.quantity), userId: usernm as! Int, sitecode: "IN", placedPrice: cell.placedPrice)
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            //cell.quantityBtn.setTitle("Qty:4", forState: UIControlState.Normal)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
        
    }
    func mycartDelegateFunctionOffline(tagInfo:Int){
        let alert = UIAlertController(title: "", message:ConstantsFile.removeItemCart_msg, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler:  { (action) -> Void in
            let indxPath : NSIndexPath = NSIndexPath(forRow: tagInfo, inSection: 0)
            let cell = self.mycartTable.cellForRowAtIndexPath(indxPath) as! MyCartCell
            
            let appDelegate =
                UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            let searchpredicate = NSPredicate(format: "skuNumber = %@", self.basketArray.valueForKey("skuNumber").objectAtIndex(tagInfo) as! String)
            let searchpredicate1 = NSPredicate(format: "sellerName == %@",self.basketArray.valueForKey("sellerName").objectAtIndex(tagInfo) as! String)
            var compound = NSCompoundPredicate.init(andPredicateWithSubpredicates:[searchpredicate,searchpredicate1])
            let fetchRequest = NSFetchRequest(entityName: "MyCart")
            fetchRequest.predicate = compound
            do {
                let fetchResults =
                    try managedContext.executeFetchRequest(fetchRequest)
                if fetchResults.count>0 {
                    appDelegate.managedObjectContext.deleteObject(fetchResults[0] as! NSManagedObject)
                    self.fetchValFromCore()
                } else {
                    // no data
                }
                
            }catch _ {
                
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            //cell.quantityBtn.setTitle("Qty:4", forState: UIControlState.Normal)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
       
        
    }
    func mycartdeleteDelegateFunctionOffline(tagInfo:Int){
        
        let indxPath : NSIndexPath = NSIndexPath(forRow: tagInfo, inSection: 0)
        let cell = mycartTable.cellForRowAtIndexPath(indxPath) as! MyCartCell
        
        let alert = UIAlertController(title: ConstantsFile.selectQty_msg, message:"", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "1", style: UIAlertActionStyle.Default, handler:  { (action) -> Void in
            cell.quantityBtn.setTitle("Qty : 1", forState: UIControlState.Normal)
            cell.quantity = 1
            let appDelegate =
                UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            let searchpredicate = NSPredicate(format: "skuNumber = %@", self.basketArray.valueForKey("skuNumber").objectAtIndex(tagInfo) as! String)
            let searchpredicate1 = NSPredicate(format: "sellerName == %@",self.basketArray.valueForKey("sellerName").objectAtIndex(tagInfo) as! String)
            var compound = NSCompoundPredicate.init(andPredicateWithSubpredicates:[searchpredicate,searchpredicate1])
            let fetchRequest = NSFetchRequest(entityName: "MyCart")
            fetchRequest.predicate = compound
            do {
                let fetchResults =
                    try managedContext.executeFetchRequest(fetchRequest)
                if fetchResults.count>0 {
                  
                    var managedObject1 = fetchResults[0]
                    managedObject1.setValue("1", forKey: "quantity")
                    try managedContext.save()
                } else {
                    // no data
                }
                
            }catch _ {
                
            }
        }))
        alert.addAction(UIAlertAction(title: "2", style: UIAlertActionStyle.Default, handler:{ (action) -> Void in
            cell.quantityBtn.setTitle("Qty : 2", forState: UIControlState.Normal)
            cell.quantity = 2
            let appDelegate =
                UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            let searchpredicate = NSPredicate(format: "skuNumber = %@", self.basketArray.valueForKey("skuNumber").objectAtIndex(tagInfo) as! String)
            let searchpredicate1 = NSPredicate(format: "sellerName == %@",self.basketArray.valueForKey("sellerName").objectAtIndex(tagInfo) as! String)
            var compound = NSCompoundPredicate.init(andPredicateWithSubpredicates:[searchpredicate,searchpredicate1])
            let fetchRequest = NSFetchRequest(entityName: "MyCart")
            fetchRequest.predicate = compound
            do {
                let fetchResults =
                    try managedContext.executeFetchRequest(fetchRequest)
                if fetchResults.count>0 {
              
                    var managedObject1 = fetchResults[0]
                    managedObject1.setValue("2", forKey: "quantity")
                    try managedContext.save()
                } else {
                    // no data
                }
                
            }catch _ {
                
            }
        }))
        alert.addAction(UIAlertAction(title: "3", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            cell.quantityBtn.setTitle("Qty : 3", forState: UIControlState.Normal)
            cell.quantity = 3
            let appDelegate =
                UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            let searchpredicate = NSPredicate(format: "skuNumber = %@", self.basketArray.valueForKey("skuNumber").objectAtIndex(tagInfo) as! String)
            let searchpredicate1 = NSPredicate(format: "sellerName == %@",self.basketArray.valueForKey("sellerName").objectAtIndex(tagInfo) as! String)
            var compound = NSCompoundPredicate.init(andPredicateWithSubpredicates:[searchpredicate,searchpredicate1])
            let fetchRequest = NSFetchRequest(entityName: "MyCart")
            fetchRequest.predicate = compound
            do {
                let fetchResults =
                    try managedContext.executeFetchRequest(fetchRequest)
                if fetchResults.count>0 {
                    
                    var managedObject1 = fetchResults[0]
                    managedObject1.setValue("3", forKey: "quantity")
                    try managedContext.save()
                } else {
                    // no data
                }
                
            }catch _ {
                
            }        }))
        alert.addAction(UIAlertAction(title: "4", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            cell.quantityBtn.setTitle("Qty : 4", forState: UIControlState.Normal)
            cell.quantity = 4
            let appDelegate =
                UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            let searchpredicate = NSPredicate(format: "skuNumber = %@", self.basketArray.valueForKey("skuNumber").objectAtIndex(tagInfo) as! String)
            let searchpredicate1 = NSPredicate(format: "sellerName == %@",self.basketArray.valueForKey("sellerName").objectAtIndex(tagInfo) as! String)
            var compound = NSCompoundPredicate.init(andPredicateWithSubpredicates:[searchpredicate,searchpredicate1])
            let fetchRequest = NSFetchRequest(entityName: "MyCart")
            fetchRequest.predicate = compound
            do {
                let fetchResults =
                    try managedContext.executeFetchRequest(fetchRequest)
                if fetchResults.count>0 {
                    
                    var managedObject1 = fetchResults[0]
                    managedObject1.setValue("4", forKey: "quantity")
                    try managedContext.save()
                } else {
                    // no data
                }
                
            }catch _ {
                
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            //cell.quantityBtn.setTitle("Qty:4", forState: UIControlState.Normal)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        

    }
    func updatebasketdetailFailed(string:NSDictionary){
        basketArray.removeAllObjects()
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId"){
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
           // JHProgressHUD.sharedHUD.showInView(self.view)
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
            wsm.getBasketDetails(usernm  as! Int , contryId: "IN")
        }else{
            self.bottomVc.hidden = true
            fetchValFromCore()
        }
    }
    func mycartDelegateFunction(tagInfo:Int){
         let indxPath : NSIndexPath = NSIndexPath(forRow: tagInfo, inSection: 0)
        let cell = mycartTable.cellForRowAtIndexPath(indxPath) as! MyCartCell
        let alert = UIAlertController(title: ConstantsFile.selectQty_msg, message:"", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "1", style: UIAlertActionStyle.Default, handler:  { (action) -> Void in
            let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            if (appdelegate.isReachable == true)
            {
            cell.quantityBtn.setTitle("Qty : 1", forState: UIControlState.Normal)
            cell.quantity = 1
                var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
            let defaults = NSUserDefaults.standardUserDefaults()
            if let usernm = defaults.valueForKey("userId"){
            wsm.updateBasketDetails(String(tagInfo), lineItemId: String(cell.lineItemId), BasketId: String(cell.BasketId), quantity: String(cell.quantity), userId: usernm as! Int, sitecode: "IN", placedPrice: cell.placedPrice)
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

        }))
        alert.addAction(UIAlertAction(title: "2", style: UIAlertActionStyle.Default, handler:{ (action) -> Void in
            let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            if (appdelegate.isReachable == true)
            {
            cell.quantityBtn.setTitle("Qty : 2", forState: UIControlState.Normal)
            cell.quantity = 2
                var window :UIWindow = UIApplication.sharedApplication().keyWindow!
             LoadingOverlay.shared.showOverlay(window)
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
            let defaults = NSUserDefaults.standardUserDefaults()
            if let usernm = defaults.valueForKey("userId"){
            wsm.updateBasketDetails(String(tagInfo), lineItemId: String(cell.lineItemId), BasketId: String(cell.BasketId), quantity: String(cell.quantity), userId: usernm as! Int, sitecode: "IN", placedPrice: cell.placedPrice)
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

        }))
        alert.addAction(UIAlertAction(title: "3", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            if (appdelegate.isReachable == true)
            {
            cell.quantityBtn.setTitle("Qty : 3", forState: UIControlState.Normal)
            cell.quantity = 3
                var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
            let defaults = NSUserDefaults.standardUserDefaults()
            if let usernm = defaults.valueForKey("userId"){
            wsm.updateBasketDetails(String(tagInfo), lineItemId: String(cell.lineItemId), BasketId: String(cell.BasketId), quantity: String(cell.quantity), userId: usernm as! Int, sitecode: "IN", placedPrice: cell.placedPrice)
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

        }))
        alert.addAction(UIAlertAction(title: "4", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            if (appdelegate.isReachable == true)
            {
            cell.quantityBtn.setTitle("Qty : 4", forState: UIControlState.Normal)
            cell.quantity = 4
                var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
            let defaults = NSUserDefaults.standardUserDefaults()
            if let usernm = defaults.valueForKey("userId"){
            wsm.updateBasketDetails(String(tagInfo), lineItemId: String(cell.lineItemId), BasketId: String(cell.BasketId), quantity: String(cell.quantity), userId: usernm as! Int, sitecode: "IN", placedPrice: cell.placedPrice)
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

        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            //cell.quantityBtn.setTitle("Qty:4", forState: UIControlState.Normal)
        }))

        self.presentViewController(alert, animated: true, completion: nil)
       
    }
    @IBAction func chdeckOutBtnClk(){
        //checkoutVc
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId"){
        for quantity in self.basketArray {
            if let qtycnt = quantity.valueForKey("quantity")
            {
                var  cnt:Int? = qtycnt as! Int
               
                if (cnt >= 5)
                {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = ""
                    alertView.message = ConstantsFile.checkout4Qty_msg
                    alertView.delegate = nil
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                    return
                }
            
            }
        }
            
           
            
        let chkVC = self.storyboard?.instantiateViewControllerWithIdentifier("checkoutVc") as! CheckoutViewController
        chkVC.TotalPrice = self.totalLbl.text
            chkVC.netAmount = totalNetVal!
        chkVC.isCalled = "cart"
        chkVC.cartItemArray = basketArray.mutableCopy() as! NSArray
        self.navigationController?.pushViewController(chkVC, animated: true)
        }else{
            
            let LoginViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("LoginView") as? LoginView
            LoginViewControllerObj?.isCalledFrm = "other"
            let NavigationController = UINavigationController(rootViewController: LoginViewControllerObj!)
            self.presentViewController(NavigationController, animated: true, completion: nil)
        }
    }
    func updatebasketdetailSuccess(string:NSDictionary){
        
        
        print("update basket \(string)")
        if let subtotal = string.valueForKey("grossAmountDisplayString") as? String{
            self.subTotalLbl.text = "₹ \(subtotal)"
        }
        if let shipping = string.valueForKey("totalShippingAmountDisplayString") as? String{
            self.shippingLbl.text = "₹ \(shipping)"
        }
        if let shipping = string.valueForKey("totalDisplayString") as? String{
            self.totalLbl.text = "₹ \(shipping)"
        }
       // dispatch_async(dispatch_get_main_queue()) {
           LoadingOverlay.shared.hideOverlayView()
        
        basketArray.removeAllObjects()
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId"){
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            // JHProgressHUD.sharedHUD.showInView(self.view)
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
            wsm.getBasketDetails(usernm  as! Int , contryId: "IN")
        }else{
            self.bottomVc.hidden = true
            fetchValFromCore()
        }

       // }
    }
    func deletebasketdetailSuccess(string:NSDictionary){
    print("update basket \(string)")
       // dispatch_async(dispatch_get_main_queue()) {
            LoadingOverlay.shared.hideOverlayView()
       // }
        var window :UIWindow = UIApplication.sharedApplication().keyWindow!
        LoadingOverlay.shared.showOverlay(window)
        self.basketArray.removeAllObjects()
        let wsm : WebServiceClass = WebServiceClass.sharedInstance
        wsm.delegates=self
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId"){
        wsm.getBasketDetails(usernm as! Int, contryId: "IN")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


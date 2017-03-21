//
//  ResellerViewController.swift
//  MarketPlace
//
//  Created by inpanr07 on 08/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

@objc protocol resellerDelegate
{
    optional  func mycartDelegateFunction(qnty:String,tagIndx:Int)
    optional  func mycartBuyNowDelegateFunction(qnty:String,tagIndx:Int)
    
}


class CustomTableCell: UITableViewCell {
    
   
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var SellerName: UILabel!
    @IBOutlet var AddToCart: UIButton!
    @IBOutlet var BuyNowBtn: UIButton!
    @IBOutlet var QuantityBtn: UIButton!

    var delegates : resellerDelegate?
    let scrSize = UIScreen.mainScreen().bounds
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        SellerName.translatesAutoresizingMaskIntoConstraints = true
        SellerName.frame = CGRectMake(8, 33, 205, 21)
    }
    
    @IBAction func addtoCartClk(){
        self.delegates?.mycartDelegateFunction!((QuantityBtn.titleLabel?.text)!,tagIndx:QuantityBtn.tag)
    }
    @IBAction func buyNowaddtoCartClk(){
        self.delegates?.mycartBuyNowDelegateFunction!((QuantityBtn.titleLabel?.text)!,tagIndx:QuantityBtn.tag)
    }
       override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class ResellerViewController: UITableViewController,resellerDelegate,webServiceDelegate {

    var sellerArr : NSMutableArray = NSMutableArray()
    var  priceArr : NSMutableArray = NSMutableArray()
     var descriptionstr  : String!
   
    var imageurl : NSString!
    var productDictin:NSMutableDictionary!=NSMutableDictionary()
    var productSellerArray:NSMutableArray!=NSMutableArray()
    var isClick:String=""
     var myButton: UIButton!
    @IBOutlet var noInternetVc:UIView!
    @IBOutlet var wifiImg:UIImageView!
    @IBOutlet var noconnetinlbl:UILabel!
    @IBOutlet var retryBtn:UIButton!
    var availableQntArray:NSMutableArray!=NSMutableArray()
    var dataLayer: TAGDataLayer = TAGManager.instance().dataLayer
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        
        
    self.tableView.rowHeight = 95.0
        
        myButton = UIButton(frame: CGRect(x:0, y: self.view.bounds.size.height-41, width: screenWidth, height: 41))
   myButton.backgroundColor = UIColor(red: 31/255.0, green: 75/255.0, blue: 164/255.0, alpha: 1)
        myButton.titleLabel!.font =  UIFont(name: "MyriadPro-Bold", size: 17)
        myButton.setTitle("GO TO CART", forState: UIControlState.Normal)
    myButton.addTarget(self, action: #selector(ResellerViewController.pressed), forControlEvents: .TouchUpInside)
        myButton.layer.shadowColor = UIColor.blackColor().CGColor
        myButton.layer.shadowOpacity = 0.8
        myButton.layer.shadowOffset = CGSizeMake(2.0, 0.0)

        
        self.navigationController?.view.addSubview(myButton)
        myButton.hidden = true
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
        
         //JHProgressHUD.sharedHUD.showInView(self.view)
        self.tableView.tableFooterView = UIView()
        
         self.tabBarController?.tabBar.hidden = true
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true)
        {
         self.noInternetVc.removeFromSuperview()
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
         LoadingOverlay.shared.showOverlay(window)
        let headers = [
            "Authorization": authorizationWithoutLogin,
            "Accept": "application/json"
        ]
        //
       
       // print("url  \(baseUrl)product?id=\(productDictin["productId"]!)&offers=X")
        // JHProgressHUD.sharedHUD.showInWindow(self.view.window!)
        Alamofire.request(.GET, "\(baseUrl)product?id=\(productDictin["productId"]!)&offers=X", headers: headers)
            .validate(contentType: ["application/json"])
            
            .responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)
                var strData = NSString(data: response.data!, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)")// server data
                //print(response.result)   // result of response serialization
                self.productSellerArray.removeAllObjects()
                self.availableQntArray = NSMutableArray()
                if let JSON : NSArray = response.result.value as! NSArray {
                    
                    for (index, seller) in JSON.enumerate() {
                        let prodDet:NSMutableDictionary!=NSMutableDictionary()
                        if let description : String = seller["description"] as? String where index == 0
                        {
                         self.descriptionstr = description
                        }
                        if let galleryThumbNails : String = seller["imageURLHigh"] as? String where index == 0
                        {
                             //prodDet.setValue(galleryThumbNails, forKey: "imageURLMedium")
                                    self.imageurl = galleryThumbNails as NSString
                        
                         //   self.descriptionstr = description
                        }
                        
                        if let netPrice : String = seller["netPriceDisplayString"] as? String where index > 0
                        {
                             prodDet.setValue(netPrice, forKey: "placedPrice")
                             self.priceArr.addObject(netPrice)
                        }
                        if let skuNumber : String = seller["skuNumber"] as? String where index > 0
                        {
                           // self.priceArr.addObject(skuNumber)
                            prodDet.setValue(skuNumber, forKey: "skuNumber")
                        }
                        
                        if let sellerNumber : String = seller["sellerNumber"] as? String where index > 0
                        {
                            // self.priceArr.addObject(skuNumber)
                            prodDet.setValue(sellerNumber, forKey: "sellerNumber")
                        }
                        if let avaliableQuantity : Int = seller["avaliableQuantity"] as? Int where index > 0
                        {
                            // self.priceArr.addObject(skuNumber)
                            prodDet.setValue(avaliableQuantity, forKey: "avaliableQuantity")
                        }else{
                             prodDet.setValue(0, forKey: "avaliableQuantity")
                        }
                        if let sellerName : String = seller["sellerName"] as? String where index > 0
                        {
                            self.sellerArr.addObject(sellerName)
                            prodDet.setValue(sellerName, forKey: "sellerName")
                            if let avaliableQuantity : Int = seller["avaliableQuantity"] as? Int where index > 0
                            {
                                // self.priceArr.addObject(skuNumber)
                               self.availableQntArray.addObject(avaliableQuantity)
                            }
                        }
                         self.productSellerArray.addObject(prodDet)
                        let  headerCell = self.tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! CustomHeaderCell
                        headerCell.headerImage.hidden =  false
//                         print(prodDet)
//                         print(seller.valueForKey("netPrice"))
                    }
                   
                }
        LoadingOverlay.shared.hideOverlayView()
                //self.tableView.hidden = false
        self.tableView.reloadData()
        
        }
        }else{
           
                self.noInternetVc.translatesAutoresizingMaskIntoConstraints = true
                self.noInternetVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
                self.view.addSubview(self.noInternetVc)
            self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
            self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
            self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
            self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
            self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
            self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)
           
        }
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(ResellerViewController.internetReachable(_:)),
                                                         name: "reachable",
                                                         object: nil)
        
        
    }
    func pressed()
    {
        
        self.tabBarController?.selectedIndex = 2
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);
       
    }
    func buynowSendToServer(notification:NSNotification){
        // let string : AnyObject = notification.userInfo!
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId"){
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
            wsm.addToBasketOnlineDetails(usernm as! Int, sitecode: "IN", productDet: self.productDictin)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.title = "Seller"
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(ResellerViewController.buynowSendToServer(_:)),
                                                         name:"buylocalreseller",
                                                         object: nil)
        
    }
    func internetReachable(notification:NSNotification){
       noInternetClk()
        //print("in reseller via reachable")
    }
    
    @IBAction func noInternetClk(){
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true)
        {
            self.noInternetVc.removeFromSuperview()
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            let headers = [
                "Authorization": authorizationWithoutLogin,
                "Accept": "application/json"
            ]
            //
            
          //  print("url  \(baseUrl)product?id=\(productDictin["productId"]!)&offers=X")
            // JHProgressHUD.sharedHUD.showInWindow(self.view.window!)
            Alamofire.request(.GET, "\(baseUrl)product?id=\(productDictin["productId"]!)&offers=X", headers: headers)
                .validate(contentType: ["application/json"])
                
                .responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response) // URL response
//                    print(response.data)
                    var strData = NSString(data: response.data!, encoding: NSUTF8StringEncoding)
                    print("Body: \(strData)")// server data
                   // print(response.result)   // result of response serialization
                    self.productSellerArray.removeAllObjects()
                    if let JSON : NSArray = response.result.value as! NSArray {
                        
                        for (index, seller) in JSON.enumerate() {
                            let prodDet:NSMutableDictionary!=NSMutableDictionary()
                            if let description : String = seller["description"] as? String where index == 0
                            {
                                self.descriptionstr = description
                            }
                            if let galleryThumbNails : String = seller["imageURLHigh"] as? String where index == 0
                            {
                                //prodDet.setValue(galleryThumbNails, forKey: "imageURLMedium")
                                self.imageurl = galleryThumbNails as NSString
                                
                                //   self.descriptionstr = description
                            }
                            
                            if let netPrice : String = seller["netPriceDisplayString"] as? String where index > 0
                            {
                                prodDet.setValue(netPrice, forKey: "placedPrice")
                                self.priceArr.addObject(netPrice)
                            }
                            if let skuNumber : String = seller["skuNumber"] as? String where index > 0
                            {
                                // self.priceArr.addObject(skuNumber)
                                prodDet.setValue(skuNumber, forKey: "skuNumber")
                            }
                            
                            if let sellerNumber : String = seller["sellerNumber"] as? String where index > 0
                            {
                                // self.priceArr.addObject(skuNumber)
                                prodDet.setValue(sellerNumber, forKey: "sellerNumber")
                            }
                            if let avaliableQuantity : Int = seller["avaliableQuantity"] as? Int where index > 0
                            {
                                // self.priceArr.addObject(skuNumber)
                                prodDet.setValue(avaliableQuantity, forKey: "avaliableQuantity")
                            }
                            if let sellerName : String = seller["sellerName"] as? String where index > 0
                            {
                                self.sellerArr.addObject(sellerName)
                                prodDet.setValue(sellerName, forKey: "sellerName")
                                
                                
                            }
                            self.productSellerArray.addObject(prodDet)
                            let  headerCell = self.tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! CustomHeaderCell
                            headerCell.headerImage.hidden =  false
//                            print(prodDet)
//                            print(seller.valueForKey("netPrice"))
                        }
                        
                    }
                    LoadingOverlay.shared.hideOverlayView()
                    self.tableView.reloadData()
                    
            }
        }else{
            
            self.noInternetVc.translatesAutoresizingMaskIntoConstraints = true
            self.noInternetVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
            self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
            self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
            self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
            self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
            self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
            self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)
            self.view.addSubview(self.noInternetVc)
            
        }
    }
    override func viewWillDisappear(animated: Bool) {
        myButton.removeFromSuperview()
        self.title = ""
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "reachable", object: nil)
    }
   
    
    func mycartBuyNowDelegateFunction(qnty:String,tagIndx:Int){
         dataLayer.push(["event": "ButtonPressed", "eventAction": "buy now from reseller ios"])
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true)
        {
       // var prodDet:NSMutableDictionary!
           let prodDet = self.productSellerArray[tagIndx+1]
          //  print(prodDet)
            
        isClick="buynow"
        var qnt = qnty
        var arqnt = qnt.componentsSeparatedByString(":")
        qnt = arqnt[1]
        qnt = qnt.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        // let prodDet:NSMutableDictionary! = self.productSellerArray[tagIndx] as! NSMutableDictionary
          //print("prodDet    \(self.priceArr[tagIndx])")
        // self.productDictin.setValue(self.productSellerArray[tagIndx].valueForKey("imageURLMedium"), forKey: "imageURLMedium")
        self.productDictin.setValue(prodDet.valueForKey("sellerName"), forKey: "sellerName")
        self.productDictin.setValue(prodDet.valueForKey("sellerNumber"), forKey: "sellerNumber")
        self.productDictin.setValue(prodDet.valueForKey("skuNumber"), forKey: "skuNumber")
        self.productDictin.setValue(prodDet.valueForKey("avaliableQuantity"), forKey: "avaliableQuantity")
        // self.productDictin.setValue(self.productSellerArray[tagIndx].valueForKey("quantity"), forKey: "quantity")
        self.productDictin.setValue(qnt, forKey: "quantity")
             self.productDictin.setValue("y", forKey: "runSalesOrder")
        self.productDictin.setValue(self.priceArr[tagIndx], forKey: "placedPrice")
           // print(productDictin)
        var abc = productDictin["placedPrice"]! as! String
        var str = abc.stringByReplacingOccurrencesOfString(",", withString: "")
             str = str.stringByReplacingOccurrencesOfString(".00", withString: "")
       // print(abc)
            let a = Int(str as String)
        let b = Int(qnt)
        //print("price \(a) qnt \(b)")
        let exprsdf = a! * b! as Int
        self.productDictin.setValue(exprsdf, forKey: "extendedPrice")
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId"){
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
            wsm.addToBasketOnlineDetails(usernm as! Int, sitecode: "IN", productDet: self.productDictin)
        }else{
            let LoginViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("LoginView") as? LoginView
            LoginViewControllerObj?.isCalledFrm = "buynowreseller"
            let NavigationController = UINavigationController(rootViewController: LoginViewControllerObj!)
            
            self.presentViewController(NavigationController, animated: true, completion: nil)
            }
        }
        else{
    let alertView:UIAlertView = UIAlertView()
    alertView.title = ""
    alertView.message = ConstantsFile.noInternet_msg
    alertView.delegate = nil
    alertView.addButtonWithTitle("OK")
    alertView.show()
    }
        }
    func mycartDelegateFunction(qnty:String,tagIndx:Int){
         dataLayer.push(["event": "ButtonPressed", "eventAction": "add to cart from reseller ios"])
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true)
        {
            let prodDet = self.productSellerArray[tagIndx+1]
           // print(prodDet)
       // print("qnty \(qnty)  tag \(tagIndx) productSellerArray \(self.productSellerArray.count) ")
        isClick="cart"
        var qnt = qnty
        var arqnt = qnt.componentsSeparatedByString(":")
        qnt = arqnt[1]
        qnt = qnt.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
       // let prodDet:NSMutableDictionary! = self.productSellerArray[tagIndx] as! NSMutableDictionary
       // print("prodDet    \(productDictin["placedPrice"]!)")
       // self.productDictin.setValue(self.productSellerArray[tagIndx].valueForKey("imageURLMedium"), forKey: "imageURLMedium")
        self.productDictin.setValue(prodDet.valueForKey("sellerName"), forKey: "sellerName")
        self.productDictin.setValue(prodDet.valueForKey("sellerNumber"), forKey: "sellerNumber")
        self.productDictin.setValue(prodDet.valueForKey("skuNumber"), forKey: "skuNumber")
        self.productDictin.setValue(prodDet.valueForKey("avaliableQuantity"), forKey: "avaliableQuantity")
       // self.productDictin.setValue(self.productSellerArray[tagIndx].valueForKey("quantity"), forKey: "quantity")
        self.productDictin.setValue(qnt, forKey: "quantity")
           
        self.productDictin.setValue(prodDet.valueForKey("placedPrice"), forKey: "placedPrice")
        var str : String = productDictin["placedPrice"] as! String
            str = str.stringByReplacingOccurrencesOfString(",", withString: "")
            str = str.stringByReplacingOccurrencesOfString(".00", withString: "")
       // let a:Int = Int(str)!
        let a = Int(str)
        let b = Int(qnt)
       // print("price \(a) qnt \(b)")
        let exprsdf = a! * b! as Int
        self.productDictin.setValue(exprsdf, forKey: "extendedPrice")
        
       //  print(self.productDictin)
            
            
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId"){
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
            wsm.addToBasketOnlineDetails(usernm as! Int, sitecode: "IN", productDet: self.productDictin)
        }else{

               // print("prod dict \(productDictin)")
            var abc = productDictin["placedPrice"]! as! String
           // print(abc)
            //var str : String = productDictin["placedPrice"] as! String
            abc = abc.stringByReplacingOccurrencesOfString(",", withString: "")
            abc = abc.stringByReplacingOccurrencesOfString(".00", withString: "")
            // let a:Int = Int(str)!
            //let a = Int(str)

            let a = Int(abc as String)
             let limitedStock = productDictin["limitedStock"] as! Int
            let maximumQuantity = productDictin["maximumQuantity"] as! Int
            var avaliableQuantity1:Int!=0
            if let avaliableQuantity =  productDictin["avaliableQuantity"]
            {
            avaliableQuantity1 = productDictin["avaliableQuantity"] as! Int
            }
//            print(String(productDictin["productId"]!))
//                print(String(productDictin["vendorPartNumber"]!))
//                    print(String(productDictin["vendorCode"]!))
//                        print(String(productDictin["description"]!))
//                            print(String(productDictin["sellerName"]!))
//             print(String(productDictin["sellerNumber"]!))
//            print(String(productDictin["skuNumber"]!))
//            // print(prc as! Int)
//             print(String(qnt))
//            
//             print(exprsdf)
//             print(limitedStock,maximumQuantity,avaliableQuantity1)
//            let imageurl = productDictin["imageURLMedium"] as! String
//            if imageurl.isEmpty
//            {
//                 addToLocalcart(a!, quantity: String(qnt), productId: String(productDictin["productId"]!), vendorPartNumber: String(productDictin["vendorPartNumber"]!), extendedPrice: exprsdf, vendorCode: String(productDictin["vendorCode"]!), description: String(productDictin["description"]!), imageURLMedium: "", sellerName: String(productDictin["sellerName"]!), sellerNumber: String(productDictin["sellerNumber"]!), limitedStock:limitedStock , maximumQuantity: maximumQuantity, availabilty: avaliableQuantity1, skuNumber: String(productDictin["skuNumber"]!),prodDic:prodDet as! NSMutableDictionary,basketId: "",lineItemId: "")
//            }
//            else
//            {
//             addToLocalcart(a!, quantity: String(qnt), productId: String(productDictin["productId"]!), vendorPartNumber: String(productDictin["vendorPartNumber"]!), extendedPrice: exprsdf, vendorCode: String(productDictin["vendorCode"]!), description: String(productDictin["description"]!), imageURLMedium: String(imageurl), sellerName: String(productDictin["sellerName"]!), sellerNumber: String(productDictin["sellerNumber"]!), limitedStock:limitedStock , maximumQuantity: maximumQuantity, availabilty: avaliableQuantity1, skuNumber: String(productDictin["skuNumber"]!),prodDic: prodDet as! NSMutableDictionary,basketId: "",lineItemId: "")
//            }
            
            if let img = productDictin["imageURLMedium"]{
            addToLocalcart(a!, quantity: String(qnt), productId: String(productDictin["productId"]!), vendorPartNumber: String(productDictin["vendorPartNumber"]!), extendedPrice: exprsdf, vendorCode: String(productDictin["vendorCode"]!), description: String(productDictin["description"]!), imageURLMedium: String(img), sellerName: String(productDictin["sellerName"]!), sellerNumber: String(productDictin["sellerNumber"]!), limitedStock:limitedStock , maximumQuantity: maximumQuantity, availabilty: avaliableQuantity1, skuNumber: String(productDictin["skuNumber"]!),prodDic: prodDet as! NSMutableDictionary,basketId: "",lineItemId: "")
            }else{
                 addToLocalcart(a!, quantity: String(qnt), productId: String(productDictin["productId"]!), vendorPartNumber: String(productDictin["vendorPartNumber"]!), extendedPrice: exprsdf, vendorCode: String(productDictin["vendorCode"]!), description: String(productDictin["description"]!), imageURLMedium: "", sellerName: String(productDictin["sellerName"]!), sellerNumber: String(productDictin["sellerNumber"]!), limitedStock:limitedStock , maximumQuantity: maximumQuantity, availabilty: avaliableQuantity1, skuNumber: String(productDictin["skuNumber"]!),prodDic:prodDet as! NSMutableDictionary,basketId: "",lineItemId: "")
            }
            let alertView:UIAlertView = UIAlertView()
            alertView.title = ""
            alertView.message = "Product added to cart."
            alertView.delegate = nil
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
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
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.sellerArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomTableCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
//        cell.AddToCart.translatesAutoresizingMaskIntoConstraints = true
//        cell.AddToCart.frame = CGRectMake(screenSize.width-100, screenSize.height-38, 70, 30)
        cell.AddToCart.layer.borderWidth = 0.8
         cell.AddToCart.layer.borderColor = UIColor (red: 31/255.0, green: 75/255.0, blue: 164/255.0, alpha: 1.0).CGColor
      //  cell.AddToCart.titleLabel?.textAlignment = NSTextAlignment.Center
        
       
        
//        cell.BuyNowBtn.translatesAutoresizingMaskIntoConstraints = true
        cell.BuyNowBtn.layer.borderWidth = 0.8
        cell.BuyNowBtn.layer.borderColor = UIColor (red: 31/255.0, green: 75/255.0, blue: 164/255.0, alpha: 1.0).CGColor
       // cell.BuyNowBtn.titleLabel?.textAlignment = NSTextAlignment.Center
        
        
        cell.QuantityBtn.layer.borderWidth = 0.8
        cell.QuantityBtn.layer.borderColor = UIColor (red: 31/255.0, green: 75/255.0, blue: 164/255.0, alpha: 1.0).CGColor
       // cell.QuantityBtn.titleLabel?.textAlignment = NSTextAlignment.Center
        
        cell.QuantityBtn.addTarget(self, action: #selector(ResellerViewController.QtybuttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.delegates = self
        
//        let image2 = UIImage(named: "DownArrow")!
//         //cell.QuantityBtn.setImage(nil, forState: UIControlState.Normal)
//        //cell.QuantityBtn.semanticContentAttribute = .ForceRightToLeft
        cell.QuantityBtn.tag = indexPath.row
//         //cell.QuantityBtn.imageEdgeInsets = UIEdgeInsetsMake(2, 0, 0, -3);
//        // cell.QuantityBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -9, 0, 0);
// UIEdgeInsetsMake(<#T##top: CGFloat##CGFloat#>, <#T##left: CGFloat##CGFloat#>, <#T##bottom: CGFloat##CGFloat#>, <#T##right: CGFloat##CGFloat#>)
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        
        cell.priceLabel.text = "₹ \(self.priceArr.objectAtIndex(indexPath.row) as! String)"
          cell.SellerName.text = "By \(self.sellerArr.objectAtIndex(indexPath.row) as! String)"
        
        
       var proDict =  self.productSellerArray.objectAtIndex(indexPath.row) as! NSDictionary
        
        let availableQty = availableQntArray.objectAtIndex(indexPath.row) as? Int
        
      //  print(availableQty)
        
        if(availableQty > 0){
            cell.AddToCart.hidden = false
            cell.BuyNowBtn.hidden = false
        }else{
            cell.AddToCart.hidden = true
            cell.BuyNowBtn.hidden = true
        }
        
        
        
        return cell
    }

    
    func QtybuttonClicked(sender:UIButton) {
        
        let alert = UIAlertController(title: ConstantsFile.selectQty_msg, message:"", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "1", style: UIAlertActionStyle.Default, handler:  { (action) -> Void in
            
            sender.setTitle("Qty : 1", forState: UIControlState.Normal)
        }))
        alert.addAction(UIAlertAction(title: "2", style: UIAlertActionStyle.Default, handler:{ (action) -> Void in
           sender.setTitle("Qty : 2", forState: UIControlState.Normal)
        }))
        alert.addAction(UIAlertAction(title: "3", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            sender.setTitle("Qty : 3", forState: UIControlState.Normal)
        }))
        alert.addAction(UIAlertAction(title: "4", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            sender.setTitle("Qty : 4", forState: UIControlState.Normal)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
     self.presentViewController(alert, animated: true, completion: nil)
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(sellerArr.count > 0){
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! CustomHeaderCell
    
        headerCell.layer.borderWidth = 0.5
        headerCell.layer.borderColor = UIColor .lightGrayColor().CGColor
    
        if let descrptn : String = self.descriptionstr
        {
        headerCell.headerTextLbl.text = descrptn
        }
         headerCell.headerImage.frame = CGRectMake(10, 9, 80, 80)
        if let imagelink : NSString = self.imageurl {
            
       
        Alamofire.request(.GET, NSURL(string:imagelink as String)!)
            .responseImage { response in
                debugPrint(response)
                
//                print(response.request)
//                print(response.response)
                debugPrint(response.result)
                
                
                headerCell.headerImage.hidden =  false
                
                if let image = response.result.value {
                                       headerCell.headerImage.image = image
                  
                }}
        }
        return headerCell
        }else{
            var DynamicView=UIView(frame: CGRectMake(0, 0, screenSize.width, 100))
            DynamicView.backgroundColor = UIColor.whiteColor()
            return DynamicView
        }
    }
    
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }

    func addToLocalcart(placedPrice:Int,quantity:String,productId:String,vendorPartNumber:String,extendedPrice:Int,vendorCode:String,description:String,imageURLMedium:String,sellerName:String,sellerNumber:String,limitedStock:Int,maximumQuantity:Int,availabilty:Int,skuNumber:String,prodDic:NSMutableDictionary,basketId:String,lineItemId:String)  {
        myButton.hidden = false
        //lineCount
        // prodDic as! String
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        var skuno = productDictin["productId"]! as! String
        let managedContext = appDelegate.managedObjectContext
        let searchpredicate = NSPredicate(format: "skuNumber == %@",skuNumber)
        let searchpredicate1 = NSPredicate(format: "sellerName == %@",sellerName)
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
                    recentsearch.setValue(placedPrice, forKey: "placedPrice")
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
                    recentsearch.setValue("", forKey: "allData")
                    recentsearch.setValue(skuNumber, forKey: "skuNumber")
                    //  recentsearch.setValue(lineItemId, forKey: "lineItemId")
                    
                    //4
                    do {
                        try managedContext.save()
                        
                        
                    } catch let error as NSError  {
                        print("Could not save \(error), \(error.userInfo)")
                    }
                }  else
                {
                    //                    let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
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
                        // try context.save()
                        
                        //                        let entity =  NSEntityDescription.entityForName("MyCart",
                        //                                                                        inManagedObjectContext:managedContext)
                        //
                        //                        let recentsearch = NSManagedObject(entity: entity!,
                        //                                                           insertIntoManagedObjectContext: managedContext)
                        
                        //3
                        person.setValue(placedPrice, forKey: "placedPrice")
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
                        person.setValue("", forKey: "allData")
                        //  recentsearch.setValue(basketId, forKey: "basketId")
                        //  recentsearch.setValue(lineItemId, forKey: "lineItemId")
                        
                        //4
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
                        // self.bottomVc.hidden = true
                        //self.noResultLbl.hidden=false
                        let defaults = NSUserDefaults.standardUserDefaults()
                        defaults.setObject("", forKey: "badge")
                    }else{
                        let defaults = NSUserDefaults.standardUserDefaults()
                        defaults.setObject(String(people.count), forKey: "badge")
                        //self.bottomVc.hidden = false
                        //self.noResultLbl.hidden=true
                    }
                    
                }
                //                data.append(people)
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }catch {
                // Catch any other errors
            }
            
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }catch {
            // Catch any other errors
        }
        
        
    }
    func addTocartSuccess(string:NSDictionary)
    {
        myButton.hidden = false
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
            //self.productDictin.setValue(qnt, forKey: "quantity")
          // print(String(productDictin["extendedPrice"]!))
            chkVC.TotalPrice = "₹ \(String(productDictin["extendedPrice"]!))"
            chkVC.isCalled = "buy"
            chkVC.cartItemArray = NSArray().mutableCopy() as! NSArray
            //chkVC.TotalPrice = "₹ \(String(exprsdf))"
            chkVC.sellerNo = "\(productDictin["sellerNumber"]!)"
            var qnt = productDictin["quantity"]!
//            var arqnt = qnt?.componentsSeparatedByString(":")
//            qnt = arqnt![1]
//            qnt = qnt!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            chkVC.quantity = qnt as! String
            chkVC.skuNo = "\(productDictin["skuNumber"]!)"
            chkVC.isCalled = "buy"
            chkVC.cartItemArray = NSArray()
            self.navigationController?.pushViewController(chkVC, animated: true)
            
        }else{

            if let cnt = string.valueForKey("lineCount") as? String{
                //  if(){
                let tabArray = self.tabBarController?.tabBar.items as NSArray!
                let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
                tabItem.badgeValue = cnt
                if(tabItem.badgeValue == "0" || tabItem.badgeValue == ""){
                    tabItem.badgeValue = nil
                }else{
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setObject(cnt, forKey: "badge")
                }
                // }
            }
           // print(string.valueForKey("lineCount"))
            
        }
    }



}

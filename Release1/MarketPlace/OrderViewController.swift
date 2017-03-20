//
//  OrderViewController.swift
//  MarketPlace
//
//  Created by Administrator on 01/09/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class OrederResult: NSObject,Mappable {
    var AddressId: String?
    var UserId: Int?
    var isCOD: Bool?
    var orderDetails: OrderDetails?
    var orderLine: OrderLine?
    
       
    required init?(_ map: Map){
        
    }
    
    
    func mapping(map: Map)
    {
        AddressId <- map["AddressId"]
        UserId <- map["UserId"]
        isCOD <- map["isCOD"]
        orderDetails <- map["OrderDetails"]
        orderLine <- map["OrderLine"]
       
    }
}

class OrderLine:  NSObject,Mappable {
    
    var ingramPartNumber: String?
    var vendorPartNumber: String?
    var imageURL: String?
    var customerLineNumber: String?
    var mpn: String?
    var skuDescription: String?
    var requestedQuantity: String?
    var payer: String?
    var shipTo: String?
    var status: String?
    var unitNetAmount: String?
    var globalPriceClass: String?
    var productInfo: String?
    var invoice:String?
    
    // var RequestedQuantity: String?
    var TotalRefundAmount: String?
    var LineNumber: String?
    // var IngramPartNumber: String?
    var ReferenceDocNumber: String?
    var ReferenceDocLineNumber: String?
    var ReasonCode:String?
    
    var AddressID: String?
    var ReturnInvoiceNumber: String?
    var MPN: String?
    //  var SkuDescription:String?
    var SkuImageURL:String?
    var Plant:String?
    var SkuNetPrice:String?
    
    var totalValues:TotalValues?
    var serialNumber:SerialNumber?
    var delivery:Delivery?
    var orderReturninfo:OrderReturninfo?
    var displayserialnumbers:Displayserialnumbers?
    var quantitylist:NSMutableArray?
    var newSerialNumbers: NewSerialNumbers?
    //SerialNumbers
    required init?(_ map: Map){
        
    }
    func mapping(map: Map)
    {
        ingramPartNumber <- map["ingramPartNumber"]
        vendorPartNumber <- map["vendorPartNumber"]
        imageURL <- map["imageURL"]
        customerLineNumber <- map["customerLineNumber"]
        
        mpn <- map["mpn"]
        skuDescription <- map["skuDescription"]
        requestedQuantity <- map["requestedQuantity"]
        payer <- map["payer"]
        shipTo <- map["stateName"]
        status <- map["status"]
        unitNetAmount <- map["unitNetAmount"]
        globalPriceClass <- map["globalPriceClass"]
        productInfo <- map["productInfo"]
        invoice <- map["invoice"]
        
        // RequestedQuantity <- map["RequestedQuantity"]
        TotalRefundAmount <- map["TotalRefundAmount"]
        LineNumber <- map["LineNumber"]
        // IngramPartNumber <- map["IngramPartNumber"]
        ReferenceDocNumber <- map["ReferenceDocNumber"]
        ReferenceDocLineNumber <- map["ReferenceDocLineNumber"]
        ReasonCode <- map["ReasonCode"]
        
        AddressID <- map["AddressID"]
        ReturnInvoiceNumber <- map["ReturnInvoiceNumber"]
        MPN <- map["MPN"]
        //  SkuDescription <- map["SkuDescription"]
        SkuImageURL <- map["SkuImageURL"]
        SkuNetPrice <- map["SkuNetPrice"]
        Plant <- map["Plant"]
        
        totalValues <- map["totalValues"]
        serialNumber <- map["serialNumber"]
        delivery <- map["delivery"]
        orderReturninfo <- map["orderReturninfo"]
        displayserialnumbers <- map["displayserialnumbers"]
        quantitylist <- map["quantitylist"]
        newSerialNumbers <- map["NewSerialNumbers"]
        //SerialNumbers
    }
    
}
class OrderDetails: NSObject,Mappable {
    var orderNumber: String?
    var orderDate: String?
    var strOrderDate: String?
    var paymentTerms: String?
    var shippableFreightAmount: Int?
    var totalShippableAmount: String?
    var userId: String?
    var billTo: String?
    var soldTo: String?
    var billToCustomerNumber: String?
    var trackingNumber: String?
    var globalPriceClass: String?
    var customernumber: String?
    var userid: String?
    var billtocustomernumber: String?
    var trackingnumber: String?
    
    
    var payer:Payer?
    var shipTo:ShipTo?
    var shipto:ShipTo?
    var customer:Customer?
    var totalValues:TotalValues?
    var lines:[Lines]?
    required init?(_ map: Map){
        
    }
    
    
    func mapping(map: Map)
    {
        orderNumber <- map["orderNumber"]
        orderDate <- map["orderDate"]
        strOrderDate <- map["strOrderDate"]
        paymentTerms <- map["paymentTerms"]
        
        shippableFreightAmount <- map["shippableFreightAmount"]
        totalShippableAmount <- map["totalShippableAmount"]
        userId <- map["userId"]
        billTo <- map["billTo"]
        soldTo <- map["soldTo"]
        billToCustomerNumber <- map["billToCustomerNumber"]
        trackingNumber <- map["trackingNumber"]
        globalPriceClass <- map["globalPriceClass"]
        customernumber <- map["customernumber"]
        payer <- map["payer"]
        shipTo <- map["shipTo"]
        customer <- map["customer"]
        lines <- map["lines"]
        userid <- map["userid"]
        billtocustomernumber <- map["billtocustomernumber"]
        trackingnumber <- map["trackingnumber"]
        shipto <- map["shipTo"]
    }
}
class Lines:  NSObject,Mappable {
    
    var ingramPartNumber: String?
    var vendorPartNumber: String?
    var imageURL: String?
    var customerLineNumber: String?
    var mpn: String?
    var skuDescription: String?
    var requestedQuantity: Int?
    var payer: String?
    var shipTo: String?
    var status: String?
    var unitNetAmount: String?
    var globalPriceClass: String?
    var productInfo: String?
    var invoice:String?
    
   
    var TotalRefundAmount: String?
    var LineNumber: Int?
   
    var ReferenceDocNumber: String?
    var ReferenceDocLineNumber: String?
    var ReasonCode:String?
    
    var AddressID: String?
    var ReturnInvoiceNumber: String?
    var MPN: String?
  
    var SkuImageURL:String?
    var Plant:String?
    var SkuNetPrice:String?
     var nwplant:String?
    var totalValues:TotalValues?
    var serialNumber:NSMutableArray?
    var delivery:NSMutableArray?
    var orderReturninfo:NSMutableArray?
    var displayserialnumbers:NSMutableArray?
    var quantitylist:NSMutableArray?
    var NewSerialNumbers: NSMutableArray?
    var SerialNumbers: NSMutableArray?
    var RequestedQuantity:Int?
    
     var nwIngramPartNumber: NSString?
      var nwSkuDescription:String?
    
    
    required init?(_ map: Map){
        
    }
    func mapping(map: Map)
    {
        ingramPartNumber <- map["ingramPartNumber"]
        vendorPartNumber <- map["vendorPartNumber"]
        imageURL <- map["imageURL"]
        customerLineNumber <- map["customerLineNumber"]
        
        mpn <- map["mpn"]
        skuDescription <- map["skuDescription"]
        requestedQuantity <- map["requestedQuantity"]
        payer <- map["payer"]
        shipTo <- map["stateName"]
        status <- map["status"]
        unitNetAmount <- map["unitNetAmount"]
        globalPriceClass <- map["globalPriceClass"]
        productInfo <- map["productInfo"]
        invoice <- map["invoice"]
        
       // RequestedQuantity <- map["RequestedQuantity"]
        TotalRefundAmount <- map["TotalRefundAmount"]
        LineNumber <- map["LineNumber"]
       // IngramPartNumber <- map["IngramPartNumber"]
        ReferenceDocNumber <- map["ReferenceDocNumber"]
        ReferenceDocLineNumber <- map["ReferenceDocLineNumber"]
        ReasonCode <- map["ReasonCode"]
        
        AddressID <- map["AddressID"]
        ReturnInvoiceNumber <- map["ReturnInvoiceNumber"]
        MPN <- map["MPN"]
      //  SkuDescription <- map["SkuDescription"]
        SkuImageURL <- map["SkuImageURL"]
        SkuNetPrice <- map["SkuNetPrice"]
        Plant <- map["Plant"]
        
        totalValues <- map["totalValues"]
        serialNumber <- map["serialNumber"]
        delivery <- map["delivery"]
        orderReturninfo <- map["orderReturninfo"]
        displayserialnumbers <- map["displayserialnumbers"]
        quantitylist <- map["quantitylist"]
        NewSerialNumbers <- map["NewSerialNumbers"]
        SerialNumbers <- map["SerialNumbers"]
        RequestedQuantity <- map["RequestedQuantity"]
        nwIngramPartNumber <- map["IngramPartNumber"]
        nwSkuDescription <- map["SkuDescription"]
        nwplant <- map["Plant"]
    }
    
}
class Quantitylist:  NSObject,Mappable {
    
    var key: Int?
    var value: Int?
    var isselected: String?
    
    
    required init?(_ map: Map){
        
    }
    func mapping(map: Map)
    {
        key <- map["key"]
        value <- map["value"]
        isselected <- map["isselected"]
      
    }
    
}
class NewSerialNumbers:  NSObject,Mappable {
    
    var serialNumber: String?
    
    var deliveryNumber: String?
    
    
    required init?(_ map: Map){
        
    }
    func mapping(map: Map)
    {
        serialNumber <- map["serialNumber"]
        deliveryNumber <- map["deliveryNumber"]
        
    }
    
}

class SerialNumber:  NSObject,Mappable {
    
    var serialNumber: String?
    
    var deliveryNumber: String?
    
    
    required init?(_ map: Map){
        
    }
    func mapping(map: Map)
    {
        serialNumber <- map["serialNumber"]
        deliveryNumber <- map["deliveryNumber"]
        
    }
    
}
class TotalValues:  NSObject,Mappable {
    
    var netAmount: String?
    var taxAmount: Int?
    var promoAmount: String?
    var extendedProductPrice: Int?
    var totalFreightAmount: String?
    var totalShippableAmount: Int?
    var globalPriceClass: String?
   
    required init?(_ map: Map){
        
    }
    func mapping(map: Map)
    {
        netAmount <- map["netAmount"]
        taxAmount <- map["taxAmount"]
        promoAmount <- map["promoAmount"]
        extendedProductPrice <- map["extendedProductPrice"]
        
        totalFreightAmount <- map["totalFreightAmount"]
        totalShippableAmount <- map["totalShippableAmount"]
        globalPriceClass <- map["globalPriceClass"]
        
    }
    
}
class Displayserialnumbers:  NSObject,Mappable {
    
    var serialNumber: String?
    
    
    required init?(_ map: Map){
        
    }
    func mapping(map: Map)
    {
        serialNumber <- map["serialNumber"]

        
        
    }
    
}
class OrderReturninfo:  NSObject,Mappable {
    
    var shipmentDate: String?
    var deliveryStatus: String?
    var podDate: String?
    var strPODDate: String?
    var trackingNumber: String?
    var trackingURL: String?
    var showTracking: String?
    var hideTraceSection: String?
    var showReturnRequest: String?
  
    
    required init?(_ map: Map){
        
    }
    func mapping(map: Map)
    {
        shipmentDate <- map["shipmentDate"]
        deliveryStatus <- map["deliveryStatus"]
        podDate <- map["podDate"]
        strPODDate <- map["strPODDate"]
        
        trackingNumber <- map["trackingNumber"]
        trackingURL <- map["trackingURL"]
        showTracking <- map["showTracking"]
        hideTraceSection <- map["hideTraceSection"]
        showReturnRequest <- map["showReturnRequest"]
       
        
    }
    
}
class Delivery:  NSObject,Mappable {
    
    var shipmentDate: String?
    var deliveryStatus: String?
    var podDate: String?
    var strPODDate: String?
    var trackingNumber: String?
    var trackingURL: String?
    var showTracking: String?
    var hideTraceSection: String?
    var showReturnRequest: String?
    var invoiceNumber: String?
    var returnType: String?
    var quantity: Int?
    var packageResponse:PackageResponse?
    
    required init?(_ map: Map){
        
    }
    func mapping(map: Map)
    {
        shipmentDate <- map["shipmentDate"]
        deliveryStatus <- map["deliveryStatus"]
        podDate <- map["podDate"]
        strPODDate <- map["strPODDate"]
        
        trackingNumber <- map["trackingNumber"]
        trackingURL <- map["trackingURL"]
        showTracking <- map["showTracking"]
        hideTraceSection <- map["hideTraceSection"]
        showReturnRequest <- map["showReturnRequest"]
        invoiceNumber <- map["invoiceNumber"]
        returnType <- map["returnType"]
        quantity <- map["quantity"]
       packageResponse <- map["packageResponse"]
        
    }
    
}
class PackageResponse:  NSObject,Mappable {
    
    var awbNumber: String?
    
    var lstPackageFlowResponse: String?
    
    
    required init?(_ map: Map){
        
    }
    func mapping(map: Map)
    {
        awbNumber <- map["awbNumber"]
        lstPackageFlowResponse <- map["lstPackageFlowResponse"]
        
    }
    
}
class Payer:  NSObject,Mappable {
    
    var id: String?
    var name1: String?
    var addressLine1: String?
    var addressLine2: String?
    var addressLine3: String?
    var addressLine4: String?
    var city: String?
    var postalCode: String?
    var stateName: String?
    var stateCode: String?
    var countryCode: String?
    var email: String?
    var phoneNumber: String?
    required init?(_ map: Map){
        
    }
    func mapping(map: Map)
    {
        id <- map["id"]
        name1 <- map["name1"]
        addressLine1 <- map["addressLine1"]
        addressLine2 <- map["addressLine2"]
        
        addressLine3 <- map["addressLine3"]
        addressLine4 <- map["addressLine4"]
        city <- map["city"]
        postalCode <- map["postalCode"]
        stateName <- map["stateName"]
        stateCode <- map["stateCode"]
        countryCode <- map["countryCode"]
        email <- map["email"]
        phoneNumber <- map["phoneNumber"]
        
    }
    
}
class Customer:  NSObject,Mappable {
    
    var id: String?
    var name1: String?
    var addressLine1: String?
    var addressLine2: String?
    var addressLine3: String?
    var addressLine4: String?
    var city: String?
    var postalCode: String?
    var stateName: String?
    var stateCode: String?
    var countryCode: String?
    var email: String?
    var phoneNumber: String?
    required init?(_ map: Map){
        
    }
    func mapping(map: Map)
    {
        id <- map["id"]
        name1 <- map["name1"]
        addressLine1 <- map["addressLine1"]
        addressLine2 <- map["addressLine2"]
        
        addressLine3 <- map["addressLine3"]
        addressLine4 <- map["addressLine4"]
        city <- map["city"]
        postalCode <- map["postalCode"]
        stateName <- map["stateName"]
        stateCode <- map["stateCode"]
        countryCode <- map["countryCode"]
        email <- map["email"]
        phoneNumber <- map["phoneNumber"]
        
    }
    
}

class ShipTo:  NSObject,Mappable {
    
    var id: String?
    var name1: String?
    var addressLine1: String?
    var addressLine2: String?
    var addressLine3: String?
    var addressLine4: String?
    var city: String?
    var postalCode: String?
    var stateName: String?
    var stateCode: String?
    var countryCode: String?
    var email: String?
    var phoneNumber: String?
    required init?(_ map: Map){
        
    }
    func mapping(map: Map)
    {
        id <- map["id"]
        name1 <- map["name1"]
        addressLine1 <- map["addressLine1"]
        addressLine2 <- map["addressLine2"]
        
        addressLine3 <- map["addressLine3"]
        addressLine4 <- map["addressLine4"]
        city <- map["city"]
        postalCode <- map["postalCode"]
        stateName <- map["stateName"]
        stateCode <- map["stateCode"]
        countryCode <- map["countryCode"]
        email <- map["email"]
        phoneNumber <- map["phoneNumber"]
        
    }
    
}
class OrderViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate,orderReturnDelegate {

    
    @IBOutlet weak var clearBtn: UIButton!
    
    @IBOutlet weak var orderTableView: UITableView!
//    @IBOutlet weak var orderHeaderView: UIView!
    @IBOutlet weak var amtLabel: UILabel!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var serachLabel: UILabel!
    @IBOutlet weak var orderSegmentOutlet: UISegmentedControl!
    var currentPage:Int=1
    var totalPages:Int=0
    var odersArray:NSMutableArray! = NSMutableArray()
    var orderStatus:String!=""
    var currentPageOpen:Int=1
    var totalPagesOpen:Int=0
    var numberOfRecordAll:Int=0
    var numberOfRecordOpen:Int=0
    var odersOpenArray:NSMutableArray! = NSMutableArray()
    var orderProductsDict:NSMutableDictionary!
    var orderProductsDictOpen:NSMutableDictionary!
     var appdelegate:AppDelegate!
    var copyOfAllOrderArr:NSMutableArray!=NSMutableArray()
    var copyOfOpenArray:NSMutableArray!=NSMutableArray()
    var copyOforderProductsDict:NSMutableDictionary!
    var copyOforderProductsDictOpen:NSMutableDictionary!
    @IBOutlet var noResultLabl:UILabel!
      let boundss = UIScreen.mainScreen().bounds
     var activity  : UIActivityIndicatorView!
    @IBOutlet var searchVc:UIView!
     var isCalledFrom:NSString!
    @IBOutlet var noInternetVc:UIView!
    @IBOutlet var wifiImg:UIImageView!
    @IBOutlet var noconnetinlbl:UILabel!
    @IBOutlet var retryBtn:UIButton!
    
    @IBOutlet var noResultVc:UIView!
    @IBOutlet var noResultImg:UIImageView!
     var isLockUI:Bool!=false
    var pageContForProd:Int=0
    var pageContForProdOpen:Int=0
    @IBAction func orderSegmentAction(sender: UISegmentedControl) {
       
         noResultVc.hidden = true
        if(orderSegmentOutlet.selectedSegmentIndex == 0){
            
            if(odersArray.count == 0){
                noResultVc.hidden = true
                orderTableView.hidden = true
                odersArray.removeAllObjects()
                orderTableView.reloadData()
                self.totalPages = 0
                currentPage = 1
                searchVc.hidden = true
                let window :UIWindow = UIApplication.sharedApplication().keyWindow!
                LoadingOverlay.shared.showOverlay(window)
                
                callApi()
            }else{
                searchVc.hidden = false
                orderTableView.reloadData()
            }
            
        }else{
             if(odersOpenArray.count == 0){
               
                orderTableView.hidden = true
                odersOpenArray.removeAllObjects()
                orderTableView.reloadData()
                self.totalPagesOpen = 0
                currentPageOpen = 1
                let window :UIWindow = UIApplication.sharedApplication().keyWindow!
                LoadingOverlay.shared.showOverlay(window)
                searchVc.hidden = true
                callApi()
             }else{
                searchVc.hidden = false
                orderTableView.reloadData()
            }
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
//myOrdersOpen
        // Do any additional setup after loading the view.
        orderProductsDict = NSMutableDictionary()
        orderProductsDictOpen = NSMutableDictionary()
        copyOforderProductsDict = NSMutableDictionary()
        copyOforderProductsDictOpen = NSMutableDictionary()
       // self.navigationItem.hidesBackButton = true
        //et newBackButton = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.Bordered, target: self, action: "back:")
       // self.navigationItem.leftBarButtonItem = newBackButton;
        let titleLab = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        titleLab.font = UIFont(name: "MyriadPro-Regular", size: 20)
        titleLab.textColor = headerColor
        titleLab.text = "My Orders"
        self.navigationItem.titleView = titleLab
        currentPage = 1
        currentPageOpen = 1
        self.totalPages = 0
        self.totalPagesOpen = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(OrderViewController.handleTap(_:)))
        tap.delegate = self
        orderSegmentOutlet.selectedSegmentIndex = 0
        clearBtn.hidden = true
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
        self.noInternetVc.hidden = true
        var window :UIWindow = UIApplication.sharedApplication().keyWindow!
        LoadingOverlay.shared.showOverlay(window)
        callApi()
        }else{
            self.noInternetVc.hidden = false
            self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
            self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
            self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
            self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
            self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
            self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)

        }
        searchTF.delegate = self
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
       guard let text = textField.text else { return true}
        let newlength = (text.characters.count) + string.characters.count - range.length
        return newlength <= 15
        
    }
    
    @IBAction func noInternetClk(){
        orderProductsDict = NSMutableDictionary()
        orderProductsDictOpen = NSMutableDictionary()
        copyOforderProductsDict = NSMutableDictionary()
        copyOforderProductsDictOpen = NSMutableDictionary()
        clearBtn.hidden = true
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            self.noInternetVc.hidden = true
        var window :UIWindow = UIApplication.sharedApplication().keyWindow!
        LoadingOverlay.shared.showOverlay(window)
        callApi()
        }else{
//            self.noInternetVc.translatesAutoresizingMaskIntoConstraints = true
//            self.noInternetVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
//            self.view.addSubview(self.noInternetVc)
            self.noInternetVc.hidden = false
            self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
            self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
            self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
            self.noconnetinlbl.text = "No internet Connection"
            self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
            self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
            self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)
        }
    }
    func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        if(self.isCalledFrom == "account"){
             self.navigationController?.popViewControllerAnimated(true)
        }
        else{
            if(isCalledFrom == "buy"){
                NSNotificationCenter.defaultCenter().postNotificationName("back", object: nil, userInfo: nil)
           }else{
                    NSNotificationCenter.defaultCenter().postNotificationName("back", object: nil, userInfo: nil)
  
            }
           
        }
    }

    override func viewWillAppear(animated: Bool) {
       
         self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(OrderViewController.getOrderList(_:)),
                                                         name: "myOrders",
                                                         object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(OrderViewController.getOrderListOpen(_:)),
                                                         name: "myOrdersOpen",
                                                         object: nil)
         self.tabBarController?.tabBar.hidden = true
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(OrderViewController.internetReachable(_:)),
                                                         name: "reachable",
                                                         object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(OrderViewController.orderFail(_:)),
                                                         name: "myOrdersFail",
                                                         object: nil)
        //        NSNotificationCenter.defaultCenter().postNotificationName("myOrdersFail", object: nil, userInfo: nil )
        
        if(self.isCalledFrom != "account"){
        var navArray:Array = (self.navigationController?.viewControllers)!
            for (index,vc) in navArray.enumerate() {
                if(vc.isKindOfClass(CheckoutViewController)){
                    navArray.removeAtIndex(index)
                }
            }
       // navArray.removeAtIndex(navArray.count-2)
        self.navigationController?.viewControllers = navArray
        }
        
        searchTF.attributedPlaceholder = NSAttributedString(string: "Search By Order Number", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
    }
    func internetReachable(notification:NSNotification){
        noInternetClk()
        print("in category via reachable")
    }
    func callApi()  {
        
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
        self.noInternetVc.hidden = true
        let wsm : WebServiceClass = WebServiceClass.sharedInstance
        if(orderSegmentOutlet.selectedSegmentIndex == 0){
        wsm.getMyOrderListDetails(currentPage, orderNumber: "", orderStatus: "")
        }else{
        wsm.getMyOrderListDetailsForOpen(currentPageOpen, orderNumber: "", orderStatus: "Open")
        }
        }else{
            self.noInternetVc.hidden = false
            self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
            self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
            self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
            self.noconnetinlbl.text = "No internet Connection"
            self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
            self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
            self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)
        }
    }
    
    func orderFail(notification: NSNotification)  {
        print(notification)
        self.noInternetVc.hidden = false
        self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
        self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
        self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
        self.noconnetinlbl.text = "Request Failed.Please try again."
        self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
        self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
        self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)
    }
    func getOrderListOpen(notification: NSNotification)  {
        print(notification)
        LoadingOverlay.shared.hideOverlayView()
        orderTableView.hidden = false
        orderTableView.tableFooterView = nil
        
        let dict : AnyObject = notification.userInfo!
        print(dict["orders"])
        isLockUI = false
        if let orderlistDict  = dict["salesOrderSearch"] as? NSDictionary{
            print(orderlistDict["totalNumberOfResults"])
          
            if(orderlistDict.count <= 0){
                searchVc.hidden = true
                orderSegmentOutlet.hidden = true
                self.noResultVc.hidden = false
                self.noResultLabl.hidden = false
            }else{
                searchVc.hidden = false
                orderSegmentOutlet.hidden = false
                self.noResultVc.hidden = true
                self.noResultLabl.hidden = true
            }
            
           // let orderData = orderlistDict["orders"] as! NSMutableArray
            //
            let orderData =  NSMutableArray(array: orderlistDict["orders"]! as! [AnyObject])
                for orderass in orderData {
                   // if(orderass["isOpen"] as! Int == 1){
                        self.odersOpenArray.addObject(orderass)
                   // }
                    
                }
                self.orderTableView.reloadData()
                print(odersOpenArray.count)
            if(self.currentPageOpen == 1){
                let totalcount   = orderlistDict["totalNumberOfResults"] as! Int
                let pagecount   = orderlistDict["numberOfResults"] as! Int
                numberOfRecordOpen = pagecount
               // pageContForProdOpen = pageContForProdOpen + pagecount
                let roundof  = ceil(Double(totalcount)/Double(pagecount))
                //
                let introundof = Int(roundof)
                print(introundof, terminator: "")
                //  print(productList1.pageIndex!)
                self.totalPagesOpen  = introundof
            }else{
                let pagecount   = orderlistDict["numberOfResults"] as! Int
              //  numberOfRecordOpen = pagecount
                pageContForProdOpen = pageContForProdOpen + pagecount
            }
            
            for i in pageContForProdOpen..<odersOpenArray.count {
                appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                if (appdelegate.isReachable == true) {
                    //var headers : [String : String]!
                    let defaults = NSUserDefaults.standardUserDefaults()
                    let userId = defaults.objectForKey("userId") as? Int
                    var headers : [String : String]!
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
                    let ordeData:AnyObject = odersOpenArray.objectAtIndex(i)
                    
                    //http://immarketapi-stg2.azurewebsites.net/api/OrderSearch?userId=164&orderStatus=&orderNumber=&currentPage=1
                    //  let url = "\(baseUrl)OrderSearch?userId=\(userId!)&currentPage=\(currentPage)&orderNumber=\(orderNumber)&orderStatus=\(orderStatus)"
                    let url = "\(baseUrl)OrderSearch?orderNumber=\(ordeData["orderNumber"]! as! String)"
                    print(url)
                    Alamofire.request(.GET,  url, headers: headers)
                        .validate(contentType: ["application/json"])
                        .responseJSON { response in
                            print(response.request)  // original URL request
                            print(response.response?.statusCode) // URL response
                            print(response.data)     // server data
                            print(response.result)
                            if(response.result .isSuccess)
                            {
                                if let JSON = response.result.value
                                {
                                    print(JSON)
                                    let arrayofprod = JSON as! NSArray
                                    self.orderProductsDictOpen[String(i)] = arrayofprod
                                    // if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                    //self.delegates?.getOthersreviewDetailsSuccess!(JSON as! NSDictionary)
                                    //  NSNotificationCenter.defaultCenter().postNotificationName("myOrders", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
                                    //  }
                                }
                            }
                            if(response.result .isFailure)
                            {
                                LoadingOverlay.shared.hideOverlayView()
                                
                                
                            }
                            print("val  of i \(i)")
                            print("order dict \(self.orderProductsDictOpen)")
                            self.orderTableView.reloadData()
                    }
                    
                }
            }
        }else{
                self.noResultVc.hidden = false
                self.noResultLabl.hidden = false
            

        }
    }

    func getOrderList(notification: NSNotification)  {
        print(notification)
        orderTableView.hidden = false
        LoadingOverlay.shared.hideOverlayView()
        orderTableView.tableFooterView = nil
        let dict : AnyObject = notification.userInfo!
        print(dict["orders"])
        isLockUI = false
        if let orderlistDict  = dict["salesOrderSearch"] as? NSDictionary{
            if(orderlistDict.count <= 0){
                 searchVc.hidden = true
                orderSegmentOutlet.hidden = true
                self.noResultVc.hidden = false
                self.noResultLabl.hidden = false
            }else{
                 searchVc.hidden = false
                orderSegmentOutlet.hidden = false
                self.noResultVc.hidden = true
                self.noResultLabl.hidden = true
            }

        print(orderlistDict["totalNumberOfResults"])
        //let orderData = orderlistDict["orders"] as! NSMutableArray
           let orderData =  NSMutableArray(array: orderlistDict["orders"]! as! [AnyObject])
        // self.attributeDetailsArray = NSMutableArray(array: productHeader)
            for orderass in orderData {
                self.odersArray.addObject(orderass)
            }
            self.orderTableView.reloadData()
            print(odersArray.count)
            
            if(currentPage == 1){
                let totalcount   = orderlistDict["totalNumberOfResults"] as! Int
                let pagecount   = orderlistDict["numberOfResults"] as! Int
                let roundof  = ceil(Double(totalcount)/Double(pagecount))
                //
                let introundof = Int(roundof)
                print(introundof, terminator: "")
                //  print(productList1.pageIndex!)
                self.totalPages  = introundof
            }else{
                let pagecount   = orderlistDict["numberOfResults"] as! Int
                pageContForProd = pageContForProd + pagecount
            }
           
      //  }
        
            for i in pageContForProd..<odersArray.count {
                appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                if (appdelegate.isReachable == true) {
                    //var headers : [String : String]!
                    let defaults = NSUserDefaults.standardUserDefaults()
                    let userId = defaults.objectForKey("userId") as? Int
                    var headers : [String : String]!
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
                    let ordeData:AnyObject = odersArray.objectAtIndex(i)
                    
                     let url = "\(baseUrl)OrderSearch?orderNumber=\(ordeData["orderNumber"]! as! String)"
                    print(url)
                    Alamofire.request(.GET,  url, headers: headers)
                        .validate(contentType: ["application/json"])
                        .responseJSON { response in
                            print(response.request)  // original URL request
                            print(response.response?.statusCode) // URL response
                            print(response.data)     // server data
                            print(response.result)
                            if(response.result .isSuccess)
                            {
                                if let JSON = response.result.value
                                {
                                    print(JSON)
                                    let arrayofprod = JSON as! NSArray
                                    self.orderProductsDict[String(i)] = arrayofprod
                                   
                                }
                            }
                            if(response.result .isFailure)
                            {
                                LoadingOverlay.shared.hideOverlayView()
                                
                                
                            }
                            print("val  of i \(i)")
                            print("order dict \(self.orderProductsDict)")
                            self.orderTableView.reloadData()
                    }

            }
        }
            
        }
        else{
                self.orderSegmentOutlet.hidden = false
                self.searchVc.hidden = false
                self.noResultVc.hidden = false
                self.noResultLabl.hidden = false
           

        }
       
    }
    
      func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        if(isLockUI == false){
        
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            
             if(orderSegmentOutlet.selectedSegmentIndex == 0){
            if(currentPage < totalPages){
                currentPage++
                var DynamicView=UIView(frame: CGRectMake(0, 0, boundss.width, 60))
                DynamicView.backgroundColor=UIColor(red: 238.0/255.0, green: 239.0/255.0, blue: 242.0/255.0, alpha: 1)
                activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
                activity.color = UIColor.init(colorLiteralRed: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                activity.startAnimating()
                activity.hidesWhenStopped = true
                activity.tag = 42
                
                activity.center = CGPointMake(DynamicView.center.x,30)
                DynamicView.addSubview(activity)
                orderTableView.tableFooterView = DynamicView
                isLockUI = true
                callApi()
              
            }
             }else{
                if(currentPageOpen < totalPagesOpen){
                    currentPageOpen++
                    var DynamicView=UIView(frame: CGRectMake(0, 0, boundss.width, 60))
                    DynamicView.backgroundColor=UIColor(red: 238.0/255.0, green: 239.0/255.0, blue: 242.0/255.0, alpha: 1)
                    activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
                    activity.color = UIColor.init(colorLiteralRed: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                    activity.startAnimating()
                    activity.hidesWhenStopped = true
                    activity.tag = 42
                    
                    activity.center = CGPointMake(DynamicView.center.x,30)
                    DynamicView.addSubview(activity)
                    orderTableView.tableFooterView = DynamicView
                    isLockUI = true
                    callApi()
                    //  callGetProductAPI(url!, isCalled: callApi)
                }
            }
            print("reach end")
        }else{
             orderTableView.tableFooterView = nil
            
            
        }
        }
      //  changeTabBar(false, animated: true)
    }

    func handleTap(sender: UITapGestureRecognizer? = nil) {
        searchTF.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        serachLabel.backgroundColor = UIColor.blueColor()
        
        let keyboardDoneButtonView = UIToolbar.init()
        keyboardDoneButtonView.sizeToFit()
//        let doneButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done,
//                                              target: self,
//                                              action: #selector(doneClicked))
        let doneButton = UIBarButtonItem.init(title: "Search", style: UIBarButtonItemStyle.Done,
                                              target: self,
                                              action: #selector(doneClicked))
        let doneButton1 = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace,
                                               target: nil,
                                               action: nil)
        doneButton1.width = screenWidth-80
        
        keyboardDoneButtonView.items = [doneButton1,doneButton]
        textField.inputAccessoryView = keyboardDoneButtonView
        
        clearBtn.hidden = false
    }
    @IBAction func clearBtnAction(sender: AnyObject) {
        if(searchTF.text?.characters.count == 0){
            self.view.endEditing(true)
        }else{
        self.noResultVc.hidden = true
        self.noResultLabl.hidden = true
        textFieldShouldClear(searchTF)
        self.view.endEditing(true)
        odersArray = copyOfAllOrderArr.mutableCopy() as! NSMutableArray
        odersOpenArray = copyOfOpenArray.mutableCopy() as! NSMutableArray
        orderTableView.reloadData()
        for i in 0..<odersOpenArray.count {
            appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            if (appdelegate.isReachable == true) {
                //var headers : [String : String]!
                let defaults = NSUserDefaults.standardUserDefaults()
                let userId = defaults.objectForKey("userId") as? Int
                var headers : [String : String]!
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
                let ordeData:AnyObject = odersOpenArray.objectAtIndex(i)
                
                //http://immarketapi-stg2.azurewebsites.net/api/OrderSearch?userId=164&orderStatus=&orderNumber=&currentPage=1
                //  let url = "\(baseUrl)OrderSearch?userId=\(userId!)&currentPage=\(currentPage)&orderNumber=\(orderNumber)&orderStatus=\(orderStatus)"
                let url = "\(baseUrl)OrderSearch?orderNumber=\(ordeData["orderNumber"]! as! String)"
                print(url)
                Alamofire.request(.GET,  url, headers: headers)
                    .validate(contentType: ["application/json"])
                    .responseJSON { response in
                        print(response.request)  // original URL request
                        print(response.response?.statusCode) // URL response
                        print(response.data)     // server data
                        print(response.result)
                        if(response.result .isSuccess)
                        {
                            if let JSON = response.result.value
                            {
                                print(JSON)
                                let arrayofprod = JSON as! NSArray
                                self.orderProductsDictOpen[String(i)] = arrayofprod
                                // if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                //self.delegates?.getOthersreviewDetailsSuccess!(JSON as! NSDictionary)
                                //  NSNotificationCenter.defaultCenter().postNotificationName("myOrders", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
                                //  }
                            }
                        }
                        if(response.result .isFailure)
                        {
                            LoadingOverlay.shared.hideOverlayView()
                            
                            //  self.showAlertForRequestFail()
                        }
                        print("val  of i \(i)")
                        print("order dict \(self.orderProductsDictOpen)")
                        self.orderTableView.reloadData()
                }
                
            }
        }
        
        for i in 0..<odersArray.count {
            appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            if (appdelegate.isReachable == true) {
                //var headers : [String : String]!
                let defaults = NSUserDefaults.standardUserDefaults()
                let userId = defaults.objectForKey("userId") as? Int
                var headers : [String : String]!
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
                let ordeData:AnyObject = odersArray.objectAtIndex(i)
                
                //http://immarketapi-stg2.azurewebsites.net/api/OrderSearch?userId=164&orderStatus=&orderNumber=&currentPage=1
                //  let url = "\(baseUrl)OrderSearch?userId=\(userId!)&currentPage=\(currentPage)&orderNumber=\(orderNumber)&orderStatus=\(orderStatus)"
                let url = "\(baseUrl)OrderSearch?orderNumber=\(ordeData["orderNumber"]! as! String)"
                print(url)
                Alamofire.request(.GET,  url, headers: headers)
                    .validate(contentType: ["application/json"])
                    .responseJSON { response in
                        print(response.request)  // original URL request
                        print(response.response?.statusCode) // URL response
                        print(response.data)     // server data
                        print(response.result)
                        if(response.result .isSuccess)
                        {
                            if let JSON = response.result.value
                            {
                                print(JSON)
                                let arrayofprod = JSON as! NSArray
                                self.orderProductsDict[String(i)] = arrayofprod
                             
                            }
                        }
                        if(response.result .isFailure)
                        {
                            LoadingOverlay.shared.hideOverlayView()
                            
                            //  self.showAlertForRequestFail()
                        }
                        print("val  of i \(i)")
                        print("order dict \(self.orderProductsDict)")
                        self.orderTableView.reloadData()
                }
                
            }
        }
        self.orderTableView.reloadData()
        clearBtn.hidden = true
        }
    }
    func doneClicked(sender: AnyObject) {
        self.view.endEditing(true)
        if(searchTF.text?.characters.count > 0){
       orderTableView.hidden = true
        copyOfOpenArray.removeAllObjects()
        copyOfAllOrderArr.removeAllObjects()
        copyOfOpenArray = odersOpenArray.mutableCopy() as! NSMutableArray
        copyOfAllOrderArr = odersArray.mutableCopy() as! NSMutableArray
        odersOpenArray.removeAllObjects()
        odersArray.removeAllObjects()
        copyOforderProductsDict.removeAllObjects()
        copyOforderProductsDictOpen.removeAllObjects()
        copyOforderProductsDictOpen = orderProductsDictOpen.mutableCopy() as! NSMutableDictionary
        copyOforderProductsDict = orderProductsDict.mutableCopy() as! NSMutableDictionary
        orderProductsDict = NSMutableDictionary()
        orderProductsDictOpen = NSMutableDictionary()
        orderTableView.reloadData()
        var window :UIWindow = UIApplication.sharedApplication().keyWindow!
        LoadingOverlay.shared.showOverlay(window)
        let wsm : WebServiceClass = WebServiceClass.sharedInstance
        if(orderSegmentOutlet.selectedSegmentIndex == 0){
            wsm.getMyOrderListDetails(currentPage, orderNumber: searchTF.text!, orderStatus: "")
        }else{
            wsm.getMyOrderListDetailsForOpen(currentPageOpen, orderNumber: searchTF.text!, orderStatus: "Open")
        }
        }
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        serachLabel.backgroundColor = UIColor(red: 111.0/255.0, green: 113.0/255.0, blue: 121.0/255.0, alpha: 1)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func moveTextField(textField: UITextField, moveDistance: Int, up: Bool){
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        UIView.commitAnimations()
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        textField.text = ""
        //textField.resignFirstResponder()
        return false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "myOrders", object: nil)
         NSNotificationCenter.defaultCenter().removeObserver(self, name: "myOrdersOpen", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "myOrdersOpen", object: nil)
        //self.tabBarController?.tabBar.hidden =
        //myOrdersOpen
         self.title = ""
         NSNotificationCenter.defaultCenter().removeObserver(self, name: "reachable", object: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension OrderViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(orderSegmentOutlet.selectedSegmentIndex == 0){
        return odersArray.count
        }else{
            return odersOpenArray.count
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if(orderSegmentOutlet.selectedSegmentIndex == 0){
        if  let prd = self.orderProductsDict.valueForKey(String(section)){
            print("######### \(prd.count)")
        return (prd.count)!+1
        }else{
            return 1
        }
         }else{
            if  let prd = self.orderProductsDictOpen.valueForKey(String(section)){
                print("######### \(prd.count)")
                return (prd.count)!+1
            }else{
                return 1
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
             if(orderSegmentOutlet.selectedSegmentIndex == 0){
            let cell = orderTableView.dequeueReusableCellWithIdentifier("detailsIdentifier", forIndexPath: indexPath) as! DetailsOrderTableViewCell
            
            let ordeData:AnyObject = odersArray.objectAtIndex(indexPath.section)
            cell.orderNumberLabel.text = "Order #\(ordeData["orderNumber"]! as! String)"
            cell.orderAmountLabel.text = "₹ \(ordeData["netAmount"]! as! String)"
            cell.orderDateLabel.text = ordeData["strOrderDate"]! as! String
           // cell.orderStatusLabel.text = "Order #\(ordeData["orderNumber"]! as! String)"
            let customerData = ordeData["customer"]
            cell.shopNameLabel.text = "By \(customerData!!["name1"]! as! String)"
            //cell.actInd.hidden = false
           // cell.actInd.startAnimating()
            return cell
             }else{
                let cell = orderTableView.dequeueReusableCellWithIdentifier("detailsIdentifier", forIndexPath: indexPath) as! DetailsOrderTableViewCell
                
                let ordeData:AnyObject = odersOpenArray.objectAtIndex(indexPath.section)
                cell.orderNumberLabel.text = "Order #\(ordeData["orderNumber"]! as! String)"
                cell.orderAmountLabel.text = "₹ \(ordeData["netAmount"]! as! String)"
                cell.orderDateLabel.text = ordeData["strOrderDate"]! as! String
                // cell.orderStatusLabel.text = "Order #\(ordeData["orderNumber"]! as! String)"
                let customerData = ordeData["customer"]
                cell.shopNameLabel.text = "By \(customerData!!["name1"]! as! String)"
               // cell.actInd.hidden = false
               // cell.actInd.startAnimating()
                 return cell
            }
            
        }else{
            //if(indexPath.row != 0){
//            var indx = NSIndexPath.init(forRow: 0, inSection: indexPath.section)
//            let cell1 = orderTableView.dequeueReusableCellWithIdentifier("detailsIdentifier", forIndexPath: indx) as! DetailsOrderTableViewCell
       
           // cell1.actInd.stopAnimating()
            let cell = orderTableView.dequeueReusableCellWithIdentifier("orderIdentifier", forIndexPath: indexPath) as! OrderTableViewCell
            let prod : NSArray!
             if(orderSegmentOutlet.selectedSegmentIndex == 0){
                let ordeData:AnyObject = odersArray.objectAtIndex(indexPath.section)
                cell.orderId = ordeData["orderNumber"]! as! String
            prod = orderProductsDict.valueForKey(String(indexPath.section)) as! NSArray
             }else{
                let ordeData:AnyObject = odersOpenArray.objectAtIndex(indexPath.section)
                cell.orderId = ordeData["orderNumber"]! as! String
                prod = orderProductsDictOpen.valueForKey(String(indexPath.section)) as! NSArray
            }
            cell.delegates = self
           
            print("prod  \(prod)")
            let prodAtrow = prod.objectAtIndex(indexPath.row-1)
            if let freebe = prodAtrow["freeItemIndicator"] as? String {
                if(freebe == ""){
                    cell.freeBeLabl.hidden = true
                }else{
                    cell.freeBeLabl.hidden = false
                }
            }
            print("prod array \(prodAtrow)")
            print("prod array \(prodAtrow["imageURL"] as! String)")
            cell.customerLineNumber = prodAtrow["sku"] as! String
          //  let imgurl = prodAtrow["imageURL"] as! String
            let image : UIImage = UIImage(named:"placeholder")!
            cell.imgOrderCell.image = image
           cell.nameLabelOrderCell.text = prodAtrow["skuDescription"] as! String
            //cell.viewReturnsBtn.addTarget(self, action:#selector(ratebuttonClicked), forControlEvents: .TouchUpInside)
            if(prodAtrow["showReturnView"] as! Bool == false){
                cell.viewReturnsBtn.hidden = true
            }else{
                cell.viewReturnsBtn.hidden = false
            }
            let deliveryData = prodAtrow["delivery"] as! NSArray
            if(deliveryData.count > 0) {
                let delivryDict = deliveryData.objectAtIndex(0) as! NSDictionary
            if(delivryDict["showTracking"] as! Bool == false){
                cell.trackBtn.hidden = true
            }else{
                cell.trackBtn.hidden = true
            }
            }else{
                cell.trackBtn.hidden = true
            }
            let url =  prodAtrow["imageURL"] as! String
            let imgURL: NSURL = NSURL(string: url)!
            print("img url **** \(imgURL.absoluteString)")
            
            if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
            {
                print("IN cache")
                cell.imgOrderCell!.image = image
                
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
                            cell.imgOrderCell!.image = image
                            photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                        }
                        else
                        {
                            let image : UIImage = UIImage(named:"placeholder")!
                            cell.imgOrderCell!.image = image
                            //photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                        }
                }
            }
            

                       // }
            return cell
         
        }
    }
    func trackbuttonClicked(orderId:String){
//        let searchpredicate = NSPredicate(format: "orderNumber = %@", orderId)
//         if(orderSegmentOutlet.selectedSegmentIndex == 0){
//            var arry = odersArray
//            arry.filterUsingPredicate(searchpredicate)
//            if(arry.count > 0){
//                 let ordeData:AnyObject = arry.objectAtIndex(0)
//                
//                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("track") as! TrackViewController
//                nextViewController.statusStr = ordeData["lineStatus"] as! String//lineStatus
//                nextViewController.imgUrlstr = ordeData["imageURL"] as! String
//                nextViewController.priceStr = ordeData["imageURL"] as! String
//                nextViewController.prodDesc = ordeData["skuDescription"] as! String
//                nextViewController.qntStr = ordeData["imageURL"] as! String
//                
//                self.navigationController?.pushViewController(nextViewController, animated: true)
//            }
//         }else{
//            
//        }
        
       
    }
    func ratebuttonClicked(orderId:String,customerLineNumber:String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("viewReturnVC") as! ViewReturnViewController
        nextViewController.orderId = orderId
        nextViewController.customerLineNumber = customerLineNumber
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 173.0
        }else{
            return 90.0
        }
    }
       func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 238.0/255.0, green: 239.0/255.0, blue: 242.0/255.0, alpha: 1)
        
        
    }
//    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        
//        
//        
//    }
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            var ordernumber:String!=""
            //tableView.deselectRowAtIndexPath(indexPath, animated: true)
            if(orderSegmentOutlet.selectedSegmentIndex == 0){
                let ordeData:AnyObject = odersArray.objectAtIndex(indexPath.section)
                ordernumber = ordeData["orderNumber"]! as! String
            }else{
                let ordeData:AnyObject = odersOpenArray.objectAtIndex(indexPath.section)
                ordernumber = ordeData["orderNumber"]! as! String
            }
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("details") as! OrderDetailsViewController
            nextViewController.orderNumber = ordernumber
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    
}

extension UISegmentedControl{
    

        func removeBorders() {
            setBackgroundImage(imageWithColor(backgroundColor!), forState: .Normal, barMetrics: .Default)
            //setBackgroundImage(imageWithColor(tintColor!), forState: .Selected, barMetrics: .Default)
            setDividerImage(imageWithColor(UIColor.clearColor()), forLeftSegmentState: .Normal, rightSegmentState: .Normal, barMetrics: .Default)
        }
        
        // create a 1x1 image with this color
        private func imageWithColor(color: UIColor) -> UIImage {
            let rect = CGRectMake(0.0, 0.0, 0.1, 29.0)
            UIGraphicsBeginImageContext(rect.size)
            let context = UIGraphicsGetCurrentContext()
            CGContextSetFillColorWithColor(context, color.CGColor);
            CGContextFillRect(context, rect);
            let image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return image
        }
    
    
}
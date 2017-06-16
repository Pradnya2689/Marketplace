//
//  CheckoutViewController.swift
//  MarketPlace
//
//  Created by Administrator on 30/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import Alamofire

class CheckoutViewController: UIViewController,webServiceDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var topPayementView: UIView!
    @IBOutlet weak var topButtonsView: UIView!
    @IBOutlet weak var deliveryBtn: UIButton!
    var cartItemArray:NSArray!=NSArray()
    @IBOutlet weak var hereBtn: UIButton!
     var dataLayer: TAGDataLayer = TAGManager.instance().dataLayer
    @IBOutlet weak var deliveryAddressView: UIView!
    @IBOutlet weak var view1NameLabel: UILabel!
    @IBOutlet weak var view1AddressLabel: UILabel!
    var TotalPrice:NSString!
    var pincodestr:NSString!=""
    var isCOD:String!=""
    var addressId:String!=""
    var sellerNo: String!=""
    var quantity: String!=""
    var skuNo: String!=""
    var runsOrder: String! = "y"
    var isCalled: String!=""
    var promoCodeStr:String!=""
    var encryptedToken:String!=""
    var tranxID:String!=""
     var netAmount:String!
   @IBOutlet var freeBeVc:UIView!
   @IBOutlet var freeBeTable:UITableView!
    
    
    var alertText : UITextField!
    
    @IBAction func addChangeButton(sender: AnyObject) {
        
        
       
       // navigationItem.backBarButtonItem = backItem
        let EditAddressControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("editAddress") as? EditAddressViewController
         var b = UIBarButtonItem(title: "Cancel", style: .Plain, target: EditAddressControllerObj, action:#selector(EditAddressViewController.cancelClicked))
        EditAddressControllerObj?.navigationItem.rightBarButtonItem = b
        EditAddressControllerObj?.NoAddrFlag = "ChangeAdressCheckout"
        let NavigationController = UINavigationController(rootViewController: EditAddressControllerObj!)
//        NavigationController.navigationItem.rightBarButtonItem = b
        self.presentViewController(NavigationController, animated: true, completion: nil)
        
        
    }
    
    
    @IBOutlet weak var promoTxtLbl: UILabel!
    
    @IBOutlet weak var topPaymentAddBtn: UIButton!
    @IBOutlet weak var topPaymentBtn: UIButton!
    @IBAction func paymentAddAction(sender: AnyObject) {
        deliveryAddressView.hidden = false
        paymentView.hidden = true
        topButtonsView.hidden = false
        topPayementView.hidden = true
        orderBtnOutlet.hidden = true
        proceedPayBtnOutlet.hidden = false
    }
    
    let rowImage = ["chk_payment","chk_cod"]
    let labelText = ["ONLINE PAYMENT","CASH ON DELIVERY"]
    
    @IBOutlet weak var paymentTable: UITableView!
    @IBOutlet weak var paymentView: UIView!
    
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var totalMoneyLabel: UILabel?
     var lstBasketArray:NSMutableArray!=NSMutableArray()
    @IBOutlet weak var viewFReebiebtn:UIButton!
    @IBOutlet weak var promoBTn:UIButton!
    
    
    @IBAction func viewFreeBieClk(){
            let LoginViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("freebieVC") as? FreebieViewController
            LoginViewControllerObj?.lstBasketArray = self.lstBasketArray
           let NavigationController = UINavigationController(rootViewController: LoginViewControllerObj!)
           self.presentViewController(NavigationController, animated: true, completion: nil)
        
    }
    
    
//    func textFieldDidBeginEditing(textField: UITextField) {
//        <#code#>
//    }
    
    
    
    
    @IBAction func promoCodeBtn(sender: AnyObject) {
       self.lstBasketArray.removeAllObjects()
        var textfld:String!
        var alert = UIAlertController(title: "Apply Promo Code", message: "Enter Promo Code", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        
        alert.addTextFieldWithConfigurationHandler{
            
            (textField) -> Void in
           // self.alertText = alert.textFields![0]
            //textfld = textField.text
            alert.textFields![0].autocapitalizationType = UITextAutocapitalizationType.AllCharacters
        }
    
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: {
            (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Apply", style: .Default, handler: {
            (action) -> Void in
            let code = alert.textFields![0].text
          //  self.alertText = alert.textFields![0]
            let encodedCode = code?.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
            print(encodedCode)
            self.promoCodeStr = encodedCode
            //print(code)
//            if(self.promoCodeStr?.characters.count == 0){
//                alert.view.tintColor = UIColor.redColor()
//                var messageTitle = "Please Enter Promo Code"
//                alert = UIAlertController(title: "Apply Promo Code", message: "Please Enter Promo Code", preferredStyle: UIAlertControllerStyle.Alert)
//                alert.setValue(NSAttributedString(string: messageTitle, attributes: [NSForegroundColorAttributeName : UIColor.redColor()]), forKey: "attributedTitle")
//            }
            let arr = self.TotalPrice!.componentsSeparatedByString(" ")
            let trimmedProductprice = arr[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                    
                {
                    let authorization = authorizationWithLogin
                    
                   // print(authorization)
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
            }
            LoadingOverlay.shared.showOverlay(self.view)
            var url: NSURL!
            
            /* Add To Cart */
            
            if (self.skuNo == ""){
                LoadingOverlay.shared.hideOverlayView()
//                url = NSURL(string: "http://immarketapi-stg2.azurewebsites.net/api/ordercreate?promoCode=\(code!)&NetAmount=\(trimmedProductprice)&AddressId=\(self.addressId)&runSalesOrderforBuyNow=&SellerNumber=\(self.sellerNo)&Quantity=0&sku=")
                
//                var arry = self.netAmount.componentsSeparatedByString(".");
//                if(arry[0].characters.count != 0) {
//                    self.netAmount = arry[0]
//                }else{
//                
//                }
                
                url = NSURL(string: "\(baseUrl)ordercreate?promoCode=\(encodedCode!)&NetAmount=\(self.netAmount)&AddressId=\(self.addressId)&runSalesOrderforBuyNow=&SellerNumber=\(self.sellerNo)&Quantity=0&Sku=")
                
                
                            let parameters = [
                            "promoCode": encodedCode!,
                            "NetAmount": trimmedProductprice,
                            "AddressId": self.addressId,
//                            "runSalesOrderforBuyNow":"y",
//                            "SellerNumber":self.sellerNo,
//                            "Quantity":self.quantity,
//                             "Sku":self.skuNo
                
                            ]
                LoadingOverlay.shared.showOverlay(self.view)
                            //print(url)
                
                Alamofire.request(.GET, url, headers: headers)
                    
                    .validate(contentType: ["application/json"])
                    
                    .responseJSON { response in
                        self.dismissViewControllerAnimated(true, completion: nil)
//                        print(response.request)
//                        print(response.response)
//                        print(response.data)
//                        print(response.result.value)
                        
                        if let JSON = response.result.value{
                            //print(JSON)
                            LoadingOverlay.shared.hideOverlayView()
                            if(response.result.isSuccess){
                                
                                
                                if let totl = JSON["totalShippingAmount"] as? String{
                           // print(totl)
                           
                            let promotional = JSON["promotional"] as! Int
                            if(promotional == 0  ){
                                if  let lstBasketCnt = JSON["lstBasket"] as? NSArray {
                                    for prod in lstBasketCnt{
                                        if(prod["freeItemIndicator"] as! String == "X"){
                                            self.lstBasketArray.addObject(prod)
                                        }
                                    }
                                    
                                if(lstBasketCnt.count > self.cartItemArray.count ){
                                    if(self.lstBasketArray.count <= 0 ){
                                        let alertView:UIAlertView = UIAlertView()
                                        alertView.title = ""
                                        alertView.message = ConstantsFile.invalidPromo_msg
                                        alertView.delegate = nil
                                        alertView.addButtonWithTitle("OK")
                                        alertView.show()
                                    }else{
                                    
                                    self.promoTxtLbl.text = "You have got \(self.lstBasketArray.count) freebie"
                                    self.promoBTn.hidden = true
                                    self.viewFReebiebtn.hidden = false

                                    }
                                    
                                }else{
                                    let alertView:UIAlertView = UIAlertView()
                                    alertView.title = ""
                                    alertView.message = ConstantsFile.invalidPromo_msg
                                    alertView.delegate = nil
                                    alertView.addButtonWithTitle("OK")
                                    alertView.show()
                                    }
                                }
                                else{
                                let alertView:UIAlertView = UIAlertView()
                                alertView.title = ""
                                alertView.message = ConstantsFile.invalidPromo_msg
                                alertView.delegate = nil
                                alertView.addButtonWithTitle("OK")
                                alertView.show()
                                }
                                
                                
                            }else{
                                let promoCode = JSON["promoCode"] as? String
                                if(promotional != 0 && promoCode == "GET500"){
                                    var textLB = JSON["promotionalDisplayString"] as? String
                                    var newText = textLB!.stringByTrimmingCharactersInSet(NSCharacterSet.init(charactersInString: "-"))
                                    var newPrice = "  - ₹ \((newText))"
                                    self.promoBTn.setTitle(newPrice, forState: .Normal)
                                   self.promoBTn.titleLabel?.textAlignment = .Right
                                    self.promoBTn.setTitleColor(UIColor(red: 227.0/255.0, green: 0.0/255.0, blue: 2.0/255.0, alpha: 1.0), forState: .Normal)
                                    
                                    
                                }else{
                                    
                                }
                                 self.totalMoneyLabel?.text = "₹ \(String(totl))"
                                    }
                                }else{
                                    let alertView:UIAlertView = UIAlertView()
                                    alertView.title = ""
                                    alertView.message = ConstantsFile.invalidPromo_msg
                                    alertView.delegate = nil
                                    alertView.addButtonWithTitle("OK")
                                    alertView.show()
                                }
                            }else{
                                let alertView:UIAlertView = UIAlertView()
                                alertView.title = ""
                                alertView.message = ConstantsFile.requestFail_msg
                                alertView.delegate = nil
                                alertView.addButtonWithTitle("OK")
                                alertView.show()
                            }
                        }
                }
            }
            
            /* Buy Now */
                
            else{
                 LoadingOverlay.shared.hideOverlayView()
                url = NSURL(string: "\(baseUrl)ordercreate?promoCode=\(encodedCode!)&NetAmount=\(self.netAmount!)&AddressId=\(self.addressId)&runSalesOrderforBuyNow=\(self.runsOrder)&SellerNumber=\(self.sellerNo)&Quantity=\(self.quantity!)&Sku=\(self.skuNo)")
                
                            let parameters = [
                            "promoCode": encodedCode!,
                            "NetAmount": trimmedProductprice,
                            "AddressId": self.addressId,
                            "runSalesOrderforBuyNow":"y",
                            "SellerNumber":self.sellerNo,
                            "Quantity":self.quantity,
                             "Sku":self.skuNo
                
                            ]
                LoadingOverlay.shared.showOverlay(self.view)
                          //  print(parameters)
                
                Alamofire.request(.GET, url, headers: headers)
                    
                    .validate(contentType: ["application/json"])
                    
                    .responseJSON { response in
                         self.dismissViewControllerAnimated(true, completion: nil)
//                        print(response.request)
//                        print(response.response)
//                        print(response.data)
//                        print(response.result.value)
                        
                        if let JSON = response.result.value{
                            //print(JSON)
                            LoadingOverlay.shared.hideOverlayView()
                              if(response.result.isSuccess){
                                
                                if let totl = JSON["totalShippingAmount"] as? String{
                                    //print(totl)
                                    
                                    let promotional = JSON["promotional"] as! Int
                                    if(promotional == 0  ){
                                        if  let lstBasketCnt = JSON["lstBasket"] as? NSArray {
                                            for prod in lstBasketCnt{
                                                if(prod["freeItemIndicator"] as! String == "X"){
                                                    self.lstBasketArray.addObject(prod)
                                                }
                                            }
                                          
                                            if(lstBasketCnt.count > 1 ){
                                                
                                                self.promoTxtLbl.text = "You have got \(self.lstBasketArray.count) freebie"
                                                self.promoBTn.hidden = true
                                                self.viewFReebiebtn.hidden = false
                                            }else{
                                                let alertView:UIAlertView = UIAlertView()
                                                alertView.title = ""
                                                alertView.message = ConstantsFile.invalidPromo_msg
                                                alertView.delegate = nil
                                                alertView.addButtonWithTitle("OK")
                                                alertView.show()
                                            }
                                        }
                                        else{
                                            let alertView:UIAlertView = UIAlertView()
                                            alertView.title = ""
                                            alertView.message = ConstantsFile.invalidPromo_msg
                                            alertView.delegate = nil
                                            alertView.addButtonWithTitle("OK")
                                            alertView.show()
                                        }
                                        
                                        
                                    }else{
                                        let promoCode = JSON["promoCode"] as? String
                                        if(promotional != 0 && promoCode == "GET500"){
                                            var textLB = JSON["promotionalDisplayString"] as? String
                                            var newText = textLB!.stringByTrimmingCharactersInSet(NSCharacterSet.init(charactersInString: "-"))
                                            var newPrice = "  - ₹ \((newText))"
                                            self.promoBTn.setTitle(newPrice, forState: .Normal)
                                            self.promoBTn.titleLabel?.textAlignment = .Right
                                            self.promoBTn.setTitleColor(UIColor(red: 227.0/255.0, green: 0.0/255.0, blue: 2.0/255.0, alpha: 1.0), forState: .Normal)
                                        }else{
                                           
                                        }
                                        self.totalMoneyLabel?.text = "₹ \(String(totl))"
                                    }
                                }else{
                                    let alertView:UIAlertView = UIAlertView()
                                    alertView.title = ""
                                    alertView.message = ConstantsFile.invalidPromo_msg
                                    alertView.delegate = nil
                                    alertView.addButtonWithTitle("OK")
                                    alertView.show()
                                }
                              }else{
                                let alertView:UIAlertView = UIAlertView()
                                alertView.title = ""
                                alertView.message = ConstantsFile.requestFail_msg
                                alertView.delegate = nil
                                alertView.addButtonWithTitle("OK")
                                alertView.show()
                            }
                        }
                }

            }
            

        }))
        
        
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true}
        let newlength = (text.characters.count) + string.characters.count - range.length
        return newlength <= 8
    }
    
    
    
    
    func cancelClicked()
    {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBAction func proceedPaymentBtn(sender: AnyObject) {
       // let index = paymentTable.indexPathForSelectedRow
        if(self.view1NameLabel.text?.characters.count == 0){
            let alertView:UIAlertView = UIAlertView()
            alertView.title = ""
            alertView.message = "Please add address."
            alertView.delegate = nil
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }else{
        
        
        let index = NSIndexPath.init(forRow: 0, inSection: 1)
        if(index.section == 0){
            let alertView:UIAlertView = UIAlertView()
            alertView.title = ""
            alertView.message = ConstantsFile.onlinePayment_msg
            alertView.delegate = nil
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else{
           
            dataLayer.push(["event": "openScreen", "screenName": "proceedToCheckoutScreeniOS"])
        let cell = paymentTable.cellForRowAtIndexPath(index) as! PaymentTableViewCell
        if(isCOD == "0"){
            cell.codLable.hidden = false
            var labelstring : NSString = "CASH ON DELIVERY"
            var attributedText: NSMutableAttributedString = NSMutableAttributedString(string: "CASH ON DELIVERY")
            var range = (labelstring as NSString).rangeOfString("CASH ON DELIVERY")
            attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
            //attributedText.addAttributes([NSFontAttributeName:UIFont(name: "MyriadPro-Regular", size: 11)!], range: range2)
            attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.0, range: range)
            attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor() , range: range)
            
            cell.paymentTBLabel.attributedText = attributedText
            
        }else{
          
            var labelstring : NSString = labelText[1]
            var attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelText[1])
            var range = (labelstring as NSString).rangeOfString(labelText[1])
            attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
            attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor() , range: range)
            cell.paymentTBLabel.attributedText = attributedText
            cell.codLable.hidden = true
        }
        
        paymentView.hidden = false
        deliveryAddressView.hidden = true
        topButtonsView.hidden = true
        topPayementView.hidden = false
        topPaymentAddBtn.userInteractionEnabled = true
        orderBtnOutlet.hidden = false
        proceedPayBtnOutlet.hidden = true
        }
        }
    }
    
    
    @IBOutlet weak var proceedPayBtnOutlet: UIButton!
    @IBOutlet weak var orderBtnOutlet: UIButton!
    
    
    @IBOutlet weak var confirmOrderTopView: UIView!
    @IBOutlet weak var placeOrderView: UIView!
    
    @IBOutlet weak var orderFailureView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName : headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
        deliveryAddressView.hidden = true
        
        // Do any additional setup after loading the view.
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId") as? Int{
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
          //  JHProgressHUD.sharedHUD.showInView(self.view)
            LoadingOverlay.shared.showOverlay(window)
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates = nil
            wsm.delegates=self
            wsm.callAdressApi(usernm)
        }
        
        deliveryBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        topPaymentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        deliveryAddressView.hidden = false
        paymentView.hidden = true
        topPayementView.hidden = true
        topButtonsView.hidden = false
        orderBtnOutlet.hidden = true
        confirmOrderTopView.hidden = true
        placeOrderView.hidden = true
        paymentTable.estimatedRowHeight = 60.0
        
        
        // let defaults = NSUserDefaults.standardUserDefaults()
        
        self.totalMoneyLabel?.text = TotalPrice as String
         dataLayer.push(["event": "openScreen", "screenName": "checkoutPageiOS"])
    }
    override func  viewWillAppear(animated: Bool)
    {
        self.title = "IMOL"
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(CheckoutViewController.backclk),
                                                         name: "back",
                                                         object: nil)
    self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        self.tabBarController?.tabBar.hidden = false
       // self.tabBarController?.tabBar.hidden = false
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "SelectedAddress", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CheckoutViewController.selectedAdressDict(_:)), name: "SelectedAddress", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CheckoutViewController.orderSuccess(_:)), name: "orderSuccess", object: nil)
        hereBtn.titleLabel?.textAlignment = NSTextAlignment.Left
        
        
    }
    func backclk(){
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    override func viewWillDisappear(animated: Bool) {
         self.title = ""
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "back", object: nil)
    }
    func  orderSuccess(notification: NSNotification) {
        let dict : AnyObject = notification.userInfo!
        if let ordid = dict["isOrderPlaced"] as? Int {
            if(ordid == 1){
                
                LoadingOverlay.shared.hideOverlayView()
                dataLayer.push(["event": "openScreen", "screenName": "paymentConfirmediOS"])
                let tabArray = self.tabBarController?.tabBar.items as NSArray!
                let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
                tabItem.badgeValue = nil
                self.tabBarController?.tabBarItem.badgeValue = nil
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.removeObjectForKey("badge")
                confirmOrderTopView.hidden = false
                totalView.hidden = true
                deliveryAddressView.hidden = true
                paymentView.hidden = true
                placeOrderView.hidden = false
                
              
            }else{
                orderFailureView.hidden = false
            }
        }
        
    }
    
    func selectedAdressDict(notification: NSNotification)
    {
        let dict : AnyObject = notification.userInfo!
        let receivednumber : NSDictionary = dict["valueToPass"] as! NSDictionary
        //print(receivednumber)
               if let a = TotalPrice{
                    let arr = TotalPrice!.componentsSeparatedByString(" ")
                    let trimmedProductprice = arr[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                    let wsm : WebServiceClass = WebServiceClass.sharedInstance
                    wsm.delegates=self
                    self.pincodestr = receivednumber["zipCode"] as! String
                    //print("pincode \(pincodestr)   productprice \(trimmedProductprice)")
                    wsm.isCODAPIcall(pincodestr as String, trimmedProductprice: trimmedProductprice)
                }else{
                    self.pincodestr = receivednumber["zipCode"] as! String
                }
        self.view1NameLabel.text = receivednumber["name"] as! String
                self.addressId = receivednumber["addressId"] as! String
                self.view1AddressLabel.text = "\(receivednumber["address1"] as! String), \(receivednumber["area"] as! String), \(receivednumber["city"] as! String), \(receivednumber["stateName"] as! String), \(receivednumber["zipCode"] as! String)"

    }
    @IBAction func continueShopping(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func hereButton(sender: AnyObject) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("myorders") as! OrderViewController
        //nextViewController.orderNumber = ordernumber
        nextViewController.isCalledFrom = "buy"
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
//        let wishList = self.storyboard?.instantiateViewControllerWithIdentifier("myorders") as? OrderViewController
//        wishList?.isCalledFrom = "account"
//        self.navigationController?.pushViewController(wishList!, animated: true)

    }
    func placeOrderFailure(){
        orderFailureView.hidden = false
    }
    
    @IBAction func continueShoppingFailViewBtn(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func mailFunction(sender: AnyObject) {
        let email = "support@imol.tech"
        let url = NSURL(string: "mailto:\(email)")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    
    @IBAction func callFunction(sender: AnyObject) {
        let phone = "+912230561149"
        
        if let url = NSURL(string: "tel://\(phone)") {
            UIApplication.sharedApplication().openURL(url)
    }
    }
    
    @IBAction func orderBtn(sender: AnyObject) {
        
        let index = self.paymentTable.indexPathForSelectedRow
        if(index?.section == 0){
//            let alert = UIAlertController(title: "", message: "Online payment is not available", preferredStyle: UIAlertControllerStyle.Alert)
//            
//            
//            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {
//                (action) -> Void in
//                self.dismissViewControllerAnimated(true, completion: nil)
//            }))
            
           // self.presentViewController(alert, animated: true, completion: nil)
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
            // JHProgressHUD.sharedHUD.showInView(self.view)
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
           // print(totalMoneyLabel?.text)
          

            wsm.placeOrderDetails(addressId, isCOD: "false",promoCode: self.promoCodeStr,promotionalShippableValue: (totalMoneyLabel?.text)!)
          
            
        }else if(index?.section == 1){
            if(isCOD == "1"){
                
                let wsm : WebServiceClass = WebServiceClass.sharedInstance
                wsm.delegates=self
                //JHProgressHUD.sharedHUD.showInView(self.view)
                var window :UIWindow = UIApplication.sharedApplication().keyWindow!
                LoadingOverlay.shared.showOverlay(window)
                if(isCOD == "1"){
                    wsm.placeOrderDetails(addressId, isCOD: "true",promoCode: self.promoCodeStr,promotionalShippableValue: (totalMoneyLabel?.text)!)
                }else{
                    wsm.placeOrderDetails(addressId, isCOD: "false",promoCode: self.promoCodeStr,promotionalShippableValue: (totalMoneyLabel?.text)!)
                }
                
                
            }else{
               
                let wsm : WebServiceClass = WebServiceClass.sharedInstance
                wsm.delegates=self
               // JHProgressHUD.sharedHUD.showInView(self.view)
                var window :UIWindow = UIApplication.sharedApplication().keyWindow!
                LoadingOverlay.shared.showOverlay(window)
                if(isCOD == "1"){
                    wsm.placeOrderDetails(addressId, isCOD: "true",promoCode: self.promoCodeStr,promotionalShippableValue: (totalMoneyLabel?.text)!)
                }else{
                    wsm.placeOrderDetails(addressId, isCOD: "false",promoCode: self.promoCodeStr,promotionalShippableValue: (totalMoneyLabel?.text)!)
                }
            }
            
            
        }else{
            let alert = UIAlertController(title: "", message: ConstantsFile.paymentMode_msg, preferredStyle: UIAlertControllerStyle.Alert)
            
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {
                (action) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    func placeOrderSuccess(orderResp:NSDictionary){
        
        if let orderId = orderResp["orderNumber"] as? String {
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
            wsm.confirmOrdersDetails(orderResp["orderNumber"]! as! String)
            //print("orderresp \(orderResp["orderNumber"])")
        }
        else{
            LoadingOverlay.shared.hideOverlayView()
            let merchantID  = orderResp["merchantIdentifier"] as? String
            let transactionReference = orderResp["transactionReference"]! as! String
             let transactionIdentifier = orderResp["transactionIdentifier"]! as! String
            let consumerEmailID = orderResp["consumerEmailID"]! as! String
            let consumerIdentifier = orderResp["consumerIdentifier"]! as! String
            let consumerMobileNumber = orderResp["consumerMobileNumber"]! as! String
            let orderHeaderTransactionId = orderResp["orderHeaderTransactionId"]! as! String
            var amnt = Float(cartItemArray.count)
            
            if(cartItemArray.count >= 2){
                amnt = 2.00
            }else if(cartItemArray.count == 1){
                amnt = 1.00
            }else{
                if(isCalled == "buy"){
                    amnt = 1.00
                }else{
                    amnt = 0.00
                }
                
            }
            
            let total = totalMoneyLabel?.text!.stringByReplacingOccurrencesOfString("₹", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            let pricetotal1 = total!.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            let pricetotal = pricetotal1.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            //print(pricetotal)
            let chkboj = Checkout.init();
            chkboj.setMerchantIdentifier("L98044")
            //chkboj.setMerchantIdentifier("T98044")
            chkboj.setPaymentTransactionIdentifier(transactionIdentifier)
            //chkboj.setPaymentTransactionIdentifier("TXN001234")
            //chkboj.setPaymentTransactionAmount(String(amnt))
            chkboj.setPaymentTransactionAmount("\(pricetotal)")
            chkboj.setPaymentTransactionDateTime("10-11-2016")
            chkboj.setPaymentTransactionCurrency("INR")
            chkboj.setPaymentTransactionReference(transactionReference)
           // chkboj.setPaymentTransactionReference("ORD0001")
            chkboj.setPaymentTransactionmerchantInitiated("N")
            chkboj.setPaymentTransactionType("Sale")
            chkboj.setPaymentTransactionSubType("Debit")
            chkboj.setConsumerAccountNumber("")
            chkboj.setConsumerIdentifier(consumerIdentifier)
            //chkboj.setConsumerIdentifier("12345")
            chkboj.setConsumerEmailID(consumerEmailID)
            chkboj.setConsumerMobileNumber(consumerMobileNumber)
            
//            let chkboj = Checkout.init();
//            chkboj.setMerchantIdentifier("T98044")
//            chkboj.setPaymentTransactionIdentifier("TXN001234")
//            chkboj.setPaymentTransactionAmount("2.00")
//            chkboj.setPaymentTransactionDateTime("10-11-2016")
//            chkboj.setPaymentTransactionCurrency("INR")
//            chkboj.setPaymentTransactionReference("ORD0001")
//            chkboj.setPaymentTransactionmerchantInitiated("N")
//            chkboj.setPaymentTransactionType("Sale")
//            chkboj.setPaymentTransactionSubType("Debit")
//            
//            chkboj.setConsumerAccountNumber("")
//            chkboj.setConsumerIdentifier("12345")
//            chkboj.setConsumerEmailID("rishikesh.pange@ingrammicro.com")
//            chkboj.setConsumerMobileNumber("9867274983")
            
             if (self.skuNo == ""){
                for (index, cartItem) in cartItemArray.enumerate(){
                    //print(cartItem)
                   // print(index)
                    if(index == 0 || index == 1){
                        let desc = cartItem["description"] as! String
                        let sku = cartItem["vpn"] as! String
                       chkboj.setCartDescription(orderHeaderTransactionId)
                        chkboj.addCartItem("Ingr", amount: String(pricetotal), surchargeOrDiscount: "0.00", SKU: sku, description: desc, providerID: "snapdeal.com", reference: "Test", commisionAmt: "0.00")
//                        chkboj.addCartItem("Ingr", amount: "2.00", surchargeOrDiscount: "0.00", SKU: "", description: "Samsung Galaxy Duos New", providerID: "snapdeal.com", reference: "Test", commisionAmt: "0.00")
                        
                    }else{
                        let desc = cartItem["description"] as! String
                        let sku = cartItem["vpn"] as! String
                        chkboj.setCartDescription(orderHeaderTransactionId)
                      chkboj.addCartItem("Ingr", amount: String(pricetotal), surchargeOrDiscount: "0.00", SKU: sku, description: desc, providerID: "snapdeal.com", reference: "Test", commisionAmt: "0.00")
//                        chkboj.addCartItem("Ingr", amount: "2.00", surchargeOrDiscount: "0.00", SKU: "", description: "Samsung Galaxy Duos New", providerID: "snapdeal.com", reference: "Test", commisionAmt: "0.00")
                    }
               }
           }
          else{
                
                let ordrhdr = "\(self.skuNo):\(self.sellerNo):\(String(pricetotal)):\(orderHeaderTransactionId)"
                chkboj.setCartDescription(ordrhdr)
            chkboj.addCartItem("Ingr", amount: String(pricetotal), surchargeOrDiscount: "0.00", SKU: self.skuNo, description: "Samsung Galaxy Duos New", providerID: "snapdeal.com", reference: "Test", commisionAmt: "0.00")
            }
           // print(chkboj)
            let paymentVc:PMPaymentOptionView = PMPaymentOptionView.init(publicKey: "3819872362YHYMJP", checkout: chkboj, paymentType: "Default", success: { (anyobject) -> Void in
               // print(anyobject)
                
                if let msg = anyobject["message"] as? String{
                    self.encryptedToken = msg
                    
                }
                if let msg = anyobject["param"] as? String{
                    self.tranxID = msg
                    
                }
                if(self.encryptedToken != "" && self.tranxID != ""){
                    
                    var escapepercent = self.encryptedToken.stringByAddingPercentEscapesUsingEncoding(NSASCIIStringEncoding)!
                    escapepercent = escapepercent.stringByReplacingOccurrencesOfString("+", withString: "%2B")
                    escapepercent = escapepercent.stringByReplacingOccurrencesOfString("/", withString: "%2F")
                     escapepercent = escapepercent.stringByReplacingOccurrencesOfString("\\", withString: "%5C")
                    
                    let window :UIWindow = UIApplication.sharedApplication().keyWindow!
                    LoadingOverlay.shared.showOverlay(window)
                    let wsm : WebServiceClass = WebServiceClass.sharedInstance
                    wsm.delegates=self
                    wsm.sendPaymentUpdateToserver(escapepercent, trnxID: self.tranxID)
                }
                
                }, failure: { (failureObj) -> Void in
                   // print("failureObj \(failureObj)")
                     LoadingOverlay.shared.hideOverlayView()
                }, cancel: { (cancelobj) -> Void in
                    LoadingOverlay.shared.hideOverlayView()
                   // print("cancelled")
            })
            
            self.navigationController?.presentViewController(paymentVc, animated: true, completion: nil)
        }
        
        
    }
    func getorderConfirmedSuccess(orderResp:NSDictionary){
        //print(orderResp)
        //isOrderPlaced
         LoadingOverlay.shared.hideOverlayView()
        confirmOrderTopView.hidden = false
        totalView.hidden = true
        deliveryAddressView.hidden = true
        paymentView.hidden = true
        placeOrderView.hidden = false
        
        orderFailureView.hidden = true
        dataLayer.push(["event": "openScreen", "screenName": "paymentConfirmediOS"])
        let tabArray = self.tabBarController?.tabBar.items as NSArray!
        let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
        tabItem.badgeValue = nil
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("badge")
//        let dict : AnyObject = orderResp
//        if let ordid = dict["isOrderPlaced"] as? Int {
//            if(ordid == 1){
//                confirmOrderTopView.hidden = false
//                totalView.hidden = true
//                deliveryAddressView.hidden = true
//                paymentView.hidden = true
//                placeOrderView.hidden = false
//                
//                orderFailureView.hidden = true
//                dataLayer.push(["event": "openScreen", "screenName": "paymentConfirmediOS"])
//                let tabArray = self.tabBarController?.tabBar.items as NSArray!
//                let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
//                tabItem.badgeValue = nil
//                let defaults = NSUserDefaults.standardUserDefaults()
//                defaults.removeObjectForKey("badge")
//            }else{
//                confirmOrderTopView.hidden = false
//                totalView.hidden = true
//                deliveryAddressView.hidden = true
//                paymentView.hidden = true
//                placeOrderView.hidden = true
//                
//                orderFailureView.hidden = false
//            }
//        
//        }
        
       
        
    }
    func callAddressapiresponse(string:NSArray)
    {
        LoadingOverlay.shared.hideOverlayView()
        if string.count == 0
        {
           
        }
        else
        {
            // self.changeAddressBtn.setTitle("CHANGE ADDRESS", forState: UIControlState.Normal)
            for address in string
            {
                deliveryAddressView.hidden = false
                //print("address  \(address)")
                if let dfaultadd : Bool = address["isDefault"] as? Bool
                {
                    //print(dfaultadd)
                    if(dfaultadd)
                    {
                        if let a = TotalPrice{
                            let arr = TotalPrice!.componentsSeparatedByString(" ")
                            let trimmedProductprice = arr[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                            let wsm : WebServiceClass = WebServiceClass.sharedInstance
                            wsm.delegates=self
                            self.pincodestr = address["zipCode"] as! String
                            //print("pincode \(pincodestr)   productprice \(trimmedProductprice)")
                            wsm.isCODAPIcall(pincodestr as String, trimmedProductprice: trimmedProductprice)
                        }else{
                            self.pincodestr = address["zipCode"] as! String
                        }

                        self.view1NameLabel.text = address["name"] as! String
                    
                        self.addressId = address["addressId"] as! String
                        self.view1AddressLabel.text = "\(address["address1"] as! String), \(address["area"] as! String), \(address["city"] as! String), \(address["stateName"] as! String), \(address["zipCode"] as! String)"
                    }
                }
                
            }
        }//print(string["state"]!.objectAtIndex(0).valueForKey("stateName")!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func isCODSuccess(codResp:NSDictionary){
       
        
       // print(codResp)
        if let COD : AnyObject  = codResp["isCOD"]
        {
            
            let codstr = "\(COD)"
            isCOD = codstr
           // print("COD:\(codstr)")
            let index = NSIndexPath.init(forRow: 0, inSection: 1)
            let cell = paymentTable.cellForRowAtIndexPath(index) as! PaymentTableViewCell
            if(isCOD == "0"){
               // var attrString =  NSAttributedString(string: "CASH ON DELIVERY", attributes: NSUnderlineStyle);
               // var attrString =  NSMutableAttributedString(string: "CASH ON DELIVERY");
               // attrString.AddAttribute(UIStringAttributeKey.StrikethroughStyle, NSNumber.FromInt32((int)NSUnderlineStyle.Single), NSRange(0, attrString.Length));
                //cell.userInteractionEnabled = false
                //cell.contentView.backgroundColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 0.5)
                cell.codLable.text = "Available on orders between ₹\(codResp["codMinLimit"]!) and ₹ \(codResp["codMaxLimit"]!)"
                //cell.paymentTBLabel.attributedText = attrString
                  var labelstring : NSString = "CASH ON DELIVERY"
                var attributedText: NSMutableAttributedString = NSMutableAttributedString(string: "CASH ON DELIVERY")
                 var range = (labelstring as NSString).rangeOfString("CASH ON DELIVERY")
                attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
              
                attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1.0, range: range)
                attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor() , range: range)
                
                cell.paymentTBLabel.attributedText = attributedText
            }else{
                var labelstring : NSString = labelText[1]
                var attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelText[1])
                var range = (labelstring as NSString).rangeOfString(labelText[1])
                attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
                attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor() , range: range)
                //cell.userInteractionEnabled = true
                
                cell.paymentTBLabel.attributedText = attributedText
                
            }
            
            paymentTable.reloadData()
        }
    }
}


extension CheckoutViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        return 2
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
       
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
         
        let cell = tableView.dequeueReusableCellWithIdentifier("paymentIdentifier", forIndexPath: indexPath) as! PaymentTableViewCell
        cell.codLable.sizeToFit()
        cell.codLable.numberOfLines = 0
        cell.selectionStyle = .None
        if indexPath.section == 0{
            cell.paymentTBImageView.image = UIImage(named: rowImage[0])
            
            var labelstring : NSString = labelText[0]
            var attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelText[0])
            var range = (labelstring as NSString).rangeOfString(labelText[0])
            attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
             attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor() , range: range)
            cell.paymentTBLabel.attributedText = attributedText
            cell.codLable.hidden = true
            return cell
        }else{
            cell.paymentTBImageView.image = UIImage(named: rowImage[1])
           // cell.paymentTBLabel.text = labelText[1]
            var labelstring : NSString = labelText[1]
            var attributedText: NSMutableAttributedString = NSMutableAttributedString(string: labelText[1])
            var range = (labelstring as NSString).rangeOfString(labelText[1])
            attributedText.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 14)!], range: range)
             attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor() , range: range)
            cell.paymentTBLabel.attributedText = attributedText
            cell.codLable.hidden = true
          //  cell.setSelected(true, animated: false)
            return cell
        }
        
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == 1){
           return 75.0
           //return UITableViewAutomaticDimension
        }else{
            return 60.0
           // return UITableViewAutomaticDimension
        }
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        
        return 10
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if(tableView == paymentTable){
        let hearder : UIView = UIView.init(frame: CGRectMake(0, 0, 414, 10))
        hearder.backgroundColor = UIColor.init(colorLiteralRed: 238.0/255.0, green: 239.0/255.0, blue: 242.0/255.0, alpha: 1)
        return hearder
        }
        return nil
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let header = UIView(frame: CGRectMake(0,28,285,20))
        header.backgroundColor = UIColor.clearColor()
        return header
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.section == 1){
            
            if(isCOD == "0"){
                
                let alertView:UIAlertView = UIAlertView()
                alertView.title = ""
                alertView.message = "Cash On Delivery is not Available for this Product"
                alertView.delegate = nil
                alertView.addButtonWithTitle("OK")
                alertView.show()
                
                for index in 0..<2
                {
                    if index != indexPath.section{
                        let rowIndex = NSIndexPath.init(forRow: 0, inSection: index)
                        let currentcell = tableView.cellForRowAtIndexPath(rowIndex) as! PaymentTableViewCell
                        currentcell.layer.borderWidth = 2.0
                        currentcell.layer.borderColor = UIColor.clearColor().CGColor }
                }
                
            }else{
            
        let indxPath = tableView.indexPathForSelectedRow
        let currentcell = tableView.cellForRowAtIndexPath(indxPath!) as! PaymentTableViewCell
        currentcell.layer.borderWidth = 2.0
        currentcell.layer.borderColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1).CGColor
        for index in 0..<2
        {
            if index != indexPath.section{
            let rowIndex = NSIndexPath.init(forRow: 0, inSection: index)
            let currentcell = tableView.cellForRowAtIndexPath(rowIndex) as! PaymentTableViewCell
            currentcell.layer.borderWidth = 2.0
                currentcell.layer.borderColor = UIColor.clearColor().CGColor }
        }
            }
   
        }else{
            let indxPath = tableView.indexPathForSelectedRow
            let currentcell = tableView.cellForRowAtIndexPath(indxPath!) as! PaymentTableViewCell
            currentcell.layer.borderWidth = 2.0
            currentcell.layer.borderColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1).CGColor
            for index in 0..<2
            {
                if index != indexPath.section{
                    let rowIndex = NSIndexPath.init(forRow: 0, inSection: index)
                    let currentcell = tableView.cellForRowAtIndexPath(rowIndex) as! PaymentTableViewCell
                    currentcell.layer.borderWidth = 2.0
                    currentcell.layer.borderColor = UIColor.clearColor().CGColor }
            }
            
        }
    }
   
}
extension String {
    
    func fromBase64() -> String? {
        guard let data = NSData(base64EncodedString: self, options: NSDataBase64DecodingOptions(rawValue: 0)) else {
            return nil
        }
        
        return String(data: data, encoding: NSUTF8StringEncoding)!
    }
    
    func toBase64() -> String? {
        guard let data = self.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        
        return data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    }
}
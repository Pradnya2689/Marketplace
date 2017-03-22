//
//  ReturnBtnViewController.swift
//  MarketPlace
//
//  Created by Administrator on 26/09/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
class ReturnBtnViewController: UIViewController,webServiceDelegate,returnRequestDelegate,returnProdRequestDelegate {
    @IBOutlet var reqSubmitBtn: UIButton!
    @IBOutlet var returnTable:UITableView!
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var orderId:String!=""
  var  paymenttype:String!=""
    var orderDetailDictn:NSDictionary!=NSDictionary()
    var linesArray:NSMutableArray!=NSMutableArray()
    var serialNumber:NSMutableArray!=NSMutableArray()
    var customerLineNumber:String!=""
    var orderDetails:OrderDetails?
    var addressId: String!=""
    var selectedQue:String!=""
    var prodArray:NSMutableArray!=NSMutableArray()
    var prodDict:NSMutableDictionary!=NSMutableDictionary()
    var pincodestr:String!=""
    var isCOD:String!=""
    var  button1: UIButton!
     var  button: UIButton!
    
    //var ratingfloat : Float!
    @IBOutlet var refundAmntLbl:UILabel!
    
    @IBOutlet var serialFooterView: UIView!
    @IBOutlet var noInternetVc:UIView!
    @IBOutlet var wifiImg:UIImageView!
    @IBOutlet var noconnetinlbl:UILabel!
    @IBOutlet var retryBtn:UIButton!
    
    var reasonArray:NSMutableArray!=NSMutableArray()
    var attrs = [
        NSFontAttributeName : UIFont.systemFontOfSize(15.0),
        NSForegroundColorAttributeName : UIColor(red: 43.0/255.0, green: 99.0/255.0, blue: 177.0/255.0, alpha: 1),
        NSUnderlineStyleAttributeName : 1]
    
    var attributedString = NSMutableAttributedString(string:"")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        accountRegistration = "accoutnNotRegistered"
        
        
        // Do any additional setup after loading the view.
        orderDetailDictn=NSDictionary()
        prodArray = NSMutableArray()
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 25))
        titleLabel.font = UIFont(name: "MyriadPro-Regular", size: 20)
        titleLabel.textColor = headerColor
        titleLabel.text = "Order Return"
        self.navigationItem.titleView = titleLabel
        var btmView:UIView = UIView.init()
        btmView.frame = CGRectMake(0, 0, screenWidth, 40)
        btmView.backgroundColor = UIColor(red: 238.0/255.0, green: 239.0/255.0, blue: 242.0/255.0, alpha: 1)
        
        let buttonTitleStr = NSMutableAttributedString(string:"Register bank account", attributes:attrs)
        attributedString.appendAttributedString(buttonTitleStr)
        
        
        button1 = UIButton(frame: CGRect(x: 10, y: 20, width: (screenSize.width/2)-20, height: 30))
        button1.center = CGPointMake((screenWidth/2), 20)
        //        button1.backgroundColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
        button1.backgroundColor = UIColor.clearColor()
        button1.setAttributedTitle(attributedString, forState: .Normal)
        button1.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 3)
        
        // button.titleLabel!.font = UIFont.systemFontOfSize(12)
        button1.titleLabel!.font =  UIFont(name: "MyriadPro-Regular", size: 12)
        button1.addTarget(self, action: #selector(regbuttonAction), forControlEvents: .TouchUpInside)
        btmView.addSubview(button1)
        
        
        
        
        button = UIButton(frame: CGRect(x: (screenWidth/2) , y: 40, width: (screenSize.width/2)-20, height: 30))
        button.center = CGPointMake((screenWidth/2), 51)
        button.backgroundColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
        button.setTitle("SUBMIT REQUEST", forState: .Normal)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 3)
        
        // button.titleLabel!.font = UIFont.systemFontOfSize(12)
        button.titleLabel!.font =  UIFont(name: "MyriadPro-Regular", size: 15)
        button.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        
        btmView.addSubview(button)
        returnTable.tableFooterView = btmView
        
        returnTable.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        
        //submitReturn
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(ReturnBtnViewController.submitReturnList(_:)),
                                                         name: "submitReturn",
                                                         object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(ReturnBtnViewController.getOrderList(_:)),
                                                         name: "OrderDet",
                                                         object: nil)
        
       let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            self.noInternetVc.hidden = true
           
        let wsm : WebServiceClass = WebServiceClass.sharedInstance
          
        wsm.getOrderDEtails(orderId, orderCofirm: false)
        wsm.delegates=self
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("userId") as? Int{
            
            //  JHProgressHUD.sharedHUD.showInView(self.view)
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            wsm.callAdressApi(usernm)
            
        }
        }else{
//            self.noInternetVc.translatesAutoresizingMaskIntoConstraints = true
//            self.noInternetVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
//            self.view.addSubview(self.noInternetVc)
            self.noInternetVc.hidden = false
            self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
            self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
            self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
            self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
            self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
            self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)
        }
       // wsm.returnProductRequestOrderDEtails("0000008020", orderId: "2000020721", sku: "000000030000000051")
        //wsm.createreturnProductRequestOrderDEtails()
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(ReturnBtnViewController.internetReachable(_:)),
                                                         name: "reachable",
                                                         object: nil)
        
       
    }
      override func viewWillAppear(animated: Bool)
      {
        if (paymenttype == "COD")
        {
            button1.enabled = true
            button1.alpha = 1.0
        }
        
        else
        {
            accountRegistration = "accoutRegistered"
            button1.enabled = false
            button1.alpha = 0.5
        
        }
//        if (accountRegistration == "accoutnNotRegistered")
//        {
//            button.enabled = false
//            button.alpha = 0.5
//        }
//        else
//        {
//            button.enabled = true
//            button.alpha = 1.0
//        }
    }
    func regbuttonAction()
    {
        let AccountRegistrationController = self.storyboard?.instantiateViewControllerWithIdentifier("AccRegVC") as! AccountRegistrationWebView
        AccountRegistrationController.orderid = self.orderId
        
//        AccountRegistrationController.mDelegate = self
        self.navigationController?.pushViewController(AccountRegistrationController, animated: true)
        
//        AccountRegistrationController.mDelegate = self
       // self.navigationController?.pushViewController(AccountRegistrationController, animated: true)
        
    }
    
    @IBAction func changeAddressClk(){
        let EditAddressControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("editAddress") as? EditAddressViewController
        var b = UIBarButtonItem(title: "Cancel", style: .Plain, target: EditAddressControllerObj, action:#selector(EditAddressViewController.cancelClicked))
        EditAddressControllerObj?.navigationItem.rightBarButtonItem = b
        EditAddressControllerObj?.NoAddrFlag = "ChangeAdressCheckout"
        let NavigationController = UINavigationController(rootViewController: EditAddressControllerObj!)
        //        NavigationController.navigationItem.rightBarButtonItem = b
        self.presentViewController(NavigationController, animated: true, completion: nil)
    }
//    func sendStringToPreviousVC(_: submitBtnstatus)
//    {
//        //DO YOUR THING
//    }
    func internetReachable(notification:NSNotification){
       noInternetClk()
        //print("in return via reachable")
    }
   
    @IBAction func noInternetClk(){
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            self.noInternetVc.hidden = true
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.getOrderDEtails(orderId, orderCofirm: false)
            wsm.delegates=self
            let defaults = NSUserDefaults.standardUserDefaults()
            if let usernm = defaults.valueForKey("userId") as? Int{
                var window :UIWindow = UIApplication.sharedApplication().keyWindow!
                //  JHProgressHUD.sharedHUD.showInView(self.view)
                LoadingOverlay.shared.showOverlay(window)
                wsm.callAdressApi(usernm)
            }
        }else{
            //            self.noInternetVc.translatesAutoresizingMaskIntoConstraints = true
            //            self.noInternetVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
            //            self.view.addSubview(self.noInternetVc)
            self.noInternetVc.hidden = false
            self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
            self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
            self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
            self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
            self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
            self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)
        }
    }
    func callAddressapiresponse(string:NSArray)
    {
        LoadingOverlay.shared.hideOverlayView()
        
        if string.count == 0
        {
            // self.addressTextField.text = ""
            // self.changeAddressBtn.setTitle("ADD ADDRESS", forState: UIControlState.Normal)
        }
        else
        {
            // self.changeAddressBtn.setTitle("CHANGE ADDRESS", forState: UIControlState.Normal)
            for address in string
            {
               // print("address  \(address)")
                if let dfaultadd : Bool = address["isDefault"] as? Bool
                {
                   // print(dfaultadd)
                    if(dfaultadd)
                    {
                       pincodestr = address["zipCode"] as! String
                        self.addressId = address["addressId"] as! String
                        //self.view1AddressLabel.text = "\(address["address1"] as! String), \(address["area"] as! String), \(address["city"] as! String), \(address["stateName"] as! String), \(address["zipCode"] as! String)"
                    }
                }
                
            }
        }//print(string["state"]!.objectAtIndex(0).valueForKey("stateName")!)
    }
    func isCODSuccess(codResp:NSDictionary){
        
        
        //print(codResp)
        if let COD : AnyObject  = codResp["isCOD"]
        {
            
            let codstr = "\(COD)"
            isCOD = codstr
            //print("COD:\(codstr)")
         //   let index = NSIndexPath.init(forRow: 0, inSection: 1)
          //  let cell = paymentTable.cellForRowAtIndexPath(index) as! PaymentTableViewCell
            if(isCOD == "0"){
               
            }
            
           // paymentTable.reloadData()
        }
    }
    func submitReturnList(notification: NSNotification)  {
       // print(notification)
        LoadingOverlay.shared.hideOverlayView()
       
         var dict = notification.userInfo!
        if let orderPlace = dict["isOrderPlaced"] as? Int{
            if(orderPlace == 1){
//                let alertView:UIAlertView = UIAlertView()
//                alertView.title = ""
//                alertView.message = "Order is returned successfully."
//                alertView.delegate = nil
//                alertView.addButtonWithTitle("OK")
//                alertView.show()
                 NSNotificationCenter.defaultCenter().postNotificationName("returnRaise", object: nil, userInfo: dict )
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
       
    }
    func getOrderList(notification: NSNotification)  {
        //print(notification)
        LoadingOverlay.shared.hideOverlayView()
        returnTable.hidden = false
        orderDetailDictn = notification.userInfo!
        orderDetails = Mapper<OrderDetails>().map(orderDetailDictn)
        
        //print("order details dict \(orderDetails)")
       linesArray=NSMutableArray()
        serialNumber=NSMutableArray()
       // print("product cnt \(linesArray.count)")
        let arry = orderDetailDictn["lines"] as! NSMutableArray
        for i in 0..<arry.count {
            let productDet = arry.objectAtIndex(i) as? NSDictionary
            //print(productDet!["ingramPartNumber"] as! String)
            if(customerLineNumber == productDet!["ingramPartNumber"] as! String){
                linesArray.addObject(productDet!)
            }
        }
        orderDetails?.lines = Mapper<Lines>().mapArray(linesArray)
       // print(orderDetails?.lines?.count)
        let productDet = linesArray.objectAtIndex(0) as? NSDictionary
        orderDetails?.lines![0].delivery = productDet!["delivery"] as? NSMutableArray
        orderDetails?.lines![0].orderReturninfo = productDet!["orderReturninfo"] as? NSMutableArray

        
        if let serialNum = productDet!["serialNumber"] as? NSArray{
            
            if(serialNum.count % 2 == 0){
                var indx=0
                 for i in 0..<serialNum.count/2 {
                     let seralData = serialNum.objectAtIndex(indx)
                    
                    //serialNumber.addObject(seralData["serialNumber"] as! String)
                    let seralData1 = serialNum.objectAtIndex(indx+1)
                    var secondval = "\(seralData["serialNumber"] as! String),\(seralData1["serialNumber"] as! String)"
                    serialNumber.addObject(secondval)
                    indx=indx+2
                }
            }else{
                var indx=0
                for i in 0..<serialNum.count/2 {
                    let seralData = serialNum.objectAtIndex(indx)
                     let seralData1 = serialNum.objectAtIndex(indx+1)
                    var secondval = "\(seralData["serialNumber"] as! String),\(seralData1["serialNumber"] as! String)"
                    serialNumber.addObject(secondval)
                    indx=indx+2
                }
                let seralData = serialNum.objectAtIndex(serialNum.count-1)
                var secondval = "\(seralData["serialNumber"] as! String)"
                serialNumber.addObject(secondval)
                
            }
          //  cell.selectionStyle = UITableViewCellSelectionStyle.None
           // let seralData = serialNumber.objectAtIndex(indexPath.row)
          //  cell.shipSerialNoLabel.text = seralData["serialNumber"] as! String
            
            let displayArray:NSMutableArray!=NSMutableArray()
           // let displayArray:NSMutableArray!=NSMutableArray()
            for i in 0..<serialNum.count{
                 let seralData = serialNum.objectAtIndex(i)
                var dict : NSMutableDictionary! = NSMutableDictionary()
                dict.setValue(seralData["serialNumber"] as! String, forKey: "serialNumber")
                displayArray.addObject(dict)
            }
            orderDetails?.lines![0].displayserialnumbers = displayArray
             orderDetails?.lines![0].serialNumber = serialNum as! NSMutableArray
            
        }
        if(linesArray.count > 0){
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
          let  productDet = linesArray.objectAtIndex(0) as? NSDictionary
            
          //  print("pincode \(pincodestr)   productprice \(trimmedProductprice)")
            wsm.isCODAPIcall(pincodestr as String, trimmedProductprice: productDet!["unitNetAmount"] as! String)
        }
        //returnTable.hidden = false
        returnTable.reloadData()
    }
   
    @IBAction func submitRequestClk(){
        
    }
    func returnreasonbuttonClicked(val:String){
        selectedQue = val
        if(val != ""){
            reasonArray.removeAllObjects()
            reasonArray.addObject(val)
        }else{
            reasonArray.removeAllObjects()
        }
        returnTable.reloadData()
       var line = orderDetails?.lines![0]
        line?.ReasonCode = val
        orderDetails?.lines![0] = line!
        //print(orderDetails?.lines![0].ReasonCode, orderDetails?.lines![0].ingramPartNumber)
        
        
    }
    func prodselectedbuttonClicked(val:String){
        prodArray.addObject(val)
        returnTable.reloadData()
      //  prodDict.setValue(val, forKey: val)
    }
    func prodUnselectedbuttonClicked(val:String){
        prodArray.removeObject(val)
        returnTable.reloadData()

        //prodDict.remo
    }
    override func viewWillDisappear(animated: Bool) {
          NSNotificationCenter.defaultCenter().removeObserver(self, name: "OrderDet", object: nil)
         NSNotificationCenter.defaultCenter().removeObserver(self, name: "reachable", object: nil)
         NSNotificationCenter.defaultCenter().removeObserver(self, name: "Accountregconfirm", object: nil)
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
    
    func selectedAdressDict(notification: NSNotification)
    {
        let dict : AnyObject = notification.userInfo!
        let receivednumber : NSDictionary = dict["valueToPass"] as! NSDictionary
        //print(receivednumber)
//        if let a = TotalPrice{
//            let arr = TotalPrice!.componentsSeparatedByString(" ")
//            let trimmedProductprice = arr[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
//            let wsm : WebServiceClass = WebServiceClass.sharedInstance
//            wsm.delegates=self
//            self.pincodestr = receivednumber["zipCode"] as! String
//            print("pincode \(pincodestr)   productprice \(trimmedProductprice)")
//            wsm.isCODAPIcall(pincodestr as String, trimmedProductprice: trimmedProductprice)
//        }else{
//            self.pincodestr = receivednumber["zipCode"] as! String
//        }
        var indx = NSIndexPath.init(forRow: 0, inSection: 2)
        let cell = returnTable.cellForRowAtIndexPath(indx) as! AddressPickupTableViewCell
        cell.pickupCellNameLabel.text = receivednumber["name"] as! String
        self.addressId = receivednumber["addressId"] as! String
        
        var addr:String!=""
       
        if let abc = receivednumber["address1"] as? String {
            addr="\(abc)"
        }
        if let abc = receivednumber["area"] as? String {
            addr="\(addr) \(abc)"
        }
        if let abc = receivednumber["city"] as? String {
            addr="\(addr) \(abc)"
        }
        if let abc = receivednumber["stateName"] as? String {
            addr="\(addr) \(abc)"
        }
        
        if let abc = receivednumber["zipCode"] as? String {
            addr="\(addr) \(abc)"
        }
//        if let abc = shippingdict["postalCode"] as? String {
//            addr="\(addr) \(abc)"
//        }
//        if let abc = shippingdict["stateName"] as? String {
//            addr="\(addr) \(abc)"
//        }
        
        cell.pickupAddress.text = addr
        
        
       // cell.pickupAddress.text = "\(), \(), \(), \(), \()"
        
    }
}

extension ReturnBtnViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return linesArray.count
        }
        if section == 1{
            return serialNumber.count
        }else{
           return linesArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         if indexPath.section == 0{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("introId", forIndexPath: indexPath) as! DetailCellTableViewCell
             cell.selectionStyle = UITableViewCellSelectionStyle.None
            if let productDet = linesArray.objectAtIndex(0) as? NSDictionary{
                cell.nameProdLabel.text = productDet["skuDescription"] as! String
                cell.prodQtyLabel.text = "Qty: \(productDet["requestedQuantity"] as! Int)"
                
              //  if let totalValues = productDet["totalValues"] as? NSDictionary{
                    cell.priceProdLabel.text = "₹ \(productDet["unitNetAmount"] as! String)"
               // }
                let image : UIImage = UIImage(named:"placeholder")!
                cell.prodImageView.image = image
                let url =  productDet["imageURL"] as! String
                let imgURL: NSURL = NSURL(string: url)!
                //print("img url **** \(imgURL.absoluteString)")
                
                if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
                {
                    //print("IN cache")
                    cell.prodImageView!.image = image
                    
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
                                cell.prodImageView!.image = image
                                photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                            }
                            else
                            {
                                let image : UIImage = UIImage(named:"placeholder")!
                                cell.prodImageView!.image = image
                                //photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                            }
                    }
                }

            }
            if let customer = orderDetailDictn["customer"] as? NSDictionary{
                cell.compNameLb.text = " By \(customer["name1"]! as! String)"
            }
            
            return cell
        }else if indexPath.section == 1{
            
            let cell = tableView.dequeueReusableCellWithIdentifier("prodSerialNo", forIndexPath: indexPath) as! ProdSerialNoTableViewCell
            
           // cell.checkbox1Btn.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
            cell.delegates = self
             if let productDet = linesArray.objectAtIndex(0) as? NSDictionary{
            if (serialNumber.count > 0){
                let serialNo = serialNumber.objectAtIndex(indexPath.row)
                let serialArry = serialNo.componentsSeparatedByString(",")
                
                if(serialArry.count == 2){
                     cell.numberLabel.text = serialArry[0]
                    cell.numberLabel1.text = serialArry[1]
                    cell.numberLabel1.hidden = false
                    cell.checkbox1Btn.hidden = false
                    if prodArray.containsObject(serialArry[0]){
                        cell.checkBoxBtn.setImage(UIImage(named: "checkboxenable.png"), forState: UIControlState.Normal)
                    }else{
                        cell.checkBoxBtn.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
                    }
                    if  prodArray.containsObject(serialArry[1]){
                        cell.checkbox1Btn.setImage(UIImage(named: "checkboxenable.png"), forState: UIControlState.Normal)
                    }else{
                        cell.checkbox1Btn.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
                    }
                }else if(serialArry.count == 1){
                        cell.numberLabel1.hidden = true
                        cell.checkbox1Btn.hidden = true
                      cell.numberLabel.text = serialArry[0]
                    if prodArray.containsObject(serialArry[0]){
                        cell.checkBoxBtn.setImage(UIImage(named: "checkboxenable.png"), forState: UIControlState.Normal)
                    }else{
                        
                        cell.checkBoxBtn.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
                    }
                   
                }
             
               
            }
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }else if indexPath.section == 2{
            
            let cell = tableView.dequeueReusableCellWithIdentifier("pickupAdd", forIndexPath: indexPath) as! AddressPickupTableViewCell
            if(orderDetailDictn.count > 0){
                if let shippingdict = orderDetailDictn["shipTo"] as? NSDictionary{
                    
                    var addr:String!=""
//                    if let abc = shippingdict["name1"] as? String {
//                        addr="\(shippingdict["name1"] as! String) \n "
//                    }
                    if let abc = shippingdict["addressLine1"] as? String {
                        addr="\(abc)"
                    }
                    if let abc = shippingdict["addressLine2"] as? String {
                        addr="\(addr) \(abc)"
                    }
                    if let abc = shippingdict["addressLine3"] as? String {
                        addr="\(addr) \(abc)"
                    }
                    if let abc = shippingdict["addressLine4"] as? String {
                        addr="\(addr) \(abc)"
                    }
                    
                    if let abc = shippingdict["city"] as? String {
                        addr="\(addr) \(abc)"
                    }
                    if let abc = shippingdict["postalCode"] as? String {
                        addr="\(addr) \(abc)"
                    }
                    if let abc = shippingdict["stateName"] as? String {
                        addr="\(addr) \(abc)"
                    }
                    
                    cell.pickupAddress.text = addr
                    cell.pickupCellNameLabel.text = shippingdict["name1"] as? String
                    //cell.totalAmtLb.text = "₹ \(orderDetailDictn["totalShippableAmount"] as! String)"
                    //cell.numberofOrderLb.text = "(\(linesArray.count) items)"
                }
            }
            
             cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("returnReason", forIndexPath: indexPath) as! ReasonCellTableViewCell
            cell.delegates = self
            if reasonArray.containsObject("MP1"){
                cell.chkBoxBtn1.setImage(UIImage(named: "checkboxenable.png"), forState: UIControlState.Normal)
            }else{
                
                cell.chkBoxBtn1.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
            }
            if reasonArray.containsObject("MP2"){
                cell.chkBoxBtn2.setImage(UIImage(named: "checkboxenable.png"), forState: UIControlState.Normal)
            }else{
                
                cell.chkBoxBtn2.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
            }
            if reasonArray.containsObject("MP3"){
                cell.chkBoxBtn3.setImage(UIImage(named: "checkboxenable.png"), forState: UIControlState.Normal)
            }else{
                
                cell.chkBoxBtn3.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
            }
//            cell.chkBoxBtn2.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
//            cell.chkBoxBtn1.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
//            cell.chkBoxBtn3.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
             cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
        
        
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1{
            if(prodArray.count > 0){
                if let productDet = linesArray.objectAtIndex(0) as? NSDictionary{
                    let unitamnt = productDet["unitNetAmount"] as! String
                    let amnt = Float(prodArray.count) * Float(unitamnt)!
                   // print(String(amnt))
                    refundAmntLbl.text = "₹ \(String(amnt)) "
                }
            return serialFooterView
            }
            return nil
            
        }else{
          return nil
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let title = UILabel()
        title.font = UIFont(name: "MyriadPro-Regular", size: 17)!
        title.textColor = grayLightColor
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font=title.font
        header.textLabel?.textColor=title.textColor
       header.backgroundColor = UIColor(red: 238.0/255.0, green: 239.0/255.0, blue: 242.0/255.0, alpha: 1)
        header.contentView.backgroundColor = UIColor(red: 238.0/255.0, green: 239.0/255.0, blue: 242.0/255.0, alpha: 1)
        //header.tintColor  = UIColor.clearColor()
        
    }
    
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        if section == 1{
            
        }else{
        let header = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 238.0/255.0, green: 239.0/255.0, blue: 242.0/255.0, alpha: 1)
        }
        
    }

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
        if indexPath.section == 0{
            return 95.0
        }else if indexPath.section == 2{
            return 120.0
        }else if indexPath.section == 3{
            return 160.0
        }else{
            return 51.0
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       
        if section == 1{
             if(prodArray.count > 0){
             return 47.0
            }
            return 0.0
        }else if section != 3{
            return 10.0
        }else{
            return 0.0
        }
}
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1{
            return "Select product serial no"
        }else if section == 2{
            return "Pickup Address"
        }else if section == 3{
            return "Reason for Return"
        }else{
            return ""
        }
    }
    
    func buttonAction(sender: UIButton!) {
        var index = NSIndexPath.init(forRow: 0, inSection: 3)
        var cell = tableView(returnTable, cellForRowAtIndexPath: index) as! ReasonCellTableViewCell
        
//          print(cell.chkBoxBtn1.selected)
//        print("hello")
//        print(prodArray)
        if(prodArray.count == 0){
            let alertView:UIAlertView = UIAlertView()
            alertView.title = ""
            alertView.message = ConstantsFile.returnSerialNo_msg
            alertView.delegate = nil
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
        }
       
        else if(cell.chkBoxBtn1.currentImage!.isEqual(UIImage(named: "checkboxDisable.png")) && cell.chkBoxBtn2.currentImage!.isEqual(UIImage(named: "checkboxDisable.png")) && cell.chkBoxBtn3.currentImage!.isEqual(UIImage(named: "checkboxDisable.png")))
        {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = ""
            alertView.message = ConstantsFile.returnReason_msg
            alertView.delegate = nil
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
        }
        else if (accountRegistration == "accoutnNotRegistered")
        {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = ""
            alertView.message = ConstantsFile.registerBankAcc_msg
            alertView.delegate = nil
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
        }
       
        else {
            prodDict=NSMutableDictionary()
            for i in 0..<prodArray.count{
                let abc = String(i)
                let val = prodArray.objectAtIndex(i) as! String
                //print(abc , prodArray.objectAtIndex(i))
                prodDict.setValue(val, forKey:abc)
            }
            //print(prodDict)
            orderDetails?.lines![0].nwSkuDescription = orderDetails?.lines![0].skuDescription
            orderDetails?.lines![0].nwIngramPartNumber = orderDetails?.lines![0].ingramPartNumber
            orderDetails?.lines![0].NewSerialNumbers = prodArray
            orderDetails?.lines![0].SerialNumbers = prodArray
            orderDetails?.lines![0].RequestedQuantity = prodArray.count
            if let productDet = linesArray.objectAtIndex(0) as? NSDictionary{
                let unitamnt = productDet["unitNetAmount"] as! String
                let amnt = Float(prodArray.count) * Float(unitamnt)!
               // print(String(amnt))
                orderDetails?.lines![0].TotalRefundAmount = String(amnt)
            }
            orderDetails?.lines![0].AddressID = addressId
            orderDetails?.lines![0].SkuImageURL = orderDetails?.lines![0].imageURL
            orderDetails?.lines![0].SkuNetPrice = orderDetails?.lines![0].unitNetAmount
            orderDetails?.lines![0].MPN = orderDetails?.lines![0].mpn
            orderDetails?.lines![0].ReferenceDocNumber = orderDetails?.orderNumber
            orderDetails?.lines![0].ReferenceDocLineNumber = orderDetails?.lines![0].customerLineNumber
            
            
            if let productDet = linesArray.objectAtIndex(0) as? NSDictionary{
                var arr = productDet["orderReturninfo"]
                if(arr?.count > 0){
                    orderDetails?.lines![0].orderReturninfo = productDet["orderReturninfo"] as? NSMutableArray
                }else{
                    orderDetails?.lines![0].orderReturninfo = []
                }
                
                
                if let delivery1 = productDet["delivery"] as? NSArray {
                    if(delivery1.count > 0){
                        let delivery = delivery1.objectAtIndex(0)
                        
                        orderDetails?.lines![0].ReturnInvoiceNumber = delivery["invoiceNumber"] as? String
                    }
                }
            }
            orderDetails?.totalValues = orderDetails?.lines![0].totalValues
            orderDetails?.trackingNumber = orderDetails?.lines![0].ReturnInvoiceNumber
            orderDetails?.trackingnumber = orderDetails?.lines![0].ReturnInvoiceNumber
            orderDetails?.billtocustomernumber = orderDetails?.billToCustomerNumber
            orderDetails?.lines![0].quantitylist = []
            orderDetails?.lines![0].LineNumber = 0
            orderDetails?.lines![0].Plant = "INC3"
            orderDetails?.lines![0].nwplant = "INC3"
            if let customer = orderDetailDictn["customer"] as? NSDictionary{
                orderDetails?.customernumber = customer["id"] as? String
            }
            
            
            let defaults = NSUserDefaults.standardUserDefaults()
            let userId = defaults.objectForKey("userId") as? Int
            var orderReturnDict:NSMutableDictionary!=NSMutableDictionary()
            orderReturnDict.setValue(addressId!, forKey: "AddressId")
            orderReturnDict.setValue(String(userId!), forKey: "UserId")
            var cod = "false"
            if isCOD == "1" {
                cod  = "true"
            }else{
                cod =  "false"
            }
            
            orderReturnDict.setValue(cod, forKey: "isCOD")
            
            let serializedUser = Mapper<OrderDetails>().toJSON(orderDetails!)
            
            orderReturnDict.setValue(serializedUser, forKey: "OrderDetails")
            orderReturnDict.setValue(orderReturnDict.objectForKey("nwSkuDescription"), forKey: "SkuDescription")
            orderReturnDict.removeObjectForKey("nwSkuDescription")
            orderReturnDict.setValue(orderReturnDict.objectForKey("nwIngramPartNumber"), forKey: "IngramPartNumber")
            orderReturnDict.removeObjectForKey("nwIngramPartNumber")
            orderReturnDict.setValue(orderReturnDict.objectForKey("nwplant"), forKey: "plant")
            orderReturnDict.removeObjectForKey("nwplant")
            
            var line : Lines = orderDetails!.lines![0]
            let serializedUser1 = Mapper<Lines>().toJSON(line)
            orderReturnDict.setValue(serializedUser1, forKey: "OrderLine")
            orderReturnDict.setValue(orderReturnDict.objectForKey("nwSkuDescription"), forKey: "SkuDescription")
            orderReturnDict.removeObjectForKey("nwSkuDescription")
            orderReturnDict.setValue(orderReturnDict.objectForKey("nwIngramPartNumber"), forKey: "IngramPartNumber")
            orderReturnDict.removeObjectForKey("nwIngramPartNumber")
            orderReturnDict.setValue(orderReturnDict.objectForKey("nwplant"), forKey: "plant")
            orderReturnDict.removeObjectForKey("nwplant")
            
            
            
            //print("final array \(orderReturnDict)")
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
             // JHProgressHUD.sharedHUD.showInView(self.view)
                    LoadingOverlay.shared.showOverlay(window) //order return webservice
                    wsm.delegates=self
                    wsm.submitOrderReturn(orderReturnDict)
        }
        
       // let dictprod = prodArray as! NSDictionary
        //print(dictprod)
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("returnID") as! OrderReturnViewController
//        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
//    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        if section == 3{
//            var btmView:UIView = UIView.init()
//            btmView.frame = CGRectMake(0, 0, 320, 40)
//            btmView.backgroundColor = UIColor(red: 238.0/255.0, green: 239.0/255.0, blue: 242.0/255.0, alpha: 1)
//            
//            let button = UIButton(frame: CGRect(x: 10, y: 20, width: screenSize.width-20, height: 40))
//            button.backgroundColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
//            button.setTitle("SUBMIT REQUEST", forState: .Normal)
//            button.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
//            btmView.addSubview(button)
//            return btmView
//        }else{
//            var btmView:UIView = UIView.init()
//            btmView.frame = CGRectZero
//            return btmView
//        }
//    }
    
    
}
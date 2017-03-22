                       //
                       //  OrderDetailsViewController.swift
                       //  MarketPlace
                       //
                       //  Created by Administrator on 06/09/16.
                       //  Copyright © 2016 inpanr07. All rights reserved.
                       //
                       
                       import UIKit
                       import Alamofire
                       class OrderDetailsViewController: UIViewController,UIGestureRecognizerDelegate,webServiceDelegate,UITextFieldDelegate {
                        @IBOutlet var orderTable:UITableView!
                        var orderDetailDictn:NSDictionary!=NSDictionary()
                        var linesArray:NSMutableArray!=NSMutableArray()
                        @IBOutlet var ButtonView: UIView!
                        var orderNumber:String!=""
                        @IBOutlet var orderNumberLbl:UILabel!
                        @IBOutlet var orderDatteLbl:UILabel!
                        let boundss = UIScreen.mainScreen().bounds
                        @IBOutlet var innerView:UIView!
                        @IBOutlet var givRatingView:FloatRatingView!
                        @IBOutlet var titileLbl:UITextField!
                        @IBOutlet var decrLbl:UITextField!
                        @IBOutlet var errorLbl:UILabel!
                        @IBOutlet var addRatingView:UIView!
                        @IBOutlet var ratingImg:UIImageView!
                        @IBOutlet var noInternetVc:UIView!
                        @IBOutlet var wifiImg:UIImageView!
                        @IBOutlet var noconnetinlbl:UILabel!
                        @IBOutlet var retryBtn:UIButton!
                        var shipmentArray:NSMutableArray! = NSMutableArray()
                        @IBOutlet weak var rateScrollView: UIScrollView!
                        var viewHasMovedUp : Bool = true
                        var orderDetailNewDict:NSMutableDictionary!=NSMutableDictionary()
                        var mpnNo:String!=""
                        override func viewDidLoad() {
                            super.viewDidLoad()
                            self.navigationController?.interactivePopGestureRecognizer?.enabled = false
                            
                            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 25))
                            titleLabel.font = UIFont(name: "MyriadPro-Regular", size: 20)
                            titleLabel.textColor = headerColor
                            titleLabel.text = "Order Details"
                            self.navigationItem.titleView = titleLabel
                            
                            
                            let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
                            tap.delegate = self
                            ratingImg.addGestureRecognizer(tap)
                            
                            
                            let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                            orderDetailDictn = NSDictionary()
                            linesArray = NSMutableArray()
                            orderTable.reloadData()
                            if (appdelegate.isReachable == true) {
                                self.noInternetVc.hidden = true
                                var window :UIWindow = UIApplication.sharedApplication().keyWindow!
                                LoadingOverlay.shared.showOverlay(window)
                                
                                let wsm : WebServiceClass = WebServiceClass.sharedInstance
                                wsm.getOrderDEtails(orderNumber, orderCofirm: false)
                            }else{
                                
                                self.noInternetVc.hidden = false
                                self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
                                self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
                                self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
                                self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
                                self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
                                self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)
                            }
                            registerKeyboardNotifications()
                            rateScrollView.alwaysBounceHorizontal = false
                            
                            
                            
                        }
                        
                        
                        func registerKeyboardNotifications() {
                            NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
                            NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
                        }
                        
                        func unregisterKeyboardNotifications() {
                            NSNotificationCenter.defaultCenter().removeObserver(self)
                        }
                        
                        func keyboardDidShow(notification: NSNotification) {
                            let userInfo: NSDictionary = notification.userInfo!
                            let keyboardSize = userInfo.objectForKey(UIKeyboardFrameBeginUserInfoKey)!.CGRectValue.size
                            let contentInsets = UIEdgeInsetsMake(0, 0, 200, 0)
                            self.rateScrollView.contentInset = contentInsets
                            self.rateScrollView.scrollIndicatorInsets = contentInsets
                            
                            //        var viewRect = view.frame
                            //        viewRect.size.height -= keyboardSize.height
                            
                            
                        }
                        
                        
                        func keyboardWillHide(notification: NSNotification) {
                            let contentInsets = UIEdgeInsetsMake(0, 0, -200, 0)
                            self.rateScrollView.contentInset = contentInsets
                            self.rateScrollView.scrollIndicatorInsets = contentInsets
                        }
                        
                        func textFieldShouldReturn(textField: UITextField) -> Bool {
                            textField.resignFirstResponder()
                            return true
                        }
                        
                        
                        func internetReachable(notification:NSNotification){
                            noInternetClk()
                            //print("in order det via reachable")
                        }
                        @IBAction func noInternetClk(){
                            let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                            if (appdelegate.isReachable == true) {
                                self.noInternetVc.hidden = true
                                var window :UIWindow = UIApplication.sharedApplication().keyWindow!
                                LoadingOverlay.shared.showOverlay(window)
                                
                                let wsm : WebServiceClass = WebServiceClass.sharedInstance
                                wsm.getOrderDEtails(orderNumber, orderCofirm: false)
                            }else{
                                
                                self.noInternetVc.hidden = false
                                self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
                                self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
                                self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
                                self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
                                self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
                                self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)
                            }
                        }
                        func handleTap(sender: UITapGestureRecognizer? = nil) {
                            // handling code
                            self.view.endEditing(true)
                            self.addRatingView.hidden = true
                        }
                        func cancelOrderList(notification: NSNotification)  {
                           // print(notification)
                            orderDetailDictn = NSMutableDictionary()
                            linesArray = NSMutableArray()
                            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
                            LoadingOverlay.shared.showOverlay(window)
                            
                            let wsm : WebServiceClass = WebServiceClass.sharedInstance
                            wsm.getOrderDEtails(orderNumber, orderCofirm: false)
                        }
                        
                        override func viewWillAppear(animated: Bool) {
                            
                            NSNotificationCenter.defaultCenter().addObserver(self,
                                                                             selector:#selector(OrderDetailsViewController.getOrderList(_:)),
                                                                             name: "OrderDet",
                                                                             object: nil)
                            NSNotificationCenter.defaultCenter().addObserver(self,
                                                                             selector:#selector(OrderDetailsViewController.cancelOrderList(_:)),
                                                                             name: "cancelOrderDet",
                                                                             object: nil)
                            NSNotificationCenter.defaultCenter().addObserver(self,
                                                                             selector:#selector(OrderDetailsViewController.addmyReview(_:)),
                                                                             name: "addReview",
                                                                             object: nil)
                            NSNotificationCenter.defaultCenter().addObserver(self,
                                                                             selector:#selector(OrderDetailsViewController.internetReachable(_:)),
                                                                             name: "reachable",
                                                                             object: nil)
                            NSNotificationCenter.defaultCenter().addObserver(self,
                                                                             selector:#selector(OrderDetailsViewController.returnRaised(_:)),
                                                                             name: "returnRaise",
                                                                             object: nil)
                        }
                        
                        override func viewWillDisappear(animated: Bool) {
                            NSNotificationCenter.defaultCenter().removeObserver(self, name: "cancelOrderDet", object: nil)
                            NSNotificationCenter.defaultCenter().removeObserver(self, name: "OrderDet", object: nil)
                            NSNotificationCenter.defaultCenter().removeObserver(self, name: "addReview", object: nil)
                            NSNotificationCenter.defaultCenter().removeObserver(self, name: "reachable", object: nil)
                            
                            unregisterKeyboardNotifications()
                        }
                        override func didReceiveMemoryWarning() {
                            super.didReceiveMemoryWarning()
                            // Dispose of any resources that can be recreated.
                        }
                        func addmyReview(notification: NSNotification)  {
                            //  ratingReviewArray.removeAllObjects()
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = ""
                            alertView.message = ConstantsFile.review_msg
                            alertView.delegate = nil
                            alertView.addButtonWithTitle("OK")
                            alertView.show()
                            
                        }
                        @IBAction func submitReview(){
                            //        self.view.endEditing(true)
                            if(givRatingView.rating == 0.0){
                                errorLbl.hidden = false
                            }else{
                                errorLbl.hidden = true
                                addRatingView.hidden = true
                                let wsm : WebServiceClass = WebServiceClass.sharedInstance
                                wsm.delegates=self
                                wsm.sendRatingDetails(mpnNo as String, Review: (self.decrLbl?.text)!, Rating: givRatingView.rating, firstName: (titileLbl?.text)!)
                                self.view.endEditing(true)
                                //  wsm.getMyownreviewDetails(self.vendorPartNumber as String, PageIndex: "0", onSearchPage: false, onProductPage: false, onReviewPage: true, onAdminPage: false)
                                //ratingReview
                            }
                        }
                        func returnRaised(notification: NSNotification)  {
                            let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                            orderDetailDictn = NSDictionary()
                            linesArray = NSMutableArray()
                            orderTable.reloadData()
                            if (appdelegate.isReachable == true) {
                                self.noInternetVc.hidden = true
                                var window :UIWindow = UIApplication.sharedApplication().keyWindow!
                                LoadingOverlay.shared.showOverlay(window)
                                
                                let wsm : WebServiceClass = WebServiceClass.sharedInstance
                                wsm.getOrderDEtails(orderNumber, orderCofirm: false)
                            }else{
                                
                                self.noInternetVc.hidden = false
                                self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
                                self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
                                self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
                                self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
                                self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
                                self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)
                            }
                            
                        }
                        
//                        override func viewDidAppear(animated: Bool) {
//                            self.orderTable.rowHeight = UITableViewAutomaticDimension
//                            self.orderTable.estimatedRowHeight = 350
//                            orderTable.reloadData()
//                        }
  func getOrderList(notification: NSNotification)  {
                            //print(notification)
                            LoadingOverlay.shared.hideOverlayView()
                            orderDetailDictn = notification.userInfo!
                            orderDetailNewDict.removeAllObjects()
                            if(orderDetailDictn.count > 0){
                                
                              //  linesArray = orderDetailDictn["lines"] as! NSMutableArray
                              linesArray =  NSMutableArray(array:orderDetailDictn["lines"] as! [AnyObject])
                               
                                // print("product cnt \(linesArray.count)")
                                orderNumberLbl.text = "Order #\(orderDetailDictn["orderNumber"] as! String)"
                                var string = orderDetailDictn["orderDate"] as! String
                                if let reverseIndex = string.characters.reverse().indexOf(".") {
                                   // print(string[string.startIndex ..< reverseIndex.base.advancedBy(-1)])
                                    string = string[string.startIndex ..< reverseIndex.base.advancedBy(-1)]
                                }
                                let deFormatter = NSDateFormatter()
                                deFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                                
                                let startTime = deFormatter.dateFromString(string)
                               // print(startTime!) // 2015-06-25 23:10:00 +0000
                                
                                
                                let formatter = NSDateFormatter()
                                formatter.dateFormat = "dd/MM/yyyy"
                                let timeString = formatter.stringFromDate(startTime!)
                                orderDatteLbl.text = "Date : \(timeString)"
                                
                            }
                            // print(shipmentArray)
                            var prodDict:NSMutableDictionary!=NSMutableDictionary()
                            for prod in linesArray{
                                
                                var prodDetailarray:NSMutableArray!=NSMutableArray()
                                var lineDict:NSMutableDictionary!=NSMutableDictionary()
                                
                                lineDict.setValue(prod["customerLineNumber"] as! String, forKey: "customerLineNumber")
                                lineDict.setValue(prod["skuDescription"] as! String, forKey: "skuDescription")
                                if let customer = orderDetailDictn["customer"] as? NSDictionary{
                                    lineDict.setValue("By \(customer["name1"]! as! String)", forKey: "seller")
                                }else{
                                    lineDict.setValue("", forKey: "seller")
                                }
                                if let freebe = prod["freeItemIndicator"] as? String {
                                    if(freebe == ""){
                                        lineDict.setValue("", forKey: "freeItemIndicator")
                                    }else{
                                        lineDict.setValue("X", forKey: "freeItemIndicator")
                                    }
                                }
                                lineDict.setValue("Qty: \(prod["requestedQuantity"] as! Int)", forKey: "requestedQuantity")
                                
                                
                                lineDict.setValue(prod["imageURL"] as! String, forKey: "imageURL")
                                if let totalValues = prod["totalValues"] as? NSDictionary{
                                    //  cell.amountLabelOutlet.text = "₹ \(totalValues["netAmount"] as! String)"
                                    lineDict.setValue("₹ \(totalValues["netAmount"] as! String)", forKey: "netAmount")
                                }
                                lineDict.setValue("\(prod["ingramPartNumber"] as! String)", forKey: "ingramPartNumber")
                                lineDict.setValue("\(prod["mpn"] as! String)", forKey: "mpn")
                                if let ststus = prod["status"] as? String{
                                    lineDict.setValue(ststus, forKey: "status")
                                }else{
                                    lineDict.setValue("", forKey: "status")
                                }
                                
                                lineDict.setValue("PI", forKey: "type")
                                //first index
                                prodDetailarray.addObject(lineDict)
                                
                                var optionsDict:NSMutableDictionary!=NSMutableDictionary()
                                
                                let orderReturnInfo = prod["orderReturninfo"] as! NSArray
                                let status = prod["status"] as! String
                                if(orderReturnInfo.count != 0){
                                    optionsDict.setValue("View Return", forKey: "ViewReturn")
                                }
                                
                                if(status == "In Progress"){
                                    optionsDict.setValue("Cancel", forKey: "Cancel")
                                }
                                optionsDict.setValue("Rate", forKey: "Rate")
                                optionsDict.setValue("opt", forKey: "type")
                                prodDetailarray.addObject(optionsDict)
                                
                                if let deliveryArray  = prod["delivery"] as? NSMutableArray{
                                    
                                    let shipmentDict:NSMutableDictionary!=NSMutableDictionary()
                                    let serialNumberArray = prod["serialNumber"] as? NSMutableArray
                                    
                                    for delivry in deliveryArray{
                                        let serialData:NSMutableArray!=NSMutableArray()
                                        let  trackNumber = delivry["trackingNumber"] as! String
                                        if(serialNumberArray?.count > 0){
                                            for serialNo in serialNumberArray!{
                                                let deliveryNumber = serialNo["deliveryNumber"] as! String
                                                if(trackNumber == deliveryNumber){
                                                    serialData.addObject(serialNo["serialNumber"] as! String)
                                                }
                                            }
                                        
                                        
                                        let serialNos:String!=serialData.componentsJoinedByString("\n")
                                        
                                        shipmentDict.setValue(trackNumber, forKey: "deliveryNumber")
                                        shipmentDict.setValue(serialNos, forKey: "serialNos")
                                        shipmentDict.setValue(delivry["strPODDate"] as! String, forKey: "strPODDate")
                                        shipmentDict.setValue(delivry["invoiceNumber"] as! String, forKey: "invoiceNumber")
                                        if let ststus = delivry["deliveryStatus"] as? String{
                                            shipmentDict.setValue(delivry["deliveryStatus"] as! String, forKey: "deliveryStatus")
                                        }else{
                                            shipmentDict.setValue("", forKey: "deliveryStatus")
                                        }
                                        shipmentDict.setValue("ship", forKey: "type")
                                        prodDetailarray.addObject(shipmentDict)
                                        
                                            if(serialNumberArray!.count > 0){
                                                //(index, forecast) in JSON.enumerate()
                                                for (index,serdata) in serialNumberArray!.enumerate(){
                                                    let serialDict:NSMutableDictionary!=NSMutableDictionary()
                                                    serialDict.setValue(serdata["serialNumber"] as! String, forKey: "serialNumber")
                                                    serialDict.setValue(index, forKey: "position")
                                                    serialDict.setValue("serial", forKey: "type")
                                                    prodDetailarray.addObject(serialDict)
                                                }
                                            }
                                            
                                            
                                        let bottomDict:NSMutableDictionary!=NSMutableDictionary()
                                        let  invoiceNumber = delivry["invoiceNumber"] as! String
                                        if(delivry["showTracking"] as! Bool == false){
                                            
                                        }else{
                                            bottomDict.setValue("Track", forKey: "showTracking")
                                            
                                        }
                                        if(invoiceNumber.characters.count != 0){
                                            bottomDict.setValue("Invoice", forKey: "Invoice")
                                        }
                                        let showReturn = delivry["showReturnRequest"] as! Bool
                                        if(showReturn == true){
                                            //showCnt=showCnt+1
                                            if let freebe = prod["freeItemIndicator"] as? String {
                                                if(freebe == ""){
                                                    //buttonTextArray.addObject("Return")
                                                    bottomDict.setValue("Return", forKey: "Return")
                                                }else{
                                                    // buttonTextArray.addObject("Replace")
                                                    bottomDict.setValue("Replace", forKey: "Return")
                                                }
                                            }
                                        }
                                        bottomDict.setValue("RIT", forKey: "type")
                                        prodDetailarray.addObject(bottomDict)
                                        }
                                    }
                                }
                                
                                
                                prodDict.setValue(prodDetailarray, forKey: prod["customerLineNumber"] as! String)
                                
                            }
                            orderDetailNewDict = prodDict.mutableCopy() as! NSMutableDictionary
                           // print(orderDetailNewDict)
                            
                            orderTable.reloadData()
                            //print(dict["orders"])
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
                       
                       extension OrderDetailsViewController: UITableViewDelegate, UITableViewDataSource{
                        
                        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
                            
                            return 1+orderDetailNewDict.count
                        }
                        
                        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                            if section == 0{
                                if(orderDetailDictn.count > 0){
                                    return 1
                                }else{
                                    return 0
                                }
                            }else{
                                if(orderDetailNewDict.count > 0){
                                    let productDet = linesArray.objectAtIndex(section-1) as? NSDictionary
                                    var lineNo = productDet!["customerLineNumber"] as! String
                                   // print(lineNo)
                                    let arr = orderDetailNewDict.valueForKey(lineNo) as! NSArray
                                    
                                    return arr.count
                                }
                                
                                return 0
                            }
                        }
                        
                        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
                            
                            
                            if indexPath.section == 0{
                                let cell = tableView.dequeueReusableCellWithIdentifier("shipping", forIndexPath: indexPath) as! ShippingHeaderTableViewCell
                                cell.selectionStyle = UITableViewCellSelectionStyle.None
                                if let shippingdict = orderDetailDictn["shipTo"] as? NSDictionary{
                                    var addr:String!=""
                                    if let abc = shippingdict["name1"] as? String {
                                        addr="\(shippingdict["name1"] as! String) \n "
                                    }
                                    if let abc = shippingdict["addressLine1"] as? String {
                                        addr="\(addr) \(abc)"
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
                                    cell.addTV.text = addr
                                    cell.payMethodLB.text = orderDetailDictn["paymentTerms"] as? String
                                    cell.totalAmtLb.text = "₹ \(orderDetailDictn["totalShippableAmount"] as! String)"
                                    if let totlPrice = orderDetailDictn["totalValues"] as? NSDictionary{
                                        if let promo = totlPrice["promoAmount"] as? String {
                                            if(promo == "0.0" || promo == "0.00"){
                                                cell.promotionalLbl.translatesAutoresizingMaskIntoConstraints = true
                                                cell.promotionalLbl.frame = CGRectMake(191, 206, 166, 0)
                                                cell.promotionalTitleLbl.translatesAutoresizingMaskIntoConstraints = true
                                                cell.promotionalTitleLbl.frame = CGRectMake(8, 206, 166, 0)
                                                cell.promotionalDevider.translatesAutoresizingMaskIntoConstraints = true
                                                cell.promotionalDevider.frame = CGRectMake(0, 232, screenWidth, 0)
                                                
                                                cell.totalTileLbl.translatesAutoresizingMaskIntoConstraints = true
                                                cell.totalTileLbl.frame = CGRectMake(8, 209, 96, 21)
                                                cell.numberofOrderLb.translatesAutoresizingMaskIntoConstraints = true
                                                cell.numberofOrderLb.frame = CGRectMake(109, 209, 60, 21)
                                                cell.totalAmtLb.translatesAutoresizingMaskIntoConstraints = true
                                                cell.totalAmtLb.frame = CGRectMake(screenWidth-200, 209, screenWidth-180, 21)
                                                
                                            }else{
                                                cell.promotionalLbl.text = promo
                                                cell.totalTileLbl.translatesAutoresizingMaskIntoConstraints = true
                                                cell.totalTileLbl.frame = CGRectMake(8, 238, 96, 21)
                                                cell.numberofOrderLb.translatesAutoresizingMaskIntoConstraints = true
                                                cell.numberofOrderLb.frame = CGRectMake(109, 238, 60, 21)
                                                cell.totalAmtLb.translatesAutoresizingMaskIntoConstraints = true
                                                cell.totalAmtLb.frame = CGRectMake(screenWidth-210, 238, screenWidth-180, 21)
                                            }
                                            
                                            
                                        }else{
                                            
                                            // cell.promotionalLbl.text = "0.0"
                                        }
                                        if let amnt = totlPrice["netAmount"] as? String {
                                            cell.subtotalLbl.text = "₹ \(amnt)"
                                        }else{
                                            cell.subtotalLbl.text = "₹ 0.0"
                                        }
                                        if let shpamnt = totlPrice["totalShippableAmount"] as? String {
                                            cell.shippingLbl.text = "₹ \(shpamnt)"
                                        }else{
                                            cell.shippingLbl.text = "₹ 0.0"
                                        }
                                        
                                    }
                                    
                                    if(linesArray.count > 1){
                                        cell.numberofOrderLb.text = "(\(linesArray.count) items)"
                                    }else{
                                        cell.numberofOrderLb.text = "(\(linesArray.count) item)"
                                    }
                                }
                                
                                
                                cell.selectionStyle = UITableViewCellSelectionStyle.None
                                return cell
                            }else{
                                let productDet = linesArray.objectAtIndex(indexPath.section-1) as? NSDictionary
                                let lineNo = productDet!["customerLineNumber"] as! String
                                let rowData = orderDetailNewDict.valueForKey(lineNo) as! NSArray
                                let currentData = rowData.objectAtIndex(indexPath.row) as! NSDictionary
                                
                                if(currentData["type"] as! String == "PI"){
                                    let cell = tableView.dequeueReusableCellWithIdentifier("orderDetails", forIndexPath: indexPath) as! ShippingOrderdetailsTableViewCell
                                    cell.selectionStyle = UITableViewCellSelectionStyle.None
                                    cell.prodNameLb.text = currentData["skuDescription"] as? String
                                    cell.shopNameLb.text = currentData["seller"] as? String
                                    cell.quantityLabel.text = currentData["requestedQuantity"] as? String
                                    cell.amountLabelOutlet.text = currentData["netAmount"] as? String
                                    if(currentData["freeItemIndicator"] as! String == "X"){
                                        cell.freebeLbl.hidden = false
                                    }else{
                                        cell.freebeLbl.hidden = true
                                    }
                                    cell.orderStatusLbl.text = currentData["status"] as? String
                                    
                                    let image : UIImage = UIImage(named:"placeholder")!
                                    cell.prodImgView.image = image
                                    let url =  currentData["imageURL"] as! String
                                    let imgURL: NSURL = NSURL(string: url)!
                                   // print("img url **** \(imgURL.absoluteString)")
                                    
                                    if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
                                    {
                                       // print("IN cache")
                                        cell.prodImgView!.image = image
                                        
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
                                                    //print(imgURL.absoluteString)
                                                    cell.prodImgView!.image = image
                                                    photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                                                }
                                                else
                                                {
                                                    let image : UIImage = UIImage(named:"placeholder")!
                                                    cell.prodImgView!.image = image
                                                    //photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                                                }
                                        }
                                    }
                                    
                                    
                                    return cell
                                    
                                }else if(currentData["type"] as! String == "opt"){
                                    
                                    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
                                    cell.selectionStyle = UITableViewCellSelectionStyle.None
                                    var counter:Int = 0
                                    var buttonTextArray:NSMutableArray! = NSMutableArray()
                                    if let orderret = currentData["ViewReturn"] as? String{
                                        counter = counter + 1
                                        buttonTextArray.addObject("View Return")
                                    }
                                    
                                    if let orderret = currentData["Cancel"] as? String{
                                        counter = counter + 1
                                        buttonTextArray.addObject("Cancel")
                                    }
                                    if let orderret = currentData["Rate"] as? String{
                                        counter = counter + 1
                                        buttonTextArray.addObject("Rate")
                                    }
                                    var sizeOfbtn = boundss.width
                                    if(counter > 1){
                                        sizeOfbtn = boundss.width/CGFloat(counter)
                                    }
                                    
                                    for i in 0..<counter{
                                        let button:UIButton = UIButton(frame: CGRectMake(sizeOfbtn*CGFloat(i), 5,sizeOfbtn, 40))
                                        button.backgroundColor = UIColor.whiteColor()
                                        button.titleLabel?.font =  UIFont(name: "MyriadPro-Regular", size: 17)
                                        button.tag = indexPath.section-1
                                        button.setTitle(buttonTextArray.objectAtIndex(i) as! String, forState: UIControlState.Normal)
                                        button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
                                        button.addTarget(self, action:#selector(ratebuttonClicked), forControlEvents: .TouchUpInside)
                                        cell.contentView.addSubview(button)
                                        
                                    }
                                    
                                    return cell
                                    
                                }else if(currentData["type"] as! String == "ship"){
                                    let cell = tableView.dequeueReusableCellWithIdentifier("shipSerial", forIndexPath: indexPath) as! ShipSerialNoTableViewCell
                                    cell.selectionStyle = UITableViewCellSelectionStyle.None
                                    cell.deliveryDateLbl.text = currentData["strPODDate"] as! String
                                    cell.invoiceNoLbl.text = currentData["invoiceNumber"] as! String
                                    cell.statusLbl.text = currentData["deliveryStatus"] as! String
                                    cell.shipmentNoLbl.text = currentData["deliveryNumber"] as! String
                                    return cell
                                    
                                }
                                else if(currentData["type"] as! String == "RIT"){
                                    
                                    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
                                    cell.selectionStyle = UITableViewCellSelectionStyle.None
                                    var counter:Int = 0
                                    var buttonTextArray:NSMutableArray! = NSMutableArray()
                                    if let orderret = currentData["showTracking"] as? String{
                                        counter = counter + 1
                                        buttonTextArray.addObject("Track")
                                    }
                                    
                                    if let orderret = currentData["Invoice"] as? String{
                                        counter = counter + 1
                                        buttonTextArray.addObject("Invoice")
                                    }
                                    if let orderret = currentData["Return"] as? String{
                                        counter = counter + 1
                                        buttonTextArray.addObject("Return")
                                    }
                                    
                                    var sizeOfbtn = boundss.width
                                    if(counter > 1){
                                        sizeOfbtn = boundss.width/CGFloat(counter)
                                    }
                                    
                                    for i in 0..<counter{
                                        let button:UIButton = UIButton(frame: CGRectMake(sizeOfbtn*CGFloat(i), 5,sizeOfbtn, 40))
                                        button.backgroundColor = bluedarkColor
                                        button.titleLabel?.font =  UIFont(name: "MyriadPro-Regular", size: 17)
                                        button.tag = indexPath.section-1
                                        button.setTitle(buttonTextArray.objectAtIndex(i) as! String, forState: UIControlState.Normal)
                                        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                                        button.addTarget(self, action:#selector(ratebuttonClicked), forControlEvents: .TouchUpInside)
                                        cell.contentView.addSubview(button)
                                        
                                    }
                                    
                                    return cell
                                    
                                }else if(currentData["type"] as! String == "serial"){
                                    let cell = tableView.dequeueReusableCellWithIdentifier("Serial", forIndexPath: indexPath) as! SerialNumCell
                                    cell.selectionStyle = UITableViewCellSelectionStyle.None
                                    cell.serialNumberDatalbl.text = currentData["serialNumber"] as! String
                                    var pos = currentData["position"] as! Int
                                    cell.serialLbl.text = "Serial Number \(pos+1)"
                                    return cell
                                    //Serial
                                }
                                else{
                                    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
                                    return cell
                                }
                                
                            }
                          
                        }
                        
                        
                        func ratebuttonClicked(sender:UIButton)  {
                            let btn = sender
                            btn.titleLabel?.font =  UIFont(name: "MyriadPro-Regular", size: 17)
                            let productDet = linesArray.objectAtIndex(btn.tag) as? NSDictionary
                           // print("btn \(btn.titleLabel?.text)")
                          //  btn.titleLabel?.font = UIFont(name: "MyriadPro-Regular", size: 20.0)
                            if(btn.titleLabel?.text == "Rate"){
                                givRatingView.rating = 0.0
                                errorLbl.hidden = true
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
                                
                                
                                mpnNo = productDet!["mpn"] as! String
                               // print(mpnNo)
                                decrLbl.layer.masksToBounds = true
                                addRatingView.hidden = false
                                innerView.translatesAutoresizingMaskIntoConstraints = true
                                innerView.frame = CGRectMake((boundss.width-273)/2, (boundss.height - 260)/2, 273, 259)
                                
                            }else if(btn.titleLabel?.text == "View Return"){
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("viewReturnVC") as! ViewReturnViewController
                                nextViewController.orderId = orderNumber
                                
                                nextViewController.customerLineNumber = productDet!["ingramPartNumber"] as! String
                                self.navigationController?.pushViewController(nextViewController, animated: true)
                                
                                
                            }else if(btn.titleLabel?.text == "Cancel"){
                                let alert = UIAlertController(title: "", message:ConstantsFile.orderCancel_msg, preferredStyle: UIAlertControllerStyle.Alert)
                                
                                alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler:  { (action) -> Void in
                                    var seller:String=""
                                    if let customer = self.orderDetailDictn["customer"] as? NSDictionary{
                                        seller = customer["id"] as! String
                                    }
                                    //print("free be ******* \(productDet!["freeItemIndicator"] as! String)")
                                    btn.setTitle("Cancelled", forState: UIControlState.Normal)
                                    //let wsm : WebServiceClass = WebServiceClass.sharedInstance
                                   // wsm.cancelOrderDEtails(self.orderNumber, itemId: productDet!["customerLineNumber"] as! String, SellerNumber: seller, index: 0,freeItemIndicator: "")
                                    var appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                                    if (appdelegate.isReachable == true) {
                                        //var headers : [String : String]!
                                        let defaults = NSUserDefaults.standardUserDefaults()
                                        let UserId = defaults.objectForKey("userId") as? Int
                                        var headers : [String : String]!
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
                                        
                                        //http://immarketapi-stg2.azurewebsites.net/api/OrderSearch?userId=164&orderStatus=&orderNumber=&currentPage=1
                                        let url = "\(baseUrl)orderview?userId=\(UserId!)&orderNumber=\(self.orderNumber)&itemId=\(productDet!["customerLineNumber"] as! String)&SellerNumber=\(seller)&freeItemIndicator="
                                       // print(url)
                                        Alamofire.request(.GET,  url, headers: headers)
                                            .validate(contentType: ["application/json"])
                                            .responseJSON { response in
//                                                print(response.request)  // original URL request
//                                                print(response.response?.statusCode) // URL response)
//                                                print(response.data)     // server data
//                                                print(response.result)
                                                
                                                
                                                if(response.response?.statusCode == 200){
                                                  LoadingOverlay.shared.hideOverlayView()
                                                    btn.setTitle("Cancelled", forState: UIControlState.Normal)
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
                                        //JHProgressHUD.sharedHUD.hide()
                                        LoadingOverlay.shared.hideOverlayView()
                                      //  showAlert()
                                    }
                                    
                                    
                                }))
                                alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler:{ (action) -> Void in
                                    
                                }))
                                
                                self.presentViewController(alert, animated: true, completion: nil)
                                
                            }else if(btn.titleLabel?.text == "Invoice"){
                                //Invoice
                                var seller:String=""
                                if let customer = orderDetailDictn["customer"] as? NSDictionary{
                                    seller = customer["id"] as! String
                                }
                                var invoiceNumber:String=""
                                if let delivery1 = productDet!["delivery"] as? NSArray {
                                    
                                    if(delivery1.count > 0){
                                        let delivery = delivery1.objectAtIndex(0)
                                        
                                        // showReturn = delivery["showReturnRequest"] as! Bool
                                        invoiceNumber = delivery["invoiceNumber"] as! String
                                    }
                                    
                                }
                                //customerLineNumber
                                LoadingOverlay.shared.showOverlay(self.view)
                                let wsm : WebServiceClass = WebServiceClass.sharedInstance
                                wsm.sendInvoiceOrderDEtails(invoiceNumber, SellerNumber: seller, index: productDet!["customerLineNumber"] as! String)
                            }else if(btn.titleLabel?.text == "Return" || btn.titleLabel?.text == "Replace"){
                                //returnVC
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("returnVC") as! ReturnBtnViewController
                                nextViewController.paymenttype = orderDetailDictn["paymentTerms"] as? String
                                nextViewController.orderId = orderNumber
                                nextViewController.customerLineNumber = productDet!["ingramPartNumber"] as! String
                                //  nextViewController.customerLineNumber = productDet!["ingramPartNumber"] as! String
                                self.navigationController?.pushViewController(nextViewController, animated: true)
                            }else if(btn.titleLabel?.text == "Track"){
                                //returnVC
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("track") as! TrackViewController
                                //nextViewController.orderNumber = ordernumber
                                self.navigationController?.pushViewController(nextViewController, animated: true)
                            }
                        }
                        
                        func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
                            //let nos = orderTable.numberOfRowsInSection(indexPath.section)
                            
                            
                            if indexPath.section == 0{
                                if let totlPrice = orderDetailDictn["totalValues"] as? NSDictionary{
                                    if let promo = totlPrice["promoAmount"] as? String {
                                        if(promo == "0.0" || promo == "0.00"){
                                            return 248.0
                                        }}}
                                return 270.0
                            }else{
                                let productDet = linesArray.objectAtIndex(indexPath.section-1) as? NSDictionary
                                let lineNo = productDet!["customerLineNumber"] as! String
                                let rowData = orderDetailNewDict.valueForKey(lineNo) as! NSArray
                                let currentData = rowData.objectAtIndex(indexPath.row) as! NSDictionary
                                
                                if(currentData["type"] as! String == "PI"){
                                    return 115.0
                                }else if(currentData["type"] as! String == "opt"){
                                    return 50.0
                                }else if(currentData["type"] as! String == "ship"){
                                    return 146.0
                                }else  if(currentData["type"] as! String == "serial"){
                                    return 31.0
                                }
                                else{
                                    return 50.0
                                }
                                //            let productDet = linesArray.objectAtIndex(indexPath.section-1) as? NSDictionary
                                //            //                let serialNumber = productDet!["serialNumber"] as! NSArray
                                //            let searchpredicate = NSPredicate(format: "custLineNumber == %@", productDet!["customerLineNumber"] as! String)
                                //            let arr = shipmentArray.filteredArrayUsingPredicate(searchpredicate) as! NSArray
                                //            if(arr.count > 0){
                                //            if indexPath.row == 0{
                                //            return 115.0
                                //            }else if(indexPath.row == 1){
                                //                return 60.0
                                //            }
                                //            else if(arr.count+2 == indexPath.row){
                                //                
                                //                return 60.0
                                //            }else{
                                //                return 182.0
                                //            }
                                //            }else{
                                //                return 0.0
                                //            }
                            }
                        }
                        
                        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
                            
                            //tableView.deselectRowAtIndexPath(indexPath, animated: true)
                            
                            //   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            // let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("return") as! ReturnBtnViewController
                            //  self.navigationController?.pushViewController(nextViewController, animated: true)
                        }
                        
                        //    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
                        //       
                        //         if(section != 0){
                        //        return 39.0
                        //        }
                        //        return 0.0
                        //    }
                        //    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
                        //        if section != 0{
                        //            if linesArray.count > 0{
                        //                if let productDet = linesArray.objectAtIndex(section-1) as? NSDictionary{
                        //                    if let delivery1 = productDet["delivery"] as? NSArray {
                        //                        if(delivery1.count > 0) {
                        //                            let delivryDict = delivery1.objectAtIndex(0) as! NSDictionary
                        //                            if(delivryDict["showTracking"] as! Bool == false){
                        //                              
                        //                                return 0
                        //                            }else{
                        //                                
                        //                                return 40
                        //                            }
                        //                        }
                        //                    }
                        //                }
                        //            }
                        //        }else{
                        //            return 0
                        //        }
                        //        return 0
                        //    }
                        //    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
                        //        
                        //        if section != 0{
                        //            if linesArray.count > 0{
                        //            if let productDet = linesArray.objectAtIndex(section-1) as? NSDictionary{
                        //                if let delivery1 = productDet["delivery"] as? NSArray {
                        //                    if(delivery1.count > 0) {
                        //                        let delivryDict = delivery1.objectAtIndex(0) as! NSDictionary
                        //                        if(delivryDict["showTracking"] as! Bool == false){
                        //                            let trackbutton = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 0))
                        //                           // trackbutton.backgroundColor = grayLightColor
                        //                            return trackbutton
                        //                        }else{
                        //        let trackbutton = UIButton(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
                        //        trackbutton.backgroundColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                        //        trackbutton.setTitle("Track", forState: .Normal)
                        //        trackbutton.tag = section - 1
                        //        trackbutton.titleLabel?.font = UIFont(name: "MyriadPro-Regular", size: 20.0)
                        //        trackbutton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
                        //        return trackbutton
                        //                        }
                        //                    }
                        //                }
                        //            }
                        //            }
                        //        }else{
                        //            let trackbutton = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 0))
                        //          //  trackbutton.backgroundColor = ligh
                        //            return trackbutton
                        //        }
                        //        let trackbutton = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 0))
                        //       // trackbutton.backgroundColor = grayLightColor
                        //        return trackbutton
                        //    }
                        
                        
                        func buttonAction(sender: UIButton!) {
                            let btn = sender
                            let productDet = linesArray.objectAtIndex(btn.tag) as? NSDictionary
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("track") as! TrackViewController
                            nextViewController.statusStr = productDet!["status"] as! String
                            nextViewController.imgUrlstr = productDet!["imageURL"] as! String
                            if let delivery1 = productDet!["delivery"] as? NSArray {
                                if(delivery1.count > 0){
                                    let delivery = delivery1.objectAtIndex(0)
                                    nextViewController.packageDict = delivery["packageResponse"] as! NSDictionary
                                    
                                }
                            }
                            nextViewController.prodDesc = productDet!["skuDescription"] as! String
                            nextViewController.qntStr = "Qty: \(productDet!["requestedQuantity"] as! Int)"
                            if let totalValues = productDet!["totalValues"] as? NSDictionary{
                                nextViewController.priceStr = "₹ \(totalValues["netAmount"] as! String)"
                            }
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                        }
                       }
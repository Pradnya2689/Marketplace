//
//  ViewReturnViewController.swift
//  MarketPlace
//
//  Created by pradnya on 14/11/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import Alamofire
class ViewReturnViewController: UIViewController {

    @IBOutlet var returnView:UIView!
   
    @IBOutlet weak var prodImg: UIImageView!
    @IBOutlet weak var prodDEscLbl: UILabel!
    @IBOutlet weak var qntLbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var sellerLbl: UILabel!
    @IBOutlet weak var orderNumLbl: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var paymentTypeLbl: UILabel!
    @IBOutlet weak var returnTable: UITableView!
    var orderId:String!=""
    var customerLineNumber:String!=""
    var orderDetailDictn:NSDictionary!=NSDictionary()
    var linesArray:NSMutableArray!=NSMutableArray()
    var orderReturnArray:NSMutableArray!=NSMutableArray()
    @IBOutlet var noInternetVc:UIView!
    @IBOutlet var wifiImg:UIImageView!
    @IBOutlet var noconnetinlbl:UILabel!
    @IBOutlet var retryBtn:UIButton!
    @IBOutlet weak var headerdividerLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         orderReturnArray = NSMutableArray()
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(ViewReturnViewController.getOrderList(_:)),
                                                         name: "viewReturn",
                                                         object: nil)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 25))
        titleLabel.font = UIFont(name: "MyriadPro-Regular", size: 20)
        titleLabel.textColor = headerColor
        titleLabel.text = "Order Return"
        self.navigationItem.titleView = titleLabel
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            self.noInternetVc.hidden = true
            linesArray = NSMutableArray()
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            wsm.viewReturnOrderDEtails(orderId, OrderCofirm: false)
        }else{
          
            self.noInternetVc.hidden = false
            self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
            self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
            self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
            self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
            self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
            self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)
        }
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(ViewReturnViewController.internetReachable(_:)),
                                                         name: "reachable",
                                                         object: nil)
        // Do any additional setup after loading the view.
    }
    func internetReachable(notification:NSNotification){
        noInternetClk()
        print("in category via reachable")
    }
    @IBAction func noInternetClk(){
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            self.noInternetVc.hidden = true
            linesArray = NSMutableArray()
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            wsm.viewReturnOrderDEtails(orderId, OrderCofirm: false)
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
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "viewReturn", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "reachable", object: nil)
    }
    func getOrderList(notification: NSNotification)  {
        print(notification)
        orderReturnArray = NSMutableArray()
        LoadingOverlay.shared.hideOverlayView()
        let dict : AnyObject = notification.userInfo!
        LoadingOverlay.shared.hideOverlayView()
        orderDetailDictn = notification.userInfo!
        paymentTypeLbl.text = "Payment: \(orderDetailDictn["paymentTerms"] as! String)"
        let arry = orderDetailDictn["lines"] as! NSMutableArray
        print("custnumber \(customerLineNumber)")
        for i in 0..<arry.count {
            let productDet = arry.objectAtIndex(i) as? NSDictionary
            print(productDet!["ingramPartNumber"] as! String)
            if(customerLineNumber == productDet!["ingramPartNumber"] as! String){
                linesArray.addObject(productDet!)
            }
        }
          if let customer = orderDetailDictn["customer"] as? NSDictionary{
            sellerLbl.text = "By \(customer["name1"]! as! String)"
        }
        if let productDet = linesArray.objectAtIndex(0) as? NSDictionary{
            
            prodDEscLbl.text = productDet["skuDescription"] as! String
            qntLbl.text = "Qty: \(productDet["requestedQuantity"] as! Int)"
            let totalValues = productDet["totalValues"] as! NSDictionary
            pricelbl.text = "₹ \(totalValues["netAmount"] as! String)"
            
            let image : UIImage = UIImage(named:"placeholder")!
            prodImg.image = image
            let url =  productDet["imageURL"] as! String
            let imgURL: NSURL = NSURL(string: url)!
            print("img url **** \(imgURL.absoluteString)")
            
            if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
            {
                print("IN cache")
                prodImg.image = image
                
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
                            self.prodImg.image = image
                            photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                        }
                        else
                        {
                            let image : UIImage = UIImage(named:"placeholder")!
                            self.prodImg.image = image
                            //photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                        }
                }
            }
            orderDate.text = orderDetailDictn["strOrderDate"] as? String
            orderNumLbl.text = "Order #\(orderId!)"
            if let delivery1 = productDet["strOrderDate"] as? NSString {
                //let delivery = delivery1.objectAtIndex(0)
                
                //cell.inVoiceNoLb.text = delivery["invoiceNumber"] as! String
                //cell.shipmentNoLb.text = delivery["trackingNumber"] as!  String
            }
            if let delivery1 = productDet["orderReturninfo"] as? NSArray {
                print("order cnt \(delivery1)")
                orderReturnArray = delivery1 as? NSMutableArray
               // let delivery = delivery1.objectAtIndex(0)
                //cell.returnStatusLb.text = delivery["returnSOStatus"] as! String
               // cell.returnNumberLb.text = delivery["returnSONumber"] as! String
                // cell.returnOrderNumberLb.text = "Order #\(orderId!)"
                //cell.inVoiceNoLb.text = delivery["invoiceNumber"] as! String
                //cell.shipmentNoLb.text = delivery["trackingNumber"] as!  String
                 returnTable.reloadData()
            }
        }
        
        returnView.hidden = false
        
        print("product cnt \(linesArray.count)")
        print(linesArray)
       
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return orderReturnArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(orderReturnArray.count > 0 ){
            print(section)
            if  let orderDet = orderReturnArray.objectAtIndex(section) as? NSDictionary{
            if  let serialNumber = orderDet["serialNumber"] as? NSArray{
            return serialNumber.count+2
                }
            }else{
                return 0
            }
        }
        return 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        if(orderReturnArray.count > 0){
              let orderDet = orderReturnArray.objectAtIndex(indexPath.section) as? NSDictionary
                 let serialNumber = orderDet!["serialNumber"] as? NSArray
           // let cnt = (serialNumber?.count)! + 2
            if(indexPath.row == 0){
                
                return 117.0
            }else if(indexPath.row == serialNumber!.count+1 ){
                
                return 88.0
            }else{
                
                return 41.0
            }
        }else{
            return 0
        }
        
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let totrow = tableView.numberOfRowsInSection(indexPath.section)
        let orderDet = orderReturnArray.objectAtIndex(indexPath.section) as? NSDictionary
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("returnHeader", forIndexPath: indexPath) as! ViewReturnHeaderCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.returnLbl.text = orderDet!["returnSONumber"] as? String
            cell.returnDate.text = orderDet!["strReturnDate"] as? String
            cell.returnStatus.text = orderDet!["returnSOStatus"] as? String
            return cell
        }else if(indexPath.row == totrow-1){
            let cell = tableView.dequeueReusableCellWithIdentifier("returnFooter", forIndexPath: indexPath) as! ViewReturnFooterCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.returnQnt.text = orderDet!["returnQty"] as? String
            cell.returnValLbl.text = "₹ \(orderDet!["returnAmount"] as! String)"
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("returnCell", forIndexPath: indexPath) as! ViewReturnCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            let serialNumber = orderDet!["serialNumber"] as! NSArray
            let seralData = serialNumber.objectAtIndex(indexPath.row - 1)
            cell.serialLbl.text = "Serial Number. \(indexPath.row)"
            cell.serialNumberLbl.text = String(seralData)
            return cell
        }
        
        
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

}

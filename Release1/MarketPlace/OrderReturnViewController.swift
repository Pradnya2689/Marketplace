//
//  OrderReturnViewController.swift
//  MarketPlace
//
//  Created by Administrator on 23/09/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import Alamofire
class OrderReturnViewController: UIViewController {

    @IBOutlet var orderReturnTable:UITableView!
    @IBOutlet var footerView: UIView!
    @IBOutlet weak var paymentTypeLb: UILabel!
    var orderId:String!=""
   var paymenttype:String!=""
    var customerLineNumber:String!=""
    var orderDetailDictn:NSDictionary!=NSDictionary()
    var linesArray:NSMutableArray!=NSMutableArray()
    @IBOutlet var noInternetVc:UIView!
    @IBOutlet var wifiImg:UIImageView!
    @IBOutlet var noconnetinlbl:UILabel!
    @IBOutlet var retryBtn:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(OrderReturnViewController.getOrderList(_:)),
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
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(OrderReturnViewController.internetReachable(_:)),
                                                         name: "reachable",
                                                         object: nil)
        
       
    }
    func internetReachable(notification:NSNotification){
       noInternetClk()
        //print("in category via reachable")
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
    override func viewWillDisappear(animated: Bool) {
         NSNotificationCenter.defaultCenter().removeObserver(self, name: "viewReturn", object: nil)
         NSNotificationCenter.defaultCenter().removeObserver(self, name: "reachable", object: nil)
    }
    func getOrderList(notification: NSNotification)  {
       // print(notification)
        LoadingOverlay.shared.hideOverlayView()
        let dict : AnyObject = notification.userInfo!
        LoadingOverlay.shared.hideOverlayView()
        orderDetailDictn = notification.userInfo!
        paymentTypeLb.text = orderDetailDictn["paymentTerms"] as? String
        let arry = orderDetailDictn["lines"] as! NSMutableArray
        //print("custnumber \(customerLineNumber)")
       
       // let arry = linesArray.mutableCopy() as! NSMutableArray
      //  linesArray.removeAllObjects()
        for i in 0..<arry.count {
            let productDet = arry.objectAtIndex(i) as? NSDictionary
            // print(productDet!["ingramPartNumber"] as! String)
            if(customerLineNumber == productDet!["ingramPartNumber"] as! String){
                linesArray.addObject(productDet!)
            }
            }
        //let emailTest = NSPredicate(format:"SELF.ingramPartNumber == %@", customerLineNumber)
       // let arry = linesArray.mutableCopy() as! NSArray
       // linesArray.removeAllObjects()
        //arry.filteredArrayUsingPredicate(emailTest)
      //  linesArray = arry.mutableCopy() as! NSMutableArray
//        print("product cnt \(linesArray.count)")
//        print(linesArray)
        orderReturnTable.reloadData()
        
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

extension OrderReturnViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(linesArray.count > 0){
        let productDet = linesArray.objectAtIndex(section) as? NSDictionary
        let serialNumber = productDet!["serialNumber"] as! NSArray
        return serialNumber.count+1
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("returnHeader", forIndexPath: indexPath) as! ReturnCellHeaderTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            if let customer = orderDetailDictn["customer"] as? NSDictionary{
                cell.companyNameLb.text = "By \(customer["name1"]! as! String)"
            }
            if let productDet = linesArray.objectAtIndex(indexPath.section) as? NSDictionary{
                cell.returnNameLabel.text = productDet["skuDescription"] as! String
                cell.returnQtyLb.text = "Qty: \(productDet["requestedQuantity"] as! Int)"
                let totalValues = productDet["totalValues"] as! NSDictionary
                cell.priceLb.text = "₹ \(totalValues["netAmount"] as! String)"
                cell.returnStatusLb.text = productDet["status"] as! String
                
                
                let image : UIImage = UIImage(named:"placeholder")!
                cell.returnImgView.image = image
                let url =  productDet["imageURL"] as! String
                let imgURL: NSURL = NSURL(string: url)!
                //print("img url **** \(imgURL.absoluteString)")
                
                if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
                {
                   // print("IN cache")
                    cell.returnImgView!.image = image
                    
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
                               // print(imgURL.absoluteString)
                                cell.returnImgView!.image = image
                                photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                            }
                            else
                            {
                                let image : UIImage = UIImage(named:"placeholder")!
                                cell.returnImgView!.image = image
                                //photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                            }
                    }
                }
                if let delivery1 = productDet["delivery"] as? NSArray {
                    let delivery = delivery1.objectAtIndex(0)
                    cell.dateLbReturn.text = delivery["strPODDate"] as! String
                    cell.returnOrderNumberLb.text = "Order #\(orderId!)"
                    //cell.inVoiceNoLb.text = delivery["invoiceNumber"] as! String
                    //cell.shipmentNoLb.text = delivery["trackingNumber"] as!  String
                }
                if let delivery1 = productDet["orderReturninfo"] as? NSArray {
                    let delivery = delivery1.objectAtIndex(0)
                    cell.returnStatusLb.text = delivery["returnSOStatus"] as! String
                    cell.returnNumberLb.text = delivery["returnSONumber"] as! String
                   // cell.returnOrderNumberLb.text = "Order #\(orderId!)"
                    //cell.inVoiceNoLb.text = delivery["invoiceNumber"] as! String
                    //cell.shipmentNoLb.text = delivery["trackingNumber"] as!  String
                }
                
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("serialId", forIndexPath: indexPath) as! SerialdetailsTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            let productDet = linesArray.objectAtIndex(indexPath.section) as? NSDictionary
            let serialNumber = productDet!["serialNumber"] as! NSArray
            let seralData = serialNumber.objectAtIndex(indexPath.row - 1)
            cell.serialNoLb.text = "Serial No. \(indexPath.row)"
             cell.serialValueLb.text = seralData["serialNumber"] as! String
            return cell
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 204.0
        }else{
            return 39.0
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       
            return footerView
       
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
         if(linesArray.count > 0){
        return 39.0
        }
        return 0.0
    }
}

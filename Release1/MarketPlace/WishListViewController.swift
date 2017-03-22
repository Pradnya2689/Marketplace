//
//  WishListViewController.swift
//  MarketPlace
//
//  Created by pradnya on 31/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import ObjectMapper
import AlamofireImage
import Alamofire
class WishListViewController: UIViewController,webServiceDelegate,wishListDelegate{
    @IBOutlet var myWishlistTable:UITableView!
    @IBOutlet var noInternetVc:UIView!
    @IBOutlet var wifiImg:UIImageView!
    @IBOutlet var noconnetinlbl:UILabel!
    @IBOutlet var retryBtn:UIButton!
    var wishListArray:NSMutableArray!
    @IBOutlet var noResultVc:UIView!
    @IBOutlet var noResultImg:UIImageView!
    @IBOutlet var noResultLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        self.title = "My Wishlist"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName : headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
       
    }
    override func viewWillAppear(animated: Bool) {
       // LoadingOverlay.shared.showOverlay(window)
        // let window :UIWindow = UIApplication.sharedApplication().keyWindow!
        // LoadingOverlay.shared.showOverlay(window)
         self.noResultVc.hidden = true
         wishListArray = NSMutableArray()
        myWishlistTable.reloadData()
         self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(WishListViewController.getWishListSucces(_:)),
                                                         name: "wishlistDetails",
                                                         object: nil)
      let  appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            self.noInternetVc.hidden = true
            
            dispatch_async(dispatch_get_main_queue())
            {
                let window :UIWindow = UIApplication.sharedApplication().keyWindow!
                LoadingOverlay.shared.showOverlay(window)
            }
            

// LoadingOverlay.shared.showOverlay(view)
        
        let wsm : WebServiceClass = WebServiceClass.sharedInstance
        wsm.delegates=self
        wsm.getWishListDetailsOfUser()
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
                                                         selector:#selector(WishListViewController.internetReachable(_:)),
                                                         name: "reachable",
                                                         object: nil)
       
    }
    func internetReachable(notification:NSNotification){
        noInternetClk()
        //print("in category via reachable")
    }
     @IBAction func noInternetClk(){
         wishListArray = NSMutableArray()
        let  appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            self.noInternetVc.hidden = true
            let window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
            wsm.getWishListDetailsOfUser()
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Price
        return self.wishListArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = myWishlistTable.dequeueReusableCellWithIdentifier("mywishlist", forIndexPath: indexPath) as! WishListCell
         let prodt  = self.wishListArray.objectAtIndex(indexPath.row) as! LstProducts
        cell.prodTitleLabel.text = prodt.description
        if let np = prodt.netPriceDisplayString{
            if(np == "Price Not Available"){
                cell.prodPriceLabel.text =  "\(prodt.netPriceDisplayString!)"
            }else{
                 cell.prodPriceLabel.text =  "₹ \(prodt.netPriceDisplayString!)"
            }
       
        }else{
            cell.prodPriceLabel.text = "Price Not Available"
        }
        cell.discountLabl.hidden = true
        cell.selectionStyle = .None
        cell.delegates=self
        cell.skunumber = prodt.sku!
        let url =  prodt.imageURLHigh
        let imgURL: NSURL = NSURL(string: url!)!
      //  print(imgURL.absoluteString)
        
        if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
        {
           // print("IN cache")
            cell.productImg.image = image
            
        }
        else
        {
            Alamofire.request(.GET, imgURL)
                .responseImage { response in
                    debugPrint(response)
                    
                   // print(response.request)
                    //print(response.response)
                    debugPrint(response.result)
                    
                    
                    
                    
                    if let image = response.result.value {
                      //  print(imgURL.absoluteString)
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //sortIds=0&filterAppliedLast=sort
        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("prodDet") as! ViewController
        let prodt  = self.wishListArray.objectAtIndex(indexPath.row) as! LstProducts
        let trimmedString = prodt.sku!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let replaced = trimmedString.stringByReplacingOccurrencesOfString(" ", withString: "")
        secondViewController.skuNumber = replaced
        secondViewController.ratingfloat = 0
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }

    
    func getWishListSucces(notification:NSNotification){
        let wishList : AnyObject = notification.userInfo!
       
        wishLstGlobalArray.removeAllObjects()
        self.wishListArray.removeAllObjects()
        if let COD : AnyObject  = wishList["product"]
        {
           // print(COD)
            
            if let customer : Array<LstProducts> = Mapper<LstProducts>().mapArray(COD["lstProducts"])! {
          //  if let customer = COD["lstProducts"]{
            for prodt in customer
            {
                wishLstGlobalArray.addObject(prodt.sku!)
                self.wishListArray .addObject(prodt)
//                print("testing   \(prodt)")
//                print("testing2")
                
            }
            }
        }
       LoadingOverlay.shared.hideOverlayView()
        if(wishLstGlobalArray.count > 0){
            self.noResultVc.hidden = true
            self.noResultLabel.hidden = true
        }else{
            
            self.noResultVc.hidden = false
            
            self.noResultLabel.hidden = false
            self.noResultImg.translatesAutoresizingMaskIntoConstraints = true
           // self.noResultVc.translatesAutoresizingMaskIntoConstraints = true
            self.noResultLabel.translatesAutoresizingMaskIntoConstraints = true
            self.noResultImg.frame = CGRectMake((screenSize.width - 120 )/2, 150, 120, 120)
            self.noResultLabel.frame = CGRectMake((screenSize.width - 248 )/2, 330, 248, 21)
           // self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)
        }
        
//        }
       
        myWishlistTable.reloadData()
    }
    func mycartDelegateFunction(sku:String){
         var window :UIWindow = UIApplication.sharedApplication().keyWindow!
        // JHProgressHUD.sharedHUD.showInView(window)
        LoadingOverlay.shared.showOverlay(window)
        wishLstGlobalArray.removeObject(sku)
        //print(wishLstGlobalArray)
        
        let alldta = wishLstGlobalArray.componentsJoinedByString(",") as NSString
        // JHProgressHUD.sharedHUD.showInView(self.view)
        let wsm : WebServiceClass = WebServiceClass.sharedInstance
        wsm.delegates=self
        wsm.addToWishListDetails(alldta)
    }
    func addWishListSuccess(wishList:NSDictionary){
         //JHProgressHUD.sharedHUD.hide()
        //print("wishData   \(wishList.valueForKey("wishData"))")
        wishListArray = NSMutableArray()
        // Do any additional setup after loading the view.
        let wsm : WebServiceClass = WebServiceClass.sharedInstance
        wsm.delegates=self
         var window :UIWindow = UIApplication.sharedApplication().keyWindow!
       // JHProgressHUD.sharedHUD.showInView(window)
        LoadingOverlay.shared.showOverlay(window)
        wsm.getWishListDetailsOfUser()

       
    }
    override func viewWillDisappear(animated: Bool) {
        LoadingOverlay.shared.hideOverlayView()
        let wsm : WebServiceClass = WebServiceClass.sharedInstance
        wsm.delegates=nil
         NSNotificationCenter.defaultCenter().removeObserver(self, name: "wishlistDetails", object: nil)
        
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

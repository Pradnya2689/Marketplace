//
//  AccountViewController.swift
//  MarketPlace
//
//  Created by inpanr07 on 29/06/16.
//  Copyright (c) 2016 inpanr07. All rights reserved.
//

import UIKit

var arrayCountries : NSMutableArray! = NSMutableArray()
var arrayState : NSMutableArray! = NSMutableArray()
class AccountViewController: UIViewController,UINavigationControllerDelegate,webServiceDelegate {
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var mailBtn: UIButton!
 
    @IBOutlet weak var faqBtn: UIButton!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var legalBtn: UIButton!
    
    @IBOutlet weak var accountTableView: UITableView!
    @IBOutlet var profileFooter: UIView!
    
    @IBOutlet weak var profileHeader: UIView!
    @IBOutlet var NameLbl: UILabel!
    @IBOutlet var emailLbl: UILabel!
    //let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginView") as! LoginView
    // var arrayCountries : NSMutableArray = NSMutableArray()
    
//    var labels = ["My Profile", "My Location", "My Orders", "Wishlist", "Notification", "Logout"]
//     var labels1 = ["My Profile", "My Location", "My Orders", "Wishlist", "Notification", "Login"]
      var labels = ["My Profile", "My Location", "My Orders", "My Wishlist", "Logout"]
      var labels1 = ["My Profile", "My Location", "My Orders", "My Wishlist", "My Wishlist1",  "Login"]
    
    
    var photo = [UIImage(named: "user"), UIImage(named: "location"), UIImage(named: "order"), UIImage(named: "wishlist"), UIImage(named: "notification"), UIImage(named: "logout")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.accountTableView.delegate = self
        self.title = "My Account"
//        self.profileHeader.hidden = true
//         self.accountTableView.hidden = true
       
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: "country", object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AccountViewController.countryList(_:)), name: "country", object: nil)
       
        
       
       
        
        let items = self.tabBarController?.tabBar.items
        let tabItem = items![3]
        tabItem.title = ""
        
       
        self.navigationItem.backBarButtonItem = nil
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName : headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
        
        profileImg.layer.cornerRadius = 30.0
        profileImg.clipsToBounds = true
        self.navigationController?.delegate = self
        

        accountTableView.contentInset = UIEdgeInsetsMake(0, 0, 51, 0);

        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(AccountViewController.StateApiResponsee(_:)),
                                                         name: "stateResp",
                                                         object: nil)
        
        if  let usernm = defaults.valueForKey("stateName"){
        let indx : NSIndexPath = NSIndexPath(forRow: 1, inSection: 0)
        let cell = accountTableView.cellForRowAtIndexPath(indx) as! AccountCell
        cell.locaationLabel.text =   usernm as? String
        }
       
        
        mailBtn.translatesAutoresizingMaskIntoConstraints = true
        mailBtn.frame = CGRectMake((screenWidth-85), 10, 30, 30)
        
        phoneBtn.translatesAutoresizingMaskIntoConstraints = true
        phoneBtn.frame = CGRectMake((screenWidth-38), 10, 30, 30)
        
        faqBtn.translatesAutoresizingMaskIntoConstraints = true
        faqBtn.frame = CGRectMake(8, 15, 35, 20)
        
        label1.translatesAutoresizingMaskIntoConstraints = true
        label1.frame = CGRectMake(53, 18, 1, 14)
        
        termsBtn.translatesAutoresizingMaskIntoConstraints = true
        termsBtn.frame = CGRectMake(64, 15, 80, 20)
        
        label2.translatesAutoresizingMaskIntoConstraints = true
        label2.frame = CGRectMake(154, 18, 1, 14)
        
        legalBtn.translatesAutoresizingMaskIntoConstraints = true
        legalBtn.frame = CGRectMake(165, 15, 43, 20)


   }
    
    @IBAction func mailBtnAction(sender: AnyObject) {
        let email = "support@imol.tech"
        let url = NSURL(string: "mailto:\(email)")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    @IBAction func callAction(sender: AnyObject) {
        let phone = "+912230561149"
        if let url = NSURL(string: "tel://\(phone)") {
            UIApplication.sharedApplication().openURL(url)
    }
    }
    
    @IBAction func faqAction(sender: AnyObject) {
        let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("faq") as? FAQViewController
       self.navigationController?.pushViewController(AccountSettingObj!, animated: true)
    }
    @IBAction func tcAction(sender: AnyObject) {
        let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("termsncond") as? TermsConditionViewController
        self.navigationController?.pushViewController(AccountSettingObj!, animated: true)
    }
    
    @IBAction func legalAction(sender: AnyObject) {
        let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("legal") as? LegalViewController
        self.navigationController?.pushViewController(AccountSettingObj!, animated: true)
    }

    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: "  ", style: .Plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
    
    override func viewWillAppear(animated: Bool) {
       // self.navigationController?.navigationItem.hidesBackButton = true
//        for subview in self.view.subviews {
//            if subview .isKindOfClass(LoadingOverlay)  {
//               subview.removeFromSuperview()
//              }
//        }

       // LoadingOverlay.shared.hideOverlayView()
        accountTableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
        let wsm : WebServiceClass = WebServiceClass.sharedInstance
        wsm.callstateApii()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let data = defaults.objectForKey("LoginObject") as? NSData
        {
              self.emailLbl.text = defaults.valueForKey("email")! as! String
            self.NameLbl.text = "\(defaults.valueForKey("firstName")! as! String)  \(defaults.valueForKey("lastName")! as! String)"
            
        }
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "loginsuccesful", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AccountViewController.loginsuccesfull(_:)), name: "loginsuccesful", object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "basketDetailsLoginPage", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(AccountViewController.badgecountResponse(_:)),
                                                         name: "basketDetailsLoginPage",
                                                         object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "country", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AccountViewController.countryList(_:)), name: "country", object: nil)
        
        self.tabBarController?.tabBar.hidden = false
         self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        
        self.navigationItem.leftBarButtonItem=nil;
        self.navigationItem.hidesBackButton=true;
       // let defaults = NSUserDefaults.standardUserDefaults()
        if let data = defaults.objectForKey("badge") as? String
        {
            let tabArray = self.tabBarController?.tabBar.items as NSArray!
            let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
            tabItem.badgeValue = data
            if(tabItem.badgeValue == "0" || tabItem.badgeValue == ""){
                tabItem.badgeValue = nil
                
            }
            
        }
    
        if let usernm = defaults.valueForKey("email") , let pwd = defaults.valueForKey("password"),let fullname = defaults.valueForKey("fullname")
        {
            self.accountTableView.hidden = false
            self.accountTableView.reloadData()
            controller.removeFromParentViewController()
            controller.view.removeFromSuperview()
            self.view.bringSubviewToFront(accountTableView)

            
        }
        else
        {
            
           
            self.accountTableView.hidden = true
            
            for view in self.view.subviews
            {
                if let noticeSubView = view as? LoginView {
                    // Subview exists
                    controller.removeFromParentViewController()
                    controller.view.removeFromSuperview()
                }
            }
         
               self.addChildViewController(controller)
            controller.didMoveToParentViewController(self)
           
            self.view.addSubview(controller.view)
            controller.scroll1.scrollEnabled = true
            controller.scroll1.contentInset = UIEdgeInsetsZero
            controller.scroll1.scrollIndicatorInsets = UIEdgeInsetsZero
            let contentInsets = UIEdgeInsetsMake(0, 0, 250, 0)
            
            controller.scroll1.contentInset = contentInsets
            
            controller.scroll1.scrollIndicatorInsets = contentInsets
            
        
        }
        
        self.navigationItem.leftBarButtonItem=nil;
        self.navigationItem.hidesBackButton=true;
    
    }
    
    func badgecountResponse(notification: NSNotification){
       // print(notification.userInfo)
        let string : AnyObject = notification.userInfo!
        var cartCnt : NSMutableArray! = NSMutableArray()
        if let bastetcartarry = string.valueForKey("lstBasket") as? NSArray{
            
            for forecast in bastetcartarry
            {
                // var lst:lstBasket = forecast as! lstBasket
                cartCnt.addObject(forecast)
                
            }
           // print(String(bastetcartarry.count))
            let tabArray = self.tabBarController?.tabBar.items as NSArray!
            let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
            tabItem.badgeValue = String(bastetcartarry.count)
            if(tabItem.badgeValue == "0" || tabItem.badgeValue == ""){
                tabItem.badgeValue = nil
            }
         //  view.subviews.forEach { LoadingOverlayremoveFromSuperview() }
            
            LoadingOverlay.shared.hideOverlayView()

           // print(bastetcartarry.count)
            
        }
        
    }
    override func viewDidDisappear(animated: Bool) {
      //self.navigationItem.title = ""
         NSNotificationCenter.defaultCenter().removeObserver(self, name: "loginsuccesful", object: nil)
          //NSNotificationCenter.defaultCenter().removeObserver(self, name: "country", object: nil)
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
    func StateApiResponsee(notification: NSNotification)  {
//        LoadingOverlay.shared.hideOverlayView()
//        let dict : AnyObject = notification.userInfo!
//        let countryArr = dict["state"] as! NSArray
//        //let country = Country!()
//        
//        //
//        for country  in countryArr
//        {
//            arrayCountries.addObject(country)
//        }
//        
//        
//        
        
        //        print(obj.stateCode)
        //        print(obj.stateId)
        
    }
    
    func  StateApiFailedDelegate(string:String)
    {
        print(string)
        
    }
    
    func loginsuccesfull(notification: NSNotification)
    {
        
        // print("login successfull")
        if let usernm = defaults.valueForKey("email") , let pwd = defaults.valueForKey("password"),let fullname = defaults.valueForKey("fullname")
        {
        self.emailLbl.text = usernm as! String
        self.NameLbl.text = fullname as! String
        }
        self.accountTableView.hidden = false
        accountTableView.reloadData()
        controller.removeFromParentViewController()
        controller.view.removeFromSuperview()
        let wsm : WebServiceClass = WebServiceClass.sharedInstance
        wsm.callstateApii()
        self.view.bringSubviewToFront(accountTableView)
        
    }

    func countryList(notification: NSNotification)
    {
        LoadingOverlay.shared.hideOverlayView()
        let dict : AnyObject = notification.userInfo!
         let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("FirstVC") as! FirstViewController
        // let receivednumber : String = dict["valueToPass"] as! String
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Location")
        AccountSettingObj.Location = []
        let receivednumber1  = dict["valueToPass"] as! NSDictionary
        
        if let add = receivednumber1["stateName"]
        {
            Globalstate = add as! NSString
             let indx : NSIndexPath = NSIndexPath(forRow: 1, inSection: 0)
            let cell = accountTableView.cellForRowAtIndexPath(indx) as! AccountCell
           // cell.locaationLabel.text =   add as! String
            cell.locaationLabel.text =   Globalstate as String
            
           
            
                
               // Globalstateid = stid as! NSString
             AccountSettingObj.Location += [add as! String]
            
           // print(AccountSettingObj.Location)
//             authorizationWithLogin1 = "Mobilestg1456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(receivednumber1["stateId"]!)"
//             authorizationWithLogin = "Mobilestg2456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(receivednumber1["stateId"]!)"
            
            //Prod
          /*  var authorizationWithLogin:String = "Mobileprod456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(receivednumber1["stateId"]!)"
            var authorizationWithLogin1:String = "Mobileprod456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(receivednumber1["stateId"]!)"*/
           
            
        //    self.tabBarController?.selectedIndex = 0
           
          //  self.stateTF.text = add as! String
            // self.tableArr.addObject(add!)
        }
        if let STAid = receivednumber1["stateId"]
        {
            Globalstateid = STAid as! NSString
            
            AccountSettingObj.Location +=  [STAid as! String]
            
            
            
            if let returnValue = NSUserDefaults.standardUserDefaults().objectForKey("Location") as? [String]{
                
                statename = returnValue[0]
                stateid = returnValue[1]
                authorizationWithoutLogin = "Mobileprod456~~~~~\(stateid)"
                
                let defaults = NSUserDefaults.standardUserDefaults()
                if  let data = defaults.objectForKey("LoginObject") as? NSData{
                    let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                    // let returnValue = NSUserDefaults.standardUserDefaults().objectForKey("Location") as? [String]
                    //var authorizationWithLogin:String = "Mobilestg2456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(stateid)"
                    //var authorizationWithLogin1:String = "Mobilestg1456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(stateid)"
                    
                    //Prod
                    authorizationWithLogin = "Mobileprod456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(stateid)"
                    authorizationWithLogin1 = "Mobileprod456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(stateid)"
                }
            }else{
                authorizationWithLogin = "Mobileprod456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(stateid)"
            }
            NSNotificationCenter.defaultCenter().postNotificationName("stateChange1", object: nil, userInfo: nil )
        }
       
        //        self.stateTF.text = receivednumber
        //        print(receivednumber)
        
        accountTableView.reloadData()
    }
}

extension AccountViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return profileHeader
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return profileFooter
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 170.0
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.labels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("accountId", forIndexPath: indexPath) as! AccountCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        if indexPath.row > 5
        {
       // cell.cellPhoto.image = photo[indexPath.row]
        }
        else
        {
        cell.cellPhoto.image = photo[indexPath.row]
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("email") , let pwd = defaults.valueForKey("password"),let fullname = defaults.valueForKey("fullname")
        {
            cell.accountLabel.text = labels[indexPath.row]
        }
        else
        {
            cell.accountLabel.text = labels1[indexPath.row]
            
        }

        // cell.preservesSuperviewLayoutMargins = false;
        cell.layoutMargins = UIEdgeInsetsZero
        
        if indexPath.row == 1
        {
//             if  let usernm = defaults.valueForKey("Location") as? NSArray{
            if  let usernm = defaults.valueForKey("Location") as? NSArray{
              
                //rishikesh edit 
                if usernm.count > 0
                {
                let staten = usernm[0]
                cell.locaationLabel.text = staten as! String
                }
              
             }else{
                cell.locaationLabel.text = "MAHARASHTRA"
            }
            cell.locaationLabel.hidden = false
            return cell
        }
        else
        {
            cell.locaationLabel.hidden = true
            return cell
        }
        
    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
     {
       // let cell = tableView.cellForRowAtIndexPath(indexPath)!.tag
        
          let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as! AccountCell!
        if (indexPath?.row == 0)
        {
             let defaults = NSUserDefaults.standardUserDefaults()
           if let userId = defaults.objectForKey("userId") as? Int
            {
                let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("AsettingView") as? AccountSettingView
                // let NavigationController = UINavigationController(rootViewController: AccountSettingObj!)
                //   self.presentViewController(NavigationController, animated: true, completion: nil)
                self.navigationController?.pushViewController(AccountSettingObj!, animated: true)
               
                
            }else{
            let LoginViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("LoginView") as? LoginView
            let NavigationController = UINavigationController(rootViewController: LoginViewControllerObj!)
            tableView.deselectRowAtIndexPath(indexPath!, animated: false)
            self.presentViewController(NavigationController, animated: true, completion: nil)
            }
        }
        if (indexPath?.row == 3)
        {
            let defaults = NSUserDefaults.standardUserDefaults()
            if let userId = defaults.objectForKey("userId") as? Int
            {
                let wishList = self.storyboard?.instantiateViewControllerWithIdentifier("wishListVC") as? WishListViewController
                // let NavigationController = UINavigationController(rootViewController: AccountSettingObj!)
                //   self.presentViewController(NavigationController, animated: true, completion: nil)
                self.navigationController?.pushViewController(wishList!, animated: true)
                
                
            }else{
                let LoginViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("LoginView") as? LoginView
                let NavigationController = UINavigationController(rootViewController: LoginViewControllerObj!)
                tableView.deselectRowAtIndexPath(indexPath!, animated: false)
                self.presentViewController(NavigationController, animated: true, completion: nil)
            }
           
        }
        //myorders
        if(indexPath?.row == 2)
        {
            let defaults = NSUserDefaults.standardUserDefaults()
            if let userId = defaults.objectForKey("userId") as? Int
            {
                let wishList = self.storyboard?.instantiateViewControllerWithIdentifier("myorders") as? OrderViewController
                wishList?.isCalledFrom = "account" 
                self.navigationController?.pushViewController(wishList!, animated: true)
                
                
            }else{
                let LoginViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("LoginView") as? LoginView
                let NavigationController = UINavigationController(rootViewController: LoginViewControllerObj!)
                tableView.deselectRowAtIndexPath(indexPath!, animated: false)
                self.presentViewController(NavigationController, animated: true, completion: nil)
            }
        }
        if(indexPath?.row == 1)
        {
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
               LoadingOverlay.shared.showOverlay(window)
            let SearchAddressControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("SearchAddress") as? SearchAddressController
            SearchAddressControllerObj?.countryToPass = (arrayCountries as? NSMutableArray)!
            SearchAddressControllerObj?.flagset = "country"
            
            let NavigationController = UINavigationController(rootViewController: SearchAddressControllerObj!)
            tableView.deselectRowAtIndexPath(indexPath!, animated: false)
            self.presentViewController(NavigationController, animated: true, completion: nil)
          LoadingOverlay.shared.hideOverlayView()
        
        }
        if(indexPath?.row == 5)
        {
          //  let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("privacyVC") as? PrivacyPolicyViewController
         let TermsConditions = self.storyboard?.instantiateViewControllerWithIdentifier("termsncond") as? TermsConditionViewController
          self.navigationController?.pushViewController(TermsConditions!, animated: true)
        }
        if(indexPath?.row == 6)
        {
            let TermsConditions = self.storyboard?.instantiateViewControllerWithIdentifier("termsncond") as? TermsConditionViewController
            self.navigationController?.pushViewController(TermsConditions!, animated: true)
        }
        if (currentCell.accountLabel.text == "Login")
        {
            
//            let LoginViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("LoginView") as? LoginView
//           let NavigationController = UINavigationController(rootViewController: LoginViewControllerObj!)
//            tableView.deselectRowAtIndexPath(indexPath!, animated: false)
//             self.presentViewController(NavigationController, animated: true, completion: nil)
        
        }
        else if (currentCell.accountLabel.text == "Logout")
        {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.removeObjectForKey("email")
            defaults.removeObjectForKey("password")
             defaults.removeObjectForKey("fullname")
            defaults.removeObjectForKey("userId")
            defaults.removeObjectForKey("LoginObject")
            defaults.removeObjectForKey("firstName")
             defaults.removeObjectForKey("badge")
            //badge
            let tabArray = self.tabBarController?.tabBar.items as NSArray!
            let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
            tabItem.badgeValue = nil
            wishLstGlobalArray.removeAllObjects()
            //userId
            self.emailLbl.text = " "
            self.NameLbl.text = "Guest"
            let alert = UIAlertController(title: "", message: ConstantsFile.logout_msg, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            self.accountTableView.hidden = true
             self.accountTableView.reloadData()
            for view in self.view.subviews {
                if let noticeSubView = view as? LoginView {
                    // Subview exists
                    controller.removeFromParentViewController()
                }
            }
            controller.view.translatesAutoresizingMaskIntoConstraints = true
            controller.emailTextField.text = ""
            controller.pwdtextField.text = ""
            self.addChildViewController(controller)
            controller.view.frame = CGRectMake(0, 0, screenWidth, screenHeight)
     
            controller.scroll1.contentInset = UIEdgeInsetsZero
            controller.scroll1.scrollIndicatorInsets = UIEdgeInsetsZero
            let contentInsets = UIEdgeInsetsMake(0, 0, 250, 0)
            controller.scroll1.contentInset = contentInsets
            controller.scroll1.scrollIndicatorInsets = contentInsets
            view.addSubview(controller.view)
            controller.didMoveToParentViewController(self)
            
        
        }
    }
    
}


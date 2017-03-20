//
//  LoginView.swift
//  MarketPlace
//
//  Created by inpanr07 on 11/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import Alamofire

class LoginView: UIViewController,UITextFieldDelegate,webServiceDelegate,UIGestureRecognizerDelegate
{
        
    @IBOutlet var NameText: UITextField!
    @IBOutlet var scroll1: UIScrollView!
//    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var pwdtextField: UITextField!
    var appdelegate:AppDelegate!
    
    @IBOutlet weak var registerBtn: UIButton!
    var isCalledFrm:String!=""

    @IBOutlet weak var label2OuletLogin: UILabel!
    @IBOutlet weak var label1OutletLogin: UILabel!
    @IBOutlet weak var termsBtnOutlet: UIButton!
    @IBOutlet weak var legalBtnOutlet: UIButton!
    @IBOutlet weak var faqOutlet: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        self.emailTextField.delegate = self
        self.pwdtextField.delegate = self
      // self.navigationItem.hidesBackButton = true
//        self.title = " ";
        self.title = "Login";
//        self.emailTextField.text = "rishikesh.pange@ingrammicro.com"
//        self.pwdtextField.text = "ingram1234"
//                self.emailTextField.text = "krutika.pai@ingrammicro.com"
//                self.pwdtextField.text = "ingram"
//        self.emailTextField.text = "jesukaran.sachin@gmail.com"
//        self.pwdtextField.text = "P@ss1234"
        
//      self.emailTextField.text = "sandhya.chotrani@ingrammicro.com"
//        self.pwdtextField.text = "Test@1234"
     
        
//        self.emailTextField.text = "pradnya.dongre@ingrammicro.com"
//        self.pwdtextField.text = "admin123"
        
//        self.emailTextField.text = "vedashree.halarnkar@ingrammicro.com"
//        self.pwdtextField.text = "ingram123"

        
//        self.emailTextField.text = "hvedashree@gmail.com"
//        self.pwdtextField.text = "ingram"

        
//        self.emailTextField.text = "rishikeshpange03@gmail.com"
//        self.pwdtextField.text = "test12345"

       // self.navigationItem.backBarButtonItem = nil
        
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "back", style: .Plain, target: nil, action: nil)
//        self.navigationItem.setHidesBackButton(true, animated:true);
        
//      self.navigationItem.setHidesBackButton(true, animated:true);
//        navigationItem.backBarButtonItem?.tintColor = UIColor.clearColor()
       // navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
       //self.navigationItem.leftBarButtonItem = nil
       // self.navigationItem.hidesBackButton = true
//      //  self.navigationItem.leftBarButtonItem?.title = "Login";
//        self.navigationItem.backBarButtonItem = nil;
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
        

       var b = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action:"cancelClicked")
        //leftBarButton.title = "Cancel"
       // rightBarButton.customView = btnName
      self.navigationItem.leftBarButtonItem = b
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginView.handleTap(_:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        let text = "Register"
        let titleString = NSMutableAttributedString(string: text)
      //  let range2 = (titleString as NSString).rangeOfString(text)
        
        titleString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(0, text.characters.count))
        titleString.addAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 17)!], range:NSMakeRange(0, text.characters.count))
        titleString.addAttribute(NSForegroundColorAttributeName, value: UIColor (red: 30/255.0, green: 74/255.0, blue: 154/255.0, alpha: 1.0) , range: NSMakeRange(0, text.characters.count))
        print(titleString)
        registerBtn.setAttributedTitle(titleString, forState: .Normal)

//        termsBtnOutlet.translatesAutoresizingMaskIntoConstraints = true
//        termsBtnOutlet.frame = CGRectMake(58, 524, 100, 20)
//        
//        legalBtnOutlet.translatesAutoresizingMaskIntoConstraints = true
//        legalBtnOutlet.frame = CGRectMake(175, 523, 35, 20)
//        
//        faqOutlet.translatesAutoresizingMaskIntoConstraints = true
//        faqOutlet.frame = CGRectMake(227, 523, 35, 20)
//
//        label1OutletLogin.translatesAutoresizingMaskIntoConstraints = true
//        label1OutletLogin.frame = CGRectMake(166, 526, 1, 14)
//
//        label2OuletLogin.translatesAutoresizingMaskIntoConstraints = true
//        label2OuletLogin.frame = CGRectMake(218, 526, 1, 14)

    }

    func handleTap(sender: UITapGestureRecognizer? = nil){
        emailTextField.resignFirstResponder()
        pwdtextField.resignFirstResponder()
    }
    
    @IBAction func faqClk(sender: AnyObject) {
        let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("faq") as? FAQViewController
        // let NavigationController = UINavigationController(rootViewController: AccountSettingObj!)
        //   self.presentViewController(NavigationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(AccountSettingObj!, animated: true)
    }
    @IBAction func termsClk(){
        //termsncond
        let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("termsncond") as? TermsConditionViewController
        // let NavigationController = UINavigationController(rootViewController: AccountSettingObj!)
        //   self.presentViewController(NavigationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(AccountSettingObj!, animated: true)
    }
    @IBAction func privacyClk(){
//        //termsncond
//        let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("legal") as? LegalViewController
//         let NavigationController = UINavigationController(rootViewController: AccountSettingObj!)
//           self.presentViewController(NavigationController, animated: true, completion: nil)
//      //  self.navigationController?.pushViewController(AccountSettingObj!, animated: true)
        
        let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("legal") as? LegalViewController
        // let NavigationController = UINavigationController(rootViewController: AccountSettingObj!)
        //   self.presentViewController(NavigationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(AccountSettingObj!, animated: true)

    }
    override func viewWillAppear(animated: Bool) {
        self.title = "Login";

//    if(self.isCalledFrm != "buynow" && self.isCalledFrm != "buynowreseller")
//        {
//     self.tabBarController?.navigationItem.hidesBackButton = true
//        }
        
        registerKeyboardNotifications()
         self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "proceedTochk", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(LoginView.buynowSendToServer(_:)),
                                                         name:"proceedTochk",
                                                         object: nil)
        //NSNotificationCenter.defaultCenter().removeObserver(self, name: "basketDetailsLoginPage", object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self,
//                                                         selector:#selector(LoginView.badgecountResponse(_:)),
//                                                         name: "basketDetailsLoginPage",
//                                                         object: nil)
    }
    

    func buynowSendToServer(notification:NSNotification){
        LoadingOverlay.shared.hideOverlayView()
      //  NSNotificationCenter.defaultCenter().postNotificationName("loginsuccesful", object: nil, userInfo: nil )
        var dictn = notification.userInfo
        if(self.isCalledFrm != "buynow" && self.isCalledFrm != "buynowreseller"){
             self.tabBarController?.navigationItem.hidesBackButton = true
            NSNotificationCenter.defaultCenter().postNotificationName("loginsuccesful", object: nil, userInfo: nil )
        }
        
        if(self.isCalledFrm == "buynowreseller"){
            NSNotificationCenter.defaultCenter().postNotificationName("buylocalreseller", object: nil, userInfo: dictn! as [NSObject : AnyObject] )
        }
        self.dismissViewControllerAnimated(true, completion:  {
            
            if(self.isCalledFrm == "buynow"){
                NSNotificationCenter.defaultCenter().postNotificationName("buylocal", object: nil, userInfo: dictn! as [NSObject : AnyObject] )
            }
            
            
        })
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyboardNotifications()
        self.title = ""
    }
    
    func cancelClicked() {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
        let contentInsets = UIEdgeInsetsMake(0, 0, 310, 0)
        self.scroll1.contentInset = contentInsets
        self.scroll1.scrollIndicatorInsets = contentInsets
        
        var viewRect = view.frame
        viewRect.size.height -= keyboardSize.height
        
          }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
        return true
    }
    func keyboardWillHide(notification: NSNotification) {
        self.scroll1.contentInset = UIEdgeInsetsZero
        self.scroll1.scrollIndicatorInsets = UIEdgeInsetsZero
        let contentInsets = UIEdgeInsetsMake(0, 0, 200, 0)
        self.scroll1.contentInset = contentInsets
        self.scroll1.scrollIndicatorInsets = contentInsets
    }
     @IBAction func SignIn(sender: AnyObject)
    {
        
       if(self.isValidEmail(self.emailTextField.text!))
       {
        if(!(self.pwdtextField.text?.isEmpty)!)
        {
        if (appdelegate.isReachable == true) {
            
            
          
          //  JHProgressHUD.sharedHUD.showInView(self.view)
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            
        let headers = [
            "Authorization" : authorizationWithoutLogin,
            "Content-Type ": "application/json"
        ]
        
      // appdelegate.stopNotifier()
        
        let email : String = self.emailTextField.text!
        let pwd : String = self.pwdtextField.text!
       
        
        let parameters = [
            "Email": email,
            "Password" : pwd
        ]
        
        print(parameters)
      
        var url : NSURL!
        url = NSURL(string:"\(baseUrl)session")
           
           
        Alamofire.request(.POST,  url!, parameters: parameters  , encoding:.JSON, headers: headers)
           // .validate(contentType: ["application/json"])
            
            .responseJSON { response in

               
                 if let data = response.result.value {
                if (response.result .isSuccess)
                {
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.removeObjectForKey("email")
                     defaults.removeObjectForKey("password")
                    defaults.removeObjectForKey("LoginObject")
                
                        if let JSON = response.result.value
                        {
                            let loginobject : NSDictionary = JSON as! NSDictionary

                            if let Message  : AnyObject  = JSON["message"]
                            {
                                if (Message as! String == "Your account is not activated with us. Please confirm your email.")
                                {
                                 self.showAlert(Message as! String)
                                }
                                else
                                {
                               }
                               
                            }
                            
                            else
                            {
                               
                               
                                let email:String = JSON["email"]! as! String
                                let password:String = self.pwdtextField.text!
                                if let fullname = JSON["firstName"]!, let lastName = JSON["lastName"]!
                                {
                                    var fullname = "\(fullname) \(lastName)"
                                    let defaults = NSUserDefaults.standardUserDefaults()
                                    defaults.setObject(JSON["firstName"]!, forKey: "firstName")
                                    defaults.setObject(email, forKey: "email")
                                    defaults.setObject(password, forKey: "password")
                                    defaults.setObject(fullname, forKey: "fullname")
                                    defaults.setObject(lastName, forKey: "lastName")
                                    defaults.setObject(JSON["userId"], forKey: "userId")
                                    defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(loginobject), forKey: "LoginObject")
                                    defaults.synchronize()
                                    
                                    if let returnValue = NSUserDefaults.standardUserDefaults().objectForKey("Location") as? [String]{
                                        
                                        statename = returnValue[0]
                                        stateid = returnValue[1] as String
                                      
                                        
                                         authorizationWithoutLogin = "Mobileprod456~~~~~\(stateid)"

                                        if  let data = defaults.valueForKey("LoginObject"){
                                            let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data as! NSData)
                                            
                                            var token = JSON["token"]! as! String
                                            var userId = String(JSON["userId"]! as! Int)
//                                            let alertView:UIAlertView = UIAlertView()
//                                            alertView.title = "token"
//                                            alertView.message =
//                                            alertView.delegate = nil
//                                            alertView.addButtonWithTitle("OK")
//                                            alertView.show()
//                                            let alertView1:UIAlertView = UIAlertView()
//                                            alertView1.title = "userId"
//                                            alertView1.message =
//                                            alertView1.delegate = nil
//                                            alertView1.addButtonWithTitle("OK")
//                                            alertView1.show()
                                            //Prod
                                            authorizationWithLogin = "Mobileprod456~\(token)~\(userId)~Customer~null~\(stateid)"
                                            
                                            authorizationWithLogin1 = "Mobileprod456~\(token)~\(userId)~Customer~null~\(stateid)"
//                                             authorizationWithLogin = "Mobilestg2456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(stateid)"
//                                             authorizationWithLogin1 = "Mobilestg2456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(stateid)"
                                        
                                        }
                                    }else{
                                        

//                                        let defaults = NSUserDefaults.standardUserDefaults()
//                                        if  let data = defaults.objectForKey("LoginObject") as? NSData{
//                                            let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
//                                            var token = JSON["token"]! as! String
//                                            var userId = String(JSON["userId"]! as! Int)
//                                            authorizationWithLogin = "Mobileprod456~\(token)~\(userId)~Customer~null~13"
//                                            authorizationWithLogin1 = "Mobileprod456~\(token)~\(userId)~Customer~null~13"
////                                        authorizationWithLogin = "Mobilestg2456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(Globalstateid)"
////                                        authorizationWithLogin1 = "Mobilestg2456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(Globalstateid)"
//                                            
//                                        }
                                    }
// commented for testing
                                   let userId=JSON["userId"] as! Int
                                    
                                    let dataLayer: TAGDataLayer = TAGManager.instance().dataLayer
                                    dataLayer.push(["event": "ButtonPressed", "eventAction": "logged user \(userId)"])
                                    //blog.valueForKey("contactNumber")! as! String
                                    defaults.setObject(blog!.valueForKey("contactNumber")! as! String, forKey: "contactNumber")
                                    let wsm : WebServiceClass = WebServiceClass.sharedInstance
                                    wsm.delegates=self
                                    wsm.sendAllcartToserver()
                                  //  let defaults = NSUserDefaults.standardUserDefaults()
                                    if let usernm = defaults.valueForKey("userId"){
                                       // wsm.delegates = nil
                                        wsm.delegates=self
                                        wsm.getBasketDetailsLoginPage(usernm  as! Int , contryId: "IN")
                                    }
                               
                                    
                                }
                            
                            }
                            
                            if let Message  : AnyObject  = JSON["message"]
                            {
                                LoadingOverlay.shared.hideOverlayView()
                                 self.showAlert(Message as! String)
                            }
                        }
                    
//                    let cart = self.storyboard?.instantiateViewControllerWithIdentifier("cartVC") as! SecondViewController
//                    cart.fetchcart()
                    
                }
                else if (response.result .isFailure)
                {
                    LoadingOverlay.shared.hideOverlayView()
                    
                    self.appdelegate.reachability?.currentReachabilityStatus
                    if (self.appdelegate.isReachable == true)
                    {
                        if let JSON = response.result.value
                        {
                            if let Message  : AnyObject  = JSON["message"]
                            {
                                self.showAlert(Message as! String)
                            }
                            
                        }
                        else
                        {
                            
                            let alert = UIAlertController(title:"IMOL", message:"Request Timed Out" as! String, preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)
                            
                        }
                     }
                    
                    else
                    {
                        self.showAlert()
                    
                    }
                   
                }
               
        }
            }
        }
        else
        {
        LoadingOverlay.shared.hideOverlayView()
        self.showAlert()
        }
        }
        else
        {
            LoadingOverlay.shared.hideOverlayView()
            self.showAlert("Please enter proper values in password field")
            
        }
       }
        else
       {
        LoadingOverlay.shared.hideOverlayView()
        self.showAlert(ConstantsFile.email_msg)
        
        }
    }
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
//    {
//        textField.resignFirstResponder()
//        return true
//    }

    @IBAction func ForgetPasswordBtnClicked(sender: AnyObject) {
        
        self.title = " ";
        let ForgetViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("ForgetPasswordView") as? ForgetPasswordController
        self.navigationController?.pushViewController(ForgetViewControllerObj!, animated: true)
        
    }
    @IBAction func RegisterBtnClicked(sender: AnyObject)
    {
        self.title = " ";
        let RegisterViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterView") as? RegisterView
        self.navigationController?.pushViewController(RegisterViewControllerObj!, animated: true)
    
    }
    
    func showAlert(Message: String){
      
        LoadingOverlay.shared.hideOverlayView()
        let alert = UIAlertController(title:"IMOL", message:Message , preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    
    }
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    func showAlert(){
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Alert"
        alertView.message = ConstantsFile.noInternet_msg
        alertView.delegate = nil
        alertView.addButtonWithTitle("OK")
        alertView.show()
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

        
        
}

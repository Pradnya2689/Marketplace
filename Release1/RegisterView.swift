  //
  //  RegisterView.swift
  //  MarketPlace
  //
  //  Created by inpanr07 on 11/08/16.
  //  Copyright © 2016 inpanr07. All rights reserved.
  //

  import UIKit
  import Alamofire
  
  
  class RegisterView: UIViewController,UITextFieldDelegate,UIGestureRecognizerDelegate {
    
    
    
    @IBOutlet weak var privacyBtn: UIButton!
    
    @IBOutlet weak var andBtn: UILabel!
    @IBOutlet weak var TandCBtn: UIButton!
    
    @IBOutlet var NameField: UITextField!
    @IBOutlet var FirstNameField: UITextField!
    @IBOutlet var LastNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var MobileNoField: UITextField!
    @IBOutlet var PincodeField: UITextField!
    @IBOutlet var PasswordField: UITextField!
    @IBOutlet var ConfirmPasswordField: UITextField!
    @IBOutlet var scroll1: UIScrollView!
    @IBOutlet var createAcnt:UIButton!
     var appdelegate:AppDelegate!
     let boundss = UIScreen.mainScreen().bounds
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.title = "Re";
//        var b = UIBarButtonItem(title: " ", style: .Plain, target: self, action:"cancelClicked")
//        //leftBarButton.title = "Cancel"
//        // rightBarButton.customView = btnName
//        self.navigationItem.leftBarButtonItem = b
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
//        self.scroll1.contentSize = CGSizeMake(320, 500)
        let defaults = NSUserDefaults.standardUserDefaults()
        if let usernm = defaults.valueForKey("username") , let pwd = defaults.valueForKey("password")
        {
            print(usernm)
            print(pwd)
            
        }
        else
        {
            
        }
        
        

//        self.FirstNameField.text = "rishi"
//         self.LastNameField.text = "rishi"
//         self.emailField.text = "r.p@gmail.com"
//         self.MobileNoField.text = "9867274983"
//         self.PincodeField.text = "400052"
//         self.PasswordField.text = "rishi1234"
//         self.ConfirmPasswordField.text = "rishi1234"
       self.FirstNameField.delegate = self
        self.LastNameField.delegate = self
        self.emailField.delegate = self
       self.MobileNoField.delegate = self
        self.PincodeField.delegate = self
       self.PasswordField.delegate = self
        self.ConfirmPasswordField.delegate = self
        
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterView.handleTap(_:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        let contentInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        self.scroll1.contentInset = contentInsets
        self.scroll1.scrollIndicatorInsets = contentInsets
        
//        self.createAcnt.translatesAutoresizingMaskIntoConstraints = true
//        self.createAcnt.frame = CGRectMake(8, boundss.height-108, 304, 40)
    }
    
    func handleTap(sender: UITapGestureRecognizer? = nil){
        FirstNameField.resignFirstResponder()
        LastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        MobileNoField.resignFirstResponder()
        PincodeField.resignFirstResponder()
        PasswordField.resignFirstResponder()
        ConfirmPasswordField.resignFirstResponder()
    }
    
    @IBAction func CreateAccountClicked(sender: AnyObject) {
          appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if let fname = self.FirstNameField.text where !fname.isEmpty ,  let lname = self.LastNameField.text where !lname.isEmpty, let email = self.emailField.text where !email.isEmpty ,  let mobileno = self.MobileNoField.text  where !mobileno.isEmpty ,  let pincode = self.PincodeField.text where !pincode.isEmpty,  let password = self.PasswordField.text  where !password.isEmpty,  let cnfrmpassword = self.ConfirmPasswordField.text where !cnfrmpassword.isEmpty
        {
            if(self.isValidEmail(self.emailField.text!))
            {
            
        if let fname = self.PasswordField.text, let lname = self.ConfirmPasswordField.text
        {
            
            if (fname == lname)
            {
                
               if (appdelegate.isReachable == true) {
                
              //  JHProgressHUD.sharedHUD.backGroundColor = UIColor.clearColor()
               // JHProgressHUD.sharedHUD.loaderColor = UIColor.blackColor()
                // self.tableView.backgroundColor = UIColor.whiteColor()
               // JHProgressHUD.sharedHUD.showInView(self.view)
                var window :UIWindow = UIApplication.sharedApplication().keyWindow!
                LoadingOverlay.shared.showOverlay(window)
                let headers = [
                    "Authorization" : authorizationWithoutLogin,
                    "Content-Type ": "application/json"
                ]
                
                
                let cont : String = self.MobileNoField.text!
                           let email : String = self.emailField.text!
                let FIRSTname : String = self.FirstNameField.text!
                let  LASTname : String = self.LastNameField.text!
                let  getotp : String = "1"
                
                //  \"unnecessary\"
                let parameters = [
                    "contactNumber": cont,
                    "email": email,
                    "firstName": FIRSTname,
                    "getOTP": true ,
                    "lastName": LASTname
                    
                ]
                
                print(parameters)
                
                //        let parameters = [
                //            "contactNumber":"9870256703",
                //            "email":" \(self.emailField.text)",
                //            "firstName":"Pradnya",
                //            "getOTP":true,
                //            "lastName":"Dongre"
                //        ]
                
                var url : NSURL!
                url = NSURL(string:"\(baseUrl)UserRegistration")
                
                
                Alamofire.request(.POST,  url!, parameters: parameters as! [String: AnyObject], encoding:.JSON, headers: headers)
                    .validate(contentType: ["application/json"])
                    
                    .responseJSON { response in
                        print(response.request)  // original URL request
                        print(response.response) // URL response
                        print(response.data)
                        var strData = NSString(data: response.data!, encoding: NSUTF8StringEncoding)
                        print("Body: \(strData!)")// server data
                        print(response.result)
                        
                        
                        if (response.result .isSuccess)
                        {
                            
                            if let JSON = response.result.value
                            {
                                if JSON .isKindOfClass(NSDictionary){
                                    print("dictionary")
                                    if let msg = JSON["message"] as? String {
                                    self.showAlert(JSON["message"] as! String )
                                    }
                                }
                                if JSON .isKindOfClass(NSString){
                                    print("String")
                                    if(JSON .isEqualToString("Verification Code sent to"))
                                    {
                                        self.showAlertForCodeSent("Verification Code sent to your mobile no.")
                                    }
                                    else
                                    {
                                        self.showAlert(JSON as! String)
                                    }
                                }
                               
                               
                        
                                
                                
                            }
                           
                        }
                        
                        else if  (response.result .isFailure)
                        {
                            if let JSON = response.result.value
                            {
                                self.showAlert(JSON["message"] as! String)
                            }
                            
                            else
                            {
                            self.showAlert("Request timed Out")
                            }
                        }
                }
                }
                else
               {
                self.showAlert(ConstantsFile.noInternet_msg)

                
                }
            }
            else
            {
                 self.showAlert(ConstantsFile.passwordMatch_msg)
         
            
            }
            
            }
            
            
            
        }
            else
            {
                
                self.showAlert(ConstantsFile.email_msg)
                
            }
        }
        else
        {
               // for case let textField as UITextField in self.view.subviews {
               if let fname = self.FirstNameField.text where fname.isEmpty{
                    self.showAlert(ConstantsFile.firstName_msg)
                   // return
                }
                else  if let lname = self.LastNameField.text where lname.isEmpty
                {
                    self.showAlert(ConstantsFile.lastName_msg)
                   // return
                }
               else  if let email = self.emailField.text where email.isEmpty
               {
                self.showAlert(ConstantsFile.registrationEmail_msg)
                // return
            }
               else  if let mobile = self.MobileNoField.text where mobile.isEmpty
               {
                self.showAlert(ConstantsFile.mobileNo_msg)
                // return
            }
               else  if let pcode = self.PincodeField.text where pcode.isEmpty
               {
                self.showAlert(ConstantsFile.pincode_msg)
                // return
            }
               else  if let pwd = self.PasswordField.text where pwd.isEmpty
               {
                self.showAlert(ConstantsFile.regPassword_msg)
                // return
            }
               else  if let cpwd = self.ConfirmPasswordField.text where cpwd.isEmpty
               {
                self.showAlert(ConstantsFile.regConfirmPass_msg)
                // return
            }
            
           // }
        //self.showAlert("Please Enter all mandatory fields")
        
        }
    }
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
////        let newLength = [textField.text.] + string.characters.count - range.length
////        let aSet = NSCharacterSet(charactersInString:"0123456789").invertedSet
////        let compSepByCharInSet = string.componentsSeparatedByCharactersInSet(aSet)
////        let numberFiltered = compSepByCharInSet.joinWithSeparator("")
////         return (([string == numberFiltered])&&(newLength == 6));
//        
//    }
    
    @IBAction func faqAction(sender: AnyObject) {
        let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("faq") as? FAQViewController
        // let NavigationController = UINavigationController(rootViewController: AccountSettingObj!)
        //   self.presentViewController(NavigationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(AccountSettingObj!, animated: true)
    }
    
    @IBAction func termsAction(sender: AnyObject) {
        let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("termsncond") as? TermsConditionViewController
        // let NavigationController = UINavigationController(rootViewController: AccountSettingObj!)
        //   self.presentViewController(NavigationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(AccountSettingObj!, animated: true)
    }
    
    @IBAction func policyAction(sender: AnyObject) {
        let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("legal") as? LegalViewController
        // let NavigationController = UINavigationController(rootViewController: AccountSettingObj!)
        //   self.presentViewController(NavigationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(AccountSettingObj!, animated: true)
    }
   
    
    func showAlertForCodeSent(Message: String)
    {
       
        LoadingOverlay.shared.hideOverlayView()
        let alert = UIAlertController(title:"IMOL", message:Message , preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
        let OTPViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("OTPView") as? OTPViewController
            OTPViewControllerObj?.fname = self.FirstNameField.text
            OTPViewControllerObj?.lname = self.LastNameField.text
            
            OTPViewControllerObj?.mobileNo = self.MobileNoField.text
            OTPViewControllerObj?.email = self.emailField.text
            
            OTPViewControllerObj?.pwd = self.PasswordField.text
            OTPViewControllerObj?.comingfrom = "registrationView"
           
            self.title = " ";
            self.navigationController?.pushViewController(OTPViewControllerObj!, animated: true) }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func showAlert(Message: String)
    {
        LoadingOverlay.shared.hideOverlayView()
        let alert = UIAlertController(title:"IMOL", message:Message , preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    override func viewWillAppear(animated: Bool) {
        self.title = "Register";
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
         self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        
//        if(screenSize.width == 750){
//            TandCBtn.translatesAutoresizingMaskIntoConstraints = true
//            TandCBtn.frame = CGRectMake(75, 538, 90, 20)
//            
//            privacyBtn.translatesAutoresizingMaskIntoConstraints = true
//            privacyBtn.frame = CGRectMake(191, 538, 82, 20)
//            
//            andBtn.translatesAutoresizingMaskIntoConstraints = true
//            andBtn.frame = CGRectMake(171, 538, 12, 20)
//        }
    }
    
    override func viewWillDisappear(animated: Bool) {
         self.title = "";
        super.viewWillDisappear(animated)
        unregisterKeyboardNotifications()
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
        let contentInsets = UIEdgeInsetsMake(0, 0, 250, 0)
        self.scroll1.contentInset = contentInsets
        self.scroll1.scrollIndicatorInsets = contentInsets
        
        var viewRect = view.frame
        viewRect.size.height -= keyboardSize.height
       
//        if CGRectContainsPoint(viewRect, self.FirstNameField.frame.origin) {
//            let scrollPoint = CGPointMake(0, self.FirstNameField.frame.origin.y - keyboardSize.height)
//            self.scroll1.setContentOffset(scrollPoint, animated: true)
//        }
//        if CGRectContainsPoint(viewRect, self.LastNameField.frame.origin) {
//            let scrollPoint = CGPointMake(0, self.LastNameField.frame.origin.y - keyboardSize.height)
//            self.scroll1.setContentOffset(scrollPoint, animated: true)
//        }
//        if CGRectContainsPoint(viewRect, self.emailField.frame.origin) {
//            let scrollPoint = CGPointMake(0, self.emailField.frame.origin.y - keyboardSize.height)
//            self.scroll1.setContentOffset(scrollPoint, animated: true)
//        }
//        if CGRectContainsPoint(viewRect, self.MobileNoField.frame.origin) {
//            let scrollPoint = CGPointMake(0, self.MobileNoField.frame.origin.y - keyboardSize.height)
//            self.scroll1.setContentOffset(scrollPoint, animated: true)
//        }
//        if CGRectContainsPoint(viewRect, self.PincodeField.frame.origin) {
//            let scrollPoint = CGPointMake(0, self.PincodeField.frame.origin.y - keyboardSize.height)
//            self.scroll1.setContentOffset(scrollPoint, animated: true)
//        }
//        if CGRectContainsPoint(viewRect, self.PasswordField.frame.origin) {
//            let scrollPoint = CGPointMake(0, self.PasswordField.frame.origin.y - keyboardSize.height)
//            self.scroll1.setContentOffset(scrollPoint, animated: true)
//        }
//        if CGRectContainsPoint(viewRect, self.ConfirmPasswordField.frame.origin) {
//            let scrollPoint = CGPointMake(0, self.ConfirmPasswordField.frame.origin.y - keyboardSize.height)
//            self.scroll1.setContentOffset(scrollPoint, animated: true)
//        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
        return true
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        if textField == self.PincodeField {
        let currentCharacterCount = self.PincodeField.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.characters.count - range.length
        return newLength <= 6
       }
        
        if textField == self.FirstNameField || textField == self.LastNameField{
            if (range.length + range.location > textField.text!.characters.count) {
                return false;
            }
            let newLength = textField.text!.characters.count + string.characters.count - range.length;
            return newLength <= 70
        }
        
        
        
        if textField == self.MobileNoField {
            guard let text = textField.text else { return true}
            let newlength = (text.characters.count) + string.characters.count - range.length
            return newlength <= 10
        }
        return true
    }
    func keyboardWillHide(notification: NSNotification) {
        self.scroll1.contentInset = UIEdgeInsetsZero
        self.scroll1.scrollIndicatorInsets = UIEdgeInsetsZero
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

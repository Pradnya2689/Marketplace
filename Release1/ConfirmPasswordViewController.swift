//
//  ConfirmPasswordViewController.swift
//  MarketPlace
//
//  Created by inpanr07 on 22/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

var username : String!

class ConfirmPasswordViewController: UIViewController,webServiceDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate {
    var email:String!=""
    @IBOutlet var passwordFiled: UITextField!
     @IBOutlet var confirmPasswordField: UITextField!
    @IBOutlet var scroll1: UIScrollView!
    var appdelegate:AppDelegate!
   
    @IBOutlet weak var passwordLabel: UILabel!
    override func viewDidLoad() {
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
        super.viewDidLoad()
 appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ConfirmPasswordViewController.handleTap(_:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
//        passwordLabel.translatesAutoresizingMaskIntoConstraints = true
//        passwordLabel.frame = CGRectMake(36.0, 121.0, 276.0, 21.0)
        
    }
    
    func handleTap(sender: UITapGestureRecognizer? = nil){
        passwordFiled.resignFirstResponder()
        confirmPasswordField.resignFirstResponder()
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    override func viewWillAppear(animated: Bool) {
         self.navigationController?.interactivePopGestureRecognizer?.enabled = false
       
            self.title = "Confirm Password";
                 super.viewWillAppear(animated)
        registerKeyboardNotifications()
        

    }
    
    override func viewWillDisappear(animated: Bool) {
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
        let contentInsets = UIEdgeInsetsMake(0, 0, 160, 0)
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
    func keyboardWillHide(notification: NSNotification) {
        self.scroll1.contentInset = UIEdgeInsetsZero
        self.scroll1.scrollIndicatorInsets = UIEdgeInsetsZero
    }

    @IBAction func ResetPasswordClicked(sender: AnyObject) {
        if let pword = self.passwordFiled.text where !pword.isEmpty
        {
             if let cpword = self.confirmPasswordField.text where !cpword.isEmpty
             {
            if let fname = self.passwordFiled.text, let lname = self.confirmPasswordField.text
            {
                
                if (fname == lname)
                {
                    
                    if (appdelegate.isReachable == true) {
                        
                      ///  JHProgressHUD.sharedHUD.backGroundColor = UIColor.clearColor()
                      //  JHProgressHUD.sharedHUD.loaderColor = UIColor.blackColor()
                        // self.tableView.backgroundColor = UIColor.whiteColor()
                       // JHProgressHUD.sharedHUD.showInView(self.view)
                        var window :UIWindow = UIApplication.sharedApplication().keyWindow!
                        LoadingOverlay.shared.showOverlay(window)
                        let defaults = NSUserDefaults.standardUserDefaults()
                       // let userId = defaults.objectForKey("userId") as? Int
                       
                        if let username = defaults.objectForKey("email") as? String{
                        let wsm : WebServiceClass = WebServiceClass.sharedInstance
                        wsm.delegates=self
                        wsm.confirmPwd(self.passwordFiled.text!, usrname: username)
                        }else{
                            let wsm : WebServiceClass = WebServiceClass.sharedInstance
                            wsm.delegates=self
                            wsm.confirmPwd(self.passwordFiled.text!, usrname: email)
                        }
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
                
                self.showAlert(ConstantsFile.reenterPassword_msg)
            }
            
        }
        else
        {
        
         self.showAlert(ConstantsFile.enterPassword_msg)
        }
        
        
        
        
    }
    
    func confirmpwdapiFailedDelegate()
    {
        LoadingOverlay.shared.hideOverlayView()
        self.showAlert("Empty response")
        //        let alert=UIAlertController(title: "", message:"Request Failed.Try again?", preferredStyle: UIAlertControllerStyle.Alert);
        //
        //        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil));
        //        //event handler with closure
        //        alert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default, handler: {(action:UIAlertAction) in
        //            let wsm : WebServiceClass = WebServiceClass.sharedInstance
        //            wsm.delegates=self       //grpDetail.masterProfileID
        //            wsm.callVendorApi("banner", page: "Home", key: "banner")
        //        }));
        //        self.presentViewController(alert, animated: true, completion: nil);
    }
    func confirmpwdapiresponse(string:NSDictionary)
    {
       // print(string)
         LoadingOverlay.shared.hideOverlayView()
        self.title = " ";
        
        let loginViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("LoginView") as? LoginView
        //LoginViewControllerObj?.isCalledFrm = "other"
        //let NavigationController = UINavigationController(rootViewController: LoginViewControllerObj!)
        //self.presentViewController(NavigationController, animated: true, completion: {(Bool) in
            self.navigationController?.popToRootViewControllerAnimated(true)
       // })
   
    }
    
    func showAlert(Message: String)
    {
        
        LoadingOverlay.shared.hideOverlayView()
        let alert = UIAlertController(title:"IMOL", message:Message , preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    func showAlert(){
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Alert"
        alertView.message = ConstantsFile.noInternet_msg
        alertView.delegate = nil
        alertView.addButtonWithTitle("OK")
        alertView.show()
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

//
//  ForgetPasswordController.swift
//  MarketPlace
//
//  Created by inpanr07 on 19/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import Alamofire

class ForgetPasswordController: UIViewController,webServiceDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate{

    
    
    @IBOutlet var scroll1: UIScrollView!
    @IBOutlet weak var resetPassField: UITextField!
    @IBOutlet weak var resetConfirmPassField: UITextField!
    var appdelegate:AppDelegate!
    var email:String!=""

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
      self.navigationItem.backBarButtonItem = nil
        
        self.navigationController?.delegate = self
       // var b = UIBarButtonItem(title: "back", style: .Plain, target: self, action:"cancelClicked")
        //leftBarButton.title = "Cancel"
        // rightBarButton.customView = btnName
        //self.navigationItem.leftBarButtonItem = b
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
      //  self.resetConfirmPassField.text = "jesuakaran.sachin@gmail.com"
        self.resetConfirmPassField.text = ""
         appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(ForgetPasswordController.handleTap(_:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    func handleTap(sender:UITapGestureRecognizer? = nil){
        resetConfirmPassField.resignFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = "Forgot Password";
         self.navigationController?.interactivePopGestureRecognizer?.enabled = false
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

    func cancelClicked() {
        
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
        }
        
    }
    @IBAction func ForgotPasswordBtnClicked(sender: AnyObject)
    {
        
       // JHProgressHUD.sharedHUD.backGroundColor = UIColor.clearColor()
      //  JHProgressHUD.sharedHUD.loaderColor = UIColor.blackColor()
        // self.tableView.backgroundColor = UIColor.whiteColor()
        //JHProgressHUD.sharedHUD.showInView(self.view)
        var window :UIWindow = UIApplication.sharedApplication().keyWindow!
        LoadingOverlay.shared.showOverlay(window)
        if(self.isValidEmail(self.resetConfirmPassField .text!))
        {
            username = self.resetConfirmPassField .text!
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self       //grpDetail.masterProfileID
            wsm.forgotPassword(self.resetConfirmPassField.text!)
        }
        else
        {
            self.showAlert(ConstantsFile.email_msg)
            
        }

        
    }
    
    func forgotpwdapiFailedDelegate()
    {
        
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
    func forgotpwdapiresponse(string:NSDictionary)
    {
       // print(string)
         LoadingOverlay.shared.hideOverlayView()
        self.title = " ";
        let OTPViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("OTPView") as? OTPViewController
          OTPViewControllerObj?.comingfrom = "ForgotPassword"
        OTPViewControllerObj?.email = self.resetConfirmPassField.text
        self.navigationController?.pushViewController(OTPViewControllerObj!, animated: true)
      
        
//        if let Message  : AnyObject  = string["message"]
//        {
//            if (Message .isEqualToString("200"))
//            {
//                self.showAlert("Password sent to your email. Please check.")
////                let LoginViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("LoginView") as? LoginView
////                self.navigationController?.pushViewController(LoginViewControllerObj!, animated: true)
//                
//            }
//            else
//            {
//                self.showAlert(Message as! String)
//            }
//        }
//        else
//        {
//        
//        
//        }
    }


func showAlert(Message: String)
{
    
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

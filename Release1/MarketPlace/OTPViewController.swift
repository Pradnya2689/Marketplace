 //
//  OTPViewController.swift
//  Scroll
//
//  Created by Developer on 8/11/16.
//  Copyright © 2016 ingram. All rights reserved.
//

import UIKit
import Alamofire

class OTPViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate,webServiceDelegate {
    
    @IBOutlet weak var otpText1Field: UITextField!
    @IBOutlet weak var otpText2Field: UITextField!
    @IBOutlet weak var otpText3Field: UITextField!
    @IBOutlet weak var otpText4Field: UITextField!
    
    @IBOutlet var otpText5Field: UITextField!
    @IBOutlet var otpText6Field: UITextField!
    var button : UIButton!
    
    var mobileNo : NSString!
    var pwd : NSString!
    var fname : NSString!
    var lname : NSString!
    var otp : NSString!
    var email : NSString!
     var comingfrom : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        button = UIButton(type: UIButtonType.Custom)
//        button.setTitle("Return", forState: UIControlState.Normal)
//        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        button.frame = CGRectMake(0, 163, 106, 53)
//        button.adjustsImageWhenHighlighted = false
//        button.addTarget(self, action: #selector(OTPViewController.Done), forControlEvents: UIControlEvents.TouchUpInside)
        
        // Do any additional setup after loading the view.
       // print("%@\n%@",fname,lname,email,mobileNo,pwd)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(OTPViewController.handleTap(_:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        self.otpText6Field.addTarget(self, action: #selector(OTPViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
    }
    
    func handleTap(sender: UITapGestureRecognizer? = nil)
    {
        otpText1Field.resignFirstResponder()
        otpText2Field.resignFirstResponder()
        otpText3Field.resignFirstResponder()
        otpText4Field.resignFirstResponder()
        otpText5Field.resignFirstResponder()
        otpText6Field.resignFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = "OTP";
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName : headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
//        super.viewWillAppear(animated)
//        registerKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldDidChange(textField: UITextField)
    {
        if let text6 = textField.text where !text6.isEmpty {
        let second : String = "\(self.otpText1Field.text!)\(self.otpText2Field.text!)\(self.otpText3Field.text!)\(self.otpText4Field.text!)\(self.otpText5Field.text!)\(self.otpText6Field.text!)"
       
        
        let wsm : WebServiceClass = WebServiceClass.sharedInstance
        wsm.delegates=self       //grpDetail.masterProfileID
            
            if let comingfrom = self.comingfrom
            {
                if (comingfrom == "registrationView")
                {
        wsm.registration(second, password: pwd as String, firstname: fname as String, contactNumber: mobileNo as String, email:email as String, lastName: lname as String)
                }//
                
                else if(comingfrom == "ForgotPassword")
                {
                    self.title = " ";
                   let ConfirmPasswordControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("ConfirmPasswordView") as? ConfirmPasswordViewController
                    ConfirmPasswordControllerObj?.email = email as String
                   self.navigationController?.pushViewController(ConfirmPasswordControllerObj!, animated: true)
                
                }
                else if(comingfrom == "UpdateMobileNumber")
                {
                    self.title = " ";
                    wsm.OTPConfirmationUpdateMobile(second, contactNumber: mobileNo as String, email: email as String)
//                    let ConfirmPasswordControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("ConfirmPasswordView") as? ConfirmPasswordViewController
//                    self.navigationController?.pushViewController(ConfirmPasswordControllerObj!, animated: true)
                    
                }
                
            }
        }
        else
        {
        print("coming back")
        }
        
    }
    
    func registartionapiFailedDelegate()
    {
        
        self.showAlert(ConstantsFile.otp_msg)
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
    
    func OTPconfirmationapiresponse (string:String)
    {
        
       // let ConfirmPasswordControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("ConfirmPasswordView") as? ConfirmPasswordViewController
         let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
//    let ConfirmPasswordControllerObj = viewControllers.count - 3 as! AccountSettingView
//       ConfirmPasswordControllerObj.mobileNumberTF.text = string
      let ConfirmPasswordControllerObj =  viewControllers [viewControllers.count - 3] as! AccountSettingView
        ConfirmPasswordControllerObj.mobileNumberTF.text = string
        
      // self.navigationController?.pushViewController(ConfirmPasswordControllerObj!, animated: true)
       // self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);
       self.navigationController!.popToViewController(ConfirmPasswordControllerObj, animated: true);
    }
 func OTPconfirmationapiFailedDelegate (string:String)
 {
    
    
    }
    @IBAction func ResendOTP(sender: AnyObject) {
        
        let  appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
       // JHProgressHUD.sharedHUD.backGroundColor = UIColor.clearColor()
       // JHProgressHUD.sharedHUD.loaderColor = UIColor.blackColor()
        // self.tableView.backgroundColor = UIColor.whiteColor()
       // JHProgressHUD.sharedHUD.showInView(self.view)
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
        LoadingOverlay.shared.showOverlay(window)
        let headers = [
            "Authorization": authorizationWithoutLogin,
            "Content-Type" : "application/json"
        ]
        
        let parameters = [
            "contactNumber": mobileNo,
            "email": email,
            "firstName": fname,
            "getOTP": true ,
            "lastName": lname
            
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
        
        
        Alamofire.request(.POST,  url!, parameters: parameters, encoding:.JSON, headers: headers)
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
                        if let Message  : AnyObject  = JSON
                        {
                            if(Message .isEqualToString("Verification Code sent to"))
                            {
                                self.showAlertForCodeSent(JSON as! String)
                            }
                            else
                            {
                                self.showAlert(Message as! String)
                            }
                        }
                        else
                        {
                            // self.showAlert(Message as! String)
                            
                        }
                        
                        
                        
                        
                        
                        
                    }
                    
                }
                    
                else if  (response.result .isFailure)
                {
                    if let JSON = response.result.value
                    {
                        self.showAlert(JSON as! String)
                    }
                        
                    else
                    {
                        self.showAlert("Request Timed Out")
                    }
                }
        }

        }else{
            LoadingOverlay.shared.hideOverlayView()
        }
        

    }
    func registartionapiresponse(string:NSDictionary)
    {
        print(string)
        
        if let Message  : AnyObject  = string["message"]
        {
            if (Message .isEqualToString("200"))
            {
             let LoginViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("LoginView") as? LoginView
                
                LoginViewControllerObj?.isCalledFrm = "other"
//                self.navigationController?.pushViewController(LoginViewControllerObj!, animated: true)
                
                let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("MyAccountView") as? AccountViewController
                //AccountSettingObj?.isCalledFrm = "other"
                self.navigationController?.pushViewController(AccountSettingObj!, animated: true)

            }
            else
            {
            self.showAlert(Message as! String)
            }
        }
    }
     func Done() -> Void
     {
    print("done clicked")
       
    }
    func textFieldDidBeginEditing(textField: UITextField) {
//         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OTPViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
//        if let text1 = otpText6Field.text where !text1.isEmpty
//        {
//        moveTextField(textField, moveDistance: 0, up: false)
////            self.otpText1Field.text = nil
////            self.otpText2Field.text = nil
////            self.otpText3Field.text = nil
////            self.otpText4Field.text = nil
////            self.otpText5Field.text = nil
////            self.otpText6Field.text = nil
//        }
//        else
//        {
        moveTextField(textField, moveDistance: -150, up: true)
       // }
        
        
    }
    func keyboardWillShow(note : NSNotification) -> Void{
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.button.hidden = false
            let keyBoardWindow = UIApplication.sharedApplication().windows.last
            self.button.frame = CGRectMake(0, (keyBoardWindow?.frame.size.height)!-53, 106, 53)
            keyBoardWindow?.addSubview(self.button)
            keyBoardWindow?.bringSubviewToFront(self.button)
            UIView.animateWithDuration(((note.userInfo! as NSDictionary).objectForKey(UIKeyboardAnimationCurveUserInfoKey)?.doubleValue)!, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.view.frame = CGRectOffset(self.view.frame, 0, 0)
                }, completion: { (complete) -> Void in
                    print("Complete")
            })
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        //        let nextTag : NSInteger =  textField.tag + 1
        //        let newtextfield  = textField.superview?.viewWithTag(nextTag)
        //          newtextfield!.becomeFirstResponder()
        
        if let text = otpText6Field.text where !text.isEmpty
        {
            if let text1 = otpText1Field.text where !text1.isEmpty , let text2 = otpText2Field.text where !text2.isEmpty, let text3 = otpText3Field.text where !text3.isEmpty, let text4 = otpText4Field.text where !text4.isEmpty, let text5 = otpText5Field.text where !text5.isEmpty, let text6 = otpText6Field.text where !text6.isEmpty
            {
                moveTextField(textField, moveDistance: -150, up: false)
                return
            }
            else
            {
                //moveTextField(textField, moveDistance: -150, up: true)
                
            }
            
        }
        moveTextField(textField, moveDistance: -150, up: false)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        
//        NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:text];
//        BOOL isPressedBackspaceAfterSingleSpaceSymbol = [text isEqualToString:@""] && [resultString isEqualToString:@""] && range.location == 0 && range.length == 1;
//        if (isPressedBackspaceAfterSingleSpaceSymbol) {
//            //  your actions for deleteBackward actions
//        }
        
      let currentCharacterCount = textField.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.characters.count - range.length
        if(newLength < 1){
            print("something deleted")
            let textfield = self.view.viewWithTag(textField.tag - 1)
            print("something deleted")
            
            let delayInSeconds = 0.0
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()) {
                textfield?.becomeFirstResponder();
            }
            
            return true;

        }
        else if (newLength == 1)
        {
            
            let textfield = self.view.viewWithTag(textField.tag + 1)
            
            let delayInSeconds = 0.0
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()) {
                textfield?.becomeFirstResponder();
            }
            
            return true;
            
        }
//        else if (newLength == 0)
//        {
//            print("something deleted")
//            let textfield = self.view.viewWithTag(textField.tag - 1)
//            
//            let delayInSeconds = 0.0
//            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
//            dispatch_after(delay, dispatch_get_main_queue()) {
//                textfield?.becomeFirstResponder();
        //    }
            
//            return true;
//
//        }
        else{
            return false;
        }
        
    
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let nextTag : NSInteger =  textField.tag + 1
        
        
        var nextResponder : UIResponder!
        nextResponder = textField.superview?.viewWithTag(nextTag)
        
        
        if ((nextResponder) != nil) {
            
            // Found next responder, so set it.
            nextResponder.becomeFirstResponder()
            
        } else {
            
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        return false; // We do not want UITextField
        
        
    }
    
    func moveTextField(textField: UITextField, moveDistance: Int, up: Bool){
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        UIView.commitAnimations()
    }
    
    func showAlertForCodeSent(Message: String)
    {
        
        LoadingOverlay.shared.hideOverlayView()
        let alert = UIAlertController(title:"IMOL", message:Message , preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{(action) -> Void in
        self.otpText1Field.text = nil
            self.otpText2Field.text = nil
            self.otpText3Field.text = nil
            self.otpText4Field.text = nil
            self.otpText5Field.text = nil
            self.otpText6Field.text = nil
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func showAlert(Message: String)
    {
        LoadingOverlay.shared.hideOverlayView()
        let alert = UIAlertController(title:"IMOL", message:Message , preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
}

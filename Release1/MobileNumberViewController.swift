//
//  MobileNumberViewController.swift
//  Scroll
//
//  Created by Developer on 8/11/16.
//  Copyright © 2016 ingram. All rights reserved.
//

import UIKit

class MobileNumberViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate, webServiceDelegate {

    @IBOutlet weak var mobileScrollView: UIScrollView!
    @IBOutlet weak var enterMobileNumberTF: UITextField!
    @IBOutlet weak var updateContactBtn: UIButton!
    
    @IBAction func updateButton(sender: AnyObject) {
        
            updateContactBtn.resignFirstResponder()
        
       
        let wsm : WebServiceClass = WebServiceClass.sharedInstance
        wsm.delegates=self
        let defaults = NSUserDefaults.standardUserDefaults()
        if let data = defaults.objectForKey("LoginObject") as? NSData
        {
            if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
            {
                
             wsm.callMobileUpdateApi(blog.valueForKey("firstName")! as! String, lastName: blog.valueForKey("lastName")! as! String, email: blog.valueForKey("email")! as! String, cont:self.enterMobileNumberTF.text!)
            }

           
        }

     
           // let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let nextViewController = self.storyboard!.instantiateViewControllerWithIdentifier("OTPView") as! OTPViewController
//            self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
self.title = "Update Contact"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
        
         self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MobileNumberViewController.handleTap(_:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        let contentInsets = UIEdgeInsetsMake(0, 0, 180, 0)
        self.mobileScrollView.contentInset = contentInsets
        self.mobileScrollView.scrollIndicatorInsets = contentInsets

        let keyboardDoneButtonView = UIToolbar.init()
        keyboardDoneButtonView.sizeToFit()
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done,
                                              target: self,
                                              action: #selector(doneClicked))
        let doneButton1 = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace,
                                               target: nil,
                                               action: nil)
        doneButton1.width = screenWidth-80
        
        keyboardDoneButtonView.items = [doneButton1,doneButton]
        enterMobileNumberTF.inputAccessoryView = keyboardDoneButtonView
        
        
      // mobileScrollView.contentSize = CGSizeMake(200, 800)

        // Do any additional setup after loading the view.
    }
    
    func doneClicked(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    func updatecontactOTPSuccess(string:NSDictionary)
    {
      print(string)
        
        let nextViewController = self.storyboard!.instantiateViewControllerWithIdentifier("OTPView") as! OTPViewController
        nextViewController.comingfrom = "UpdateMobileNumber"
        nextViewController.mobileNo = self.enterMobileNumberTF.text
        let defaults = NSUserDefaults.standardUserDefaults()
        // defaults.removeObjectForKey("contactNumber")
        
        if let data = defaults.objectForKey("LoginObject") as? NSData
        {
            print("mobile no:",self.enterMobileNumberTF.text)
            
             defaults.setObject(self.enterMobileNumberTF.text, forKey:"contactNumber")
            defaults.synchronize()
         
            if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
            {
                print(blog)
               // blog.setValue(self.enterMobileNumberTF.text!, forKey: "contactNumber")
                nextViewController.email = blog.valueForKey("email")! as! String
            }
        }
        self.navigationController?.pushViewController(nextViewController, animated: true)

    }
    func  updatecontactOTPFailure(string:String)
    {
        print("ERROR")
        self.showAlert(string)
        
    }
    
    func showAlert(Message: String)
    {
        
        LoadingOverlay.shared.hideOverlayView()
        let alert = UIAlertController(title:"IMOL", message:Message , preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mobileScrollView.contentSize = CGSize(width: 200, height: 700)
    }

    func handleTap(sender: UITapGestureRecognizer? = nil) {
        enterMobileNumberTF.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        //moveTextField(textField, moveDistance: -150, up: true)
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
       // moveTextField(textField, moveDistance: -150, up: false)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}




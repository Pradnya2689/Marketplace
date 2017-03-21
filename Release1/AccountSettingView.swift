//
//  AccountSettingView.swift
//  MarketPlace
//
//  Created by inpanr07 on 24/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class AccountSettingView: UIViewController , UITextFieldDelegate, UIGestureRecognizerDelegate,webServiceDelegate
 {
    @IBOutlet weak var TCBtn: UIButton!
    @IBOutlet weak var policyBtn: UIButton!
    @IBOutlet weak var AndBtn: UILabel!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var personalNameTF: UITextField!
    @IBOutlet weak var changeInfoBtn: UIButton!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailAddressTF: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var changeAddressBtn: UIButton!
    @IBOutlet weak var addressTextField: UITextView!
    @IBOutlet weak var changePassBtn: UIButton!
    @IBOutlet var scroll1: UIScrollView!
    
    @IBAction func saveActionButton(sender: AnyObject!){
        self.changeInfoBtn.hidden = false
        self.buttonsView.hidden = true
        personalNameTF.userInteractionEnabled = false
        lastNameTF.userInteractionEnabled = false
        mobileNumberTF.userInteractionEnabled = false
        emailAddressTF.userInteractionEnabled = false
        LoadingOverlay.shared.showOverlay(view)
        let wsm : WebServiceClass = WebServiceClass.sharedInstance
        wsm.delegates=self
        wsm.UpdateApiFprProfile(personalNameTF.text!, lastName: lastNameTF.text!, email: emailAddressTF.text!, cont: mobileNumberTF.text!)
    }
    
    @IBAction func cancelActionButton(sender: AnyObject!){
        self.changeInfoBtn.hidden = false
        self.buttonsView.hidden = true
        personalNameTF.userInteractionEnabled = false
        lastNameTF.userInteractionEnabled = false
        mobileNumberTF.userInteractionEnabled = false
        emailAddressTF.userInteractionEnabled = false
    }
    
    @IBAction func changeInfo(sender: AnyObject) {
        self.buttonsView.hidden = false
        self.changeInfoBtn.hidden = true
        personalNameTF.userInteractionEnabled = true
        lastNameTF.userInteractionEnabled = true
        mobileNumberTF.userInteractionEnabled = true
        emailAddressTF.userInteractionEnabled = true
        
    }
    
    
    @IBAction func changePassAction(sender: AnyObject) {
        changePassBtn.resignFirstResponder()
        let nextViewController =  self.storyboard?.instantiateViewControllerWithIdentifier("ConfirmPasswordView") as! ConfirmPasswordViewController
        //nextViewController.NoAddrFlag = "Address"
        //        nextViewController.addSegmentoutlet.selectedSegmentIndex = 0;
        //        nextViewController.addSegmentoutlet.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        self.navigationController?.pushViewController(nextViewController, animated: true)

    }
    
    @IBAction func faqActionBtn(sender: AnyObject) {
        let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("faq") as? FAQViewController
        // let NavigationController = UINavigationController(rootViewController: AccountSettingObj!)
        //   self.presentViewController(NavigationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(AccountSettingObj!, animated: true)
    }
    
    @IBAction func termsCondAction(sender: AnyObject) {
        let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("termsncond") as? TermsConditionViewController
        // let NavigationController = UINavigationController(rootViewController: AccountSettingObj!)
        //   self.presentViewController(NavigationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(AccountSettingObj!, animated: true)
    }
    
    @IBAction func privacyPolicyAction(sender: AnyObject) {
        let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("legal") as? LegalViewController
        // let NavigationController = UINavigationController(rootViewController: AccountSettingObj!)
        //   self.presentViewController(NavigationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(AccountSettingObj!, animated: true)
    }
    func profileSucc(notification:NSNotification){
        let string : AnyObject = notification.userInfo!
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Profile"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName : headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
        
        let contentInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        self.scroll1.contentInset = contentInsets
        self.scroll1.scrollIndicatorInsets = contentInsets
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(AccountSettingView.profileSucc(_:)),
                                                         name: "profileDet",
                                                         object: nil)
        
        
        
      let wsm : WebServiceClass = WebServiceClass.sharedInstance
        wsm.delegates=self
       
        // Do any additional setup after loading the view, typically from a nib.
        let defaults = NSUserDefaults.standardUserDefaults()
        if let data = defaults.objectForKey("LoginObject") as? NSData
        {
//            let unarc = NSKeyedUnarchiver(forReadingWithData: data)
           // let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
         
            if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
            {
                //print(blog)
                wsm.callAdressApi(blog.valueForKey("userId")! as! Int)
                self.emailTextField.text = blog.valueForKey("email")! as! String
                self.personalNameTF.text = blog.valueForKey("firstName")! as! String
                self.lastNameTF.text = blog.valueForKey("lastName")! as! String
                 self.mobileNumberTF.text = defaults.valueForKey("contactNumber")! as! String
                 //self.mobileNumberTF.text = blog.valueForKey("email")! as! String
                 self.emailAddressTF.text = blog.valueForKey("email")! as! String
                
                
            }
            
       
        }
        
        //password.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(AccountSettingView.handleTap(_:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        self.buttonsView.hidden = true
        
        personalNameTF.userInteractionEnabled = false
        personalNameTF.userInteractionEnabled = false
        lastNameTF.userInteractionEnabled = false
        mobileNumberTF.userInteractionEnabled = false
        emailAddressTF.userInteractionEnabled = false
        
//        passView.translatesAutoresizingMaskIntoConstraints = true
//        addView.translatesAutoresizingMaskIntoConstraints = false
//        infoView.translatesAutoresizingMaskIntoConstraints = false
//        
     passView.frame = CGRectMake(10.0, 20.0, 350.0, 161.0)
        
        changePassBtn.layer.borderWidth = 1;
        changePassBtn.layer.borderColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1).CGColor
        //changePassBtn.translatesAutoresizingMaskIntoConstraints = true
        changePassBtn.frame = CGRect(x: 10, y: 78, width: 282, height: 40)
        passView.addSubview(changePassBtn)
        
        
        changeAddressBtn.layer.borderWidth = 1;
        changeAddressBtn.layer.borderColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1).CGColor
        
        changeInfoBtn.layer.borderWidth = 1;
        changeInfoBtn.layer.borderColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1).CGColor
        
        saveButton.layer.borderWidth = 1;
        saveButton.layer.borderColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1).CGColor
    }
    
    
    @IBAction func changeAddressActionButton(sender: AnyObject) {
        
       // changeAddressBtn.resignFirstResponder()
        // let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
       if let addresstext = self.addressTextField.text  where !addresstext.isEmpty
       {
        let nextViewController =  self.storyboard?.instantiateViewControllerWithIdentifier("editAddress") as! EditAddressViewController
        nextViewController.NoAddrFlag = "Address"
//        nextViewController.addSegmentoutlet.selectedSegmentIndex = 0;
//        nextViewController.addSegmentoutlet.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        else
       {
        let nextViewController =  self.storyboard?.instantiateViewControllerWithIdentifier("editAddress") as! EditAddressViewController
        nextViewController.NoAddrFlag = "NoAddress"
//        nextViewController.addSegmentoutlet.selectedSegmentIndex = 1;
//        nextViewController.addSegmentoutlet.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        }
        
    }
    

    func handleTap(sender: UITapGestureRecognizer? = nil) {
        emailTextField.resignFirstResponder()
        addressTextField.resignFirstResponder()
        personalNameTF.resignFirstResponder()
        lastNameTF.resignFirstResponder()
        mobileNumberTF.resignFirstResponder()
        emailAddressTF.resignFirstResponder()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = "My Profile";
       
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(AccountSettingView.updatepersonal(_:)),
                                                         name: "profileupdate",
                                                         object: nil)
        
        super.viewWillAppear(animated)
         self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        
        registerKeyboardNotifications()
        let wsm : WebServiceClass = WebServiceClass.sharedInstance
        wsm.delegates=self
        let defaults = NSUserDefaults.standardUserDefaults()
        if let data = defaults.objectForKey("LoginObject") as? NSData
        {
            //            let unarc = NSKeyedUnarchiver(forReadingWithData: data)
            // let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
            
            if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
            {
                wsm.callAdressApi(blog.valueForKey("userId")! as! Int)
            }}
        
        
       
        if let data = defaults.objectForKey("LoginObject") as? NSData
        {
            //            let unarc = NSKeyedUnarchiver(forReadingWithData: data)
            // let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
            
//            if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
//            {
                //wsm.callAdressApi(blog.valueForKey("userId")! as! Int)
                self.emailTextField.text = defaults.valueForKey("email")! as! String
                self.personalNameTF.text = defaults.valueForKey("firstName")! as! String
                self.lastNameTF.text = defaults.valueForKey("lastName")! as! String
                self.mobileNumberTF.text = defaults.valueForKey("contactNumber")! as! String
                //self.mobileNumberTF.text = blog.valueForKey("email")! as! String
                self.emailAddressTF.text = defaults.valueForKey("email")! as! String
                
                
         //   }
            
            
        }
//        if(screenSize.width == 750){
//        
//        TCBtn.translatesAutoresizingMaskIntoConstraints = true
//        TCBtn.frame = CGRectMake(68, 701, 89, 25)
//        
//        policyBtn.translatesAutoresizingMaskIntoConstraints = true
//        policyBtn.frame = CGRectMake(180, 701, 82, 25)
//        }
    }
    func updatepersonal(notification:NSNotification)
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(self.personalNameTF.text!, forKey: "firstName")
        defaults.setObject(self.emailTextField.text!, forKey: "email")
        defaults.setObject(self.lastNameTF.text!, forKey: "lastName")
        
        
        
    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyboardNotifications()
         NSNotificationCenter.defaultCenter().removeObserver(self, name: "profileDet", object: nil)
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
        let contentInsets = UIEdgeInsetsMake(0, 0, 180, 0)
        self.scroll1.contentInset = contentInsets
        self.scroll1.scrollIndicatorInsets = contentInsets
        
        var viewRect = view.frame
        viewRect.size.height -= keyboardSize.height
        
        //        if CGRectContainsPoint(viewRect, self.FirstNameField.frame.origin) {
        //            let scrollPoint = CGPointMake(0, self.FirstNameField.frame.origin.y - keyboardSize.height)
        //            self.scroll1.setContentOffset(scrollPoint, animated: true)
        //        }
               
    }
    
   
    func keyboardWillHide(notification: NSNotification)
    {
        self.scroll1.contentInset = UIEdgeInsetsZero
        self.scroll1.scrollIndicatorInsets = UIEdgeInsetsZero
     
    }

    
    func textFieldDidBeginEditing(textField: UITextField) {
        
       // moveTextField(textField, moveDistance: -250, up: true)
        
        if textField == mobileNumberTF{
            mobileNumberTF.resignFirstResponder()
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("nextView") as! MobileNumberViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
   func callAddressapiresponse(string:NSArray)
   {
//    print(string.objectAtIndex(0))
    if string.count == 0
    {
        self.addressTextField.text = ""
        self.changeAddressBtn.setTitle("ADD ADDRESS", forState: UIControlState.Normal)
    }
    else
    {
         self.changeAddressBtn.setTitle("CHANGE ADDRESS", forState: UIControlState.Normal)
    for address in string
    {
        if let dfaultadd : Bool = address["isDefault"] as! Bool
    {
       // print(dfaultadd)
        if(dfaultadd)
        {
        self.addressTextField.text = "\(address["address1"] as! String),\(address["area"] as! String),\(address["city"] as! String),\(address["stateName"] as! String),\(address["zipCode"] as! String)"
        }
    }
    
    }
    }//print(string["state"]!.objectAtIndex(0).valueForKey("stateName")!)
    }
    func  callAddressapiFailedDelegate()
    {
   // print("ERROR")
    
    }
    func textFieldDidEndEditing(textField: UITextField) {
       // moveTextField(textField, moveDistance: -250, up: false)
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
    
    
    
}


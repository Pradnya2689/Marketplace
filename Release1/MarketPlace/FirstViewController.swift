//
//  FirstViewController.swift
//  MarketPlace
//
//  Created by inpanr07 on 24/06/16.
//  Copyright (c) 2016 inpanr07. All rights reserved.
//

import UIKit
import CoreLocation
import AddressBookUI

var Globalstate : NSString = "Maharashtra"
var Globalstateid : NSString = "13"

public class Toast{
    
    class var sharedInstance: Toast {
        struct Static {
            static let sharedInstance: Toast = Toast()
        }
        return Static.sharedInstance
    }
    
    
    func rectForText(text: String, font: UIFont, maxSize: CGSize) -> CGSize {
        let attrString = NSAttributedString.init(string: text, attributes: [NSFontAttributeName:font])
        let rect = attrString.boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
        let size = CGSizeMake(rect.size.width, rect.size.height)
        return size
    }
    
    
    public func toastNormal(backgroundColor:UIColor, textColor:UIColor, message:String, numberOfLines:Int, height:CGFloat, position:String)
    {
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let label = UILabel(frame: CGRectZero)
        label.textAlignment = NSTextAlignment.Center
        label.text = message
        label.font = UIFont(name: "MyriadPro-Regular", size: 13)
        label.adjustsFontSizeToFitWidth = true
        
        label.backgroundColor =  UIColor(red: 26.0/255.0, green: 41.0/255.0, blue: 64.0/255.0, alpha: 1)
        label.textColor = UIColor.whiteColor()
        
        label.sizeToFit()
        label.numberOfLines = numberOfLines
        label.layer.shadowColor = UIColor.grayColor().CGColor
        label.layer.shadowOffset = CGSizeMake(4, 3)
        label.layer.shadowOpacity = 0.3
        if(position == "bottom"){
            label.frame = CGRectMake((screenWidth-200)/2,screenHeight-50, 200, height)
        }else if(position == "center"){
            label.frame = CGRectMake((screenWidth-200)/2,(screenHeight-height)/2, 200, height)
        }else{
            label.frame = CGRectMake((screenWidth-200)/2,120, 200, height)
        }
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.alpha = 1
        
       // Indicator.sharedInstance.stopActivityIndicator()
        appDelegate.window!.addSubview(label)
        
        UIView.animateWithDuration(2.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            //label.frame = CGRectMake((screenWidth-200)/2,screenHeight-50, 200, height)
            if(position == "bottom"){
                label.frame = CGRectMake((screenWidth-200)/2,screenHeight-50, 200, height)
            }else if(position == "center"){
                label.frame = CGRectMake((screenWidth-200)/2,(screenHeight-height)/2, 200, height)
            }else{
                label.frame = CGRectMake((screenWidth-200)/2,120, 200, height)
            }
            },  completion: {
                (value: Bool) in
                UIView.animateWithDuration(2.0, delay: 2.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    label.alpha = 0
                    },  completion: {
                        (value: Bool) in
                        label.removeFromSuperview()
                })
        })
    }
    
    
    public func textOnlyToast(message:String, position:String)
    {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let label = UILabel(frame: CGRectZero)
        label.textAlignment = NSTextAlignment.Center
        label.text = message
        label.font = UIFont(name: "MyriadPro-Regular", size: 13)
        label.adjustsFontSizeToFitWidth = true
        
        label.backgroundColor =  UIColor(red: 26.0/255.0, green: 41.0/255.0, blue: 64.0/255.0, alpha: 1)
        label.textColor = UIColor.whiteColor()
        
        var sizeoftxt:CGSize  = rectForText(message, font: label.font, maxSize: CGSizeMake(screenWidth-100,200))
        
        
        label.sizeToFit()
        label.numberOfLines = 10
        label.layer.shadowColor = UIColor.grayColor().CGColor
        label.layer.shadowOffset = CGSizeMake(4, 3)
        label.layer.shadowOpacity = 0.3
        if(position == "bottom"){
            label.frame = CGRectMake((screenWidth-200)/2,screenHeight-50, 200, sizeoftxt.height)
        }else if(position == "center"){
            label.frame = CGRectMake((screenWidth-200)/2,(screenHeight-sizeoftxt.height)/2, 200, sizeoftxt.height)
        }else{
            label.frame = CGRectMake((screenWidth-200)/2,120, 200, sizeoftxt.height)
        }
        //label.frame = CGRectMake((screenWidth-200)/2,(screenHeight-sizeoftxt.height)/2, 200, sizeoftxt.height)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.alpha = 1
        
       // Indicator.sharedInstance.stopActivityIndicator()
        appDelegate.window!.addSubview(label)
        
        UIView.animateWithDuration(2.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            if(position == "bottom"){
                label.frame = CGRectMake((screenWidth-200)/2,screenHeight-50, 200, sizeoftxt.height)
            }else if(position == "center"){
                label.frame = CGRectMake((screenWidth-200)/2,(screenHeight-sizeoftxt.height)/2, 200, sizeoftxt.height)
            }else{
                label.frame = CGRectMake((screenWidth-200)/2,120, 200, sizeoftxt.height)
            }
            //label.frame = CGRectMake((screenWidth-200)/2,(screenHeight-sizeoftxt.height)/2, 200, sizeoftxt.height)
            },  completion: {
                (value: Bool) in
                UIView.animateWithDuration(2.0, delay: 2.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    label.alpha = 0
                    },  completion: {
                        (value: Bool) in
                        label.removeFromSuperview()
                })
        })
        
    }
    
    public func intervalToast(message:String, interval:Double, position:String,finished: () -> Void)
    {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let label = UILabel(frame: CGRectMake((screenWidth-200)/2,screenHeight-150, 200, 100))
        label.textAlignment = NSTextAlignment.Center
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        paragraphStyle.alignment = NSTextAlignment.Center
        let attrString = NSMutableAttributedString(string: message)
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        label.attributedText = attrString;
        //label.text = message
        label.font = UIFont(name: "MyriadPro-Regular", size: 16)
        //label.adjustsFontSizeToFitWidth = true
        
        label.backgroundColor =  UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
        label.textColor = UIColor.whiteColor()
        
        var sizeoftxt:CGSize  = rectForText(message, font: label.font, maxSize: CGSizeMake(screenWidth-100,200))
        
        
        //label.sizeToFit()
        label.numberOfLines = 3
        //label = 10
        label.layer.shadowColor = UIColor.grayColor().CGColor
        label.layer.shadowOffset = CGSizeMake(4, 3)
        label.layer.shadowOpacity = 0.3
         label.frame = CGRectMake((screenWidth-200)/2,(screenHeight-sizeoftxt.height)/2, 200, 60)
//        if(position == "bottom"){
//
//        }else if(position == "center"){
//            label.frame = CGRectMake((screenWidth-200)/2,(screenHeight-sizeoftxt.height)/2, 200, sizeoftxt.height)
//        }else{
//            label.frame = CGRectMake((screenWidth-200)/2,120, 200, sizeoftxt.height)
//        }
        //label.frame = CGRectMake((screenWidth-200)/2,(screenHeight-sizeoftxt.height)/2, 200, sizeoftxt.height)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.alpha = 1
        
      //  Indicator.sharedInstance.stopActivityIndicator()
        appDelegate.window!.addSubview(label)
       // appDelegate.window?.bringSubviewToFront(label)
        
        UIView.animateWithDuration(3.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            if(position == "bottom"){
                label.frame = CGRectMake((screenWidth-200)/2,(screenHeight-sizeoftxt.height)/2, 200, 60)
            }else if(position == "center"){
                label.frame = CGRectMake((screenWidth-200)/2,(screenHeight-sizeoftxt.height)/2, 200, sizeoftxt.height)
            }else{
                label.frame = CGRectMake((screenWidth-200)/2,120, 200, sizeoftxt.height)
            }
            //label.frame = CGRectMake((screenWidth-200)/2,(screenHeight-sizeoftxt.height)/2, 200, sizeoftxt.height)
            },  completion: {
                (value: Bool) in
                UIView.animateWithDuration(interval, delay: 3.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    label.alpha = 0
                    },  completion: {
                        (value: Bool) in
                        label.removeFromSuperview()
                        finished()
                })
        })
        
    }
}

class FirstViewController: UIViewController,CLLocationManagerDelegate  {
    
    var Location: [String] {
        get {
            if let returnValue = NSUserDefaults.standardUserDefaults().objectForKey("Location") as? [String] {
                return returnValue == [] ? [] : returnValue
            } else {
                return ["Maharashtra","13"] //Default value
            }
        }
        set
        {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "Location")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    

    @IBOutlet weak var logoImgView: UIImageView!
    
   
    
    let scrSize: CGRect = UIScreen.mainScreen().bounds
     var locationManager = CLLocationManager()
     var state : NSString!
     var dataLayer: TAGDataLayer = TAGManager.instance().dataLayer
    @IBOutlet weak var versionLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        state = ""
        
       // print(Location)
       
         dataLayer.push(["event": "openScreen", "screenName": "SplashScreenTagios"])
        //  self.title="IMOL"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
        self.navigationController?.navigationBarHidden = true
        // let tabBarItem = UITabBarItem(tabBarSystemItem:0, tag: UIImage(named: "more"))
        
        let tabBarItem = UITabBarItem(title:"", image:UIImage(named: "ichome"), tag: 0)
        tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // Do any additional setup after loading the view, typically from a nib.
        
        versionLabel.frame = CGRectMake(scrSize.width-100, scrSize.height-31, 70, 21)
        let versionNumber = String(format:"Version %@", NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String)
      //  let aStr = String(format: "%@%x", "timeNow in hex: ", timeNow)
        versionLabel.text = versionNumber
       
        
      }
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let isAppAlreadyLaunchedOnce = defaults.stringForKey("isAppAlreadyLaunchedOnce"){
           // print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.setBool(true, forKey: "isAppAlreadyLaunchedOnce")
           // print("App launched first time")
            return false
        }
    }
    func isAppAlreadyLaunchedOnceagain()->Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let isAppAlreadyLaunchedOnce = defaults.stringForKey("isAppAlreadyLaunchedOnceagain"){
            //print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.setBool(true, forKey: "isAppAlreadyLaunchedOnceagain")
           // print("App launched first time")
            return false
        }
    }

    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {

        self.locationManager.stopUpdatingLocation()
        self.locationManager.delegate = nil;
        let window :UIWindow = UIApplication.sharedApplication().keyWindow!
        LoadingOverlay.shared.showOverlay(window)
        let SearchAddressControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("SearchAddress") as? SearchAddressController
        SearchAddressControllerObj?.countryToPass = arrayState
        SearchAddressControllerObj?.flagset = "country"
        
        let NavigationController = UINavigationController(rootViewController: SearchAddressControllerObj!)
        // tableView.deselectRowAtIndexPath(indexPath!, animated: false)
        self.presentViewController(NavigationController, animated: true, completion: nil)
        LoadingOverlay.shared.hideOverlayView()
    }

    
     func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         self.locationManager.stopUpdatingLocation()
        self.locationManager.delegate = nil;

        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
       // print("locations = \(locValue.latitude) \(locValue.longitude)")

            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
            geoCoder.reverseGeocodeLocation(location)
            {
                (placemarks, error) -> Void in
                
                let placeArray = placemarks as [CLPlacemark]!
                if(placeArray != nil){
                // Place details
                var placeMark: CLPlacemark!
                placeMark = placeArray?[0]
                
                // Address dictionary
               // print(placeMark.addressDictionary)
                
                if let country = placeMark.addressDictionary?["State"] as? NSString
                {
                   self.state = country
                    //print(country)
                   // Location
                    
                    self.compareTwoStates()
                    
                }
                }else{
                    var alert = UIAlertController(title: "", message: "Could not find your location.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(action:UIAlertAction) in
                       
                        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        if (appdelegate.isReachable == true) {
                        var window :UIWindow = UIApplication.sharedApplication().keyWindow!
                        LoadingOverlay.shared.showOverlay(window)
                        let SearchAddressControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("SearchAddress") as? SearchAddressController
                        SearchAddressControllerObj?.countryToPass = arrayState
                        SearchAddressControllerObj?.flagset = "country"
                        
                        let NavigationController = UINavigationController(rootViewController: SearchAddressControllerObj!)
                        // tableView.deselectRowAtIndexPath(indexPath!, animated: false)
                        self.presentViewController(NavigationController, animated: true, completion: nil)
                        LoadingOverlay.shared.hideOverlayView()
                        }else{
                            self.fadeOut()
                        }
                        
                    }));
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }


       
    }
    
    func compareTwoStates() {
        for state in arrayState
        {
            if let st = state.valueForKey("stateName")
            {
                
                if(st.caseInsensitiveCompare(self.state! as String) == NSComparisonResult.OrderedSame)
                {
                    Globalstate = st as! NSString
                   // print(Globalstate)
                    NSUserDefaults.standardUserDefaults().removeObjectForKey("Location")
                    
                    Location = [Globalstate as String]
                    if let stid = state.valueForKey("stateId")
                    {
                       // NSUserDefaults.standardUserDefaults().removeObjectForKey("Location")
                        var ststID = stid as! NSString
                        Globalstateid = stid as! NSString
                        Location += [stid as! String]
                                if let returnValue = NSUserDefaults.standardUserDefaults().objectForKey("Location") as? [String]{
                        
                                     statename = returnValue[0]
                                     stateid = returnValue[1]
                                     authorizationWithoutLogin = "Mobileprod456~~~~~\(ststID)"
                                   
                                    let defaults = NSUserDefaults.standardUserDefaults()
                                    if  let data = defaults.objectForKey("LoginObject") as? NSData{
                                     let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                                                         
                                    //Prod
                                     authorizationWithLogin = "Mobileprod456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(ststID)"
                                     authorizationWithLogin1 = "Mobileprod456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(ststID)"
                                    }
                                }
                    }
                    let statestr = st as! String
                     self.fadeOut()
//                    Toast.sharedInstance.intervalToast("You are viewing prices for \(statestr)", interval: 2, position: "bottom") {
//                        
//                        //do something here after running your function
//                        print("Tada!!!!")
//                       
//                    }
                   // self.showAlertView("You are viewing prices for \(statestr)", message: nil)
                    
                    return
                }
                
                var window :UIWindow = UIApplication.sharedApplication().keyWindow!
                LoadingOverlay.shared.showOverlay(window)
                let SearchAddressControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("SearchAddress") as? SearchAddressController
                SearchAddressControllerObj?.countryToPass = arrayState
                SearchAddressControllerObj?.flagset = "country"
                
                let NavigationController = UINavigationController(rootViewController: SearchAddressControllerObj!)
                // tableView.deselectRowAtIndexPath(indexPath!, animated: false)
                self.presentViewController(NavigationController, animated: true, completion: nil)
                LoadingOverlay.shared.hideOverlayView()
            }
            
            
            
        }

    }
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.startUpdatingLocation()
        }
        
    }

    func getCityStateApiResponse(notification: NSNotification)  {
        LoadingOverlay.shared.hideOverlayView()
        let dict : AnyObject = notification.userInfo!
        
        
        let dict1 : AnyObject = dict as! [NSObject : AnyObject]
        //print(dict1)
        var stateDict = dict1 as! NSDictionary
       // print(stateDict)
        arrayState.removeAllObjects()
        let countryArr = dict["state"] as! NSArray
        for country  in countryArr
        {
                       arrayState.addObject(country)
        }
      
        if CLLocationManager.locationServicesEnabled() {
           
                    locationManager = CLLocationManager.init()
                    locationManager.delegate = self
                    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            let authorizationStatus = CLLocationManager.authorizationStatus()
//            if (authorizationStatus == CLAuthorizationStatus.NotDetermined) {
                locationManager.requestAlwaysAuthorization()
                locationManager.requestLocation()
//            } else if (authorizationStatus == CLAuthorizationStatus.AuthorizedWhenInUse) {
                locationManager.startUpdatingLocation()
            //}
           
        } else {
           // print("Location services are not enabled")
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            LoadingOverlay.shared.showOverlay(window)
            let SearchAddressControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("SearchAddress") as? SearchAddressController
            SearchAddressControllerObj?.countryToPass = arrayState
            SearchAddressControllerObj?.flagset = "country"
            
            let NavigationController = UINavigationController(rootViewController: SearchAddressControllerObj!)
            
            self.presentViewController(NavigationController, animated: true, completion: nil)
            LoadingOverlay.shared.hideOverlayView()
        }
       
        
       }
    
    func showAlertView(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "", style: .Cancel, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
           // print("Bye. Lovvy")
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    func cancelclicked()
    {
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Location")
//        Location += ["Maharashtra"]
//        Location += ["13"]
        
         self.fadeOut()
       // print(Location)

        
    }

    func countryList(notification: NSNotification)
    {
        let dict : AnyObject = notification.userInfo!
        // let receivednumber : String = dict["valueToPass"] as! String
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Location")
        Location = []
        let receivednumber1  = dict["valueToPass"] as! NSDictionary
        
        if let add = receivednumber1["stateName"]
        {
            
            Globalstate = add as! NSString
        Location += [add as! String]
            
        }
        if let STAid = receivednumber1["stateId"]
        {
            var ststID = STAid as! NSString
            Globalstateid = STAid as! NSString
            Location += [STAid as! String]
            if let returnValue = NSUserDefaults.standardUserDefaults().objectForKey("Location") as? [String]{
                
                statename = returnValue[0]
                stateid = returnValue[1]
                authorizationWithoutLogin = "Mobileprod456~~~~~\(ststID)"
                
                let defaults = NSUserDefaults.standardUserDefaults()
                if  let data = defaults.objectForKey("LoginObject") as? NSData{
                    let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                    
                    
                    //Prod
                    authorizationWithLogin = "Mobileprod456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(ststID)"
                    authorizationWithLogin1 = "Mobileprod456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(ststID)"
                }
            }
        }
         self.fadeOut()
//        Toast.sharedInstance.intervalToast("You are viewing prices for \(Globalstate)", interval: 2, position: "bottom") {
//
//            //do something here after running your function
//            print("Tada!!!!")
//        }

           }

    
    override func viewWillAppear(animated: Bool) {
        
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(FirstViewController.getCityStateApiResponse(_:)),
                                                         name: "stateCompare",
                                                         object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "country", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FirstViewController.countryList(_:)), name: "country", object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "CancelClicked", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FirstViewController.cancelclicked), name: "CancelClicked", object: nil)
        
        
        let scrWidth = scrSize.width
        let scrHeight = scrSize.height
        let xcord = ((scrWidth-246)/2)
        let ycord = ((scrHeight-140)/2)
        self.logoImgView.translatesAutoresizingMaskIntoConstraints = true
        logoImgView.frame = CGRectMake(xcord, view.bounds.height, 246 ,140)
//        print(scrWidth)
//        print(scrHeight)
    }
    
    override func viewDidAppear(animated: Bool) {
        let scrWidth = scrSize.width
        let scrHeight = scrSize.height
        let xcord = ((scrWidth-246)/2)
        let ycord = ((scrHeight-140)/2)
        UIView.animateWithDuration(2.0, delay: 2.0, usingSpringWithDamping: 2.0, initialSpringVelocity: 11.5, options: .CurveEaseOut, animations:{
            self.logoImgView.translatesAutoresizingMaskIntoConstraints = true
            self.logoImgView.frame = CGRectMake(xcord, ycord, 246, 140)
            
        }, completion:
            {
            finished in
                
                if (self.isAppAlreadyLaunchedOnce())
                {
                    self.fadeOut()
                    
                }
                else
                {
                   let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    if (appdelegate.isReachable == true) {
                    let wsmm : WebServiceClass = WebServiceClass.sharedInstance
                    wsmm.callstateApiicompare()
                    }else{

                        self.fadeOut()
                    }
  
                    
                }
            // remove the views
//            if finished {
//                func fadeOut() {
//                    UIView.animateWithDuration(0.5, delay: 0.5, options: UIViewAnimationOptions.CurveEaseOut, animations: {
//                        self.view.alpha = 0.0
//                        }, completion: {
//                        finished in
            
                         if finished {
                            //self.fadeOut()
//                                    let chkVC = self.storyboard?.instantiateViewControllerWithIdentifier("tabVC") as! TabViewController
//                                  // let NavigationController = UINavigationController(rootViewController: chkVC)
//                                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                                       // let viewController = mainStoryboard.instantiateViewControllerWithIdentifier("tabBarcontroller") as UITabBarController
//                                        UIApplication.sharedApplication().keyWindow?.rootViewController = chkVC;
                        }
                        
                        
                        })
       

                      // }
//            let chkVC = self.storyboard?.instantiateViewControllerWithIdentifier("tabVC") as! TabViewController
//                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                UIApplication.sharedApplication().keyWindow?.rootViewController = chkVC;
          }
     // })
        
           // print(xcord)
        
  // }
    
    func fadeOut()
    {
        
       let chkVC = self.storyboard?.instantiateViewControllerWithIdentifier("tabVC") as! TabViewController
         let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         UIApplication.sharedApplication().keyWindow?.rootViewController = chkVC;
        
        chkVC.view.addSubview(self.view)
        
        //UIApplication.sharedApplication().keyWindow?.backgroundColor = UIColor.whiteColor()
//        UIView.transitionWithView((chkVC.view)!, duration: 5.5, options: UIViewAnimationOptions.CurveEaseOut, animations: {
//           // self.view.alpha = 0.0
//            //UIApplication.sharedApplication().keyWindow?.rootViewController = chkVC;
//            }, completion:{ finished in
//            if finished {
//           self.view.removeFromSuperview()
//        }
//    })
//
//        UIView.transitionFromView((self.view.window?.rootViewController?.view)!, toView: chkVC.view, duration: 0.5, options: UIViewAnimationOptions.CurveEaseOut , completion: {
//            
//            finished in
//            if finished {
//                   UIApplication.sharedApplication().keyWindow?.rootViewController = chkVC;
//            }
//     })
    
       // UIView.animateWithDuration(<#T##duration: NSTimeInterval##NSTimeInterval#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
        
//        [UIView transitionFromView:self.window.rootViewController.view
//            toView:viewController.view
//            duration:0.65f
//            options:transition
//            completion:^(BOOL finished){
//            let chkVC = self.storyboard?.instantiateViewControllerWithIdentifier("tabVC") as! TabViewController
//            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//             UIApplication.sharedApplication().keyWindow?.rootViewController = chkVC;
//            }];
//        
//        let chkVC = self.storyboard?.instantiateViewControllerWithIdentifier("tabVC") as! TabViewController
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//       // UIApplication.sharedApplication().keyWindow?.backgroundColor = UIColor.whiteColor()
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.view.alpha = 0.0
            //                                 UIApplication.sharedApplication().keyWindow?.rootViewController = chkVC;
            }, completion: { finished in
                if finished {
                    //self.view.removeFromSuperview() //rishikesh edit 
                    if (self.isAppAlreadyLaunchedOnceagain())
                    {
                        
                    }else{
                        Toast.sharedInstance.intervalToast("You are viewing prices for \(Globalstate)", interval:3, position: "bottom") {
                            
                            //do something here after running your function
                           // print("Tada!!!!")
                        }
                    }

                }
            }
        )
        
//
                               }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


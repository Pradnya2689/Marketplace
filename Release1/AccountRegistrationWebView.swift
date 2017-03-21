//
//  AccountRegistrationWebView.swift
//  MarketPlace
//
//  Created by inpanr07 on 14/11/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
 var accountRegistration : String! = ""

//protocol MyProtocol: class
//{
//    func sendStringToPreviousVC(submitBtnstatus:String)
//}

class AccountRegistrationWebView: UIViewController,UIWebViewDelegate {
    
     @IBOutlet var webv: UIWebView!
   // weak var mDelegate:MyProtocol?
    
    var orderid : String! = ""
   

    override func viewDidLoad() {
        super.viewDidLoad()
        //print(self.orderid)
        self.webv.delegate = self
        let url = NSBundle.mainBundle().URLForResource("registration", withExtension:"html")
        let request = NSURLRequest(URL: url!)
        self.webv.loadRequest(request)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(AccountRegistrationWebView.AccountConfirmation(_:)),
                                                         name: "Accountregconfirm",
                                                         object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(AccountRegistrationWebView.AccountConfirmationFailed(_:)),
                                                         name: "ConfirmationFailed",
                                                         object: nil)
        
    }

    func AccountConfirmation(notification:NSNotification)
    {
        let submitBtn : String = "AccConfirmationDone"
        accountRegistration = "AccountRegistered"
//        mDelegate?.sendStringToPreviousVC(submitBtn)
         LoadingOverlay.shared.hideOverlayView()
        self.navigationController?.popViewControllerAnimated(true)
        //        print("in return via reachable")
    }
 func AccountConfirmationFailed(notification:NSNotification)
 {
    // LoadingOverlay.shared.hideOverlayView()
    self.navigationController?.popViewControllerAnimated(true)
    //        print("in return via reachable")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func webViewDidStartLoad(webView : UIWebView) {
        //UIApplication.sharedApplication().networkActivityIndicatorVisible = true
       // print("AA")
    }
    
    func webViewDidFinishLoad(webView : UIWebView) {
        //UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        //print("BB")
        if (webView.loading)
        {
        return
        }
        else{
        LoadingOverlay.shared.hideOverlayView()
        }
        
        
        //        if let returnedString = webv.stringByEvaluatingJavaScriptFromString(script)
        //        {
        //            print("the result is \(returnedString)")
        //        }
    }
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        var window :UIWindow = UIApplication.sharedApplication().keyWindow!
        //  JHProgressHUD.sharedHUD.showInView(self.view)
        LoadingOverlay.shared.showOverlay(window)
        let myAppScheme = "imol";
        let myActionType = "myJavascriptActionType";
        //        if (![request.URL.scheme isEqualToString:myAppScheme]) {
        //            return YES;
        //        }
      //  print(request.URL?.scheme)
      //  print(request.URL?.host)
        
        if (request.URL?.scheme != myAppScheme)
        {
            return true;
        }
       // print(request.URL?.fragment!)
            let  actionType : String = (request.URL?.host)!
            let  jsonDictString : String = (request.URL?.fragment!.stringByReplacingPercentEscapesUsingEncoding(NSASCIIStringEncoding))!
        let  text2 = jsonDictString.stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let  text3 = text2.stringByReplacingOccurrencesOfString("}", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
      //  print(text2)
       
        
        let tokenstring : String!
        if let token : String = text3.componentsSeparatedByString(":").last {
            tokenstring = token
            
            let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            if (appdelegate.isReachable == true) {
                //self.noInternetVc.hidden = true
                var window :UIWindow = UIApplication.sharedApplication().keyWindow!
               // LoadingOverlay.shared.showOverlay(window)
                
                let wsm : WebServiceClass = WebServiceClass.sharedInstance
              //  print("token %@,%@",token,orderid)
                wsm.accregister(token, oredrID: orderid)
          //  print("token %@",token)
        }
        
        if (request.URL?.scheme == myAppScheme)
        {
//            let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//            if (appdelegate.isReachable == true) {
//                //self.noInternetVc.hidden = true
//                var window :UIWindow = UIApplication.sharedApplication().keyWindow!
//                LoadingOverlay.shared.showOverlay(window)
//                
//                let wsm : WebServiceClass = WebServiceClass.sharedInstance
//                wsm.accregister(tokenstring, oredrID: "2389")
            //    wsm.accregister( TOKE, oredrID: <#T##String#>)
            }else{
                //            self.noInternetVc.translatesAutoresizingMaskIntoConstraints = true
                //            self.noInternetVc.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
                //            self.view.addSubview(self.noInternetVc)
//                self.noInternetVc.hidden = false
//                self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
//                self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
//                self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
//                self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
//                self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
//                self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)
            }
        }
              return false
    }
    
    override func viewWillDisappear(animated: Bool) {
               NSNotificationCenter.defaultCenter().removeObserver(self, name: "Accountregconfirm", object: nil)
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


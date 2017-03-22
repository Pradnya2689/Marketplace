//
//  TermsConditionViewController.swift
//  MarketPlace
//
//  Created by Administrator on 8/24/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import Alamofire



class TermsConditionViewController: UIViewController, UIWebViewDelegate {
    
     @IBOutlet weak var termsConditionWebView: UIWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        self.title = "Terms of Use"
        self.tabBarController?.tabBar.hidden = true
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
        
         var window :UIWindow = UIApplication.sharedApplication().keyWindow!
        LoadingOverlay.shared.showOverlay(window)
        
        let headers = [
            "Authorization": authorizationWithoutLogin,
            "Content-Type" : "application/json"
        ]
        
        var url : NSURL!
        
       // url = NSURL(string:"\(baseUrl)MarketPlaceCMS?itemtype=staticcontent&page=Home&key=staticcontent")
         url = NSURL(string:"\(baseUrl)MarketPlaceCMS?itemtype=staticcontent&page=Home&key=terms-and-conditions")
       
       // url = NSURL(string: "\(baseUrl)MarketPlaceCMS?itemtype=staticcontent&page=Home&key=faq-help")
        
       Alamofire.request(.GET, url,headers: headers).responseJSON { response in

        if let JSON = response.result.value{
           // if  let staticcontent: AnyObject = JSON["staticContentList"]
            if  let staticcontent: AnyObject = JSON["staticContentListResponse"]
            {
               // if  let termAndcond: AnyObject = staticcontent["termsAndConditions"]
                if  let termAndcond: AnyObject = staticcontent["text"]
                {
                    //print(termAndcond)
                     LoadingOverlay.shared.hideOverlayView()
               // let trm = termAndcond["text"] as! String
                //self.termsConditionWebView.loadHTMLString(trm, baseURL: nil)
                    self.termsConditionWebView.loadHTMLString(termAndcond as! String, baseURL: nil)
                    
                }
                

            }
        }
                
        }

    }
    
    func webViewDidFinishLoad(webView: UIWebView)
    {
       
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

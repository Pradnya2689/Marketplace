//
//  FAQViewController.swift
//  MarketPlace
//
//  Created by Administrator on 05/12/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import Alamofire

class FAQViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var faqWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        self.title = "FAQ"
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
        
        url = NSURL(string: "\(baseUrl)MarketPlaceCMS?itemtype=staticcontent&page=Home&key=faq-help")
        
        Alamofire.request(.GET, url,headers: headers).responseJSON { response in
            
            if let JSON = response.result.value{
                if  let staticcontent: AnyObject = JSON["staticContentListResponse"]
                {
                    if  let termAndcond: AnyObject = staticcontent["text"]
                    {
                        print(termAndcond)
                        LoadingOverlay.shared.hideOverlayView()
                        self.faqWebView.loadHTMLString(termAndcond as! String, baseURL: nil)
                        
                    }
                    
                    
                }
            }
            
        }
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
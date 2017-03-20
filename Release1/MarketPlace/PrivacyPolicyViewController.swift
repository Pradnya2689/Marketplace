//
//  PrivacyPolicyViewController.swift
//  TermsAndPrivacy
//
//  Created by Administrator on 8/23/16.
//  Copyright © 2016 Administrator. All rights reserved.
//

import UIKit
import Alamofire

class PrivacyPolicyViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageViewController: UIPageViewController!
    var pageTitle: NSArray!
    var pageWebView: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.hidden = true
        self.navigationController?.navigationBarHidden = true
        self.pageTitle = NSArray(objects: "Privacy Policy","Refund And Cancellation Policy","Shipping And Delivery Policy")
    
        self.pageWebView = NSMutableArray()
        
        let headers = [
            "Authorization": authorizationWithoutLogin,
            "Content-Type" : "application/json"
        ]
        
        let button = UIButton(frame: CGRect(x: 0, y: 15, width: 60   , height: 40))
        button.backgroundColor = UIColor.whiteColor()
        button.setTitleColor(UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1), forState: .Normal)
        button.setTitle("Cancel", forState: .Normal)
        button.addTarget(self, action: #selector(cancelClicked), forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
    
        LoadingOverlay.shared.showOverlay(view)
        
        self .setupPageControl()
        var url : NSURL!
        
        url = NSURL(string:"\(baseUrl)MarketPlaceCMS?itemtype=staticcontent&page=Home&key=staticcontent")
        
        Alamofire.request(.GET, url,headers: headers).responseJSON { response in
            
            if let JSON = response.result.value{
                if  let staticcontent: AnyObject = JSON["staticContentList"]{
                    if  let policy: AnyObject = staticcontent["privacyPolicy"]{
                        //print(termAndcond)
                        let trm = policy["text"] as! String
                        self.pageWebView.addObject(trm)
                        //self.termsConditionWebView.loadHTMLString(trm, baseURL: nil)
                        
                    }
                    if  let policy: AnyObject = staticcontent["refundAndCancellationPolicy"]{
                        //print(termAndcond)
                        let trm = policy["text"] as! String
                        self.pageWebView.addObject(trm)
                        //self.termsConditionWebView.loadHTMLString(trm, baseURL: nil)
                        
                    }
                    if  let policy: AnyObject = staticcontent["shippingAndDeliveryPolicy"]{
                        //print(termAndcond)
                        let trm = policy["text"] as! String
                        self.pageWebView.addObject(trm)
                        //self.termsConditionWebView.loadHTMLString(trm, baseURL: nil)
                        
                    }
                    LoadingOverlay.shared.hideOverlayView()
                    self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageView") as! UIPageViewController
                    self.pageViewController.dataSource = self
                    self.pageViewController.view.contentMode = .ScaleToFill
                    // self.pageViewController.delegate = self
                    self.setupPageControl()

                    let startVC = self.viewControllerAtIndex(0)
                    let viewController = NSArray(object: startVC)
                    
                    self.pageViewController.setViewControllers(viewController as? [UIViewController], direction: .Forward, animated: true, completion: nil)
                    
                   self.view.addSubview(self.pageViewController.view)
                    self.pageViewController.didMoveToParentViewController(self)
                     self.view.addSubview(button)
                }
            }
        
        }
        
        
        
//        var b = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action:"cancelClicked")
//        //leftBarButton.title = "Cancel"
//        // rightBarButton.customView = btnName
//        self.navigationItem.leftBarButtonItem = b
        
    }
    
   @IBAction func cancelClicked(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func setupPageControl() {
        /*let appearance = UIPageControl.appearance()
        // appearance.tintColor = UIColor.clearColor()
        // appearance.translatesAutoresizingMaskIntoConstraints = true
        //   appearance.frame =  CGRectMake(0, 0, boundss.width, 5)
        appearance.pageIndicatorTintColor = UIColor.lightGrayColor()
        appearance.currentPageIndicatorTintColor = UIColor.blackColor()
        // appearance.indicatorDiameter
        appearance.backgroundColor = UIColor.redColor()
       // appearance.bounds = CGRectMake(0, 30, 0, 0)*/
        let pageController = UIPageControl.appearance()
        pageController.translatesAutoresizingMaskIntoConstraints = true
        pageController.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageController.currentPageIndicatorTintColor = UIColor.blackColor()

        pageController.backgroundColor = UIColor.whiteColor()
          pageController.bounds = CGRectMake(0, 0, 0, 0)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewControllerAtIndex(index: Int) -> ContentViewController{
        
        if ((self.pageTitle.count == 0) || (index >= self.pageTitle.count)){
            
            return ContentViewController()
        }
        
        let vc: ContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentView") as! ContentViewController
        
        vc.webviewIndex = self.pageWebView[index] as! String
        vc.titleIndex = self.pageTitle[index] as! String
        vc.pageIndex = index
        return vc
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if(index == 0 || index == NSNotFound)
        {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if(index == NSNotFound)
        {
            return nil
        }
        
        index += 1
        
        if(index == self.pageTitle.count)
        {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageTitle.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
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

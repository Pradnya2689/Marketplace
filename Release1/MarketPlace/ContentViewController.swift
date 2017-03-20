//
//  ContentViewController.swift
//  TermsAndPrivacy
//
//  Created by Administrator on 8/23/16.
//  Copyright © 2016 Administrator. All rights reserved.
//

import UIKit
import Alamofire

class ContentViewController: UIViewController,UIWebViewDelegate,UIScrollViewDelegate {
    
    @IBOutlet weak var privacyTitleLabel: UILabel!
    @IBOutlet weak var privacyWebView: UIWebView!
    
    var pageIndex: Int!
    var titleIndex: String!
    var webviewIndex: String!
    
//   var pageControl : UIPageControl = UIPageControl(frame: CGRectMake(0, 0, 30, 0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.privacyWebView.loadHTMLString(self.webviewIndex, baseURL: nil)
        self.privacyTitleLabel.text = self.titleIndex
        
//       self.privacyWebView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0)
        
        privacyWebView.scrollView.delegate = self
        
       // setupPageControl()
    }
    
//    private func setupPageControl() {
//        
////        let appearance = UIPageControl.appearance()
////        
////        appearance.pageIndicatorTintColor = UIColor.lightGrayColor()
////        appearance.currentPageIndicatorTintColor = bluedarkColor
////        
////        appearance.backgroundColor = UIColor.clearColor()
////        appearance.bounds = CGRectMake(0, 568, 0, 0)
//        
//        
////        self.pageControl.tintColor = UIColor.lightGrayColor()
////        //self.pageControl.pageIndicatorTintColor = UIColor.blackColor()
////        self.pageControl.currentPageIndicatorTintColor = bluedarkColor
////        self.view.addSubview(pageControl)
//        let appearance = UIPageControl.appearance()
//        appearance.pageIndicatorTintColor = UIColor.lightGrayColor()
//        appearance.currentPageIndicatorTintColor = UIColor.blueColor()
//        
//        appearance.backgroundColor = UIColor.clearColor()
//        appearance.bounds = CGRectMake(0, 30, 0, 0)
//    }
//    

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

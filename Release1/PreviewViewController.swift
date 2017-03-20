//
//  PreviewViewController.swift
//  MarketPlace
//
//  Created by Administrator on 15/12/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//
//Rishikesh
//Pange
import UIKit
import Alamofire

class PreviewViewController: UIViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    @IBOutlet weak var cancelButtonPreviewOutlet: UIButton!
    var pageControllerView : UIPageViewController!
    private var pageViewController: UIPageViewController?
    var slideImgArray : NSArray! = NSArray()
    let boundss = UIScreen.mainScreen().bounds

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.hidden = true
        self.navigationController?.navigationBarHidden = true
        
        self.configurePageControl()
        
        self.pageControllerView = UIPageViewController()
       
        
        self.pageControllerView = self.storyboard?.instantiateViewControllerWithIdentifier("imagePVC") as! UIPageViewController
        self.pageControllerView.dataSource = self
      
        
        let startVC = self.viewControllerAtIndex(0)
        let viewController = NSArray(object: startVC)
        
        self.pageControllerView.setViewControllers(viewController as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        self.addChildViewController(self.pageControllerView)
        self.view.addSubview(self.pageControllerView.view)
        self.pageControllerView.didMoveToParentViewController(self)
        
        cancelButtonPreviewOutlet.translatesAutoresizingMaskIntoConstraints = true
        cancelButtonPreviewOutlet.frame = CGRectMake(10, 35, 50, 40)
        
    }
    
    func configurePageControl() {
        if(slideImgArray.count <= 1)
        {
            
            let pageController = UIPageControl.appearance()
            pageController.translatesAutoresizingMaskIntoConstraints = true
            pageController.pageIndicatorTintColor = UIColor.clearColor()
            pageController.currentPageIndicatorTintColor = UIColor.clearColor()
            
            pageController.backgroundColor = UIColor.clearColor()
            pageController.bounds = CGRectMake(0, 0, 30, 0)
        }else{
        
            let pageController = UIPageControl.appearance()
            pageController.translatesAutoresizingMaskIntoConstraints = true
            pageController.pageIndicatorTintColor = UIColor.lightGrayColor()
            pageController.currentPageIndicatorTintColor = bluedarkColor
            
            pageController.backgroundColor = UIColor.whiteColor()
            pageController.bounds = CGRectMake(0, 0, 30, 0)
            
        }
    }

    @IBAction func cancelPreviewBtn(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func viewControllerAtIndex(index: Int) -> ContentImageViewController{
        print(slideImgArray.count)
        let vc1 = self.storyboard?.instantiateViewControllerWithIdentifier("ImageContentView") as! ContentImageViewController
        vc1.view.translatesAutoresizingMaskIntoConstraints = true
        vc1.view.frame=CGRectMake(0, 77, boundss.width,screenHeight-77)
        vc1.imageViewContent!.translatesAutoresizingMaskIntoConstraints = true
        vc1.imageViewContent!.frame=CGRectMake(0, 0, screenWidth, vc1.view.frame.size.height)
        vc1.imageName = self.slideImgArray[index] as! String

        print(vc1.imageName)
        vc1.pageIndex = index
        vc1.view.bringSubviewToFront(vc1.imageViewContent!)
        
        return vc1
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
         var vc1 = viewController as! ContentImageViewController
        var index = vc1.pageIndex as Int

        
        if index > 0
        {
            
            return self.viewControllerAtIndex(index-1)
            
        }
        else
        {
            return self.viewControllerAtIndex(slideImgArray.count-1)
        }
        
        return nil
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var vc1 = viewController as! ContentImageViewController
        var index = vc1.pageIndex as Int
        

        
        if index+1 < slideImgArray.count
        {
            
            return self.viewControllerAtIndex(index+1)
        }
        else{
            return self.viewControllerAtIndex(0)
        }


    }
     
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.slideImgArray.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

    
    

}

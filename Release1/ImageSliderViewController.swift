//
//  ImageSliderViewController.swift
//  MarketPlace
//
//  Created by Administrator on 09/11/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import Alamofire
class ImageSliderViewController: UIViewController, UIScrollViewDelegate,UIGestureRecognizerDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    var pageController : UIPageViewController!
    
    private var pageViewController: UIPageViewController?
    let boundss = UIScreen.mainScreen().bounds

    @IBOutlet weak var cancelSlideBtn: UIButton!

    @IBOutlet weak var imagesliderView: UIView!
    @IBAction func closeActionBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
   // @IBOutlet weak var cancelSlideBtn: UIButton!
    
    var slideImgArray : NSArray! = NSArray()
   
    
    var imageCounter : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //self.ImageScrollView.delegate = self
        
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(responseToSwipeLeft))
//        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
//        swipeLeft.delegate = self
//        self.ImageScrollView.addGestureRecognizer(swipeLeft)
//        
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(responseToSwipeRight))
//        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
//        swipeRight.delegate = self
//        self.ImageScrollView.addGestureRecognizer(swipeRight)
        print(slideImgArray.count)
        print(imagesliderView.frame.height-50)
        print(imagesliderView.frame.height)
        self.pageController = UIPageViewController()
        self.createPageViewController()
        
       // self.setupPageControl()
        
        imagesliderView.translatesAutoresizingMaskIntoConstraints = true
        imagesliderView.frame = CGRectMake(0, 108, screenWidth, (screenHeight-145))
        
        
        configurePageControl()
        
        navigationController?.navigationBarHidden = true
        
        cancelSlideBtn.translatesAutoresizingMaskIntoConstraints = true
        cancelSlideBtn.frame = CGRectMake(10, 40, 50, 40)
    }
    
    func configurePageControl() {
        if(slideImgArray.count <= 1)
        {

            
            
            let pageController = UIPageControl.appearance()
            pageController.translatesAutoresizingMaskIntoConstraints = true
            pageController.pageIndicatorTintColor = UIColor.clearColor()
            pageController.currentPageIndicatorTintColor = UIColor.clearColor()
            
            pageController.backgroundColor = UIColor.clearColor()
            pageController.bounds = CGRectMake(0, 250, 0, 0)
            }else{
            
            print(imagesliderView.frame.height)
            let pageController = UIPageControl.appearance()
            pageController.translatesAutoresizingMaskIntoConstraints = true
            pageController.pageIndicatorTintColor = UIColor.lightGrayColor()
            pageController.currentPageIndicatorTintColor = UIColor.blackColor()
            
            pageController.backgroundColor = UIColor.whiteColor()
            pageController.bounds = CGRectMake(0, 250, 0, 0)
           
        }
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return slideImgArray.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
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
    
    private func createPageViewController() {
        
        pageController.removeFromParentViewController()
        pageController.view.removeFromSuperview()
        pageController = UIPageViewController.init(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        //pageController
        // pageController.view.backgroundColor = UIColor.clearColor()
        pageController.view.sizeToFit()
        pageController.delegate = self
        pageController.dataSource = self
        
        if slideImgArray.count >= 0 {
            let firstController = getItemController(0)!
            // firstController.view.frame=CGRectMake(0, 0, boundss.width, self.bannerView.frame.size.height+40)
            let startingViewControllers = [firstController]
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        pageViewController?.view.translatesAutoresizingMaskIntoConstraints = true
        pageViewController!.view.frame = CGRectMake(0, 0, boundss.width, self.imagesliderView.frame.size.height+44)
        self.imagesliderView.translatesAutoresizingMaskIntoConstraints = true
        self.imagesliderView.frame = CGRectMake(0, 22, boundss.width,screenHeight-200)
        addChildViewController(pageViewController!)
        self.imagesliderView.addSubview(pageViewController!.view)
        //view.bringSubviewToFront(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! ImgPageControlViewController
        itemController.view.translatesAutoresizingMaskIntoConstraints = true
        itemController.view.frame=CGRectMake(0, 0, boundss.width, self.imagesliderView.frame.size.height)
        
        if itemController.itemIndex > 0
        {
//            for indx in 0...slideImgArray.count-1
//            {
//                if(indx == itemController.itemIndex)
//                {
////                    var index = NSIndexPath.init(forRow: indx, inSection: 0)
////                    var cell = sliderCollectionView.cellForItemAtIndexPath(index) as! SliderImgCollectionViewCell
////                    cell.layer.borderWidth = 2.0
////                    cell.layer.borderColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1).CGColor
//                }
//                else
//                {
////                    var index = NSIndexPath.init(forRow: indx, inSection: 0)
////                    var cell = sliderCollectionView.cellForItemAtIndexPath(index) as! SliderImgCollectionViewCell
////                    cell.layer.borderWidth = 2.0
////                    cell.layer.borderColor = UIColor.clearColor().CGColor
//                }
//            }
            return getItemController(itemController.itemIndex-1)
            
        }
        else
        {
//            for indx in 0...slideImgArray.count-1
//            {
//                if(indx == slideImgArray.count-1)
//                {
////                    var index = NSIndexPath.init(forRow: indx, inSection: 0)
////                    var cell = sliderCollectionView.cellForItemAtIndexPath(index) as! SliderImgCollectionViewCell
////                    cell.layer.borderWidth = 2.0
////                    cell.layer.borderColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1).CGColor
//                }
//                else
//                {
////                    var index = NSIndexPath.init(forRow: indx, inSection: 0)
////                    var cell = sliderCollectionView.cellForItemAtIndexPath(index) as! SliderImgCollectionViewCell
////                    cell.layer.borderWidth = 2.0
////                    cell.layer.borderColor = UIColor.clearColor().CGColor
//                }
//            }
            return getItemController(slideImgArray.count-1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! ImgPageControlViewController
        itemController.view.translatesAutoresizingMaskIntoConstraints = true
        itemController.view.frame=CGRectMake(0, 0, boundss.width, self.imagesliderView.frame.size.height)
        
        if itemController.itemIndex+1 < slideImgArray.count
        {
            
//            for indx in 0...slideImgArray.count-1{
//                if(indx == itemController.itemIndex)
//                {
////                    var index = NSIndexPath.init(forRow: indx, inSection: 0)
////                    var cell = sliderCollectionView.cellForItemAtIndexPath(index) as! SliderImgCollectionViewCell
////                    cell.layer.borderWidth = 2.0
////                    cell.layer.borderColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1).CGColor
//                }
//                else{
////                    var index = NSIndexPath.init(forRow: indx, inSection: 0)
////                    var cell = sliderCollectionView.cellForItemAtIndexPath(index) as! SliderImgCollectionViewCell
////                    cell.layer.borderWidth = 2.0
////                    cell.layer.borderColor = UIColor.clearColor().CGColor
//                }
//            }
            return getItemController(itemController.itemIndex+1)
        }
        else{
           /* for indx in 0...slideImgArray.count-1
            {
                if(indx == 0){
//                    var index = NSIndexPath.init(forRow: indx, inSection: 0)
//                    var cell = sliderCollectionView.cellForItemAtIndexPath(index) as! SliderImgCollectionViewCell
//                    cell.layer.borderWidth = 2.0
//                    cell.layer.borderColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1).CGColor
                }else{
//                    var index = NSIndexPath.init(forRow: indx, inSection: 0)
//                    var cell = sliderCollectionView.cellForItemAtIndexPath(index) as! SliderImgCollectionViewCell
//                    cell.layer.borderWidth = 2.0
//                    cell.layer.borderColor = UIColor.clearColor().CGColor
                }
            }*/
          return getItemController(0)
            // return nil
        }
        
       
    }
    
    private func getItemController(itemIndex: Int) -> ImgPageControlViewController? {
        
        if itemIndex < slideImgArray.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("imagePageControl") as! ImgPageControlViewController
            pageItemController.view.translatesAutoresizingMaskIntoConstraints = true
            pageItemController.view.frame=CGRectMake(0, 0, boundss.width, self.imagesliderView.frame.size.height)
            pageItemController.SliderImageView!.translatesAutoresizingMaskIntoConstraints = true
            pageItemController.SliderImageView!.frame=CGRectMake(0, 0, boundss.width, pageItemController.view.frame.size.height)
            pageItemController.itemIndex = itemIndex
            if(slideImgArray.count >= 0){
                pageItemController.imageName = slideImgArray[itemIndex] as! String
                
               
                
            }else{
                // pageItemController.imageName = contentImages[itemIndex] as! String
                
            }
            pageItemController.view.bringSubviewToFront(pageItemController.SliderImageView!)
            return pageItemController
        }
    
        
        return nil
    }
    
    // MARK: - Page Indicator
    
   

}

extension ImageSliderViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slideImgArray.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageSlider", forIndexPath: indexPath) as! SliderImgCollectionViewCell
        let url =  slideImgArray.objectAtIndex(indexPath.row)
        let imgURL: NSURL = NSURL(string: url as! String)!
        print(imgURL.absoluteString)
        
        if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
        {
            print("IN cache")
           /// cell.SliderCellImage.image = image
            
        }
        else
        {
            Alamofire.request(.GET, imgURL)
                .responseImage { response in
                    debugPrint(response)
                    
                    print(response.request)
                    print(response.response)
                    debugPrint(response.result)
                    
                    
                    
                    
                    if let image = response.result.value {
                        print(imgURL.absoluteString)
                        //cell.SliderCellImage.image = image
                        photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                    }
                    else
                    {
                        let image : UIImage = UIImage(named:"placeholder")!
                       // cell.SliderCellImage.image = image
                        photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                    }
            }
        }
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        for indx in 0...slideImgArray.count-1
        {
            if(indx == indexPath.row)
            {
//                var index = NSIndexPath.init(forRow: indx, inSection: 0)
//                var cell = sliderCollectionView.cellForItemAtIndexPath(index) as! SliderImgCollectionViewCell
//                cell.layer.borderWidth = 2.0
//                cell.layer.borderColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1).CGColor
            }
            else
            {
//                var index = NSIndexPath.init(forRow: indx, inSection: 0)
//                var cell = sliderCollectionView.cellForItemAtIndexPath(index) as! SliderImgCollectionViewCell
//                cell.layer.borderWidth = 2.0
//                cell.layer.borderColor = UIColor.clearColor().CGColor
            }
        }

        let firstController = getItemController(indexPath.row)!
        // firstController.view.frame=CGRectMake(0, 0, boundss.width, self.bannerView.frame.size.height+40)
        let startingViewControllers = [firstController]
        pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)

        
    }
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
       
        
        var cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell!.layer.borderWidth = 2.0
        cell!.layer.borderColor = UIColor.clearColor().CGColor
        
    }
}

//
//  ImgPageControlViewController.swift
//  MarketPlace
//
//  Created by Administrator on 18/11/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire


class ImgPageControlViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var ImgScrollView: UIScrollView!
    
    @IBOutlet weak var SliderImageView: UIImageView!
    
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var rightButton: UIButton!
    
    @IBAction func leftBtnAction(sender: AnyObject) {
    }
    
    @IBAction func rightBtnAction(sender: AnyObject) {
    }
    
    var itemIndex: Int = 0
    let boundss = UIScreen.mainScreen().bounds
    var imageName: String = ""
    
        {
        
        
        didSet {
            //print(SliderImageView)
            if let imageView = SliderImageView {
                SliderImageView?.contentMode = .ScaleAspectFit
                // contentImageView!.translatesAutoresizingMaskIntoConstraints = true
                //  contentImageView!.frame=CGRectMake(0, 0, boundss.width, 190)
                //  contentImageView!.backgroundColor = UIColor.redColor()
                // self.view?.bringSubviewToFront(contentImageView!)
                // imageView.image = UIImage(named: imageName)
                let image : UIImage = UIImage(named:"placeholder")!
                imageView.image = image
                let url =  imageName
                let imgURL: NSURL = NSURL(string: url)!
               // print(imgURL.absoluteString)
                
                if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
                {
                   // print("IN cache")
                    imageView.image = image
                    imageView.contentMode = .ScaleAspectFit
                }
                else
                {
                    Alamofire.request(.GET, imgURL)
                        .responseImage { response in
                            debugPrint(response)
                            
//                            print(response.request)
//                            print(response.response)
                            debugPrint(response.result)
                            
                            
                            
                            
                            if let image = response.result.value {
                                //print(imgURL.absoluteString)
                                imageView.image = image
                                imageView.contentMode = .ScaleAspectFit
                                photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                            }
                            else
                            {
                                let image : UIImage = UIImage(named:"placeholder")!
                                imageView.image = image
                                imageView.contentMode = .ScaleAspectFit
                                photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                            }
                    }
                }
            }
            
        }
    }
    
    var imageSlideArray:  NSArray! = NSArray()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(screenHeight-20)
        

        // Do any additional setup after loading the view.
        self.ImgScrollView.delegate = self
        
         SliderImageView!.image = UIImage(named: imageName)
        SliderImageView.translatesAutoresizingMaskIntoConstraints = true
        SliderImageView.frame = CGRectMake(57, 146, 300, 300)
        
        ImgScrollView.minimumZoomScale = 1.0
        ImgScrollView.maximumZoomScale = 5.0
        
        var vWidth = self.view.frame.width
        var vHeight = self.view.frame.height
        
        ImgScrollView.delegate = self
        ImgScrollView.frame = CGRectMake(0, 0, vWidth, vHeight)
        ImgScrollView.backgroundColor = UIColor(red: 90, green: 90, blue: 90, alpha: 0.90)
        ImgScrollView.alwaysBounceVertical = false
        ImgScrollView.alwaysBounceHorizontal = false
        ImgScrollView.showsVerticalScrollIndicator = true
        ImgScrollView.flashScrollIndicators()
        
        
        self.view!.addSubview(ImgScrollView)
        
        SliderImageView!.layer.cornerRadius = 11.0
        SliderImageView!.clipsToBounds = false
        ImgScrollView.addSubview(SliderImageView!)

        SliderImageView.translatesAutoresizingMaskIntoConstraints = true
        SliderImageView.frame = CGRectMake(((screenWidth-200)/2), ((screenHeight-200)/2), 200, 200)
        
        
        var otherVc = ImageSliderViewController()
        imageSlideArray = otherVc.slideImgArray
       // print(imageSlideArray)
    }
    

    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return imageSlideArray.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    override func viewWillAppear(animated: Bool) {
       // ImgScrollView.alwaysBounceHorizontal = false
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.SliderImageView
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

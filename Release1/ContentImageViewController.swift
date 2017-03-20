//
//  ContentImageViewController.swift
//  MarketPlace
//
//  Created by Administrator on 15/12/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class ContentImageViewController: UIViewController,UIScrollViewDelegate {
    
      @IBOutlet weak var imageViewContent: UIImageView!
    
    @IBOutlet weak var previewScrollView: UIScrollView!
    
   // var imageName: String = ""
    var imageName: String!
        var pageIndex: Int = 0
    
    {
    
    
    didSet {
   // print(imageViewContent)
    if let imageView = imageViewContent {
    imageViewContent?.contentMode = .ScaleAspectFit
    let image : UIImage = UIImage(named:"placeholder")!
    imageView.image = image
    let url =  imageName
    let imgURL: NSURL = NSURL(string: url)!
    print(imgURL.absoluteString)
    
    if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
    {
    print("IN cache")
    imageView.image = image
    imageView.contentMode = .ScaleAspectFit
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

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // imageViewContent!.image = UIImage(named: imageName)
        
        self.previewScrollView.minimumZoomScale = 1.0
        self.previewScrollView.maximumZoomScale = 5.0
        
        previewScrollView.alwaysBounceHorizontal = false
        previewScrollView.alwaysBounceVertical = false
       
        
        imageViewContent.translatesAutoresizingMaskIntoConstraints = true
        imageViewContent.frame = CGRectMake(0, 0, previewScrollView.frame.width, previewScrollView.frame.height)
        
         previewScrollView.addSubview(imageViewContent!)
        
        imageViewContent.contentMode = .ScaleAspectFit
    }
    

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageViewContent
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

//
//  PageItemController.swift
//  Paging_Swift
//
//  Created by olxios on 26/10/14.
//  Copyright (c) 2014 swiftiostutorials.com. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
class PageItemController: UIViewController {
    
    // MARK: - Variables
    var itemIndex: Int = 0
    let boundss = UIScreen.mainScreen().bounds
    var imageName: String = ""
        
        {
        
        
        didSet {
            
            if let imageView = contentImageView
            {
                contentImageView?.contentMode = .ScaleToFill
                // contentImageView!.translatesAutoresizingMaskIntoConstraints = true
                //  contentImageView!.frame=CGRectMake(0, 0, boundss.width, 190)
                //  contentImageView!.backgroundColor = UIColor.redColor()
                // self.view?.bringSubviewToFront(contentImageView!)
                // imageView.image = UIImage(named: imageName)
                let image : UIImage = UIImage(named:"placeholder")!
                imageView.image = image
                if let url =  imageName as? String{
//                   if canOpenURL(url)
//                   {
                    
                        if let imgURL = NSURL(string: url)! as? NSURL {
                           // print(imgURL.absoluteString)
                            
                            if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
                            {
                               // print("IN cache")
                                imageView.image = image
                                imageView.contentMode = .ScaleToFill
                            }
                            else
                            {
                                Alamofire.request(.GET, imgURL)
                                    .responseImage { response in
                                        debugPrint(response)
                                        
//                                        print(response.request)
//                                        print(response.response)
                                        debugPrint(response.result)
                                        
                                        
                                        
                                        
                                        if let image = response.result.value {
                                            //print(imgURL.absoluteString)
                                            imageView.image = image
                                            imageView.contentMode = .ScaleToFill
                                            photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                                        }
                                        else
                                        {
                                            let image : UIImage = UIImage(named:"placeholder")!
                                            imageView.image = image
                                            imageView.contentMode = .ScaleToFill
                                            photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                                        }
                                }
                            }
                    }
                 //   }
//                    else
//                   {
//                        let image : UIImage = UIImage(named:"placeholder")!
//                        imageView.image = image
//                    }
                }
                else
                {
                    let image : UIImage = UIImage(named:"placeholder")!
                    imageView.image = image
                }
    
            }        }
    }
    func canOpenURL(string: String?) -> Bool {
        guard let urlString = string else {return false}
        guard let url = NSURL(string: urlString) else {return false}
        if !UIApplication.sharedApplication().canOpenURL(url) {return false}
        
        //
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluateWithObject(string)
    }
    @IBOutlet var contentImageView: UIImageView?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        contentImageView!.image = UIImage(named: imageName)
//        let tapgesture = UITapGestureRecognizer()
//        tapgesture.addTarget(self, action:"handleOffTap")
//        contentImageView!.addGestureRecognizer(tapgesture)
    }
    
//    func handleOffTap() {
//        print("tap")
////        print(currntIndex)
////        print(contentImages)
//        
//    }
}

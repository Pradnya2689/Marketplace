//
//  NewPageItemController.swift
//  MarketPlace
//
//  Created by pradnya on 08/09/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//


import UIKit
import AlamofireImage
import Alamofire
class NewPageItemController: UIViewController {

    
    var itemIndex: Int = 0
    let boundss = UIScreen.mainScreen().bounds
    var imageName: String = ""
        
        {
        
        
        didSet {
            
            if let imageView = contentImageView {
                contentImageView?.contentMode = .ScaleAspectFit
                
                let image : UIImage = UIImage(named:"placeholder")!
                imageView.image = image
                let url =  imageName
                let imgURL: NSURL = NSURL(string: url)!
               // print(imgURL.absoluteString)
                if(imageName == ""){
                    let image : UIImage = UIImage(named:"placeholder")!
                    imageView.image = image
                }
                
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
                               // print(imgURL.absoluteString)
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
            }else{
                let image : UIImage = UIImage(named:"placeholder")!
                contentImageView!.image = image
            }
            
        }
    
    }
    
    @IBOutlet var contentImageView: UIImageView?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       // contentImageView!.image = UIImage(named: imageName)
    }
    override func viewDidAppear(animated: Bool) {
       // print("img name  \(imageName)")
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

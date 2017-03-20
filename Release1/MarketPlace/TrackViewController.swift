//
//  TrackViewController.swift
//  MarketPlace
//
//  Created by Administrator on 03/10/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import Alamofire
class TrackViewController: UIViewController {

    @IBOutlet weak var trackImgView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackQtyLb: UILabel!
    @IBOutlet weak var trackPriceLb: UILabel!
    @IBOutlet weak var trackStatusLb: UILabel!
    @IBOutlet weak var trackScroll: UIScrollView!
    
    @IBOutlet weak var tracktableView: UITableView!
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    let stageLabelArray = ["Order Placed","Shipped","Out for Delivery","Delivered"]
    
    var imgUrlstr:String!=""
    var  prodDesc:String!=""
    var qntStr:String!=""
    var priceStr:String!=""
    var statusStr:String!=""
    
    var packageDict:NSDictionary!=NSDictionary()
    var lstPackageFlowResponseArray:NSMutableArray!=NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        trackNameLabel.text = prodDesc
        trackQtyLb.text = qntStr
        trackPriceLb.text = priceStr
        trackStatusLb.text = statusStr
        if let pckgResp = packageDict["lstPackageFlowResponse"] as? NSArray{
            lstPackageFlowResponseArray = pckgResp.mutableCopy() as! NSMutableArray
            
        }
        
        let url =  imgUrlstr
        let imgURL: NSURL = NSURL(string: url!)!
        print("########\(imgURL.absoluteString)")
        
        if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
        {
            print("IN cache")
           trackImgView.image = image
            
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
                        self.trackImgView.image = image
                        photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                    }
                    else
                    {
                        let image : UIImage = UIImage(named:"placeholder")!
                        self.trackImgView.image = image
                        //photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                    }
            }
        }
        
        self.title = "Order Track"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]


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

extension TrackViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 3{
            
            let cell = tableView.dequeueReusableCellWithIdentifier("trackId", forIndexPath: indexPath) as! TrackCellTableViewCell
            cell.trckCircleWhite.image = UIImage(named: "white_topPath")
            let searchpredicate = NSPredicate(format: "status = %@", "Delivered")
            let ManifestedArry:NSArray = lstPackageFlowResponseArray.filteredArrayUsingPredicate(searchpredicate)
            if(ManifestedArry.count >= 1){
                let packRes = ManifestedArry.objectAtIndex(0)
                cell.trackCircleBlue.hidden = false
                cell.trackCircleBlue.image = UIImage(named: "topPath_blueCircle")
                cell.trackDateLb.hidden = false
                cell.trackDateLb.text = packRes["date"] as! String
            }else{
                cell.trackCircleBlue.hidden = true
                cell.trackCircleBlue.image = UIImage(named: "topPath_blueCircle")
                cell.trackDateLb.hidden = true
            }
            
            cell.trackWhitePath.hidden = true
            cell.trackBluePath.hidden = true
//            cell.trackDateLb.hidden = true
            
            cell.trackStageLabel.text = stageLabelArray[indexPath.row]
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            return cell
            
        }else if indexPath.row == 0{
        
         let cell = tableView.dequeueReusableCellWithIdentifier("trackId", forIndexPath: indexPath) as! TrackCellTableViewCell
            cell.trckCircleWhite.image = UIImage(named: "white_bottomPath")
          let searchpredicate = NSPredicate(format: "status = %@", "Manifested")
            let ManifestedArry:NSArray = lstPackageFlowResponseArray.filteredArrayUsingPredicate(searchpredicate)
            if(ManifestedArry.count >= 1){
                let packRes = ManifestedArry.objectAtIndex(0)
                cell.trackCircleBlue.hidden = false
                if(ManifestedArry.count == 1){
                cell.trackCircleBlue.image = UIImage(named: "blueCircle_full")
                }else if(ManifestedArry.count > 1){
                    cell.trackCircleBlue.image = UIImage(named: "bottomPath_BlueCircle")
                }
                cell.trackDateLb.hidden = false
                cell.trackDateLb.text = packRes["date"] as! String
                let searchpredicate = NSPredicate(format: "status = %@", "In Transit")
                let ManifestedArry:NSArray = lstPackageFlowResponseArray.filteredArrayUsingPredicate(searchpredicate)
                if(ManifestedArry.count >= 1){
                   // cell.trackWhitePath.hidden = false
                    cell.trackBluePath.hidden = false
                }else{
                   // cell.trackWhitePath.hidden = true
                    cell.trackBluePath.hidden = true
                }
            }else{
                cell.trackCircleBlue.hidden = true
                cell.trackCircleBlue.image = UIImage(named: "blueCircle_full")
                cell.trackDateLb.hidden = true
               // cell.trackWhitePath.hidden = true
                cell.trackBluePath.hidden = true
            }
          
         cell.trackStageLabel.text = stageLabelArray[indexPath.row]
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
        return cell
        }else{
            
            let cell = tableView.dequeueReusableCellWithIdentifier("trackId", forIndexPath: indexPath) as! TrackCellTableViewCell
            
            if(indexPath.row == 1){
                cell.trckCircleWhite.image = UIImage(named: "white_bothPath")
                let searchpredicate = NSPredicate(format: "status = %@", "In Transit")
                let ManifestedArry:NSArray = lstPackageFlowResponseArray.filteredArrayUsingPredicate(searchpredicate)
                if(ManifestedArry.count >= 1){
                    let packRes = ManifestedArry.objectAtIndex(0)
                    cell.trackCircleBlue.hidden = false
                    cell.trackCircleBlue.image = UIImage(named: "bothPath_BlueCircle")
                    cell.trackDateLb.hidden = false
                    cell.trackDateLb.text = packRes["date"] as! String
                    let searchpredicate = NSPredicate(format: "status = %@", "Dispatatched")
                    let ManifestedArry:NSArray = lstPackageFlowResponseArray.filteredArrayUsingPredicate(searchpredicate)
                    if(ManifestedArry.count >= 1){
                        cell.trackBluePath.hidden = false
                    }else{
                        cell.trackBluePath.hidden = true
                    }
                }else{
                    cell.trackCircleBlue.hidden = true
                    cell.trackCircleBlue.image = UIImage(named: "bothPath_BlueCircle")
                    cell.trackDateLb.hidden = true
                    cell.trackBluePath.hidden = true
                }
            }
            if(indexPath.row == 2){
                cell.trckCircleWhite.image = UIImage(named: "white_bothPath")
                let searchpredicate = NSPredicate(format: "status = %@", "Dispatatched")
                let ManifestedArry:NSArray = lstPackageFlowResponseArray.filteredArrayUsingPredicate(searchpredicate)
                if(ManifestedArry.count >= 1){
                    let packRes = ManifestedArry.objectAtIndex(0)
                    cell.trackCircleBlue.hidden = false
                    cell.trackCircleBlue.image = UIImage(named: "bothPath_BlueCircle")
                    cell.trackDateLb.hidden = false
                    cell.trackDateLb.text = packRes["date"] as! String
                    let searchpredicate = NSPredicate(format: "status = %@", "Delivered")
                    let ManifestedArry:NSArray = lstPackageFlowResponseArray.filteredArrayUsingPredicate(searchpredicate)
                    if(ManifestedArry.count >= 1){
                        cell.trackBluePath.hidden = false
                    }else{
                        cell.trackBluePath.hidden = true
                    }
                }else{
                    cell.trackBluePath.hidden = true
                    cell.trackCircleBlue.hidden = true
                    cell.trackCircleBlue.image = UIImage(named: "bothPath_BlueCircle")
                    cell.trackDateLb.hidden = true
                }
            }
//            cell.trackDateLb.hidden = true
//            cell.trackCircleBlue.image = UIImage(named: "bothPath_BlueCircle")
            cell.trackStageLabel.text = stageLabelArray[indexPath.row]
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            return cell

        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
}

//
//  ReviewRatingViewController.swift
//  MarketPlace
//
//  Created by pradnya on 14/09/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit



class ReviewRatingViewController: UIViewController,webServiceDelegate {
    @IBOutlet var reviewTable:UITableView!
    var star5val:Float!
    var star4val:Float!
    var star3val:Float!
    var star2val:Float!
    var star1val:Float!
    var ratingArray:NSMutableArray!=NSMutableArray()
    @IBOutlet var totalReviewLable:UILabel!
    @IBOutlet var star5Slider:UIProgressView!
    @IBOutlet var star4Slider:UIProgressView!
    @IBOutlet var star3Slider:UIProgressView!
    @IBOutlet var star2Slider:UIProgressView!
    @IBOutlet var star1Slider:UIProgressView!
    
    @IBOutlet var fiveStarcntLbl:UILabel!
    @IBOutlet var fourStarcntLbl:UILabel!
    @IBOutlet var threeStarcntLbl:UILabel!
    @IBOutlet var twoStarcntLbl:UILabel!
    @IBOutlet var oneStarcntLbl:UILabel!
    
    @IBOutlet var activityInnd:UIActivityIndicatorView!
    @IBOutlet var footerVc:UIView!
    var pageIndex:Int!=0
    var totalCnt:Int!=0
    var mpn:String!=""
    @IBOutlet var loadmorebtn:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
         self.tabBarController?.tabBar.hidden = true
        self.title = "All Reviews"

       // print(ratingArray.count)

       
        
        footerVc.frame = CGRectMake(0, 0,400 , 50)
        reviewTable.tableFooterView = footerVc
        reviewTable.reloadData()
        LoadingOverlay.shared.showOverlay(view)
        activityInnd.hidden = true
        let wsm : WebServiceClass = WebServiceClass.sharedInstance
        wsm.delegates=self
        wsm.getOthersreviewDetails(self.mpn as String, PageIndex: "0", onSearchPage: false, onProductPage: true, onReviewPage: false, onAdminPage: false)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool)
    {
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(ReviewRatingViewController.getOtherReview(_:)),
                                                         name: "othersReview",
                                                         object: nil)
    }
    override func viewDidAppear(animated: Bool) {
        self.reviewTable.rowHeight = UITableViewAutomaticDimension
        self.reviewTable.estimatedRowHeight = 100
        reviewTable.reloadData()
    }
    func callNextPage()  {
        LoadingOverlay.shared.showOverlay(view)
        let wsm : WebServiceClass = WebServiceClass.sharedInstance
        wsm.delegates=self
        wsm.getOthersreviewDetails(self.mpn as String, PageIndex: String(pageIndex), onSearchPage: false, onProductPage: true, onReviewPage: false, onAdminPage: false)
    }
    func getOtherReview(notification: NSNotification)  {
        LoadingOverlay.shared.hideOverlayView()
        self.reviewTable.hidden = false
        // print(notification)
        let dict : AnyObject = notification.userInfo!
       // print(dict["ratingCount"])
        let ratingCountDict = dict["ratingCount"] as? NSArray
        for forecast in ratingCountDict!
        {
            if forecast["totalProductCount"]! != nil
            {
            totalCnt = forecast["totalProductCount"] as! Int
            }
        }
        
        let ratingReviewDict = dict["ratingReview"] as? NSArray
        //ratingReviewArray = ratingCountDict.mutableCopy() as! NSMutableArray
        for firstReview in ratingReviewDict!{
            ratingArray.addObject(firstReview)
            
        }

        if(ratingCountDict?.count > 0){
            let pred = NSPredicate(format: "rating1 = 1")
            let pred2 = NSPredicate(format: "rating2 = 1")
            let pred3 = NSPredicate(format: "rating3 = 1")
            let pred4 = NSPredicate(format: "rating4 = 1")
            let pred5 = NSPredicate(format: "rating5 = 4")
            var filterArr = ratingCountDict?.filteredArrayUsingPredicate(pred)
            var filterArr2 = ratingCountDict?.filteredArrayUsingPredicate(pred2)
            var filterArr3 = ratingCountDict?.filteredArrayUsingPredicate(pred3)
            var filterArr4 = ratingCountDict?.filteredArrayUsingPredicate(pred4)
            var filterArr5 = ratingCountDict?.filteredArrayUsingPredicate(pred5)
            //        print(filterArr.count)
            //        print(filterArr2.count)
            //        print(filterArr3.count)
            //        print(filterArr4.count)
            //        print(filterArr5.count)
            //var arcnt = filterArr.count
            
            var arcnt = ratingCountDict?.objectAtIndex(0).valueForKey("totalProductCount") as! Int
            star1Slider.progress = (Float(ratingCountDict?.objectAtIndex(0).valueForKey("rating1") as! Int)/Float(ratingArray.count)) as Float
            star2Slider.progress = (Float(ratingCountDict?.objectAtIndex(0).valueForKey("rating2") as! Int)/Float(ratingArray.count)) as Float
            star3Slider.progress = (Float(ratingCountDict?.objectAtIndex(0).valueForKey("rating3") as! Int)/Float(ratingArray.count)) as Float
            star4Slider.progress = (Float(ratingCountDict?.objectAtIndex(0).valueForKey("rating4") as! Int)/Float(ratingArray.count)) as Float
            star5Slider.progress = (Float(ratingCountDict?.objectAtIndex(0).valueForKey("rating5") as! Int)/Float(ratingArray.count)) as Float
            
            
           if let fs = ratingCountDict?.objectAtIndex(0).valueForKey("rating5")
           {
            
            fiveStarcntLbl.text = String(fs)
            }
            if let frs = ratingCountDict?.objectAtIndex(0).valueForKey("rating4")
            {
                fourStarcntLbl.text = String(frs)
            }
            //fourStarcntLbl.text = String(ratingCountDict?.objectAtIndex(0).valueForKey("rating4")!)
            
            if let thrs = ratingCountDict?.objectAtIndex(0).valueForKey("rating3")
            {
                threeStarcntLbl.text = String(thrs)
            }
           // threeStarcntLbl.text = String(ratingCountDict?.objectAtIndex(0).valueForKey("rating3")!)
            if let tws = ratingCountDict?.objectAtIndex(0).valueForKey("rating2")
            {
                twoStarcntLbl.text = String(tws)
            }
          //  twoStarcntLbl.text = String(ratingCountDict?.objectAtIndex(0).valueForKey("rating2")!)
            
            if let ones = ratingCountDict?.objectAtIndex(0).valueForKey("rating1")
            {
               oneStarcntLbl.text  = String(ones)
            }
           // oneStarcntLbl.text = String(ratingCountDict?.objectAtIndex(0).valueForKey("rating1")!)
            //loadmorebtn.hidden = false
            //activityInnd.hidden = true
            
        }
        if(totalCnt == ratingArray.count){
            loadmorebtn.hidden = true
            activityInnd.hidden = true
        }else{
            activityInnd.hidden = true
            loadmorebtn.hidden = false
        }
     self.reviewTable.reloadData()
        //ratingReview
    }
    
    @IBAction func loadmoreClk(){
        //if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            //reach bottom
            if(ratingArray.count < totalCnt){
                pageIndex = pageIndex + 1
                loadmorebtn.hidden = true
                 activityInnd.hidden = false
                activityInnd.startAnimating()
                callNextPage()
            }else{
                footerVc.frame = CGRectMake(0, 0,400 , 0)
                reviewTable.tableFooterView = footerVc
                reviewTable.reloadData()
                 activityInnd.hidden = true
                loadmorebtn.hidden = true
        }
            
           // print("reach end")
        //}
    }
      func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "othersReview", object: nil)
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
extension ReviewRatingViewController: UITableViewDataSource, UITableViewDelegate{
    
   
 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratingArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("reviewCell", forIndexPath: indexPath) as! ReviewCell
        var review = ratingArray.objectAtIndex(indexPath.row)
        
        cell.review1Title.text = review["firstName"] as? String
        cell.review1Commnt.text = review["review"] as? String
        cell.review1stars.rating = review["rating"] as!Float
        let deFormatter = NSDateFormatter()
        var string = review["createdOn"] as! String
        if let reverseIndex = string.characters.reverse().indexOf(".") {
           // print(string[string.startIndex ..< reverseIndex.base.advancedBy(-1)])
            string = string[string.startIndex ..< reverseIndex.base.advancedBy(-1)]
        }
        
        deFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let startTime = deFormatter.dateFromString(string)
       // print(startTime!) // 2015-06-25 23:10:00 +0000
        
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let timeString = formatter.stringFromDate(startTime!)
       // print(timeString)
        cell.review1DateLbl.text = timeString
        cell.selectionStyle = .None
        
       return cell
    }
    
}

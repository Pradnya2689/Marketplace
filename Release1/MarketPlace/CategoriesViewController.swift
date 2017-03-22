
//
//  CategoriesViewController.swift
//  MarketPlace
//
//  Created by inpanr07 on 24/06/16.
//  Copyright (c) 2016 inpanr07. All rights reserved.
//

import UIKit

import Alamofire
import ObjectMapper
import Kingfisher



import ObjectMapper
import Alamofire
import Kingfisher


class Category: Mappable {
    var aCatRecCount: String?
    var aCategoryId: String?
    var aCategoryName: String?
    var subCategory: [SubCategory]?
    // var threeDayForecast: [Forecast]?
    //
    required init?(_ map: Map){
        
    }
    //
    func mapping(map: Map) {
        aCatRecCount <- map["aCatRecCount"]
        aCategoryId <- map["aCategoryId"]
        aCategoryName <- map["aCategoryName"]
        subCategory <- map["subCategory"]
    }
}

class SubCategory: Mappable {
    var subCatRecCount: String?
    var subCategoryId: String?
    var subCategoryName: String?
    var category3List1: [category3List]?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        subCatRecCount <- map["subCatRecCount"]
        subCategoryId <- map["subCategoryId"]
        subCategoryName <- map["subCategoryName"]
        category3List1 <- map["category3List"]
    }
}


class category3List: Mappable {
    var cat3RecCount: String?
    var category3Id: String?
    var category3Name: String?
    //    var category3List: [category3List]?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        cat3RecCount <- map["cat3RecCount"]
        category3Id <- map["category3Id"]
        category3Name <- map["category3Name"]
    }
}




var glblArr : NSMutableArray = NSMutableArray()
var coolectionImageData : NSMutableArray = NSMutableArray()


class CategoriesViewController: UITableViewController
{
    var newArrayofDicts : NSMutableArray = NSMutableArray()
    //mapper class array
    var newObjectMarr : NSMutableArray = NSMutableArray()
    var newObjectMSubCatarr : NSMutableArray = NSMutableArray()
    var newObjectM3Levelarr : NSMutableArray = NSMutableArray()
     var objectToPass : Category!
      var subCatToPass : SubCategory!
    var somevalue1 : NSArray!
   //mapper class array end
    var subcatArray : NSMutableArray = NSMutableArray ()
     var level3catArray : NSMutableArray = NSMutableArray ()
    var CategoriesDict : NSMutableDictionary = NSMutableDictionary()
     var catflag : String = String()
  //  var newArrayofDicts = [String: AnyObject?]()
    var tableName = [String]()
    
    @IBOutlet var noInternetView:UIView!
    @IBOutlet var wifiImg:UIImageView!
    @IBOutlet var noconnetinlbl:UILabel!
    @IBOutlet var retryBtn:UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "Categories"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName : grayLightColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]

        /*
        newArrayofDicts = NSMutableArray()
        //mapper class array
        newObjectMarr = NSMutableArray()
        newObjectMSubCatarr  = NSMutableArray()
        newObjectM3Levelarr = NSMutableArray()
        
        //mapper class array end
        subcatArray = NSMutableArray ()
        level3catArray  = NSMutableArray ()
        CategoriesDict  = NSMutableDictionary()
        
        let headers = [
            "Authorization": authorizationWithoutLogin,
            "Accept": "application/json"
        ]
        if #available(iOS 9.0, *) {
            Alamofire.Manager.sharedInstance.session.getAllTasksWithCompletionHandler { (tasks) -> Void in
                tasks.forEach({ $0.cancel() })
            }
        }
       // Alamofire.Request.suspend()
        self.tableView.tableFooterView = UIView()
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            
            self.noInternetView.removeFromSuperview()
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            // JHProgressHUD.sharedHUD.showInView(window)
            LoadingOverlay.shared.showOverlay(window)
            // JHProgressHUD.sharedHUD.showInWindow(self.view.window!)
            
            
            Alamofire.request(.GET, "\(baseUrl)category?", headers: headers)
                .validate(contentType: ["application/json"])
            
                .responseJSON { response in
                    print(response.request)  // original URL request
                    print(response.response) // URL response
                    print(response.data)     // server data
                    print(response.result)   // result of response serialization
                    
                    if let JSON = response.result.value {
                        //  print(self.delegates)
                        
                        print("application viewc \(UIApplication.topViewController())")
                        
                        print(JSON)
                        let customer : Array<Category> = Mapper<Category>().mapArray(JSON)!
                        
                        for forecast in customer
                        {
                            print("category name:\(forecast.aCategoryName!)")
                            
                            self.newObjectMarr.addObject(forecast)
                            let subcat : Array<SubCategory> = forecast.subCategory!
                            
                            for subcategory in subcat
                            {
                                self.newObjectMSubCatarr.addObject(subcategory)
                                print("subcategory name:\(subcategory.subCategoryName!)")
                                let category3 : Array<category3List> = subcategory.category3List1!
                                
                                for level3cat in category3
                                {
                                    self.newObjectM3Levelarr.addObject(level3cat)
                                    print("level3cat name:\(level3cat.category3Name!)")
                                }
                            }
                            //                       print(forecast.subCategoryId)
                            //                        print(forecast.subCatRecCount)
                        }
                        
                        print(self.newObjectM3Levelarr)
                        print(self.newObjectMSubCatarr)
                        print(self.newObjectMarr.objectAtIndex(0))
                        print(self.newObjectMarr.objectAtIndex(1))
                        print(self.newObjectMarr.objectAtIndex(2))
                        print(self.newObjectMarr.objectAtIndex(3))
                        
                        // }
                    }
                    dispatch_async(dispatch_get_main_queue())
                    {
//                         LoadingOverlay.shared.hideOverlayView()
//                         self.tableView.hidden = false
//                        self.tableView.reloadData()
                    }
                    
            }
        }else{
            LoadingOverlay.shared.hideOverlayView()
            //showAlert()
            //self.noInternetView.translatesAutoresizingMaskIntoConstraints = true
            self.noInternetView.frame = CGRectMake(0,-63, screenSize.width, screenSize.height)
            self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
            self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
            self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
            self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
            self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
            self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)
            self.view.addSubview(self.noInternetView)
        }
       
        
//        
//        if (appdelegate.isReachable == true) {
//            
//            self.noInternetView.removeFromSuperview()
//            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
//            // JHProgressHUD.sharedHUD.showInView(window)
//            LoadingOverlay.shared.showOverlay(window)
//            // JHProgressHUD.sharedHUD.showInWindow(self.view.window!)
//            
//            if #available(iOS 9.0, *) {
//                Alamofire.Manager.sharedInstance.session.getAllTasksWithCompletionHandler { (tasks) -> Void in
//                    tasks.forEach({ $0.cancel() })
//                }
//            }
//            Alamofire.request(.GET, "\(baseUrl)category?", headers: headers)
//                .validate(contentType: ["application/json"])
//                
//                .responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response) // URL response
//                    print(response.data)     // server data
//                    print(response.result)   // result of response serialization
//                    
//                    if let JSON = response.result.value {
//                        //  print(self.delegates)
//                        
//                        let arrayOfDicts : NSMutableArray? = JSON as! NSMutableArray
//                        
//                        if arrayOfDicts != nil
//                        {
//                            for item in arrayOfDicts!
//                            {
//                                if var dict  = item as? NSMutableDictionary
//                                {
//                                    var newDict : NSMutableDictionary = NSMutableDictionary()
//                                    
//                                    if dict["aCategoryName"] != nil
//                                    {
//                                        newDict["aCategoryName"] = dict["aCategoryName"]
//                                        newDict["aCategoryId"] = dict["aCategoryId"]
//                                        
//                                        
//                                        self.newArrayofDicts.addObject(newDict)
//                                        
//                                    }
//                                    if dict["subCategory"] != nil
//                                    {
//                                        var arrayOfDicts : NSMutableArray? = dict["subCategory"] as? NSMutableArray
//                                        
//                                        var subcat : String  = dict["aCategoryName"] as! String
//                                        if arrayOfDicts != nil {
//                                        for item in arrayOfDicts!
//                                        {
//                                            
//                                            if let dict  = item as? NSMutableDictionary
//                                            {
//                                                var newDict1 : NSMutableDictionary = NSMutableDictionary()
//                                                
//                                                if dict["subCategoryName"] != nil
//                                                {
//                                                    newDict1[subcat] = dict["subCategoryName"]
//                                                    newDict1["subCategoryId"] = dict["subCategoryId"]
//                                                    self.subcatArray.addObject(newDict1)
//                                                }
//                                                
//                                                
//                                                if dict ["category3List"] != nil
//                                                {
//                                                    var arrayOfDicts1 : NSMutableArray? = dict["category3List"] as? NSMutableArray
//                                                    var subcat1 : String  = dict["subCategoryName"] as! String
//                                                    if arrayOfDicts1 != nil
//                                                    {
//                                                    for item in arrayOfDicts1!
//                                                    {
//                                                        if var dict  = item as? NSMutableDictionary
//                                                        {
//                                                            var newDict2 : NSMutableDictionary = NSMutableDictionary()
//                                                            if dict["category3Name"] != nil
//                                                            {
//                                                                newDict2[subcat1] = dict["category3Name"]
//                                                                newDict2["category3Id"] = dict["category3Id"]
//                                                             
//                                                                self.level3catArray.addObject(newDict2)
//                                                                
//                                                            }
//                                                            
//                                                            
//                                                            
//                                                        }
//                                                        
//                                                    }
//                                                }
//                                                }
//                                                
//                                                
//                                                
//                                            }
//                                            
//                                            
//                                        }
//                                    }
//                                    }
//                                    
//                                }
//                            }
//                        }
//                        
//                        print("category array ::\(self.newArrayofDicts)", terminator: "")
//                        print("Subcategory array ::\(self.subcatArray)", terminator: "")
//                        print("level3category array :: \(self.level3catArray)", terminator: "")
//                        
//
//                        
////                        print(self.newObjectM3Levelarr)
////                        print(self.newObjectMSubCatarr)
////                        print(self.newObjectMarr.objectAtIndex(0))
////                        print(self.newObjectMarr.objectAtIndex(1))
////                        print(self.newObjectMarr.objectAtIndex(2))
////                        print(self.newObjectMarr.objectAtIndex(3))
//                        
//                        // }
//                    }
//                    dispatch_async(dispatch_get_main_queue())
//                    {
//                                                 LoadingOverlay.shared.hideOverlayView()
//                                                 self.tableView.hidden = false
//                                                self.tableView.reloadData()
//                    }
//                    
//            }
//        }
        
        
        
        
         if (appdelegate.isReachable == true) {
        let url = NSURL(string: "\(baseUrl)category?")
        //let url = NSURL(string: "http://immarketapi-dev.azurewebsites.net/api/category?")
        let request = NSMutableURLRequest(URL: url!)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession.sharedSession()
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let urlConnection = NSURLConnection(request: request, delegate: self)
        request.HTTPMethod = "GET"
        request.setValue(authorizationWithoutLogin, forHTTPHeaderField: "Authorization")
       
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            self.tableView.hidden = false
            if  let strData = NSString(data: data!, encoding: NSUTF8StringEncoding){
            print("Body: \(strData)")
            var err: NSError?
            let json = (try? NSJSONSerialization.JSONObjectWithData(data!, options:[]) as? NSDictionary)
            var arrayOfDicts : NSMutableArray? = (try? NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers)) as? NSMutableArray
            
            if arrayOfDicts != nil
            {
                for item in arrayOfDicts!
                {
                    if var dict  = item as? NSMutableDictionary
                    {
                        var newDict : NSMutableDictionary = NSMutableDictionary()
                        
                        if dict["aCategoryName"] != nil
                        {
                            newDict["aCategoryName"] = dict["aCategoryName"]
                            newDict["aCategoryId"] = dict["aCategoryId"]
                            
                        
                            self.newArrayofDicts.addObject(newDict)
                            
                        }
                        if dict["subCategory"] != nil
                        {
                            var arrayOfDicts : NSMutableArray? = dict["subCategory"] as? NSMutableArray
                            
                            var subcat : String  = dict["aCategoryName"] as! String
                            
                            for item in arrayOfDicts!
                            {
                                
                                if let dict  = item as? NSMutableDictionary
                                {
                                    var newDict1 : NSMutableDictionary = NSMutableDictionary()
                                    
                                    if dict["subCategoryName"] != nil
                                    {
                                        newDict1[subcat] = dict["subCategoryName"]
                                        newDict1["subCategoryId"] = dict["subCategoryId"]
                                        self.subcatArray.addObject(newDict1)
                                    }
                                    
                                    
                                    if dict ["category3List"] != nil
                                    {
                                        var arrayOfDicts1 : NSMutableArray? = dict["category3List"] as? NSMutableArray
                                        var subcat1 : String  = dict["subCategoryName"] as! String
                                        for item in arrayOfDicts1!
                                        {
                                            if var dict  = item as? NSMutableDictionary
                                            {
                                                var newDict2 : NSMutableDictionary = NSMutableDictionary()
                                                if dict["category3Name"] != nil
                                                {
                                                    newDict2[subcat1] = dict["category3Name"]
                                                    newDict2["category3Id"] = dict["category3Id"]
                                                    // self.subCategories[dict["aCategoryName"]] = dict["subCategoryName"]
                                                    // self.subcatArray.addObject(newDict1["subCategoryName"]!)
                                                    self.level3catArray.addObject(newDict2)
                                                    
                                                }
                                                
                                                
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                    
                                    
                                }
                                
                                
                            }
                            
                        }
                        
                    }
                }
            }
            
            print("category array ::\(self.newArrayofDicts)", terminator: "")
            print("Subcategory array ::\(self.subcatArray)", terminator: "")
            print("level3category array :: \(self.level3catArray)", terminator: "")
            
            if(err != nil) {
                print(err!.localizedDescription)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                
                dispatch_async(dispatch_get_main_queue())
                {
                     self.tableView.hidden = false
                    LoadingOverlay.shared.hideOverlayView()
                    self.tableView.reloadData()
                }
            }
            }
        })
         self.tableView.hidden = false
        self.tableView.reloadData()
        task.resume()
        }
        self.tableView.hidden = false
        */
    }
    
    @IBAction func noInternetConnectionClk(){
        newArrayofDicts = NSMutableArray()
        //mapper class array
        newObjectMarr = NSMutableArray()
        newObjectMSubCatarr  = NSMutableArray()
        newObjectM3Levelarr = NSMutableArray()
        
        //mapper class array end
        subcatArray = NSMutableArray ()
        level3catArray  = NSMutableArray ()
        CategoriesDict  = NSMutableDictionary()
        
        let headers = [
            "Authorization": authorizationWithoutLogin,
            "Accept": "application/json"
        ]
//        if #available(iOS 9.0, *) {
//            Alamofire.Manager.sharedInstance.session.getAllTasksWithCompletionHandler { (tasks) -> Void in
//                tasks.forEach({ $0.cancel() })
//            }
//        }
        // Alamofire.Request.suspend()
        self.tableView.tableFooterView = UIView()
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            
            self.noInternetView.removeFromSuperview()
            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
            // JHProgressHUD.sharedHUD.showInView(window)
            LoadingOverlay.shared.showOverlay(window)
            // JHProgressHUD.sharedHUD.showInWindow(self.view.window!)
            
            
            Alamofire.request(.GET, "\(baseUrl)category?", headers: headers)
                .validate(contentType: ["application/json"])
                
                .responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response) // URL response
//                    print(response.data)     // server data
//                    print(response.result)   // result of response serialization
                    
                    if let JSON = response.result.value {
                        //  print(self.delegates)
                        
                       // print("application viewc \(UIApplication.topViewController())")
                        
                        //print(JSON)
                        let customer : Array<Category> = Mapper<Category>().mapArray(JSON)!
                        
                        for forecast in customer
                        {
                            //print("category name:\(forecast.aCategoryName!)")
                            
                            self.newObjectMarr.addObject(forecast)
                            let subcat : Array<SubCategory> = forecast.subCategory!
                            
                            for subcategory in subcat
                            {
                                self.newObjectMSubCatarr.addObject(subcategory)
                               // print("subcategory name:\(subcategory.subCategoryName!)")
                                let category3 : Array<category3List> = subcategory.category3List1!
                                
                                for level3cat in category3
                                {
                                    self.newObjectM3Levelarr.addObject(level3cat)
                                    //print("level3cat name:\(level3cat.category3Name!)")
                                }
                            }
                            //                       print(forecast.subCategoryId)
                            //                        print(forecast.subCatRecCount)
                        }
                        
//                        print(self.newObjectM3Levelarr)
//                        print(self.newObjectMSubCatarr)
//                        print(self.newObjectMarr.objectAtIndex(0))
//                        print(self.newObjectMarr.objectAtIndex(1))
//                        print(self.newObjectMarr.objectAtIndex(2))
//                        print(self.newObjectMarr.objectAtIndex(3))
                        
                        // }
                    }
                    dispatch_async(dispatch_get_main_queue())
                    {
                        //                         LoadingOverlay.shared.hideOverlayView()
                        //                         self.tableView.hidden = false
                        //                        self.tableView.reloadData()
                    }
                    
            }
        }else{
            LoadingOverlay.shared.hideOverlayView()
            //showAlert()
            //self.noInternetView.translatesAutoresizingMaskIntoConstraints = true
            self.noInternetView.frame = CGRectMake(0,-63, screenSize.width, screenSize.height)
            self.wifiImg.translatesAutoresizingMaskIntoConstraints = true
            self.noconnetinlbl.translatesAutoresizingMaskIntoConstraints = true
            self.retryBtn.translatesAutoresizingMaskIntoConstraints = true
            self.wifiImg.frame = CGRectMake((screenSize.width - 170 )/2, 150, 170, 170)
            self.noconnetinlbl.frame = CGRectMake((screenSize.width - 248 )/2, 370, 248, 21)
            self.retryBtn.frame = CGRectMake((screenSize.width - 144 )/2, 420, 144, 40)
            self.view.addSubview(self.noInternetView)
        }
        
        
        //
        //        if (appdelegate.isReachable == true) {
        //
        //            self.noInternetView.removeFromSuperview()
        //            var window :UIWindow = UIApplication.sharedApplication().keyWindow!
        //            // JHProgressHUD.sharedHUD.showInView(window)
        //            LoadingOverlay.shared.showOverlay(window)
        //            // JHProgressHUD.sharedHUD.showInWindow(self.view.window!)
        //
        //            if #available(iOS 9.0, *) {
        //                Alamofire.Manager.sharedInstance.session.getAllTasksWithCompletionHandler { (tasks) -> Void in
        //                    tasks.forEach({ $0.cancel() })
        //                }
        //            }
        //            Alamofire.request(.GET, "\(baseUrl)category?", headers: headers)
        //                .validate(contentType: ["application/json"])
        //
        //                .responseJSON { response in
        //                    print(response.request)  // original URL request
        //                    print(response.response) // URL response
        //                    print(response.data)     // server data
        //                    print(response.result)   // result of response serialization
        //
        //                    if let JSON = response.result.value {
        //                        //  print(self.delegates)
        //
        //                        let arrayOfDicts : NSMutableArray? = JSON as! NSMutableArray
        //
        //                        if arrayOfDicts != nil
        //                        {
        //                            for item in arrayOfDicts!
        //                            {
        //                                if var dict  = item as? NSMutableDictionary
        //                                {
        //                                    var newDict : NSMutableDictionary = NSMutableDictionary()
        //
        //                                    if dict["aCategoryName"] != nil
        //                                    {
        //                                        newDict["aCategoryName"] = dict["aCategoryName"]
        //                                        newDict["aCategoryId"] = dict["aCategoryId"]
        //
        //
        //                                        self.newArrayofDicts.addObject(newDict)
        //
        //                                    }
        //                                    if dict["subCategory"] != nil
        //                                    {
        //                                        var arrayOfDicts : NSMutableArray? = dict["subCategory"] as? NSMutableArray
        //
        //                                        var subcat : String  = dict["aCategoryName"] as! String
        //                                        if arrayOfDicts != nil {
        //                                        for item in arrayOfDicts!
        //                                        {
        //
        //                                            if let dict  = item as? NSMutableDictionary
        //                                            {
        //                                                var newDict1 : NSMutableDictionary = NSMutableDictionary()
        //
        //                                                if dict["subCategoryName"] != nil
        //                                                {
        //                                                    newDict1[subcat] = dict["subCategoryName"]
        //                                                    newDict1["subCategoryId"] = dict["subCategoryId"]
        //                                                    self.subcatArray.addObject(newDict1)
        //                                                }
        //
        //
        //                                                if dict ["category3List"] != nil
        //                                                {
        //                                                    var arrayOfDicts1 : NSMutableArray? = dict["category3List"] as? NSMutableArray
        //                                                    var subcat1 : String  = dict["subCategoryName"] as! String
        //                                                    if arrayOfDicts1 != nil
        //                                                    {
        //                                                    for item in arrayOfDicts1!
        //                                                    {
        //                                                        if var dict  = item as? NSMutableDictionary
        //                                                        {
        //                                                            var newDict2 : NSMutableDictionary = NSMutableDictionary()
        //                                                            if dict["category3Name"] != nil
        //                                                            {
        //                                                                newDict2[subcat1] = dict["category3Name"]
        //                                                                newDict2["category3Id"] = dict["category3Id"]
        //
        //                                                                self.level3catArray.addObject(newDict2)
        //
        //                                                            }
        //
        //
        //
        //                                                        }
        //
        //                                                    }
        //                                                }
        //                                                }
        //
        //
        //
        //                                            }
        //
        //
        //                                        }
        //                                    }
        //                                    }
        //
        //                                }
        //                            }
        //                        }
        //
        //                        print("category array ::\(self.newArrayofDicts)", terminator: "")
        //                        print("Subcategory array ::\(self.subcatArray)", terminator: "")
        //                        print("level3category array :: \(self.level3catArray)", terminator: "")
        //
        //
        //
        ////                        print(self.newObjectM3Levelarr)
        ////                        print(self.newObjectMSubCatarr)
        ////                        print(self.newObjectMarr.objectAtIndex(0))
        ////                        print(self.newObjectMarr.objectAtIndex(1))
        ////                        print(self.newObjectMarr.objectAtIndex(2))
        ////                        print(self.newObjectMarr.objectAtIndex(3))
        //
        //                        // }
        //                    }
        //                    dispatch_async(dispatch_get_main_queue())
        //                    {
        //                                                 LoadingOverlay.shared.hideOverlayView()
        //                                                 self.tableView.hidden = false
        //                                                self.tableView.reloadData()
        //                    }
        //
        //            }
        //        }
        
        
        
        
        if (appdelegate.isReachable == true) {
            let url = NSURL(string: "\(baseUrl)category?")
            //let url = NSURL(string: "http://immarketapi-dev.azurewebsites.net/api/category?")
            let request = NSMutableURLRequest(URL: url!)
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession.sharedSession()
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let urlConnection = NSURLConnection(request: request, delegate: self)
            request.HTTPMethod = "GET"
            request.setValue(authorizationWithoutLogin, forHTTPHeaderField: "Authorization")
            
            var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
               // print("Response: \(response)")
                self.tableView.hidden = false
                if  let strData = NSString(data: data!, encoding: NSUTF8StringEncoding){
                   // print("Body: \(strData)")
                    var err: NSError?
                    let json = (try? NSJSONSerialization.JSONObjectWithData(data!, options:[]) as? NSDictionary)
                    var arrayOfDicts : NSMutableArray? = (try? NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers)) as? NSMutableArray
                    
                    if arrayOfDicts != nil
                    {
                        for item in arrayOfDicts!
                        {
                            if var dict  = item as? NSMutableDictionary
                            {
                                var newDict : NSMutableDictionary = NSMutableDictionary()
                                
                                if dict["aCategoryName"] != nil
                                {
                                    newDict["aCategoryName"] = dict["aCategoryName"]
                                    newDict["aCategoryId"] = dict["aCategoryId"]
                                    
                                    
                                    self.newArrayofDicts.addObject(newDict)
                                    
                                }
                                if dict["subCategory"] != nil
                                {
                                    var arrayOfDicts : NSMutableArray? = dict["subCategory"] as? NSMutableArray
                                    
                                    var subcat : String  = dict["aCategoryName"] as! String
                                    
                                    for item in arrayOfDicts!
                                    {
                                        
                                        if let dict  = item as? NSMutableDictionary
                                        {
                                            var newDict1 : NSMutableDictionary = NSMutableDictionary()
                                            
                                            if dict["subCategoryName"] != nil
                                            {
                                                newDict1[subcat] = dict["subCategoryName"]
                                                newDict1["subCategoryId"] = dict["subCategoryId"]
                                                self.subcatArray.addObject(newDict1)
                                            }
                                            
                                            
                                            if dict ["category3List"] != nil
                                            {
                                                var arrayOfDicts1 : NSMutableArray? = dict["category3List"] as? NSMutableArray
                                                var subcat1 : String  = dict["subCategoryName"] as! String
                                                for item in arrayOfDicts1!
                                                {
                                                    if var dict  = item as? NSMutableDictionary
                                                    {
                                                        var newDict2 : NSMutableDictionary = NSMutableDictionary()
                                                        if dict["category3Name"] != nil
                                                        {
                                                            newDict2[subcat1] = dict["category3Name"]
                                                            newDict2["category3Id"] = dict["category3Id"]
                                                            // self.subCategories[dict["aCategoryName"]] = dict["subCategoryName"]
                                                            // self.subcatArray.addObject(newDict1["subCategoryName"]!)
                                                            self.level3catArray.addObject(newDict2)
                                                            
                                                        }
                                                        
                                                        
                                                        
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                            
                                            
                                        }
                                        
                                        
                                    }
                                    
                                }
                                
                            }
                        }
                    }
                    
//                    print("category array ::\(self.newArrayofDicts)", terminator: "")
//                    print("Subcategory array ::\(self.subcatArray)", terminator: "")
//                    print("level3category array :: \(self.level3catArray)", terminator: "")
                    
                    if(err != nil) {
                       // print(err!.localizedDescription)
                        let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                       // print("Error could not parse JSON: '\(jsonStr)'")
                    }
                    else {
                        
                        dispatch_sync(dispatch_get_main_queue())
                        {
                            self.tableView.hidden = false
                            LoadingOverlay.shared.hideOverlayView()
                            self.tableView.reloadData()
                            self.view.setNeedsDisplay()
                        }
                    }
                }
            })
            
            task.resume()
            self.tableView.hidden = false
            self.tableView.reloadData()
        }
        self.tableView.hidden = false
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = "Categories"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName : headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
         self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        
        let items = self.tabBarController?.tabBar.items
        let tabItem = items![1]
        tabItem.title = ""
        self.tabBarController?.tabBar.hidden = false
       
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(CategoriesViewController.internetReachable(_:)),
                                                         name: "reachable",
                                                         object: nil)
        if(newObjectMarr.count <= 0){
            noInternetConnectionClk()
        }else{
            self.tableView.hidden = false
            self.tableView.reloadData()
            
        }
    }
    func internetReachable(notification:NSNotification){
        noInternetConnectionClk()
       // print("in category via reachable")
    }
    override  func viewWillDisappear(animated: Bool) {
       // self.title = ""
         NSNotificationCenter.defaultCenter().removeObserver(self, name: "reachable", object: nil)
       // glblArr .removeObjectAtIndex(0)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    @IBAction func searchSubView(sender: AnyObject)
    {
        
        let  appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
        self.navigationController?.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBarHidden = true
         performSegueWithIdentifier("Search", sender: self)
        }else{
            let alert = UIAlertController(title: "", message: ConstantsFile.noInternet_msg, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
   
//        return self.newArrayofDicts.count
        
        return self.newObjectMarr.count
    }
    var catDic : NSMutableDictionary = NSMutableDictionary ()
   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! categoryCell
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        cell.selectionStyle = .None
       // cell.categoryText.font = UIFont(name:"MyriadPro-Regular", size: 24)
   /*     var stringvalue: AnyObject  = self.newArrayofDicts[indexPath.row]

         print(stringvalue, terminator: "")
        var stringvalue1: String = stringvalue["aCategoryName"] as! String
        print(stringvalue1, terminator: "")*/
        let extarctValue :Category  = self.newObjectMarr[indexPath.row] as! Category
       // print(extarctValue.aCategoryName)
        var stringvalue1: String = extarctValue.aCategoryName!
        //print(stringvalue1, terminator: "")

   /*     var stringvalue2: String = stringvalue["aCategoryId"] as! String
        print(stringvalue2, terminator: "")
        let a:Int? = Int(stringvalue2)
        
        if let tempStockCode = a {
            cell.tag = tempStockCode
            
        }*/
        
         //let tag = 99
        
        
      //  print(a!)
       // cell.categoryText?.text = "\(self.newArrayofDicts[indexPath.row])"
       cell.categoryText?.text = "\(stringvalue1)"
        // cell.categoryText?.text = self.newObjectMarr.objectAtIndex(indexPath.row) as! String
        // Configure the cell...
        
       

        return cell
    }
   
    
    var valueToPass:String!
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       
         let cell = tableView.cellForRowAtIndexPath(indexPath)!.tag
        
        
//         print(self.newArrayofDicts[indexPath.row])
//        CategoriesDict["categories2Pass"] = self.newArrayofDicts[indexPath.row]
        let indexPath = tableView.indexPathForSelectedRow
        let somevalue1   = self.newObjectMarr.objectAtIndex((indexPath?.row)!) as! Category
        let somevalue2 = somevalue1.subCategory
        //print(somevalue2!)
       
       self.objectToPass = self.newObjectMarr.objectAtIndex((indexPath?.row)!) as! Category
               let somevalue :Category  = self.objectToPass
        self.somevalue1  = somevalue.subCategory as! NSArray
        
       // print(self.somevalue1)
       
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as! categoryCell!
       
        catDic["categoryname"] = somevalue.aCategoryName!
        catDic["categoryID"] = somevalue.aCategoryId!
        glblArr.removeAllObjects()
        glblArr.addObject(catDic)
        valueToPass = currentCell.categoryText.text!
       
        //print(self.subcatArray.count)
        // print(self.subcatArray)
        var array1:NSMutableArray = NSMutableArray ()
        for item in subcatArray
        {
            //self.newArray1["subCategory2pass"] = item
            if var dict  = item as? NSMutableDictionary
            {
               //print(valueToPass)
                if dict[valueToPass] != nil
                {
                    array1 .addObject(dict[valueToPass]!)
//                    self.newArray2 .addObject(dict["subCategoryId"]!)
//                    
                }
                
                
            }
            
        }

        
        if array1.count == 0
        {
        performSegueWithIdentifier("OnlyCategorySearch", sender: self)
        }
        else
        {
        performSegueWithIdentifier("SubCategory", sender: self)
        }
       
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "SubCategory") {
            
            let viewController = (segue.destinationViewController as! SubCategoryViewController)
            
            // your new view controller should have property that will store passed value
           // print(valueToPass, terminator: "")
          //  myString.stringByReplacingOccurrencesOfString(" ", withString: "")
            let trimmedString = valueToPass.stringByReplacingOccurrencesOfString(" ", withString: "", options: []
                , range: nil)

            let backButton = UIBarButtonItem(title: valueToPass, style: UIBarButtonItemStyle.Plain, target: self, action: nil)
            backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 15)!], forState: UIControlState.Normal)
            navigationItem.backBarButtonItem = backButton
            
            viewController.passedValue = valueToPass
            viewController.passedDict = self.CategoriesDict
            
            viewController.categoryArr=self.newArrayofDicts
            viewController.subcategoryArr = self.subcatArray
            viewController.level3Arr = self.level3catArray
            viewController.subcatOject = self.somevalue1
            viewController.catDict = self.catDic
        }
        
        else if(segue.identifier == "OnlyCategorySearch")
        {
            let backButton = UIBarButtonItem(title: valueToPass, style: UIBarButtonItemStyle.Plain, target: self, action: nil)
            backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 15)!], forState: UIControlState.Normal)
            navigationItem.backBarButtonItem = backButton
            
         let viewController = (segue.destinationViewController as! CollectionViewController)
            //viewController.keyWords = ""
        viewController.comingfrom = "Category"
            viewController.keyWords = valueToPass
        
        }
        
        else if(segue.identifier == "Search")
        {
            let viewController = (segue.destinationViewController as! CollectionViewController)
            viewController.comingfrom = "Search"
        }
        
    }
    @IBAction func unwindToCatVC(segue: UIStoryboardSegue)
    {
        
        glblArr .removeLastObject()
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

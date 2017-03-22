

//
//  WebServiceClass.swift
//  MarketPlace
//
//  Created by Administrator on 11/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher
import AlamofireImage
import AlamofireImage
import CoreData

@objc protocol webServiceDelegate
{
    optional  func myDelegateFunction(string:ImgList)
    optional  func requestFailDelegate()
    
    optional  func registartionapiresponse(string:NSDictionary)
    optional  func  registartionapiFailedDelegate()
    
    optional  func forgotpwdapiresponse(string:NSDictionary)
    optional  func  forgotpwdapiFailedDelegate()
    
    optional  func confirmpwdapiresponse(string:NSDictionary)
    optional  func  confirmpwdapiFailedDelegate()
    
    optional  func basketdetailSuccess(string:NSDictionary)
    
    optional  func callAddressapiresponse(string:NSArray)
    optional  func  callAddressapiFailedDelegate()
    
    optional  func updatecontactOTPSuccess(string:NSDictionary)
    optional  func updatecontactOTPFailure(string:String)
    
    
    optional  func OTPconfirmationapiresponse (string:String)
    optional  func OTPconfirmationapiFailedDelegate (string:String)
    
    
    optional  func StateApiResponse (string:NSDictionary)
    optional  func StateApiFailedDelegate (string:String)
    
    optional  func CityApiResponse (string:NSDictionary)
    optional  func CityApiFailedDelegate (string:String)
    
    optional  func callAddressEditapiresponse(string:NSArray)
    optional  func  callAddressEditapiFailedDelegate()
    
    
    optional  func updatebasketdetailSuccess(string:NSDictionary)
    optional  func deletebasketdetailSuccess(string:NSDictionary)
    
    optional  func saveAddressapiresponse(string:String)
    optional  func saveAddressapiFailedDelegate (string:String)
    
    optional  func deleteAddressapiresponse(string:String)
    optional  func deleteAddressapiFailedDelegate(string:String)
    
    optional  func SetDefaultApiResponse (string:String)
    optional  func SetDefaultApiFailedDelegate (string:String)
    
    optional  func    UpdateAddressapiFailedDelegate (string:String)
    optional  func  UpdateAddressapiresponse (string:String)
    
    
    
    optional  func updatebasketdetailFailed(string:NSDictionary)
    
    optional  func addTocartSuccess(string:NSDictionary)
    
    optional  func getWishListSuccess(wishList:NSDictionary)
    
    optional  func addWishListSuccess(wishList:NSDictionary)
    
    optional  func isCODSuccess(codResp:NSDictionary)
    
    optional  func placeOrderSuccess(orderResp:NSDictionary)
    
    optional func getorderConfirmedSuccess(orderResp:NSDictionary)
    optional func placeOrderFailure()
}





//http://immarketapi.azurewebsites.net/api/
//Mobileprod456
//var baseUrl:String! = "http://immarketapi-stg2.azurewebsites.net/api/"
var baseUrl:String! = "http://immarketapi.azurewebsites.net/api/"
//var baseUrl:String! = "http://immarketapi-stg1.azurewebsites.net/api/"
//var baseUrl1:String! = "http://immarketapi-stg1.azurewebsites.net/api/"




var authorization1 : String!
var statename = Globalstate
var stateid = Globalstateid
var returnValue = NSUserDefaults.standardUserDefaults().objectForKey("Location") as? [String]

//let statename = returnValue![0]
//let stateid = returnValue![1]


var authorizationWithoutLogin:String = "Mobileprod456~~~~~13"

let defaults = NSUserDefaults.standardUserDefaults()
let data = defaults.objectForKey("LoginObject") as? NSData
let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data!)
// let returnValue = NSUserDefaults.standardUserDefaults().objectForKey("Location") as? [String]

//stage 2
//var authorizationWithLogin:String = "Mobilestg2456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(stateid)"
//var authorizationWithLogin1:String = "Mobilestg2456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(stateid)"
//var authorizationWithoutLogin:String = "Mobilestg2456~~~~~\(stateid)"


//stage 1
//var authorizationWithoutLogin:String = "Mobilestg1456~~~~~\(stateid)"
//var authorizationWithLogin:String = "Mobilestg1456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(stateid)"
//var authorizationWithLogin1:String = "Mobilestg1456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(stateid)"

//Prod

var authorizationWithLogin:String = "Mobileprod456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~13"
var authorizationWithLogin1:String = "Mobileprod456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~13"

class WebServiceClass: NSObject {
    var  delegates : webServiceDelegate?
    //static let sharedInstance = WebServiceClass()
    
    class var sharedInstance: WebServiceClass {
        struct Static {
            static let sharedInstance: WebServiceClass = WebServiceClass()
        }
        return Static.sharedInstance
    }
    
    
//    private override init() {
//    
//        if let returnValue = NSUserDefaults.standardUserDefaults().objectForKey("Location") as? [String]{
//         
//             statename = returnValue[0]
//             stateid = returnValue[1]
//             authorizationWithoutLogin = "Mobileprod456~~~~~\(stateid)"
//            
//            let defaults = NSUserDefaults.standardUserDefaults()
//            if  let data = defaults.objectForKey("LoginObject") as? NSData{
//             let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
//            // let returnValue = NSUserDefaults.standardUserDefaults().objectForKey("Location") as? [String]
//            //var authorizationWithLogin:String = "Mobilestg2456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(stateid)"
//            //var authorizationWithLogin1:String = "Mobilestg2456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(stateid)"
//            
//            //Prod
//             authorizationWithLogin = "Mobileprod456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(stateid)"
//             authorizationWithLogin1 = "Mobileprod456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(stateid)"
//            }
//        }else{
//            authorizationWithoutLogin = "Mobileprod456~~~~~13"
//            
//            let defaults = NSUserDefaults.standardUserDefaults()
//            if  let data = defaults.objectForKey("LoginObject") as? NSData{
//                let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
//                // let returnValue = NSUserDefaults.standardUserDefaults().objectForKey("Location") as? [String]
//                // authorizationWithLogin = "Mobilestg2456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(stateid)"
//                // authorizationWithLogin1 = "Mobilestg2456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~\(stateid)"
//                
//                //Prod
//                authorizationWithLogin = "Mobileprod456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~13"
//                authorizationWithLogin1 = "Mobileprod456~\(blog!.valueForKey("token")!)~\(blog!.valueForKey("userId")!)~Customer~null~13"
//            }
//        }
//    }
    var appdelegate:AppDelegate!
    
    func callVendorApi(itemtype:NSString,page:NSString,key:NSString)  {
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            let headers = [
                "Authorization": authorizationWithoutLogin,
                "Accept": "application/json"
            ]
            let url = "\(baseUrl)MarketPlaceCMS?itemtype=\(itemtype)&page=\(page)&key=\(key)"
           // print(url)
            Alamofire.request(.GET, url,headers: headers).responseObject { (response: Response<ImgList, NSError>) in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)
                if(response.result .isSuccess){
                    if let JSON = response.result.value {
                       // print(JSON)
                        if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                            self.delegates?.myDelegateFunction!(JSON)
                        }
                    }
                }
                if(response.result .isFailure){
                    if let JSON = response.result.value {
                        //print(JSON)
                        if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                            self.delegates?.requestFailDelegate!()
                        }
                    }
                }
                
            }
            
        }
        else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
    }
    
    
    func registration(otp:String,password:String,firstname:String,contactNumber:String,email:String,lastName:String)  {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            let headers = [
                "Authorization": authorizationWithoutLogin,
                "Content-Type" : "application/json"
            ]
            
            var url : NSURL!
            
            url = NSURL(string:"\(baseUrl)UserRegistration")
            let parameters = [
                "firstName":firstname,
                "lastName":lastName,
                "getOTP": false ,
                "contactNumber": contactNumber,
                "email":email,
                "codeSentBySMS": otp,
                "password" : password,
                "promotionalOffers":false
            ]
           // print(parameters)
            Alamofire.request(.POST,  url!, parameters: parameters as! [String : AnyObject], encoding:.JSON, headers: headers)
                .validate(contentType: ["application/json"])
                
                .responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess)
                    {
                        if let JSON = response.result.value
                        {
                            //print(JSON)
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                self.delegates?.registartionapiresponse!(JSON as! NSDictionary)
                            }
                        }
                    }
                    if(response.result .isFailure)
                    {
                        if let JSON = response.result.value
                        {
                            //                        print(JSON)
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                self.delegates?.registartionapiFailedDelegate!()
                            }
                        }
                        else if let statuscode = response.response?.statusCode
                        {
                           // print(statuscode)
                            var dict = NSDictionary()
                            dict = ["message" : "200"]
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                self.delegates?.registartionapiresponse!(dict as NSDictionary)
                            }
                            
                        }
                        else
                        {
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                self.delegates?.registartionapiFailedDelegate!()
                            }
                        }
                    }
                    
            }
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func forgotPassword(email:String)
    {
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            let headers = [
                "Authorization": authorizationWithoutLogin,
                "Accept": "application/json"
            ]
            let url = "\(baseUrl)password?userName=\(email)&mode=2"
           // print(url)
            Alamofire.request(.GET, url,headers: headers).responseObject { (response: Response<ImgList, NSError>) in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)
                if(response.result .isSuccess){
                    if let JSON = response.result.value {
                       // print(JSON)
                        var dict = NSDictionary()
                        if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                            self.delegates?.forgotpwdapiresponse!(dict as NSDictionary)
                        }
                    }
                }
                if(response.result .isFailure){
                    if let JSON = response.result.value
                    {
                        if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                            self.delegates?.forgotpwdapiFailedDelegate!()
                        }
                    }
                    else if let statuscode = response.response?.statusCode
                    {
                       // print(statuscode)
                        //                        if (statuscode == 200)
                        //                        {
                        var dict = NSDictionary()
                        dict = ["message" : "200"]
                        if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                            self.delegates?.forgotpwdapiresponse!(dict as NSDictionary)
                        }
                        //                        }
                        //                        else
                        //                        {
                        //
                        //                        self.delegates?.forgotpwdapiFailedDelegate!()
                        //                        }
                        
                        
                    }
                    else
                    {
                        if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                            self.delegates?.forgotpwdapiFailedDelegate!()
                        }
                    }
                }
                
            }
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
    }
    
    func confirmPwd(pwd:String,usrname:String)
    {
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            let headers = [
                "Authorization": authorizationWithoutLogin,
                "Accept": "application/json"
            ]
            //            :  http://immarketapi-stg2.azurewebsites.net/api/password
            let url = "\(baseUrl)password"
            
            //            var url : NSURL!
            //
            //            url = NSURL(string:"http://immarketapi-stg2.azurewebsites.net/api/UserRegistration")
            let parameters = [
                "Password":pwd,
                "UserName":usrname
            ]
           // print(parameters)
            Alamofire.request(.PUT,  url, parameters: parameters as! [String : String], encoding:.JSON, headers: headers)
                .validate(contentType: ["application/json"])
                
                .responseJSON { response in
                    
                    //            print(url)
                    //            Alamofire.request(.PUT, url,headers: headers).responseObject { (response: Response<ImgList, NSError>) in
//                    print(response.request)  // original URL request
//                    print(response.response) // URL response
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess){
                        if let JSON = response.result.value {
                           // print(JSON)
                            var dict = NSDictionary()
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                               // if(JSON.isKindOfClass(NSDictionary)){
                                self.delegates?.confirmpwdapiresponse!(dict as NSDictionary)
//                                }else{
//                                     self.delegates?.confirmpwdapiFailedDelegate!()
//                                }
                            }
                        }
                    }
                    if(response.result .isFailure){
                        if let JSON = response.result.value
                        {
                            //                        print(JSON)
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                self.delegates?.confirmpwdapiFailedDelegate!()
                            }
                        }
                        else if let statuscode = response.response?.statusCode
                        {
                            //print(statuscode)
                            //                        var dict = NSDictionary()
                            //                        dict = ["message" : "200"]
                            //                        self.delegates?.forgotpwdapiresponse!(dict as NSDictionary)
                            
                            
                        }
                        else
                        {
                            //   self.delegates?.forgotpwdapiFailedDelegate!()
                        }
                    }
                    
            }
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
    }
    func getBasketDetails(userId:Int,contryId:String)  {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            let headers = [
                "Authorization": authorizationWithLogin,
                "Content-Type" : "application/json"
            ]
            
            // var url : NSURL!
           // print(headers)
            let url = "\(baseUrl)basket?userId=\(userId)&sitecode=\(contryId)"
           // print(url)
            Alamofire.request(.GET, url,headers: headers).responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response?.statusCode) // URL response
//                print(response.data)     // server data
//                print(response.result)
              //  print(self.delegates as! UIViewController)
                
               // print("application viewc \(UIApplication.topViewController())")
                
                if(response.result .isSuccess)
                {
                    if let JSON = response.result.value
                    {
                       // print(JSON)
                       // if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                            //self.delegates?.basketdetailSuccess!(JSON as! NSDictionary)
                            LoadingOverlay.shared.hideOverlayView()
                            //if(JSON.isKindOfClass(NSDictionary)){
                                NSNotificationCenter.defaultCenter().postNotificationName("basketDetails", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
//                            }else{
//                                LoadingOverlay.shared.hideOverlayView()
//                                self.showAlertForRequestFail()
//                        }
//                        }else{
//                            LoadingOverlay.shared.hideOverlayView()
//                        }
                    }
                }
                if(response.result .isFailure)
                {
                    LoadingOverlay.shared.hideOverlayView()
                    self.showAlertForRequestFail()
                }
                
            }
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    
    func getBasketDetailslandingpage(userId:Int,contryId:String)  {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            let headers = [
                "Authorization": authorizationWithLogin,
                "Content-Type" : "application/json"
            ]
            
            // var url : NSURL!
           // print(headers)
            let url = "\(baseUrl)basket?userId=\(userId)&sitecode=\(contryId)"
            //print(url)
            Alamofire.request(.GET, url,headers: headers).responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response?.statusCode) // URL response
//                print(response.data)     // server data
//                print(response.result)
                //  print(self.delegates as! UIViewController)
                
               // print("application viewc \(UIApplication.topViewController())")
                
                if(response.result .isSuccess)
                {
                    if let JSON = response.result.value
                    {
                       // print(JSON)
                        // if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                        //self.delegates?.basketdetailSuccess!(JSON as! NSDictionary)
                        LoadingOverlay.shared.hideOverlayView()
                        //if(JSON.isKindOfClass(NSDictionary)){
                        NSNotificationCenter.defaultCenter().postNotificationName("basketDetailsLandingPage", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
                        //                            }else{
                        //                                LoadingOverlay.shared.hideOverlayView()
                        //                                self.showAlertForRequestFail()
                        //                        }
                        //                        }else{
                        //                            LoadingOverlay.shared.hideOverlayView()
                        //                        }
                    }
                }
                if(response.result .isFailure)
                {
                    LoadingOverlay.shared.hideOverlayView()
                    self.showAlertForRequestFail()
                }
                
            }
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func getBasketDetailsLoginPage(userId:Int,contryId:String)  {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            let headers = [
                "Authorization": authorizationWithLogin,
                "Content-Type" : "application/json"
            ]
            
            // var url : NSURL!
           // print(headers)
            let url = "\(baseUrl)basket?userId=\(userId)&sitecode=\(contryId)"
            //print(url)
            Alamofire.request(.GET, url,headers: headers).responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response?.statusCode) // URL response
//                print(response.data)     // server data
//                print(response.result)
                //  print(self.delegates as! UIViewController)
                
                //print("application viewc \(UIApplication.topViewController())")
                
                if(response.result .isSuccess)
                {
                    if let JSON = response.result.value
                    {
                        //print(JSON)
                        // if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                        //self.delegates?.basketdetailSuccess!(JSON as! NSDictionary)
                        LoadingOverlay.shared.hideOverlayView()
                        //if(JSON.isKindOfClass(NSDictionary)){
                        NSNotificationCenter.defaultCenter().postNotificationName("basketDetailsLoginPage", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
                        //                            }else{
                        //                                LoadingOverlay.shared.hideOverlayView()
                        //                                self.showAlertForRequestFail()
                        //                        }
                        //                        }else{
                        //                            LoadingOverlay.shared.hideOverlayView()
                        //                        }
                    }
                }
                if(response.result .isFailure)
                {
                    LoadingOverlay.shared.hideOverlayView()
                    self.showAlertForRequestFail()
                }
                
            }
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    
    func callAdressApi(userID:Int)
    {
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            let headers = [
                "Authorization": authorizationWithoutLogin,
                "Accept": "application/json"
            ]
            let url = "\(baseUrl)address?addressId=&UserId=\(userID)"
           // print(url)
            Alamofire.request(.GET, url, headers: headers)
                .validate(contentType: ["application/json"])
                
                .responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response) // URL response
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess){
                        if let JSON = response.result.value {
                          //  print(JSON)
                            var dict = NSDictionary()
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                
                                self.delegates?.callAddressapiresponse!(JSON as! NSArray)
                            }
                        }
                    }
                    if(response.result .isFailure){
                        if let JSON = response.result.value
                        {
                            //                        print(JSON)
                            self.delegates?.callAddressapiFailedDelegate!()
                        }
                        else if let statuscode = response.response?.statusCode
                        {
                           // print(statuscode)
                             var dict = NSDictionary()
                            dict = ["message" : "200"]
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                self.delegates?.callAddressapiFailedDelegate!()
                            }
                            
                            
                        }
                        else
                        {
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                self.delegates?.callAddressapiFailedDelegate!()
                            }
                        }
                    }
                    
            }
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
    }
    func callAdressApiForEdit(userID:Int)
    {
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            let headers = [
                "Authorization": authorizationWithoutLogin,
                "Accept": "application/json"
            ]
            let url = "\(baseUrl)address?addressId=&UserId=\(userID)"
           // print(url)
            Alamofire.request(.GET, url, headers: headers)
                .validate(contentType: ["application/json"])
                
                .responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response) // URL response
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess){
                        if let JSON = response.result.value {
                            //print(JSON)
                            var dict = NSDictionary()
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                self.delegates?.callAddressEditapiresponse!(JSON as! NSArray)
                            }
                        }
                    }
                    if(response.result .isFailure){
                        if let JSON = response.result.value
                        {
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                self.delegates?.callAddressEditapiFailedDelegate!()
                            }
                        }
                        else if let statuscode = response.response?.statusCode
                        {
                           // print(statuscode)
                            //                        if (statuscode == 200)
                            //                        {
                            var dict = NSDictionary()
                            dict = ["message" : "200"]
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                self.delegates?.callAddressEditapiFailedDelegate!()
                            }
                            
                            
                        }
                        else
                        {
                            self.delegates?.callAddressEditapiFailedDelegate!()
                        }
                    }
                    
            }
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
    }
    
    
    func callMobileUpdateApi(firstName:String,lastName:String,email:String,cont:String)
    {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            
            
            let defaults = NSUserDefaults.standardUserDefaults()
            if let data = defaults.objectForKey("LoginObject") as? NSData
            {
                
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                   // print(blog)
                    let authorization = authorizationWithLogin
                     let headers = [
                        "Authorization" : authorization,
                        "Content-Type ": "application/json"
                    ]
                    
                    let parameters = [
                        "contactNumber": cont,
                        "email": email,
                        "firstName": firstName,
                        "getOTP": true ,
                        "lastName": lastName
                    ]
                    
                   // print(parameters)
                    
                    let url = "\(baseUrl)Profile"
                    Alamofire.request(.POST,  url, parameters: parameters as! [String: AnyObject], encoding:.JSON, headers: headers)
                        .validate(contentType: ["application/json"])
                        
                        .responseJSON { response in
//                            print(response.request)  // original URL request
//                            print(response.response) // URL response
//                            print(response.data)
                            var strData = NSString(data: response.data!, encoding: NSUTF8StringEncoding)
//                            print("Body: \(strData!)")// server data
//                            print(response.result)
                            
                            
                            if (response.result .isSuccess)
                            {
                                
                                if let JSON = response.result.value
                                {
                                    if let Message  : AnyObject  = JSON
                                    {
                                       // print(Message)
                                        
                                        // print(message)
                                        if(Message .isEqual("Verification Code sent to"))
                                        {
                                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                                var dict = NSDictionary()
                                                self.delegates?.updatecontactOTPSuccess!(dict)
                                                // self.showAlertForCodeSent(JSON as! String)
                                            }
                                        }
                                        else
                                        {
                                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                                let message  = Message["message"]! as! String
                                                self.delegates?.updatecontactOTPFailure!(message as! String)
                                            }
                                        }
                                    }
                                    else
                                    {
                                        // self.showAlert(Message as! String)
                                        
                                    }
                                }
                                
                            }//alamofire success req complete
                                
                            else if  (response.result .isFailure)
                            {
                                
                                if let JSON = response.result.value
                                {
                                    if let Message  : AnyObject  = JSON
                                    {
                                        if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                            let messge = Message as! String
                                            self.delegates?.updatecontactOTPFailure!(messge)
                                        }
                                    }
                                    // self.showAlert(JSON as! String)
                                    
                                }
                                    
                                else
                                {
                                    //self.showAlert("Request timed Out")
                                }
                            }//alamofire failure req complete
                            
                    }//alamofire req complete
                    
                    
                }//login object req compelte
                
            }//login object req compelte
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
    }//update req compelte
    
    func OTPConfirmationUpdateMobile(otp:String,contactNumber:String,email:String)  {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            let defaults = NSUserDefaults.standardUserDefaults()
            if let data = defaults.objectForKey("LoginObject") as? NSData
            {
                //            let unarc = NSKeyedUnarchiver(forReadingWithData: data)
                // let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    //print(blog)
                    let authorization = authorizationWithLogin
                    //                print(authorization)
                    //                print(blog.valueForKey("token")! as! String)
                    
                    let headers = [
                        "Authorization" : authorization,
                        "Content-Type ": "application/json"
                    ]
                    
                    
                    var url : NSURL!
                    
                    url = NSURL(string:"\(baseUrl)Profile")
                    let parameters = [
                        "getOTP": false ,
                        "contactNumber": contactNumber,
                        "email":email,
                        "codeSentBySMS": otp
                    ]
                   // print(parameters)
                    Alamofire.request(.POST,  url!, parameters: parameters as! [String : AnyObject], encoding:.JSON, headers: headers)
                        .validate(contentType: ["application/json"])
                        
                        .responseJSON { response in
//                            print(response.request)  // original URL request
//                            print(response.response?.statusCode) // URL response
//                            print(response.data)     // server data
//                            print(response.result)
                            if(response.result .isSuccess)
                            {
                                if let JSON = response.result.value
                                {
                                   // print(JSON)
                                    if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                        var dict = String()
                                        self.delegates?.OTPconfirmationapiresponse!(contactNumber)
                                    }
                                }
                            }
                            if(response.result .isFailure)
                            {
                                if let JSON = response.result.value
                                {
                                    if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                        var dict = String()
                                        //                        print(JSON)
                                        self.delegates?.OTPconfirmationapiFailedDelegate!(dict as String)
                                    }
                                }
                                else if let statuscode = response.response?.statusCode
                                {
                                    //                                    print(statuscode)
                                    //                                    var dict = NSDictionary()
                                    //                                    dict = ["message" : "200"]
                                    // self.delegates?.registartionapiresponse!(dict as NSDictionary)
                                    
                                    
                                }
                                else
                                {
                                    //  self.delegates?.registartionapiFailedDelegate!()
                                }
                            }
                            
                    }
                    
                }else{
                    LoadingOverlay.shared.hideOverlayView()
                    showAlert()
                }
                
                
                
                
                
                
            }
            
            
            
        }
        
    }
    
    
    func updateBasketDetails(index:String,lineItemId:String,BasketId:String,quantity:String,userId:Int,sitecode:String,placedPrice:String)  {
        //{index: 1, lineItemId: 709, BasketId: 1, quantity: 1, userId: 7, sitecode: "IN", placedPrice: 18382}
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            //            let headers = [
            //                "Authorization": "Mobilestg2456~~~~~13",
            //                "Content-Type" : "application/json"
            //            ]
            var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                    
                {
                    let authorization = authorizationWithLogin
                    
                   // print(authorization)
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
            }
            //  userId =
            let parameters = [
                "index":index,
                "lineItemId":lineItemId,
                "BasketId":BasketId,
                "quantity":quantity,
                "userId":String(userId),
                "sitecode":sitecode,
                "placedPrice":placedPrice
                
            ]
            // var url : NSURL!
            
            //  let url = "\(baseUrl)basket?index=\(index)&lineItemId=\(lineItemId)&BasketId=\(BasketId)&quantity=\(quantity)&userId=\(userId)&sitecode=\(sitecode)&placedPrice=\(placedPrice)"
            let url = "\(baseUrl)basket"
           // print(url)
            Alamofire.request(.PUT,  url, parameters: parameters as! [String : String], encoding:.JSON, headers: headers)
                .responseJSON { response in
                    // Alamofire.request(.PUT, url,headers: headers).responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess)
                    {
                        if let JSON = response.result.value
                        {
                           // print(JSON)
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                //if(JSON.isKindOfClass(NSDictionary)){
                                self.delegates?.updatebasketdetailSuccess!(JSON as! NSDictionary)
//                                }else{
//                                    LoadingOverlay.shared.hideOverlayView()
//                                    self.showAlertForRequestFail()
//                                }
                            }
                        }
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                        self.showAlertForRequestFail()
                        if let JSON = response.result.value
                        {
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                self.delegates?.updatebasketdetailFailed!(JSON as! NSDictionary)
                            }
                        }
                    }
                    
            }
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func DeleteBasketDetails(index:String,lineItemId:String,BasketId:String,quantity:String,userId:Int,sitecode:String,placedPrice:String)  {
        //{index: 1, lineItemId: 709, BasketId: 1, quantity: 1, userId: 7, sitecode: "IN", placedPrice: 18382}
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            let headers = [
                "Authorization": authorizationWithoutLogin,
                "Content-Type" : "application/json"
            ]
            let parameters = [
                "index":index,
                "lineItemId":lineItemId,
                "BasketId":BasketId,
                "quantity":quantity,
                "userId":userId,
                "sitecode":sitecode,
                "placedPrice":placedPrice
                
            ]
            // var url : NSURL!
            let url = "\(baseUrl)basket?index=\(index)&lineItemId=\(lineItemId)&BasketItemId=\(BasketId)&userId=\(userId)&sitecode=\(sitecode)&placedPrice=\(placedPrice)"
            //let url = "\(baseUrl)basket"
           // print(url)
            Alamofire.request(.DELETE,  url, headers: headers)
                .validate(contentType: ["application/json"])
                
                .responseJSON { response in
                    // Alamofire.request(.PUT, url,headers: headers).responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess)
                    {
                        if let JSON = response.result.value
                        {
                           // print(JSON)
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                self.delegates?.deletebasketdetailSuccess!(JSON as! NSDictionary)
                            }
                        }
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                        self.showAlertForRequestFail()
                    }
                    
            }
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func addToBasketOnlineDetails(userId:Int,sitecode:String,productDet:NSDictionary)  {
        //{index: 1, lineItemId: 709, BasketId: 1, quantity: 1, userId: 7, sitecode: "IN", placedPrice: 18382}
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        // var prodArr = []
        var  prodArr  = [
            "avaliableQuantity": 145,
            "description": "500GB RUGGED MINI USB 3.0 [7200]",
            "extendedPrice": 3872,
            "imageURLMedium": "http://impix-in.azureedge.net/150/9_2896685_Front.jpg",
            "limitedStock": "0",
            "maximumQuantity": "4",
            "modifiedBy": "",
            "placedPrice": 3872,
            "productId": "301556",
            "quantity": 1,
            "sellerName": "CROMA  CBD",
            "sellerNumber": "0200000038",
            "skuNumber": "000000030000000100",
            "vendorCode": "hp",
            "vendorPartNumber": "301556",
            "runSalesOrder":"y"
        ]
       // print(productDet)
        if (appdelegate.isReachable == true) {
            var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                
                
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                    
                {
                    
                    //print(blog)
                    
                    let authorization = authorizationWithLogin
                    
                  //  print(authorization)
                    
                    
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
            }
            let parameters = [
                
                "userId":userId,
                "siteCode":sitecode,
                "name":"My Basket",
                "BasketLineItem": [productDet]
                
            ]
           // print(parameters)
            // var url : NSURL!
            let url = "\(baseUrl)basket"
            //let url = "\(baseUrl)basket"
          //  print(url)
            Alamofire.request(.POST,  url,parameters: parameters as! [String : AnyObject], encoding:.JSON, headers: headers)
                .validate(contentType: ["application/json"])
                
                .responseJSON { response in
                    // Alamofire.request(.PUT, url,headers: headers).responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess)
                    {
                        if let JSON = response.result.value
                        {
                            
                           // print(JSON)
                            LoadingOverlay.shared.hideOverlayView()
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                               // if(JSON.isKindOfClass(NSDictionary)){
                                     self.delegates?.addTocartSuccess!(JSON as! NSDictionary)
//                                }else{
//                                    LoadingOverlay.shared.hideOverlayView()
//                                    self.showAlertForRequestFail()
//                                }
                               
                            }
                        }
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                        self.showAlertForRequestFail()
                    }
                    
            }
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func deleteMyCartData()  {
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        let coord = appDelegate.persistentStoreCoordinator
        let fetchRequest = NSFetchRequest(entityName: "MyCart")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.executeRequest(deleteRequest)
            
        } catch {
            // Error Handling
        }
    }
    func sendAllcartToserver()  {
        
        let prodArr:NSMutableArray!=NSMutableArray()
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "MyCart")
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            if let Mycarttbl : [NSManagedObject] = results as? [NSManagedObject]
            {
                for cart in Mycarttbl
                {
                    
                    let productDict=NSMutableDictionary()
                    // if let np = cart {
                    productDict.setValue(cart.valueForKey("placedPrice"), forKey: "placedPrice")
                    // }
                    
                    productDict.setValue(cart.valueForKey("quantity"), forKey: "quantity")
                    productDict.setValue(cart.valueForKey("productId"), forKey: "productId")
                    productDict.setValue(cart.valueForKey("vendorPartNumber"), forKey: "vendorPartNumber")
                    productDict.setValue("hp", forKey: "vendorCode")
                    productDict.setValue(cart.valueForKey("extendedPrice"), forKey: "extendedPrice")
                    productDict.setValue(cart.valueForKey("vendorCode"), forKey: "vendorCode")
                    productDict.setValue(cart.valueForKey("mdescription"), forKey: "description")
                    productDict.setValue(cart.valueForKey("imageURLMedium"), forKey: "imageURLMedium")
                    productDict.setValue(cart.valueForKey("sellerName"), forKey: "sellerName")
                    productDict.setValue(cart.valueForKey("sellerNumber"), forKey: "sellerNumber")
                    productDict.setValue(cart.valueForKey("skuNumber"), forKey: "skuNumber")
                    productDict.setValue(cart.valueForKey("limitedStock"), forKey: "limitedStock")
                    productDict.setValue(cart.valueForKey("maximumQuantity"), forKey: "maximumQuantity")
                    productDict.setValue(cart.valueForKey("availabilty"), forKey: "avaliableQuantity")
                    //self.productDict.setValue("hp", forKey: "vendorCode")
                    productDict.setValue("", forKey: "modifiedBy")
                    prodArr.addObject(productDict)
                }
                
            }
            
        }catch _ {
        }
        
        //  if prodArr.count > 0 {
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                    
                {
                    
                    let authorization = authorizationWithLogin
                    
                   // print(authorization)
                    
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
            }
            var  prodArr1  = [
                "avaliableQuantity": 145,
                "description": "500GB RUGGED MINI USB 3.0 [7200]",
                "extendedPrice": 3872,
                "imageURLMedium": "http://impix-in.azureedge.net/150/9_2896685_Front.jpg",
                "limitedStock": "0",
                "maximumQuantity": "4",
                "modifiedBy": "",
                "placedPrice": 3872,
                "productId": "301556",
                "quantity": 1,
                "sellerName": "CROMA  CBD",
                "sellerNumber": "0200000038",
                "skuNumber": "000000030000000100",
                "vendorCode": "hp",
                "vendorPartNumber": "301556"
                
            ]
            
            if prodArr.count > 0 {
                
                let parameters = [
                    
                    "userId":defaults.objectForKey("userId")!,
                    "siteCode":"IN",
                    "name":"My Basket",
                    
                    "BasketLineItem": prodArr!
                    
                ]
               // print(parameters)
                
                let url = "\(baseUrl)basket"
                
               // print(url)
                Alamofire.request(.POST,  url,parameters: parameters as! [String : AnyObject], encoding:.JSON, headers: headers)
                    .validate(contentType: ["application/json"])
                    
                    .responseJSON { response in
                        // Alamofire.request(.PUT, url,headers: headers).responseJSON { response in
//                        print(response.request)  // original URL request
//                        print(response.response?.statusCode) // URL response
//                        print(response.data)     // server data
//                        print(response.result)
                        if(response.result .isSuccess)
                        {
                            if let JSON = response.result.value
                            {
                               // print(JSON)
                                //proceedTochk
                                NSNotificationCenter.defaultCenter().postNotificationName("proceedTochk", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
                                self.deleteMyCartData()
                                //self.delegates?.addTocartSuccess!(JSON as! NSDictionary)
                                if let cnt = JSON.valueForKey("lineCount") as? String{
                                    if(cnt == "0"){
                                        // tabItem.badgeValue = nil
                                        let defaults = NSUserDefaults.standardUserDefaults()
                                        defaults.setObject("", forKey: "badge")
                                    }else{
                                        let defaults = NSUserDefaults.standardUserDefaults()
                                        defaults.setObject(cnt, forKey: "badge")
                                    }
                                    // }
                                }
                                
                            }
                        }
                        if(response.result .isFailure)
                        {
                           // LoadingOverlay.shared.hideOverlayView()
                            //self.showAlertForRequestFail()
                            self.sendAllcartToserver()
                        }
                        
                }
                
            }else{
                NSNotificationCenter.defaultCenter().postNotificationName("proceedTochk", object: nil, userInfo: prodArr1 as [NSObject: AnyObject] )
            }
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        // }
    }
    func callstateApiicompare()
    {
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            //let defaults = NSUserDefaults.standardUserDefaults()
//            if let data = defaults.objectForKey("LoginObject") as? NSData
//            {
//                            let unarc = NSKeyedUnarchiver(forReadingWithData: data)
//                 let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
//                
//                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
//                {
                  
                    let authorization = authorizationWithoutLogin
                    //                print(authorization)
                    //                print(blog.valueForKey("token")! as! String)
                    
                    let headers = [
                        "Authorization" : authorization,
                        "Content-Type ": "application/json"
                    ]
                    
            
                    var url : NSURL!
                    
                    url = NSURL(string:"\(baseUrl)address")
                    
                    Alamofire.request(.GET, url, headers: headers)
                        .validate(contentType: ["application/json"])
                        
                        .responseJSON { response in
//                            print(response.request)  // original URL request
//                            print(response.response?.statusCode) // URL response
//                            print(response.data)     // server data
//                            print(response.result)
                            if(response.result .isSuccess)
                            {
                                if let JSON = response.result.value
                                {
                                  //  print(JSON)
                                    
                                    LoadingOverlay.shared.hideOverlayView()
                                    
                                    let dict : AnyObject = JSON as! [NSObject : AnyObject]
                                    //print(dict)
                                    var stateDict = dict as! NSDictionary
                                   // print(stateDict)
                                    arrayState.removeAllObjects()
                                    let countryArr = dict["state"] as! NSArray
                                    for country  in countryArr
                                    {
                                        arrayState.addObject(country)
                                    }
                                  //  print(arrayState)
                                    
                                     NSNotificationCenter.defaultCenter().postNotificationName("stateCompare", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
                                    
                                    
                                    //                                    if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                    //                                        var dict = String()
                                    // self.delegates?.StateApiResponse!(JSON as! NSDictionary)
                                    // NSNotificationCenter.defaultCenter().postNotificationName("stateResp", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
                                    //stateResp
                                    //  }
                                }
                            }
                            if(response.result .isFailure)
                            {
                                if let JSON = response.result.value
                                {
                                    if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                        var dict = String()
                                        //                        print(JSON)
                                        self.delegates?.StateApiFailedDelegate!(dict as String)
                                    }
                                }
                                else if let statuscode = response.response?.statusCode
                                {
                                    //                                    print(statuscode)
                                    //                                    var dict = NSDictionary()
                                    //                                    dict = ["message" : "200"]
                                    // self.delegates?.registartionapiresponse!(dict as NSDictionary)
                                    
                                    
                                }
                                else
                                {
                                    //  self.delegates?.registartionapiFailedDelegate!()
                                }
                            }
                            
                    }
                    
                }else{
                    LoadingOverlay.shared.hideOverlayView()
                    showAlert()
                }
                
                
                
            
//            }
//            
//            
//            
//        }
        
        
    }
    func callstateApii()
    {
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            let defaults = NSUserDefaults.standardUserDefaults()
            if let data = defaults.objectForKey("LoginObject") as? NSData
            {
                //            let unarc = NSKeyedUnarchiver(forReadingWithData: data)
                // let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    //print(blog)
                    let authorization = authorizationWithLogin1
                    //                print(authorization)
                    //                print(blog.valueForKey("token")! as! String)
                    
                    let headers = [
                        "Authorization" : authorization,
                        "Content-Type ": "application/json"
                    ]
                    
                    
                    var url : NSURL!
                    
                    url = NSURL(string:"\(baseUrl)address?txtState=")
                    
                    Alamofire.request(.GET, url, headers: headers)
                        .validate(contentType: ["application/json"])
                        
                        .responseJSON { response in
//                            print(response.request)  // original URL request
//                            print(response.response?.statusCode) // URL response
//                            print(response.data)     // server data
//                            print(response.result)
                            if(response.result .isSuccess)
                            {
                                if let JSON = response.result.value
                                {
                                   // print(JSON)
                                    
                                    LoadingOverlay.shared.hideOverlayView()
                                   
                                        let dict : AnyObject = JSON as! [NSObject : AnyObject]
                                        var stateDict = dict as! NSDictionary
                                    arrayCountries = NSMutableArray()
                                        arrayCountries.removeAllObjects()
                                    
                                        let countryArr = dict["state"] as! NSArray
                                        for country  in countryArr
                                        {
                                            arrayCountries.addObject(country)
                                        }
                                        //print(arrayCountries)
                                        
                                       
//                                    if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
//                                        var dict = String()
                                       // self.delegates?.StateApiResponse!(JSON as! NSDictionary)
                                        // NSNotificationCenter.defaultCenter().postNotificationName("stateResp", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
                                        //stateResp
                                  //  }
                                }
                            }
                            if(response.result .isFailure)
                            {
                                if let JSON = response.result.value
                                {
                                    if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                        var dict = String()
                                        //                        print(JSON)
                                        self.delegates?.StateApiFailedDelegate!(dict as String)
                                    }
                                }
                                else if let statuscode = response.response?.statusCode
                                {
                                    //                                    print(statuscode)
                                    //                                    var dict = NSDictionary()
                                    //                                    dict = ["message" : "200"]
                                    // self.delegates?.registartionapiresponse!(dict as NSDictionary)
                                    
                                    
                                }
                                else
                                {
                                    //  self.delegates?.registartionapiFailedDelegate!()
                                }
                            }
                            
                    }
                    
                }else{
                    LoadingOverlay.shared.hideOverlayView()
                    showAlert()
                }
                
                
                
            }
            
            
            
        }
        
        
    }
    func callCityApi ()
    {
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            let defaults = NSUserDefaults.standardUserDefaults()
            if let data = defaults.objectForKey("LoginObject") as? NSData
            {
                //            let unarc = NSKeyedUnarchiver(forReadingWithData: data)
                // let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                   // print(blog)
                    let authorization = authorizationWithLogin
                    //                print(authorization)
                    //                print(blog.valueForKey("token")! as! String)
                    
                    let headers = [
                        "Authorization" : authorization,
                        "Content-Type ": "application/json"
                    ]
                    
                    
                    var url : NSURL!
                    
                    url = NSURL(string:"\(baseUrl)address?txtCity=")
                    
                    Alamofire.request(.GET, url, headers: headers)
                        .validate(contentType: ["application/json"])
                        
                        .responseJSON { response in
//                            print(response.request)  // original URL request
//                            print(response.response?.statusCode) // URL response
//                            print(response.data)     // server data
//                            print(response.result)
                            if(response.result .isSuccess)
                            {
                                if let JSON = response.result.value
                                {
                                   // print(JSON)
                                      NSNotificationCenter.defaultCenter().postNotificationName("cityResp", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
//                                    if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
//                                        var dict = String()
//                                       // self.delegates?.CityApiResponse!(JSON as! NSDictionary)
//                                         NSNotificationCenter.defaultCenter().postNotificationName("cityResp", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
//                                    }
                                }
                            }
                            if(response.result .isFailure)
                            {
                                  LoadingOverlay.shared.hideOverlayView()
                                if let JSON = response.result.value
                                {
                                    if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                        var dict = String()
                                        //                        print(JSON)
                                        self.delegates?.CityApiFailedDelegate!(dict as String)
                                    }
                                }
                                else if let statuscode = response.response?.statusCode
                                {
                                    //                                    print(statuscode)
                                    //                                    var dict = NSDictionary()
                                    //                                    dict = ["message" : "200"]
                                    // self.delegates?.registartionapiresponse!(dict as NSDictionary)
                                    
                                    
                                }
                                else
                                {
                                    //  self.delegates?.registartionapiFailedDelegate!()
                                }
                            }
                            
                    }
                    
                }else{
                    LoadingOverlay.shared.hideOverlayView()
                    showAlert()
                }
                
                
            }
            
            
            
        }
        
        
    }
    func callCityApiTogetState(selcity:String)
    {
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            let defaults = NSUserDefaults.standardUserDefaults()
            if let data = defaults.objectForKey("LoginObject") as? NSData
            {
                //            let unarc = NSKeyedUnarchiver(forReadingWithData: data)
                // let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    //print(blog)
                    let authorization = authorizationWithLogin
                    //                print(authorization)
                    //                print(blog.valueForKey("token")! as! String)
                    
                    let headers = [
                        "Authorization" : authorization,
                        "Content-Type ": "application/json"
                    ]
                    
                    
                    var url : NSURL!
                    
                    url = NSURL(string:"\(baseUrl)address?Expand=0&City=\(selcity)")
                    
                    Alamofire.request(.GET, url, headers: headers)
                       // .validate(contentType: ["application/json"])
                        
                        .responseJSON { response in
//                            print(response.request)  // original URL request
//                            print(response.response?.statusCode) // URL response
//                            print(response.data)     // server data
//                            print(response.result)
                            if(response.result .isSuccess)
                            {
                                if let JSON = response.result.value
                                {
                                    //print(JSON)
//                                    if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
//                                        var dict = String()
                                        // self.delegates?.CityApiResponse!(JSON as! NSDictionary)
                                        NSNotificationCenter.defaultCenter().postNotificationName("citystateResp", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
                                   // }
                                }
                            }
                            if(response.result .isFailure)
                            {
                                LoadingOverlay.shared.hideOverlayView()
                                if let JSON = response.result.value
                                {
                                    if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                        var dict = String()
                                        //                        print(JSON)
                                        self.delegates?.CityApiFailedDelegate!(dict as String)
                                    }
                                }
                                else if let statuscode = response.response?.statusCode
                                {
                                  
                                    
                                    
                                }
                                else
                                {
                                    //  self.delegates?.registartionapiFailedDelegate!()
                                }
                            }
                            
                    }
                    
                }else{
                    LoadingOverlay.shared.hideOverlayView()
                    showAlert()
                }
                
                
            }
            
            
            
        }
        
        
    }
    func callSaveAdressApi(userID:String,stateID:String,address:String,area:String,city:String,name:String,title:String,zipcode:String)
    {
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true)
        {
            var headers : [String : String]!
            
            var url : NSURL!
            
            let statenull = NSNull()
            
            url = NSURL(string:"\(baseUrl)address?CheckDelivey=true")
            
            let parameters :[String : AnyObject] =  ["data":[
                "address1":address,
                "area":area,
                "city":city,
                "name":name,
                "showAddress":false,
                "stateId":stateID,
                "title":title,
                "userId":userID,
                "zipCode":zipcode
                ]]
         
            let defaults = NSUserDefaults.standardUserDefaults()
            let userId = defaults.objectForKey("userId") as? Int
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    //print(blog)
                    let authorization = authorizationWithLogin
                    authorization1 = authorization
                    
                    let headers = [
                        "Authorization":authorization,
                        "Content-Type":"application/json"
                        
                    ]
                    //print(headers)
                }
            }
            
            var  request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(authorization1, forHTTPHeaderField: "Authorization")
            
            let values = ["06786984572365", "06644857247565", "06649998782227"]
            let parameters2  =  [[
                "address1":address,
                "area":area,
                "city":city,
                "name":name,
                "showAddress":false,
                "stateId":stateID,
                "title":title,
                "userId":userID,
                "zipCode":zipcode
                ]]
          //  print(parameters2)
            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(parameters2, options:[])
            Alamofire.request(request)
                .responseJSON { response in
                    // do whatever you want here
                    switch response.result {
                    case .Failure(let error):
                       // print(error)
                        
                        if let data = response.data, let responseString = String(data: data, encoding:NSUTF8StringEncoding) {
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                self.delegates?.saveAddressapiFailedDelegate!(responseString as String)
                            }
                        }
                    case .Success(let responseObject):
                        //print(responseObject)
                        if (responseObject.isEqual(1))
                        {
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                self.delegates?.saveAddressapiresponse!("Success")
                            }
                        }else{
                            if let data = response.data, let responseString = String(data: data, encoding:NSUTF8StringEncoding) {
                                //print(responseString)
                                  if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                               self.delegates?.saveAddressapiFailedDelegate!(responseString as String)
                                }
                            }
                        }
                    }
            }
        }
            
        else
        {
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
    }
    
    
    
    func callDeleteAdressApi(addressID:Int)
    {
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            
            let defaults = NSUserDefaults.standardUserDefaults()
            if let data = defaults.objectForKey("LoginObject") as? NSData
            {
                //            let unarc = NSKeyedUnarchiver(forReadingWithData: data)
                // let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    //print(blog)
                    let authorization = authorizationWithLogin
                    //                print(authorization)
                    //                print(blog.valueForKey("token")! as! String)
                    
                    let headers = [
                        "Authorization" : authorization,
                        "Content-Type ": "application/json"
                    ]
                    
                    
                    var url : NSURL!
                    url = NSURL(string:"\(baseUrl)address?addressId=\(addressID)")
                    Alamofire.request(.DELETE, url, headers: headers)
                        .validate(contentType: ["application/json"])
                        
                        .responseJSON { response in
//                            print(response.request)  // original URL request
//                            print(response.response?.statusCode) // URL response
//                            print(response.data)     // server data
//                            print(response.result)
                            if(response.result .isSuccess)
                            {
                                if let JSON = response.result.value
                                {
                                    //print(JSON)
                                    var dict = String()
                                    if (JSON as! NSObject == 1)
                                    {
                                        if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                            self.delegates?.deleteAddressapiresponse!("success")
                                        }
                                    }
                                }
                            }
                            if(response.result .isFailure)
                            {
                                if let JSON = response.result.value
                                {
                                    if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                        var dict = String()
                                        //                        print(JSON)
                                        self.delegates?.deleteAddressapiFailedDelegate!(dict as String)
                                    }
                                }
                                else if let statuscode = response.response?.statusCode
                                {
                                    
                                }
                                else
                                {
                                    //  self.delegates?.registartionapiFailedDelegate!()
                                }
                            }
                            
                    }
                }
            }
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
    }
    
    
    
    
    func getWishListDetails()  {
        //{index: 1, lineItemId: 709, BasketId: 1, quantity: 1, userId: 7, sitecode: "IN", placedPrice: 18382}
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            let userId = defaults.objectForKey("userId") as? Int
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    let authorization = authorizationWithLogin
                    
                    //print(authorization)
                    
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
                
                let url = "\(baseUrl)WishList?userId=\(userId!)&WishDetails=t"
                //let url = "\(baseUrl)basket"
              //  print(url)
                do{
                    Alamofire.request(.GET,  url, headers: headers)
                        .validate(contentType: ["application/json"])
                        .responseJSON { response  in
                            //.responseObject { (response: Response<Product, NSError>) in
                            // Alamofire.request(.PUT, url,headers: headers).responseJSON { response in
//                            print(response.request)  // original URL request
//                            print(response.response?.statusCode) // URL response
//                            print(response.data)     // server data
//                            print(response.result)
                            if(response.result .isSuccess)
                            {
                                if let JSON = response.result.value
                                {
                                    //print(JSON)
                                    
                                    LoadingOverlay.shared.hideOverlayView()
                                    // JHProgressHUD.sharedHUD.hide()
                                    wishLstGlobalArray.removeAllObjects()
                                    // self.wishListArray.removeAllObjects()
                                    if let COD : AnyObject  = JSON["product"]
                                    {
                                        //print(COD)
                                        
                                        if let customer : Array<LstProducts> = Mapper<LstProducts>().mapArray(COD["lstProducts"])! {
                                            //  if let customer = COD["lstProducts"]{
                                            for prodt in customer
                                            {
                                                wishLstGlobalArray.addObject(prodt.sku!)
                                                //   self.wishListArray .addObject(prodt)
//                                                print("testing   \(prodt)")
//                                                print("testing2")
                                                
                                            }
                                        }
                                    }
                                    // self.delegates?.getWishListSuccess!(JSON as! NSDictionary)
                                    
                                    
                                    
                                }
                            }
                            if(response.result .isFailure)
                            {
                                LoadingOverlay.shared.hideOverlayView()
                                self.showAlertForRequestFail()
                            }
                            
                    }
                }catch let error as NSError {
                   // print("Could not fetch \(error), \(error.userInfo)")
                }
                
                
            }else{
                LoadingOverlay.shared.hideOverlayView()
            }
            
            // var url : NSURL!
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func getWishListDetailsOfUser()  {
        //{index: 1, lineItemId: 709, BasketId: 1, quantity: 1, userId: 7, sitecode: "IN", placedPrice: 18382}
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            let userId = defaults.objectForKey("userId") as? Int
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    let authorization = authorizationWithLogin
                    
                    //print(authorization)
                    
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
                
                let url = "\(baseUrl)WishList?userId=\(userId!)&WishDetails=t"
                //let url = "\(baseUrl)basket"
               // print(url)
                do{
                    Alamofire.request(.GET,  url, headers: headers)
                        .validate(contentType: ["application/json"])
                        .responseJSON { response  in
                            //.responseObject { (response: Response<Product, NSError>) in
                            // Alamofire.request(.PUT, url,headers: headers).responseJSON { response in
//                            print(response.request)  // original URL request
//                            print(response.response?.statusCode) // URL response
//                            print(response.data)     // server data
//                            print(response.result)
                            if(response.result .isSuccess)
                            {
                                if let JSON = response.result.value
                                {
                                   // print(JSON)
                                     if let a = self.delegates{
                                       // print(self.delegates! as! UIViewController)
                                        if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                           // self.delegates?.getWishListSuccess!(JSON as! NSDictionary)
                                            NSNotificationCenter.defaultCenter().postNotificationName("wishlistDetails", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
                                        }
                                    }
                                    
                                }
                            }
                            if(response.result .isFailure)
                            {
                                LoadingOverlay.shared.hideOverlayView()
                                self.showAlertForRequestFail()
                            }
                            
                    }
                }catch let error as NSError {
                   // print("Could not fetch \(error), \(error.userInfo)")
                }
                
                
            }else{
                LoadingOverlay.shared.hideOverlayView()
            }
            
            // var url : NSURL!
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func addToWishListDetails(wishList:NSString)  {
        //{index: 1, lineItemId: 709, BasketId: 1, quantity: 1, userId: 7, sitecode: "IN", placedPrice: 18382}
        //JHProgressHUD.sharedHUD.showInWindow(self)
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            let userId = defaults.objectForKey("userId") as? Int
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    let authorization = authorizationWithLogin
                    
                   // print(authorization)
                    
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
            }
            
            // var url : NSURL!
            let url = "\(baseUrl)WishList"
            
            let parameters: [String : AnyObject] = [
                
                "userId": userId!,
                "wishList": wishList
                
            ]
           // print(url)
            Alamofire.request(.POST,  url,parameters: parameters as! [String : AnyObject], encoding:.JSON, headers: headers)
                
                
                .responseJSON { response in
                    // Alamofire.request(.PUT, url,headers: headers).responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess)
                    {
                        if let JSON = response.result.value
                        {
                           // print(JSON)
                            do{
                                LoadingOverlay.shared.hideOverlayView()
                                if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                    self.delegates?.addWishListSuccess!(JSON as! NSDictionary)
                                }
                                
                            }catch let error as NSError {
                                //print("Could not fetch \(error), \(error.userInfo)")
                            }
                        }
                        
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                        self.showAlertForRequestFail()
                    }
                    
            }
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    
    func isCODAPIcall(pincode1:String,trimmedProductprice:String)  {
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            let headers = [
                "Authorization": authorizationWithoutLogin,
                "Accept": "application/json"
            ]
            
            var url : NSURL!
            url = NSURL(string:"\(baseUrl)address?pincode=\(pincode1)&total=\(trimmedProductprice)&stateCode=MH&expand=1")
           // print(url!)
            Alamofire.request(.GET, url!, headers: headers)
                
                .responseJSON { response in
                   // print(response.result)
                    if(response.result .isSuccess)
                    {
                        if let JSON = response.result.value
                        {
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                self.delegates?.isCODSuccess!(JSON as! NSDictionary)
                            }
                            
                        }
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                        self.showAlertForRequestFail()
                    }
                    
                    
            }
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
    }
    
    
    func callSetDefaultApi(userID:String,addressID:String)
    {
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            let userId = defaults.objectForKey("userId") as? Int
            let useremail = defaults.objectForKey("email") as? String
            if let data = defaults.objectForKey("LoginObject") as? NSData
            {
                //            let unarc = NSKeyedUnarchiver(forReadingWithData: data)
                // let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                
                
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                  //  print(blog)
                    let authorization = authorizationWithLogin
                    //                print(authorization)
                    //                print(blog.valueForKey("token")! as! String)
                    
                    let headers = [
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                    
                    var url : NSURL!
                    
                    url = NSURL(string:"\(baseUrl)address?isDefault=true&UserId=\(userID)&addressId=\(addressID)")
                    
                    Alamofire.request(.POST, url, headers: headers)
                        .validate(contentType: ["application/json"])
                        
                        .responseJSON { response in
//                            print(response.request)  // original URL request
//                            print(response.response?.statusCode) // URL response
//                            print(response.data)     // server data
//                            print(response.result)
                            if(response.result .isSuccess)
                            {
                                if let JSON = response.result.value
                                {
                                   // print(JSON)
                                    var dict = String()
                                    if (JSON.isEqual(1))
                                    {
                                        if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                            self.delegates?.SetDefaultApiResponse!("Success")
                                        }
                                    }
                                    
                                }
                            }
                            if(response.result .isFailure)
                            {
                                if let JSON = response.result.value
                                {
                                    var dict = String()
                                    if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                        self.delegates?.SetDefaultApiFailedDelegate!(dict as String)
                                    }
                                }
                                else if let statuscode = response.response?.statusCode
                                {
                                    //                                    print(statuscode)
                                    //                                    var dict = NSDictionary()
                                    //                                    dict = ["message" : "200"]
                                    // self.delegates?.registartionapiresponse!(dict as NSDictionary)
                                    
                                    
                                }
                                else
                                {
                                    //  self.delegates?.registartionapiFailedDelegate!()
                                }
                            }
                            
                    }}}
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
        
        
        
        
    }
    
    func callUpdateAdressApi(userID:String,stateID:String,address:String,area:String,city:String,name:String,title:String,zipcode:String,addressID:String,isDefault:Bool)
    {
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true)
        {
            var url : NSURL!
            url = NSURL(string:"\(baseUrl)address?CheckDelivey=true")
            
            let defaults = NSUserDefaults.standardUserDefaults()
            let userId = defaults.objectForKey("userId") as? Int
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                //            let unarc = NSKeyedUnarchiver(forReadingWithData: data)
                // let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                   // print(blog)
                    let authorization = authorizationWithLogin
                    authorization1 = authorization
                    //                print(authorization)
                    //                print(blog.valueForKey("token")! as! String)
                    
                    let headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                   // print(headers)
                }
                
            }
            
            var  request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            //request.setValue("\(authorization)", forHTTPHeaderField: "Authorization")
            request.setValue(authorization1, forHTTPHeaderField: "Authorization")
            //            "addressId": "133",
            //            "title": "Home1234",
            //            "name": "Amalraj123",
            //            "address1": "2020 Vrindavan Gardens",
            //            "area": "Near D Mart",
            //            "zipCode": "400078",
            //            "city": "Mumbai",
            //            "state": null,
            //            "userId": null,
            //            "countryId": "1",
            //            "stateId": "13",
            //            "addressFlag": 0,
            //            "countryName": null,
            //            "stateName": "MAHARASHTRA",
            //            "isDefault": false
            
//            print(addressID)
//            print(addressID)
            let parameters2  =  [[
                "addressId": addressID,
                "title": title,
                "name": name,
                "address1": address,
                "area": area,
                "zipCode": zipcode,
                "city": city,
                "userId": userID,
                "stateId": stateID,
                "showAddress":false,
                "isDefault": isDefault
                ]]
           // print(parameters2)
            //  request.httpBody = try! JSONSerialization.data(withJSONObject: parameters2)
            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(parameters2, options:[])
            Alamofire.request(request)
                .responseJSON { response in
                    // do whatever you want here
                    switch response.result {
                    case .Failure(let error):
                        //print(error)
                        
                        if let data = response.data, let responseString = String(data: data, encoding:NSUTF8StringEncoding) {
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                self.delegates?.UpdateAddressapiFailedDelegate!(responseString as String)
                            }
                        }
                    case .Success(let responseObject):
                        //print(responseObject)
                        if (responseObject.isEqual(1))
                        {
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                self.delegates?.UpdateAddressapiresponse!("Success")
                            }
                        }
                        else
                        {
                            let str  = responseObject as! NSArray
                            var appendMessage = String()
                            for message in str
                            {
                                
                                appendMessage += " \(message)"
                                //print(appendMessage)
                                
                            }
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                self.delegates?.UpdateAddressapiFailedDelegate!(appendMessage as! String)
                            }
                            
                        }
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                        self.showAlertForRequestFail()
                    }
                    
            }
        }
            
        else
        {
            // JHProgressHUD.sharedHUD.hide()
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    
    func placeOrderDetails(addressId:String,isCOD:String,promoCode:String,promotionalShippableValue:String)  {
        //{index: 1, lineItemId: 709, BasketId: 1, quantity: 1, userId: 7, sitecode: "IN", placedPrice: 18382}
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            let userId = defaults.objectForKey("userId") as? Int
            let useremail = defaults.objectForKey("email") as? String
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    let authorization = authorizationWithLogin
                    
                    //print(authorization)
                    
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
            }
           // print(headers)
            // var url : NSURL!
            let url = "\(baseUrl)PaymentReceived"
           // print(url)
            
            var cod:Bool!=false
            if(isCOD == "true"){
                cod = true
            }
         //  let parameters = "{addressId:63,email:paikrutika1094@gmail.com,isCOD:true,userId":100}"
            let parameters: [String : AnyObject] = [
                
                "userId": userId!,
                "email": useremail!,
                "isCOD": cod,
                "addressId": addressId,
                "Promocode":promoCode,
                "promotionalShippableValue":promotionalShippableValue
                
            ]
           // print(parameters)
            Alamofire.request(.POST,  url,parameters: parameters as [String : AnyObject], encoding:.JSON, headers: headers)
                
                
                .responseJSON { response in
                    // Alamofire.request(.PUT, url,headers: headers).responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess)
                    {
                        if let JSON = response.result.value
                        {
                           // print(JSON)
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                               // if(JSON.isKindOfClass(NSDictionary)){
                                self.delegates?.placeOrderSuccess!(JSON as! NSDictionary)
//                                }else{
//                                    LoadingOverlay.shared.hideOverlayView()
//                                    // self.JHProgressHUD.sharedHUD.hide()
//                                    self.delegates?.placeOrderFailure!()
//                                }
                            }
                        }
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                        // self.JHProgressHUD.sharedHUD.hide()
                         self.delegates?.placeOrderFailure!()
                        //self.showAlertForRequestFail()
                    }
                    
            }
            
        }else{
            // JHProgressHUD.sharedHUD.hide()
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func confirmOrdersDetails(orderId:String)  {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            let userId = defaults.objectForKey("userId") as? Int
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    let authorization = authorizationWithLogin
                    
                    //print(authorization)
                    
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                }
            }
            
            let url = "\(baseUrl)orderview?userId=\(userId!)&orderCofirm=true&orderId=\(orderId)"
           // print(url)
            Alamofire.request(.GET,  url, headers: headers)
                .validate(contentType: ["application/json"])
                .responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess)
                    {
                        if let JSON = response.result.value
                        {
                          //  print(JSON)
                            
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                //if(JSON .isKindOfClass(NSDictionary)){
                                if(JSON.isKindOfClass(NSDictionary)){
                                     self.delegates?.getorderConfirmedSuccess!(JSON as! NSDictionary)
                                }else{
                                    LoadingOverlay.shared.hideOverlayView()
                                    
                                    self.showAlertForRequestFail()
                                }
                                //}
                               
                            }
                        }
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                       
                        self.showAlertForRequestFail()
                    }
                    
            }
            
        }else{
           
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func getOthersreviewDetails(mpn:String,PageIndex:String,onSearchPage:Bool,onProductPage:Bool,onReviewPage:Bool,onAdminPage:Bool)  {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
           //var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            let userId = defaults.objectForKey("userId") as? Int
            let headers = [
                "Authorization": authorizationWithoutLogin,
                "Accept": "application/json"
            ]
            
            //rishikesh edit
            let escapepercent = mpn.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            let url = "\(baseUrl)RatingReview?userId=0&PageIndex=\(PageIndex)&mpn=\(escapepercent)&onSearchPage=\(onSearchPage)&onProductPage=\(onProductPage)&onReviewPage=\(onReviewPage)&onAdminPage=\(onAdminPage)"
           // print(url)
            Alamofire.request(.GET,  url, headers: headers)
                .validate(contentType: ["application/json"])
                .responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess)
                    {
                        if let JSON = response.result.value
                        {
                            //print(JSON)
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                               
                                if(JSON.isKindOfClass(NSDictionary)){
                                    NSNotificationCenter.defaultCenter().postNotificationName("othersReview", object: nil, userInfo: JSON as! [NSObject : AnyObject])
                                }else{
                                    LoadingOverlay.shared.hideOverlayView()
                                    NSNotificationCenter.defaultCenter().postNotificationName("othersReviewFail", object: nil, userInfo: nil)
                                    //self.showAlertForRequestFail()
                                }
                            }
                        }
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                        self.showAlertForRequestFail()
                    }
                    
            }
            
        }else{
           
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func getMyownreviewDetails(mpn:String,PageIndex:String,onSearchPage:Bool,onProductPage:Bool,onReviewPage:Bool,onAdminPage:Bool)  {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            //var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            let userId = defaults.objectForKey("userId") as? Int
            let headers = [
                "Authorization": authorizationWithoutLogin,
                "Accept": "application/json"
            ]
            //rishikesh edit
              let escapepercent = mpn.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            let url = "\(baseUrl)RatingReview?userId=\(userId!)&PageIndex=\(PageIndex)&mpn=\(escapepercent)&onSearchPage=\(onSearchPage)&onProductPage=\(onProductPage)&onReviewPage=\(onReviewPage)&onAdminPage=\(onAdminPage)"
           // print(url)
            Alamofire.request(.GET,  url, headers: headers)
                .validate(contentType: ["application/json"])
                .responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess)
                    {
                        if let JSON = response.result.value
                        {
                           // print(JSON)
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                //self.delegates?.getOthersreviewDetailsSuccess!(JSON as! NSDictionary)
                                NSNotificationCenter.defaultCenter().postNotificationName("myReview", object: nil, userInfo: JSON as! [NSObject : AnyObject])
                            }
                        }
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                        
                        self.showAlertForRequestFail()
                    }
                    
            }
            
        }else{
            //JHProgressHUD.sharedHUD.hide()
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func sendRatingDetails(MPN:String,Review:String,Rating:Float,firstName:String)  {
        //{index: 1, lineItemId: 709, BasketId: 1, quantity: 1, userId: 7, sitecode: "IN", placedPrice: 18382}
       

        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            let userId = defaults.objectForKey("userId") as? Int
            let useremail = defaults.objectForKey("firstName") as? String
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    let authorization = authorizationWithLogin
                    
                    //print(authorization)
                    
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
            }
//            let headers = [
//                "Authorization": "Mobilestg2456~~~~~13",
//                "Accept": "application/json"
//            ]
//            
            //print(headers)
            // var url : NSURL!
            let url = "\(baseUrl)RatingReview"
            //print(url)
            let parameters: [String : AnyObject]
            if(Review != ""){
                 parameters  = [
                    
                    "MPN": MPN,
                    "UserId": userId!,
                    "Review": Review,
                    "Rating": Rating,
                    "firstName": useremail!,
                    "isApproved": false,
                    "isRejected":false
                    
                    
                ]
            }else{
                parameters  = [
                    
                    "MPN": MPN,
                    "UserId": userId!,
                   
                    "Rating": Rating,
                    "firstName": useremail!,
                    "isApproved": false,
                    "isRejected":false
                    
                    
                ]
            }
            
           
            //print(parameters)
            Alamofire.request(.POST,  url,parameters: parameters as [String : AnyObject], encoding:.JSON, headers: headers)
                
                
                .responseJSON { response in
                    // Alamofire.request(.PUT, url,headers: headers).responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess)
                    {
                        if let JSON = response.result.value
                        {
                            //print(JSON)
                            if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                               // self.delegates?.placeOrderSuccess!(JSON as! NSDictionary)
                                NSNotificationCenter.defaultCenter().postNotificationName("addReview", object: nil, userInfo:nil)
                            }
                        }
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                        // self.JHProgressHUD.sharedHUD.hide()
                        self.showAlertForRequestFail()
                    }
                    
            }
            
        }else{
            // JHProgressHUD.sharedHUD.hide()
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func getMyOrderListDetails(currentPage:Int,orderNumber:String,orderStatus:String)  {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            //var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            let userId = defaults.objectForKey("userId") as? Int
             var headers : [String : String]!
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    let authorization = authorizationWithLogin
                    
                    //print(authorization)
                    
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
            }

            
            let url = "\(baseUrl)OrderSearch?userId=\(userId!)&currentPage=\(currentPage)&orderNumber=\(orderNumber)&orderStatus=\(orderStatus)"
           
           // print(url)
          
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            configuration.timeoutIntervalForResource = 10800 // seconds
            configuration.timeoutIntervalForRequest = 10800 // seconds
            
            Alamofire.Manager(configuration: configuration)
            Alamofire.request(.GET,  url, headers: headers)
                .validate(contentType: ["application/json"])
                .responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess)
                    {
                        if let JSON = response.result.value
                        {
                           // print(JSON)
                           
                                NSNotificationCenter.defaultCenter().postNotificationName("myOrders", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
                          
                        }
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                         NSNotificationCenter.defaultCenter().postNotificationName("myOrdersFail", object: nil, userInfo: nil )
                       // self.showAlertForRequestFail()
                    }
                    
            }
            
        }else{
            //JHProgressHUD.sharedHUD.hide()
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func getMyOrderListDetailsForOpen(currentPage:Int,orderNumber:String,orderStatus:String)  {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            //var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            let userId = defaults.objectForKey("userId") as? Int
            var headers : [String : String]!
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    let authorization = authorizationWithLogin
                    
                   // print(authorization)
                    
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
            }
            
            //http://immarketapi-stg2.azurewebsites.net/api/OrderSearch?userId=164&orderStatus=&orderNumber=&currentPage=1
            let url = "\(baseUrl)OrderSearch?userId=\(userId!)&currentPage=\(currentPage)&orderNumber=\(orderNumber)&orderStatus=\(orderStatus)"
            //print(url)
            var alamoFireManager : Alamofire.Manager!
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            configuration.timeoutIntervalForResource = 10800 // seconds
            configuration.timeoutIntervalForRequest = 10800 // seconds
            
            alamoFireManager = Alamofire.Manager(configuration: configuration)
            Alamofire.request(.GET,  url, headers: headers)
                .validate(contentType: ["application/json"])
                .responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess)
                    {
                        if let JSON = response.result.value
                        {
                            //print(JSON)
                            // if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                            //self.delegates?.getOthersreviewDetailsSuccess!(JSON as! NSDictionary)
                            NSNotificationCenter.defaultCenter().postNotificationName("myOrdersOpen", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
                            //  }
                        }
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                       NSNotificationCenter.defaultCenter().postNotificationName("myOrdersFail", object: nil, userInfo: nil )
                      //  self.showAlertForRequestFail()
                    }
                    
            }
            
        }else{
            //JHProgressHUD.sharedHUD.hide()
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func getOrderDEtails(orderId:String,orderCofirm:Bool)  {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            //var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            let userId = defaults.objectForKey("userId") as? Int
            var headers : [String : String]!
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    let authorization = authorizationWithLogin
                    
                   // print(authorization)
                    
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
            }
            //print(headers)
            //http://immarketapi-stg2.azurewebsites.net/api/OrderSearch?userId=164&orderStatus=&orderNumber=&currentPage=1
            let url = "\(baseUrl)orderview?userId=\(userId!)&orderId=\(orderId)&orderCofirm=\(orderCofirm)"
            //print(url)
            Alamofire.request(.GET,  url, headers: headers)
                .validate(contentType: ["application/json"])
                .responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response)
//                    print(response.data)     // server data
//                    print(response.result)
                    
                    
                    if(response.result .isSuccess)
                    {
                        if let JSON = response.result.value
                        {
                           // print(JSON)
                            // if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                            //self.delegates?.getOthersreviewDetailsSuccess!(JSON as! NSDictionary)
                            NSNotificationCenter.defaultCenter().postNotificationName("OrderDet", object: nil, userInfo: JSON as! [NSObject:AnyObject])
                            //  }
                        }
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                        
                        self.showAlertForRequestFail()
                    }
                    
            }
            
        }else{
            //JHProgressHUD.sharedHUD.hide()
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func viewReturnOrderDEtails(OrderId:String,OrderCofirm:Bool)  {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            //var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            let UserId = defaults.objectForKey("userId") as? Int
            var headers : [String : String]!
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    let authorization = authorizationWithLogin
                    
                    //print(authorization)
                    
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
            }
            
            //http://immarketapi-stg2.azurewebsites.net/api/OrderSearch?userId=164&orderStatus=&orderNumber=&currentPage=1
            let url = "\(baseUrl)returnorder?UserId=\(UserId!)&OrderId=\(OrderId)&OrderCofirm=\(OrderCofirm)"
            //print(url)
            Alamofire.request(.GET,  url, headers: headers)
                .validate(contentType: ["application/json"])
                .responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response)
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess)
                    {
                        if let JSON = response.result.value
                        {
                            //print(JSON)
                            // if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                            //self.delegates?.getOthersreviewDetailsSuccess!(JSON as! NSDictionary)
                        NSNotificationCenter.defaultCenter().postNotificationName("viewReturn", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
                            //  }
                        }
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                        
                        self.showAlertForRequestFail()
                    }
                    
            }
            
        }else{
            //JHProgressHUD.sharedHUD.hide()
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func cancelOrderDEtails(orderNumber:String,itemId:String,SellerNumber:String,index:Int,freeItemIndicator:String)  {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            //var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            let UserId = defaults.objectForKey("userId") as? Int
            var headers : [String : String]!
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    let authorization = authorizationWithLogin
                    
                   // print(authorization)
                    
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
            }
            
            //http://immarketapi-stg2.azurewebsites.net/api/OrderSearch?userId=164&orderStatus=&orderNumber=&currentPage=1
            let url = "\(baseUrl)orderview?userId=\(UserId!)&orderNumber=\(orderNumber)&itemId=\(itemId)&SellerNumber=\(SellerNumber)&freeItemIndicator=\(freeItemIndicator)"
           // print(url)
            Alamofire.request(.GET,  url, headers: headers)
                .validate(contentType: ["application/json"])
                .responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response)
//                    print(response.data)     // server data
//                    print(response.result)
                    
                    
                    if(response.response?.statusCode == 200){
                        NSNotificationCenter.defaultCenter().postNotificationName("cancelOrderDet", object: nil, userInfo: [:] )
                    }else{
                        LoadingOverlay.shared.hideOverlayView()
                        self.showAlertForRequestFail()
                    }
                    
//                    if(response.result .isSuccess)
//                    {
//                        if let JSON = response.result.value
//                        {
//                            print(JSON)
//                            // if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
//                            //self.delegates?.getOthersreviewDetailsSuccess!(JSON as! NSDictionary)
//                           // NSNotificationCenter.defaultCenter().postNotificationName("viewReturn", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
//                            //  }
//                        }
//                    }
//                    if(response.result .isFailure)
//                    {
//                        LoadingOverlay.shared.hideOverlayView()
//                        
//                        self.showAlertForRequestFail()
//                    }
                    
            }
            
        }else{
            //JHProgressHUD.sharedHUD.hide()
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    
    func sendInvoiceOrderDEtails(invoiceNumber:String,SellerNumber:String,index:String)  {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            //var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            let UserId = defaults.objectForKey("email") as? String
            //email
            var headers : [String : String]!
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    let authorization = authorizationWithLogin
                    
                   // print(authorization)
                    
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
            }
            
            //http://immarketapi-stg2.azurewebsites.net/api/OrderSearch?userId=164&orderStatus=&orderNumber=&currentPage=1
            let url = "\(baseUrl)orderview?email=\(UserId!)&invoiceNumber=\(invoiceNumber)&SellerNumber=\(SellerNumber)&index=\(index)"
           // print(url)
            Alamofire.request(.GET,  url, headers: headers)
                .validate(contentType: ["application/json"])
                .responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response)
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess)
                    {
                        if let JSON = response.result.value
                        {
                            LoadingOverlay.shared.hideOverlayView()
                            //print(JSON)
                            if(JSON as! Bool == true){
                                let alertView:UIAlertView = UIAlertView()
                                alertView.title = ""
                                alertView.message = ConstantsFile.invoice_msg
                                alertView.delegate = nil
                                alertView.addButtonWithTitle("OK")
                                alertView.show()
                            }
                            // if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                            //self.delegates?.getOthersreviewDetailsSuccess!(JSON as! NSDictionary)
                           // NSNotificationCenter.defaultCenter().postNotificationName("viewReturn", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
                            //  }
                        }
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                        
                        self.showAlertForRequestFail()
                    }
                    
            }
            
        }else{
            //JHProgressHUD.sharedHUD.hide()
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func returnProductRequestOrderDEtails(invoice:String,orderId:String,sku:String)  {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            //var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            let UserId = defaults.objectForKey("userId") as? String
            //email
            var headers : [String : String]!
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    let authorization = authorizationWithLogin
                    
                    //print(authorization)
                    
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
            }
            
            //http://immarketapi-stg2.azurewebsites.net/api/OrderSearch?userId=164&orderStatus=&orderNumber=&currentPage=1
            let url = "\(baseUrl)returns?invoice=\(invoice)&orderId=\(orderId)&sku=\(sku)"
          //  print(url)
            Alamofire.request(.GET,  url, headers: headers)
                .validate(contentType: ["application/json"])
                .responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response)
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess)
                    {
                        if let JSON = response.result.value
                        {
                            //print(JSON)
                            
                            // if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                            //self.delegates?.getOthersreviewDetailsSuccess!(JSON as! NSDictionary)
                            // NSNotificationCenter.defaultCenter().postNotificationName("viewReturn", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
                            //  }
                        }
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                        
                        self.showAlertForRequestFail()
                    }
                    
            }
            
        }else{
            //JHProgressHUD.sharedHUD.hide()
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func createreturnProductRequestOrderDEtails()  {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            //var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            let UserId = defaults.objectForKey("userId") as? String
            //email
            var headers : [String : String]!
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    let authorization = authorizationWithLogin
                    
                   // print(authorization)
                    
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
            }
            
            //http://immarketapi-stg2.azurewebsites.net/api/OrderSearch?userId=164&orderStatus=&orderNumber=&currentPage=1
            let url = "\(baseUrl)returnorder"
           // print(url)
            Alamofire.request(.GET,  url, headers: headers)
                .validate(contentType: ["application/json"])
                .responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response)
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess)
                    {
                        if let JSON = response.result.value
                        {
                           // print(JSON)
                            
                            // if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                            //self.delegates?.getOthersreviewDetailsSuccess!(JSON as! NSDictionary)
                            // NSNotificationCenter.defaultCenter().postNotificationName("viewReturn", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
                            //  }
                        }
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                        
                        self.showAlertForRequestFail()
                    }
                    
            }
            
        }else{
            //JHProgressHUD.sharedHUD.hide()
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func submitOrderReturn(orderDict:NSMutableDictionary)  {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            let defaults = NSUserDefaults.standardUserDefaults()
            let UserId = defaults.objectForKey("userId") as? String
            //email
            var headers : [String : String]!
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    let authorization = authorizationWithLogin
                    authorization1 = authorization
                    //print(authorization)
                    
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
            }
           // var url : NSURL!
            
          let  url = NSURL(string:"\(baseUrl)returnorder")
            let parameters = [
                "order": orderDict
               
            ]
            var  request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            //request.setValue("\(authorization)", forHTTPHeaderField: "Authorization")
            request.setValue(authorization1, forHTTPHeaderField: "Authorization")
            // let jsonData = try! NSJSONSerialization.dataWithJSONObject(orderDict, options: NSJSONWritingOptions.PrettyPrinted)
          //  print(jsonData)
            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(orderDict, options:[])
           // print(request.HTTPBody)
            Alamofire.request(request)
            
           // print(parameters)
           // Alamofire.request(.POST,  url!, parameters: parameters as [String:AnyObject], encoding:.JSON, headers: headers)
                .responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response
//                    print(response.data)     // server data
//                    print(response.result)
                    if(response.result .isSuccess)
                    {
                        if let JSON = response.result.value
                        {
                             LoadingOverlay.shared.hideOverlayView()
                            //print(JSON)
                           /// if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                
                                
                               // self.delegates?.registartionapiresponse!(JSON as! NSDictionary)
                               NSNotificationCenter.defaultCenter().postNotificationName("submitReturn", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
                           // }
                        }
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                        
                        self.showAlertForRequestFail()
                    }
                    
            }
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func sendPaymentUpdateToserver(encryptMsg:String,trnxID:String)  {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            let defaults = NSUserDefaults.standardUserDefaults()
            let UserId = defaults.objectForKey("userId") as? String
            //email
            var headers : [String : String]!
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    let authorization = authorizationWithLogin
                    authorization1 = authorization
                   // print(authorization)
                    
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
            }
            
           // print(headers)
         //   var urlstr : NSURL!
           // let encp = encryptMsg.stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet.URLUserAllowedCharacterSet())
            let urlstr =   NSURL(string:"\(baseUrl)PaymentReceived?msg=\(encryptMsg)&tpsl_mrct_cd=\(trnxID)")
//            if let encodedString = original.stringByAddingPercentEncodingWithAllowedCharacters(
//                NSCharacterSet.URLHostAllowedCharacterSet()),
//                urlstr = NSURL(string: encodedString)
//            {
          //  print(urlstr)
                Alamofire.request(.GET,  urlstr!, headers: headers)
                    .validate(contentType: ["application/json"])
                    .responseJSON { response in
//                        print(response.request)  // original URL request
//                        print(response.response?.statusCode) // URL response)
//                        print(response.data)     // server data
//                        print(response.result)
                        if(response.result .isSuccess)
                        {
                            if let JSON = response.result.value
                            {
                                //print(JSON)
                                LoadingOverlay.shared.hideOverlayView()
                                //orderSuccess
                                if(JSON.isKindOfClass(NSDictionary)){
                                   NSNotificationCenter.defaultCenter().postNotificationName("orderSuccess", object: nil, userInfo: JSON as! [NSObject : AnyObject] )
                                }else{
                                    LoadingOverlay.shared.hideOverlayView()
                                    self.delegates?.placeOrderFailure!()
                                }
                                
                            }
                        }
                        if(response.result .isFailure)
                        {
                            LoadingOverlay.shared.hideOverlayView()
                            self.delegates?.placeOrderFailure!()
                            //self.showAlertForRequestFail()
                        }
                        
               // }
            }
            
           //let url = NSURL(string:"\(baseUrl)PaymentReceived?msg=\(encryptMsg)&tpsl_mrct_cd=\(trnxID)")
            
            //print(urlstr)
           
            
        }else{
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }
    func UpdateApiFprProfile(firstName:String,lastName:String,email:String,cont:String)
    {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            
            
            let defaults = NSUserDefaults.standardUserDefaults()
            if let data = defaults.objectForKey("LoginObject") as? NSData
            {
                //            let unarc = NSKeyedUnarchiver(forReadingWithData: data)
                // let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                   // print(blog)
                    let authorization = authorizationWithLogin
                    //                print(authorization)
                    //                print(blog.valueForKey("token")! as! String)
                    
                    let headers = [
                        "Authorization" : authorization,
                        "Content-Type ": "application/json"
                    ]
                    
                    let defaults = NSUserDefaults.standardUserDefaults()
                    let UserId = defaults.objectForKey("userId") as? Int
                    
                
                    //  \"unnecessary\"
                    let parameters:[String: AnyObject] = [
                        "contactNumber": cont,
                        "email": email,
                        "firstName": firstName,
                        "userId": UserId! ,
                        "lastName": lastName
                    ]
                    
                   // print(parameters)
                    
                    let url = "\(baseUrl)Profile"
                    Alamofire.request(.PUT,  url, parameters: parameters as! [String: AnyObject], encoding:.JSON, headers: headers)
                        .validate(contentType: ["application/json"])
                        
                        .responseJSON { response in
//                            print(response.request)  // original URL request
//                            print(response.response) // URL response
//                            print(response.data)
                            var strData = NSString(data: response.data!, encoding: NSUTF8StringEncoding)
//                            print("Body: \(strData!)")// server data
//                            print(response.result)
                            
                            
                            if (response.result .isSuccess)
                            {
                                
                                if let JSON = response.result.value
                                {
                                    LoadingOverlay.shared.hideOverlayView()
                                NSNotificationCenter.defaultCenter().postNotificationName("profileupdate", object: nil, userInfo: nil )
                                }
                                
                            }//alamofire success req complete
                                
                            else if  (response.result .isFailure)
                            {
                                
                                if let JSON = response.result.value
                                {
                                    if let Message  : AnyObject  = JSON
                                    {
                                        if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                                            let messge = Message as! String
                                             LoadingOverlay.shared.hideOverlayView()
                                            self.showAlertForRequestFail()
                                           // self.delegates?.updatecontactOTPFailure!(messge)
                                        }
                                    }
                                    // self.showAlert(JSON as! String)
                                    
                                }
                                    
                                else
                                {
                                    //self.showAlert("Request timed Out")
                                }
                            }//alamofire failure req complete
                            
                    }//alamofire req complete
                    
                    
                }//login object req compelte
                
            }//login object req compelte
        }else{
             LoadingOverlay.shared.hideOverlayView()
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
    }//up
    
    func accregister(token:String,oredrID:String)  {
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appdelegate.isReachable == true) {
            //var headers : [String : String]!
            let defaults = NSUserDefaults.standardUserDefaults()
            let userId = defaults.objectForKey("userId") as? Int
            var headers : [String : String]!
            if let data = defaults.objectForKey("LoginObject") as? NSData
                
            {
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    let authorization = authorizationWithLogin
                    
                    //print(authorization)
                    
                    headers = [
                        
                        "Authorization" : authorization,
                        
                        "Content-Type ": "application/json"
                        
                    ]
                    
                }
                
            }
           // print(headers)
            //http://immarketapi-stg2.azurewebsites.net/api/OrderSearch?userId=164&orderStatus=&orderNumber=&currentPage=1
            let url = "\(baseUrl)returnorder?orderId=\(oredrID)&bnkRefundTokenID=\(token)"
            //let url = "\(baseUrl)orderview?userId=\(userId!)&orderId=\(orderId)&orderCofirm=\(orderCofirm)"
           // print(url)
            let parameters: [String : AnyObject] = [
                
                
                "merchantId": "T6921",
                "pgMerchantRegID": "T6921",
                "pgMerchantTxnID": "T6921",
                "aspMasterID": "1",
                "consumerAliasId": "572",
                "consumerRegId": "292",
                "consumerId": "292"
//                "userId": userId!,
//                "email": useremail!,
//                "isCOD": cod,
//                "addressId": addressId,
//                "Promocode":promoCode
//                
                
            ]
          //  print(parameters)
            Alamofire.request(.POST,  url, headers: headers)
                .validate(contentType: ["application/json"])
                .responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response?.statusCode) // URL response)
//                    print(response.data)     // server data
//                    print(response.result)
                    
                    
                    if(response.result .isSuccess)
                    {
                         LoadingOverlay.shared.hideOverlayView()
                        if let JSON = response.result.value
                        {
                            
                            if (JSON as! NSObject == 1)
                            {
                             NSNotificationCenter.defaultCenter().postNotificationName("Accountregconfirm", object: nil, userInfo: nil )
                            }
                            else
                            {
                              NSNotificationCenter.defaultCenter().postNotificationName("ConfirmationFailed", object: nil, userInfo: nil )
                            }
                            //print(JSON)
                            
                            // if(self.delegates! as! UIViewController == UIApplication.topViewController()!){
                            //self.delegates?.getOthersreviewDetailsSuccess!(JSON as! NSDictionary)
                           // NSNotificationCenter.defaultCenter().postNotificationName("OrderDet", object: nil, userInfo: JSON as! [NSObject:AnyObject])
                            //  }
                        }
                    }
                    if(response.result .isFailure)
                    {
                        LoadingOverlay.shared.hideOverlayView()
                        
                        self.showAlertForRequestFail()
                    }
                    
            }
            
        }else{
            //JHProgressHUD.sharedHUD.hide()
            LoadingOverlay.shared.hideOverlayView()
            showAlert()
        }
        
        
    }

    func showAlert(){
        let alertView:UIAlertView = UIAlertView()
        alertView.title = ""
        alertView.message = ConstantsFile.noInternet_msg
        alertView.delegate = nil
        alertView.addButtonWithTitle("OK")
        alertView.show()
    }
    func showAlertForRequestFail(){
        let alertView:UIAlertView = UIAlertView()
        alertView.title = ""
        alertView.message = ConstantsFile.requestFail_msg
        alertView.delegate = nil
        alertView.addButtonWithTitle("OK")
        
        alertView.show()
       
            }
}

//
//  AppDelegate.swift
//  MarketPlace
//
//  Created by inpanr07 on 13/07/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import CoreData
import ReachabilitySwift
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,TAGContainerOpenerNotifier {

    var window: UIWindow?
    var isReachable:Bool!
    var reachability: Reachability?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
   
        Fabric.with([Crashlytics.self])
        
        let GTM = TAGManager.instance()
        GTM.logger.setLogLevel(kTAGLoggerLogLevelVerbose)
        
        TAGContainerOpener.openContainerWithId("GTM-N5K2JS",  // change the container ID "GTM-PT3L9Z" to yours
            tagManager: GTM, openType: kTAGOpenTypePreferFresh,
            timeout: nil,
            notifier: self)
        UINavigationBar.appearance().tintColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
        UINavigationBar.appearance().translucent = false
       
        
        print("testing")
      

        do {
            reachability = try Reachability.reachabilityForInternetConnection()
            reachability?.whenReachable = { reachability in
                dispatch_async(dispatch_get_main_queue()) {
                    self.isReachable = true
                    self.updateLabelColourWhenReachable(reachability)
                }
            }
        } catch {
            isReachable = false
            print("Unable to create Reachability")
            //return
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.reachabilityChanged(_:)),name: ReachabilityChangedNotification,object: reachability)
        do{
            try reachability?.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
       
        
        
        return true
    }
    func containerAvailable(container: TAGContainer!) {
        container.refresh()
    }

    func setupReachability(hostName hostName: String?, useClosures: Bool) {
       // hostNameLabel.text = hostName != nil ? hostName : "No host name"
        
       // print("--- set up with host name: \(hostNameLabel.text!)")
        
        do {
            let reachability = try hostName == nil ? Reachability.reachabilityForInternetConnection() : Reachability(hostname: hostName!)
            self.reachability = reachability
            //isReachable = true
        } catch ReachabilityError.FailedToCreateWithAddress(let address) {
            isReachable = false
           // networkStatus.textColor = UIColor.redColor()
           // networkStatus.text = "Unable to create\nReachability with address:\n\(address)"
            return
        } catch {}
        
        if (useClosures) {
            reachability?.whenReachable = { reachability in
                dispatch_async(dispatch_get_main_queue()) {
                    self.isReachable = true
                    self.updateLabelColourWhenReachable(reachability)
                }
            }
            reachability?.whenUnreachable = { reachability in
                dispatch_async(dispatch_get_main_queue()) {
                    self.isReachable = false
                    self.updateLabelColourWhenNotReachable(reachability)
                }
            }
        } else {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.reachabilityChanged(_:)), name: ReachabilityChangedNotification, object: reachability)
        }
    }
    
    func startNotifier() {
        print("--- start notifier")
        do {
            try reachability?.startNotifier()
        } catch {
            isReachable = false
           // networkStatus.textColor = UIColor.redColor()
         //   networkStatus.text = "Unable to start\nnotifier"
            return
        }
    }
    
    func stopNotifier() {
        print("--- stop notifier")
        reachability?.stopNotifier()
        NSNotificationCenter.defaultCenter().removeObserver(self, name: ReachabilityChangedNotification, object: nil)
        reachability = nil
    }
    
    func updateLabelColourWhenReachable(reachability: Reachability) {
        print("\(reachability.description) - \(reachability.currentReachabilityString)")
        if reachability.isReachableViaWiFi() {
             isReachable = true
         //   self.networkStatus.textColor = UIColor.greenColor()
        } else {
             isReachable = true
           // self.networkStatus.textColor = UIColor.blueColor()
        }
        
       // self.networkStatus.text = reachability.currentReachabilityString
    }
    
    func updateLabelColourWhenNotReachable(reachability: Reachability) {
        print("\(reachability.description) - \(reachability.currentReachabilityString)")
         isReachable = false
       // self.networkStatus.textColor = UIColor.redColor()
        
        //self.networkStatus.text = reachability.currentReachabilityString
    }
    
    
    func reachabilityChanged(note: NSNotification) {
        let reachability = note.object as! Reachability
        
        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
                print("Reachable via WiFi")
                
                isReachable = true
                NSNotificationCenter.defaultCenter().postNotificationName("reachable", object: nil, userInfo: nil )
            } else {
                
                isReachable = true
                 NSNotificationCenter.defaultCenter().postNotificationName("reachable", object: nil, userInfo: nil )
                print("Reachable via Cellular")
            }
        } else {
            isReachable = false
            print("Network not reachable")
        }
       // let reachability = note.object as! Reachability
        
        if reachability.isReachable() {
            updateLabelColourWhenReachable(reachability)
        } else {
            updateLabelColourWhenNotReachable(reachability)
        }
    }
    
    deinit {
        stopNotifier()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        
        
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.razeware.HitList" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("MarketPlace", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("MarketPlaceCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        
        let mOptions = [NSMigratePersistentStoresAutomaticallyOption: true,
                        NSInferMappingModelAutomaticallyOption: true]
       
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: mOptions)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as! NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}
extension UIApplication {
    class func topViewController(base: UIViewController? = (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        print("top vc \(base)")
        return base
    }
}





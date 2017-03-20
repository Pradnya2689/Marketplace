//
//  SearchAddressController.swift
//  MarketPlace
//
//  Created by inpanr07 on 30/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class SearchAddressController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
     var citiesToPass : NSMutableArray = NSMutableArray()
    var countryToPass : NSMutableArray = NSMutableArray()
    var flagset : NSString!
    var tableArr : NSMutableArray = NSMutableArray()
    @IBOutlet var searchText : UISearchBar!
    @IBOutlet var adressTable: UITableView!
    var filterArray:NSMutableArray! = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
       // print(citiesToPass)
        print(countryToPass)
        
        var window :UIWindow = UIApplication.sharedApplication().keyWindow!
        LoadingOverlay.shared.showOverlay(window)
         self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        
        self.adressTable.delegate = self
        self.adressTable.dataSource = self
        filterArray.removeAllObjects()
        if (flagset .isEqualToString("cities"))
            
        {
            self.title = "Cities"
            searchText.placeholder = "Search for City"
            self.tableArr.removeAllObjects()
        for address in citiesToPass
        {
        print(address["cityName"])
            if let add = address["cityName"]
            {
           self.tableArr.addObject(add!)
            }
           
          //  self.tableArr.addObject(address["cityName"])
        }
        }
        else if(flagset .isEqualToString("country"))
        {
            self.title = "IMOL"
            searchText.placeholder = "Search for State"
            self.tableArr.removeAllObjects()
            for address in countryToPass
            {
                print(address["stateName"])
                if let add = address["stateName"]
                {
                    self.tableArr.addObject(add!)
                }
                
                //  self.tableArr.addObject(address["cityName"])
            }
        
        }
        filterArray = self.tableArr.mutableCopy() as! NSMutableArray
        print(self.tableArr)
        
//        var bottomoffset: CGPoint = CGPointMake(0, 6000)
//        //if bottomoffset.y > 0 {
//            self.adressTable.contentOffset = bottomoffset;
       // }

        self.adressTable.reloadData()
//        let offset = CGPoint(x: 0, y: 2000);
//        
//        self.adressTable.contentOffset = offset;
       self.adressTable.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 380, right: 0)
        LoadingOverlay.shared.hideOverlayView()
        // Do any additional setup after loading the view.
        
    }
    override func viewWillDisappear(animated: Bool) {
        self.citiesToPass.removeAllObjects()
        self.countryToPass.removeAllObjects()
        self.tableArr.removeAllObjects()
        self.filterArray.removeAllObjects()
    }
    override func viewDidDisappear(animated: Bool) {
        
    }
    
    override func viewWillAppear(animated: Bool) {
        searchText.becomeFirstResponder()
//        let offset = CGPoint(x: 0, y: 2000);
//       self.adressTable.contentOffset = offset;
       

    }
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (range.length + range.location > searchBar.text!.characters.count) {
            return false;
        }
        let newLength = searchBar.text!.characters.count + text.characters.count - range.length;
        return newLength <= 100
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        NSNotificationCenter.defaultCenter().postNotificationName("CancelClicked", object: nil, userInfo: nil)

        //NSNotificationCenter.defaultCenter().postNotificationName("cancel", object: nil, userInfo:nil)
        self.dismissViewControllerAnimated(true, completion: nil)
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.characters.count > 0)
        {
         let searchpredicate = NSPredicate(format: "SELF contains[cd] %@", searchText)
            let searchpredicate1 = NSPredicate(format: "stateName contains[cd] %@", searchText)
        //filterArray = NSArray()
             filterArray = self.tableArr.mutableCopy() as! NSMutableArray
            
            
//            countryToPass.removeAllObjects()
//            countryToPass = filterArray
            
         filterArray.filterUsingPredicate(searchpredicate)
        // countryToPass.filterUsingPredicate(searchpredicate)
            
            var descriptor: NSSortDescriptor = NSSortDescriptor(key:"stateName", ascending: true)
            var sortedResults: NSArray = countryToPass.sortedArrayUsingDescriptors([descriptor])
            sortedResults.filteredArrayUsingPredicate(searchpredicate1)
            print(sortedResults)
       //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ contains %@", @"stateName", searchText];
         //NSArray *predict = [mainArrayAll filteredArrayUsingPredicate:predicate];
            
          //  print(countryToPass)
        self.adressTable.reloadData()
        }
        else
        {
            filterArray.removeAllObjects()
            filterArray = self.tableArr.mutableCopy() as! NSMutableArray
            self.adressTable.reloadData()
        }
        //return true
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableCell")! as UITableViewCell
     //   print(filteredData[indexPath.row])
       
        cell.textLabel?.text = self.filterArray.objectAtIndex(indexPath.row) as! String
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterArray.count
    }
    
    var valueToPass:String!
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath)!.tag
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
//        searchBar.text = currentCell.textLabel?.text
        if(flagset == "cities")
        {
        NSNotificationCenter.defaultCenter().postNotificationName("refresh1", object: nil, userInfo: ["valueToPass":self.filterArray.objectAtIndex((indexPath?.row)!)])
        }
        else if (flagset == "country")
        {
            for character in self.countryToPass
            {
                if let statenamecp = character["stateName"] as? String
                {
                    if let st = currentCell.textLabel?.text
                    {
                    if (st == statenamecp )
                    {
                      //  var window :UIWindow = UIApplication.sharedApplication().keyWindow!
                        LoadingOverlay.shared.hideOverlayView()
                     NSNotificationCenter.defaultCenter().postNotificationName("country", object: nil, userInfo: ["valueToPass": character])
                        
                        }
                      
                    }

                }
            }
      //  NSNotificationCenter.defaultCenter().postNotificationName("country", object: nil, userInfo: ["valueToPass":self.countryToPass.objectAtIndex((indexPath?.row)!)])
        }
//
       self.dismissViewControllerAnimated(true, completion: nil)
        
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

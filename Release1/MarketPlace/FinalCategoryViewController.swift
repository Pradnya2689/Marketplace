//
//  FinalCategoryViewController.swift
//  MarketPlace
//
//  Created by inpanr07 on 24/06/16.
//  Copyright (c) 2016 inpanr07. All rights reserved.
//

import UIKit

class FinalCategoryViewController: UITableViewController {
    
    
    //mapper class array
    var FinalCatMarr : NSMutableArray = NSMutableArray()
         var objectToPass : category3List!
    //
  var newArray : NSMutableArray = NSMutableArray()
    var newArray2 : NSMutableArray = NSMutableArray()
    
    var categoryArr : NSMutableArray!
    
    var subcategoryArr : NSMutableArray!
    
    var level3Arr : NSMutableArray!
    
     var passedValue: String!
    
     var FinalcatOject : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        //self.navigationController?.navigationItem.title = ""
         self.title=""
        
         self.tableView.tableFooterView = UIView()
        
        for item in FinalcatOject!
        {
            let subcattest1  = item  as! category3List
            print(subcattest1.category3Name)
            self.FinalCatMarr.addObject(subcattest1)
            
        }
        
        
        
        for item in level3Arr!
        {
            
            if let dict  = item as? NSMutableDictionary
            {
                if dict[passedValue] != nil
                {
                    
                    self.newArray .addObject(dict[passedValue]!)
                    self.newArray2 .addObject(dict["category3Id"]!)
                }
                
            }
            
        }
        print(self.newArray, terminator: "")
        
         print(self.categoryArr, terminator: "")
         print(self.subcategoryArr, terminator: "")
         print(self.level3Arr, terminator: "")
        
        self.tableView .reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    @IBAction func searchSubView(sender: AnyObject)
    {
        
        self.navigationController?.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBarHidden = true
        performSegueWithIdentifier("Search", sender: self)
        
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

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.FinalCatMarr.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FinalIdentifier", forIndexPath: indexPath) as UITableViewCell
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        cell.selectionStyle = .None
      /*  let stringvalue1: String = newArray2 .objectAtIndex(indexPath.row) as! String
        print(stringvalue1, terminator: "")
        let a:Int? = Int(stringvalue1)
        
        if let tempStockCode = a {
            cell.tag = tempStockCode
            
        }*/


        let extarctValue :category3List  = self.FinalCatMarr[indexPath.row] as! category3List
        print(extarctValue.category3Name)
        var stringvalue1: String = extarctValue.category3Name!

         cell.textLabel?.font = UIFont(name: "MyriadPro-Regular", size: 20)
//        cell.textLabel?.text = self.newArray .objectAtIndex(indexPath.row) as? String
        cell.textLabel?.text = "\(stringvalue1)"
        // Configure the cell...

        return cell
    }
   
    
    var valueToPass:String!
       var catDic : NSMutableDictionary = NSMutableDictionary()
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let indexPath = tableView.indexPathForSelectedRow
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
        
        let cll = currentCell.tag
       
        valueToPass = currentCell.textLabel?.text
        
        self.objectToPass = self.FinalCatMarr.objectAtIndex((indexPath?.row)!) as! category3List
        let somevalue :category3List  = self.objectToPass
       
        catDic["categoryname"] = somevalue.category3Name!
        catDic["categoryID"] = somevalue.category3Id!

        
        glblArr.addObject(catDic)
        
        
        print(glblArr, terminator: "")
        
        print(valueToPass)
        performSegueWithIdentifier("SearchResult", sender: self)
        

    }
    override  func viewWillDisappear(animated: Bool)
    {
        
     //  self.title = ""
        
    }
       
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
         if (segue.identifier == "SearchResult")
         {
        let backButton = UIBarButtonItem(title:"", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 15)!], forState: UIControlState.Normal)
        navigationItem.backBarButtonItem = backButton
            
            let viewController = (segue.destinationViewController as! CollectionViewController)
            viewController.globcategoryArray = FinalCatMarr.mutableCopy() as! NSMutableArray
            viewController.keyWords = valueToPass
            viewController.comingfrom = "FinalCategory"
            
       }
         else if(segue.identifier == "Search")
         {
            let viewController = (segue.destinationViewController as! CollectionViewController)
            viewController.globcategoryArray = FinalCatMarr.mutableCopy() as! NSMutableArray
            viewController.comingfrom = "Search"
        }
        

    }
    @IBAction func unwindToFinalVC(segue: UIStoryboardSegue)
    {
    
     glblArr .removeLastObject()
        
    }
    deinit
    {
//        if(MyVariables.comingfromsearch == "search")
//        {
//            print(MyVariables.comingfromsearch)
//            MyVariables.comingfromsearch = "anotherView"
//        }
//        else
//        {
            glblArr .removeLastObject()
        //}

    }
    // ...


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

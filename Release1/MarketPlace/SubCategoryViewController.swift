//
//  SubCategoryViewController.swift
//  MarketPlace
//
//  Created by inpanr07 on 24/06/16.
//  Copyright (c) 2016 inpanr07. All rights reserved.
//

import UIKit

var comingfromsearch: String!


class SubCategoryViewController: UITableViewController {
    var catDict : NSMutableDictionary = NSMutableDictionary()
    //mapper class array
    var SubCatMarr : NSMutableArray = NSMutableArray()
     var objectToPass : SubCategory!
    var somevalue1 : NSArray!

    //mapper class array end
     var newArray : NSMutableArray = NSMutableArray()
    var newArray2 : NSMutableArray = NSMutableArray()
    var newArray1 : NSMutableDictionary = NSMutableDictionary()
    
     var passedValue: String!
    var comingfromsearch: String!
    
    var categoryArr : NSMutableArray!
    
    var subcategoryArr : NSMutableArray!
    
    var level3Arr : NSMutableArray!
    
     var passedDict : NSMutableDictionary!
    
     var subcatOject : NSArray!
    
    
   

    override func viewDidLoad() {
         super.viewDidLoad()
//        print(passedValue, terminator: "")
//         print(subcategoryArr, terminator: "")
//        
//         print(subcatOject, terminator: "")
        
      
       
        for item in subcatOject!
        {
            let subcattest1  = item  as! SubCategory
            //print(subcattest1.subCategoryName)
            self.SubCatMarr.addObject(subcattest1)
            
        }
       // print(SubCatMarr)
        
        self.tableView.tableFooterView = UIView()
        var arr1 : NSArray = NSArray()
        arr1 = subcategoryArr
        
       let descriptor: NSSortDescriptor = NSSortDescriptor(key:"Input Devices", ascending: true)
        var sortedResults = arr1.sortedArrayUsingDescriptors([descriptor])
       self.title=""
       for item in subcategoryArr!
        {
            //self.newArray1["subCategory2pass"] = item
            if let dict  = item as? NSMutableDictionary
            {
                if dict[passedValue] != nil
                {

                       self.newArray .addObject(dict[passedValue]!)
                       self.newArray2 .addObject(dict["subCategoryId"]!)
                    
                }
                
            }
           
        }
        self.tableView .reloadData()
   }

    override func  viewWillAppear(animated: Bool)
    {
        self.tabBarController?.tabBar.hidden = false
         self.navigationController?.interactivePopGestureRecognizer?.enabled = false
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
        return self.SubCatMarr.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Subdentifier", forIndexPath: indexPath) as UITableViewCell
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        cell.selectionStyle = .None
        // Configure the cell...
      /*
        let stringvalue: AnyObject  = self.subcategoryArr[indexPath.row]
        print(stringvalue, terminator: "")
        let stringvalue1: String = newArray2 .objectAtIndex(indexPath.row) as! String
        print(stringvalue1, terminator: "")
        let a:Int? = Int(stringvalue1)
        
        if let tempStockCode = a {
            cell.tag = tempStockCode
            
        }
*/
        let extarctValue :SubCategory  = self.SubCatMarr[indexPath.row] as! SubCategory
       // print(extarctValue.subCategoryName)
        var stringvalue1: String = extarctValue.subCategoryName!
        
            cell.textLabel?.font = UIFont(name: "MyriadPro-Regular", size: 20)
         //   cell.textLabel?.text = self.SubCatMarr .objectAtIndex(indexPath.row) as? String
        
         cell.textLabel?.text = "\(stringvalue1)"
             //cell.tag = indexPath.row
        return cell
    }
   

    
    var valueToPass:String!
    var SubCategoriesDict : NSMutableDictionary = NSMutableDictionary()
    var catDic : NSMutableDictionary = NSMutableDictionary()
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)!.tag
        
        let tag = indexPath.row
       
    
        passedDict["SubcategoryDic"] = self.subcategoryArr[indexPath.row]
       // print(passedDict)
        
        let indexPath = tableView.indexPathForSelectedRow
        
        
        self.objectToPass = self.SubCatMarr.objectAtIndex((indexPath?.row)!) as! SubCategory
        let somevalue :SubCategory  = self.objectToPass
        self.somevalue1  = somevalue.category3List1 as! NSArray
        
        
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
        valueToPass = currentCell.textLabel?.text
//        catDic["categoryname"] = valueToPass
//        catDic["categoryID"] = cell
        
        catDic["categoryname"] = somevalue.subCategoryName!
        catDic["categoryID"] = somevalue.subCategoryId!

        glblArr.removeAllObjects()
        glblArr.addObject(catDict)
        glblArr.addObject(catDic)
      //  print(valueToPass)
        
        let array1:NSMutableArray = NSMutableArray ()
        for item in self.level3Arr
        {
            //self.newArray1["subCategory2pass"] = item
            if let dict  = item as? NSMutableDictionary
            {
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
            performSegueWithIdentifier("SubCategorySearch", sender: self)
        }
        else
        {
            performSegueWithIdentifier("finalSelection", sender: self)
        }
       // performSegueWithIdentifier("finalSelection", sender: self)
    }
    
    override  func viewWillDisappear(animated: Bool) {
        
      // glblArr .removeObjectAtIndex(0)
        self.title = ""
        
        
    }
    
    //    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //        println("You selected cell #\(indexPath.row)!")
    //
    //        // Get Cell Label
    //        let indexPath = tableView.indexPathForSelectedRow();
    //        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!;
    //
    //        valueToPass = currentCell.textLabel.text
    //        performSegueWithIdentifier("yourSegueIdentifer", sender: self)
    //
    //    }
    
   

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "finalSelection") {
            
            // initialize new view controller and cast it as your view controller
            // var viewController = segue.destinationViewController as SubCategoryViewController
            let viewController = (segue.destinationViewController as! FinalCategoryViewController)
            // your new view controller should have property that will store passed value
           // print(valueToPass, terminator: "")
          
            
            let myString = valueToPass
            //let length = countElements(valueToPass)
            
            if  myString.characters.count > 20
            {
                let backButton = UIBarButtonItem(title: valueToPass, style: UIBarButtonItemStyle.Plain, target: self, action: nil)
                backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 15)!], forState: UIControlState.Normal)
                navigationItem.backBarButtonItem = backButton
            }
            else
            {
            let backButton = UIBarButtonItem(title: valueToPass, style: UIBarButtonItemStyle.Plain, target: self, action: nil)
            backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 15)!], forState: UIControlState.Normal)
            navigationItem.backBarButtonItem = backButton
            }
           viewController.passedValue = valueToPass
            
            viewController.categoryArr=self.categoryArr
            viewController.subcategoryArr = self.subcategoryArr
            viewController.level3Arr = self.level3Arr
            viewController.FinalcatOject = self.somevalue1
        }
        
        else if (segue.identifier == "SubCategorySearch") {
             // let myString = valueToPass
            if  valueToPass.characters.count > 20
            {
                let backButton = UIBarButtonItem(title: valueToPass, style: UIBarButtonItemStyle.Plain, target: self, action: nil)
                backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 15)!], forState: UIControlState.Normal)
                navigationItem.backBarButtonItem = backButton
            }
            else
            {
                let backButton = UIBarButtonItem(title: valueToPass, style: UIBarButtonItemStyle.Plain, target: self, action: nil)
                backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 15)!], forState: UIControlState.Normal)
                navigationItem.backBarButtonItem = backButton
            }
             let viewController = (segue.destinationViewController as! CollectionViewController)
            viewController.comingfrom = "SubCategory"
            viewController.keyWords = valueToPass
            
        }
        
        else if(segue.identifier == "Search")
        {
            let viewController = (segue.destinationViewController as! CollectionViewController)
            viewController.comingfrom = "Search"
        }
        
    }

    
    @IBAction func unwindToSubCatVC(segue: UIStoryboardSegue)
    {
        
        glblArr .removeLastObject()
        
    }
    deinit
    {
        
//        if(MyVariables.comingfromsearch == "search")
//        {
//        print(MyVariables.comingfromsearch)
//            MyVariables.comingfromsearch = "anotherView"
//        }
//        else
//        {
        glblArr .removeLastObject()
       //}
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

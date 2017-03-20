//
//  SearchViewController.swift
//  MarketPlace
//
//  Created by inpanr07 on 04/07/16.
//  Copyright (c) 2016 inpanr07. All rights reserved.
//

import UIKit
import CoreData
struct MyVariables
{
    static var comingfromsearch = "search"
}

class SearchViewController: UIViewController , UITableViewDataSource, UISearchBarDelegate,UITableViewDelegate  {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var data = ["Desktops", "Mobiles", "Networking", "Tablets"]
    var data1 : [String] = []
     var itemcarousel: [Int] = []
    var filteredData: [String]!
     var people = [NSManagedObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         tableView.contentInset = UIEdgeInsetsMake(0, 0, 210, 0);
//        comingfromsearch = "search"
      
        
    }
    override func viewWillAppear(animated: Bool) {
         self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        MyVariables.comingfromsearch = "search"
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        // data1.append("networkDevice")
        
        // fetch data from coredata
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "RecentSearch")
        let sortDescriptor = NSSortDescriptor(key: "searchValue", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            if let people : [NSManagedObject] = results as? [NSManagedObject]
            {
                for searchstring in people
                {
                    print(searchstring.valueForKey("searchValue"))
                    
                    let str  = searchstring.valueForKey("searchValue") as! String
                    
                    data1.append(str)
                    
                    
                }}
            
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        filteredData = data1
        searchBar.becomeFirstResponder()
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableCell")! as UITableViewCell
        print(filteredData[indexPath.row])
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.textLabel?.font = UIFont(name:"MyriadPro-Regular", size:20)
        cell.textLabel?.textColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1)
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    var valueToPass:String!
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
              let cell = tableView.cellForRowAtIndexPath(indexPath)!.tag
               let indexPath = tableView.indexPathForSelectedRow
              let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
        searchBar.text = currentCell.textLabel?.text
        
        self.dismissViewControllerAnimated(true, completion: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("refresh", object: nil, userInfo: ["valueToPass":searchBar.text!])
     
        
       
        
    }
   
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
      
        
       if (segue.identifier == "Search") {
////            
////            // initialize new view controller and cast it as your view controller
          var viewController = segue.destinationViewController as! CollectionViewController
////
              viewController.searchValue = valueToPass
             viewController.comingfrom = "SearchView"
        }
    }

    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        NSNotificationCenter.defaultCenter().postNotificationName("cancel", object: nil, userInfo:nil)
           self.dismissViewControllerAnimated(true, completion: nil)
    }
    func saveName(name: String) {
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("RecentSearch",
                                                        inManagedObjectContext:managedContext)
        
        let recentsearch = NSManagedObject(entity: entity!,
                                     insertIntoManagedObjectContext: managedContext)
        
        //3
        recentsearch.setValue(name, forKey: "searchValue")
        
        //4
        do {
            try managedContext.save()
            let appDelegate =
                UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            //2
            let fetchRequest = NSFetchRequest(entityName: "RecentSearch")
            
            //3
            do {
                let results =
                    try managedContext.executeFetchRequest(fetchRequest)
                if let people : [NSManagedObject] = results as? [NSManagedObject]
                {
                    for searchstring in people
                    {
                        print(searchstring.valueForKey("searchValue"))
                        
                        let str  = searchstring.valueForKey("searchValue") as! String
                        
                        data1.append(str)
                        
                        //data1.append(s)
                    }
                    print(data1)
                    filteredData = data1
                    tableView.reloadData()
                }
                //                data.append(people)
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
           
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (range.length + range.location > searchBar.text!.characters.count) {
            return false;
        }
        let newLength = searchBar.text!.characters.count + text.characters.count - range.length;
        return newLength <= 100
    }

    func searchBarSearchButtonClicked( searchBar: UISearchBar!)
    {
        valueToPass =  searchBar.text
        
        
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
      let searchpredicate = NSPredicate(format: "searchValue = %@", valueToPass)
         let fetchRequest = NSFetchRequest(entityName: "RecentSearch")
        fetchRequest.predicate = searchpredicate
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            if let people : [NSManagedObject] = results as? [NSManagedObject]
            {
            if (people .isEmpty)
                {
                self.saveName(valueToPass)
                
                }
                
                else
                {
                print("Empty Objects")
                
                }
               

            }
          
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
       
        
        
        
        
    
        
        self.dismissViewControllerAnimated(true, completion: nil)
         NSNotificationCenter.defaultCenter().postNotificationName("refresh", object: nil, userInfo: ["valueToPass":valueToPass])

       
    }
    // This method updates filteredData based on the text in the Search Box
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        if searchText.isEmpty
        {
            filteredData = data1
        }
        else
        {
            
            
            filteredData = data1.filter({(dataItem: String) -> Bool in
                // If dataItem matches the searchText, return true to include it
                if dataItem.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
                {
                    return true
                }
                else
                {
                    return false
                }
            })
        }
        tableView.reloadData()
    
}

    
    deinit
    {
       print("deallocated", terminator: "")
        // NSNotificationCenter.defaultCenter().removeObserver(self)
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

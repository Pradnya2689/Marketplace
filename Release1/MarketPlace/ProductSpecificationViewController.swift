//
//  ProductSpecificationViewController.swift
//  MarketPlace
//
//  Created by pradnya on 05/12/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import Alamofire
class ProductSpecificationViewController: UIViewController {
    @IBOutlet var prodDetTable:UITableView!
    var  sheader  = [String]()
    var  rowsinheader  = [[String]]()
    var array = NSMutableArray()
    var descProd : NSMutableAttributedString!
    @IBOutlet var prodDetailSegment:UISegmentedControl!
    @IBOutlet var prodImg: UIImageView!
    @IBOutlet var prodTitle:UILabel!
    @IBOutlet var prodDetTxt:UITextView!
    var imgStr:String!=""
    var prodTitleStr:String!=""
    
    var keyarr = NSMutableArray()
    var valuearr = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Product Details"
        print(rowsinheader)
        if(self.descProd != nil){
            self.prodDetTxt.attributedText = self.descProd
        }else{
            self.prodDetTxt.text = "No Description"
        }
        self.prodTitle.text = self.prodTitleStr
        
        //        array = NSMutableArray()
        
        //        for (index, element) in rowsinheader.enumerate() {
        // do something with index
        
        
        if let books = rowsinheader as? [[String]]
        {
            for bookDict in books {
                
                print("title: \(bookDict)")
                
                var samekey = ""
                //                for (index1, element) in bookDict.enumerate()
                //                {
                //                    print(index)
                //                    print(index1)
                var array1 = NSMutableArray()
                var array2 = NSMutableDictionary()
                var dict = NSMutableDictionary()
                for bookDict1 in bookDict
                {
                    
                    let fullName = bookDict1
                    let fullNameArr = fullName.characters.split{$0 == ":"}.map(String.init)
                    
                    if let dickey = fullNameArr[0] as? String
                    {
                        
                        //dict.contains(<#T##predicate: ((key: AnyObject, value: AnyObject)) throws -> Bool##((key: AnyObject, value: AnyObject)) throws -> Bool#>)
                        
                        if((dict[dickey]) != nil)
                        {
                            var dicvalue = dict.valueForKey(dickey)
                            dicvalue = "\(dicvalue!) \n\(fullNameArr[1])"
                            dict.setValue(dicvalue! , forKey: dickey)
                        }
                        else
                        {
                            dict.setValue(fullNameArr[1] , forKey: dickey)
                            
                        }
                        
                    }
                    
                    if (samekey .isEmpty)
                    {
                        print("samename")
                        samekey = fullNameArr[0]
                    }
                    else if (samekey == fullNameArr[0])
                    {
                        print(samekey)
                        //array1.objectAtIndex(-1)
                    }
                    
                    
                    
                    array1.addObject(bookDict1)
                    print(bookDict1)
                    /* let fullName = bookDict1
                     let fullNameArr = fullName.characters.split{$0 == ":"}.map(String.init)
                     
                     
                     
                     if (samekey .isEmpty)
                     {
                     print("samename")
                     samekey = fullNameArr[0]
                     }
                     else if (samekey == fullNameArr[0])
                     {
                     print(samekey)
                     }
                     else
                     {
                     array.addObject(bookDict1)
                     }
                     
                     fullNameArr[0] // First
                     fullNameArr[1] // Last
                     
                     print("fullname0 : \(fullNameArr[0])")
                     print("fullname1 : \( fullNameArr[1])")
                     print("title: \(bookDict1)")*/
                    
                }
                array.addObject(dict)
                
                
                //   }
                //let title = bookDict["title"]
                
                //   }
            }
            // print(array)
            print(array)
        }
        
        //        if(self.sheader.count == 0){
        //            var  values  = [String]()
        //            let first = "This product does not have specifications"
        //            values.append(first)
        //            self.rowsinheader.append(values)
        //        }
        
        // self.prodDetTxt.attributedText = descProd
        
        if let url =   self.imgStr as? String{
            let imgURL: NSURL = NSURL(string: url)!
            print(imgURL.absoluteString)
            let image : UIImage = UIImage(named:"placeholder")!
            self.prodImg.image = image
            
            if let image = photoCache.imageWithIdentifier(imgURL.absoluteString)
            {
                print("IN cache")
                self.prodImg.image = image
                
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
                            self.prodImg.image = image
                            photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                        }
                        else
                        {
                            let image : UIImage = UIImage(named:"placeholder")!
                            self.prodImg.image = image
                            photoCache.addImage(image, withIdentifier: imgURL.absoluteString)
                        }
                }
            }
        }else{
            let image : UIImage = UIImage(named:"placeholder")!
            self.prodImg.image = image
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func segmntValueuChng(){
        if(self.prodDetailSegment.selectedSegmentIndex == 0){
            self.prodDetTxt.hidden = false
            self.prodDetTable.hidden = true
        }else{
            self.prodDetTxt.hidden = true
            self.prodDetTable.hidden = false
        }
    }
    //    override func viewDidAppear(animated: Bool) {
    //        // self.tbl1.rowHeight = UITableViewAutomaticDimension
    //        // self.tbl1.estimatedRowHeight = 20
    //
    //        // self.tbl1.reloadData()
    //        self.view.setNeedsDisplay()
    //        self.view.setNeedsLayout()
    //        self.view.layoutIfNeeded()
    //
    //    }
    override func viewDidAppear(animated: Bool) {
        
        self.prodDetTable.rowHeight = UITableViewAutomaticDimension
        self.prodDetTable.estimatedRowHeight = 50
        
        prodDetTable.reloadData()
        
        self.view.setNeedsDisplay()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    //    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
    //        return tableView.estimatedRowHeight
    //    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(self.sheader.count > 0){
            return "  \(self.sheader[section].uppercaseString)"
        }
        
        return " "
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        keyarr.removeAllObjects()
        valuearr.removeAllObjects()
        if(self.sheader.count == 0){
            return 1
        }
        return self.sheader.count
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        var title = UILabel()
        //title.frame = CGRectMake(-80, 0, 100, 30)
        title.font = UIFont(name: "Myriad Pro", size: 12)!
        title.textColor = UIColor (red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        
        let header = view as! UITableViewHeaderFooterView
        // header.frame   = CGRectMake(0, 0, 100, 30)
        header.textLabel?.font=title.font
        header.textLabel?.textColor=title.textColor
        header.contentView.backgroundColor = UIColor .whiteColor()
    }
    
    //    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        if(self.sheader.count > 0){
    //        if(self.rowsinheader[section ].count ==  0){
    //            return 0.0
    //        }
    //        }
    //        return 30.0
    //    }
    //
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(self.sheader.count > 0){
            // return self.rowsinheader[section].count
            var dict =  self.array.objectAtIndex(section) as? NSDictionary
            return (dict?.count)!
        }
        
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // tableView.registerNib(UINib(nibName: "CustomViewCell", bundle: nil), forCellReuseIdentifier:"cell")
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! CustomViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        if(self.sheader.count == 0)
        {
            cell.noResultLbl.text = "     Product doesnt have any specification."
            cell.noResultLbl.hidden = false
            
            // cell.valuelbl.text = "Product info"
            // cell.lbl.text = self.rowsinheader[indexPath.section][indexPath.row]
        }
        else
        {
            cell.noResultLbl.hidden = true
            let dict = self.array.objectAtIndex(indexPath.section) as? NSMutableDictionary
            print(dict!)
            //        cell.lbl.text = self.rowsinheader[indexPath.section][indexPath.row]
            //        var myString: String = self.rowsinheader[indexPath.section][indexPath.row]
            //        var myStringArr = myString.componentsSeparatedByString(":")
            //            let lbltext = self.array.objectAtIndex(indexPath.section).valueAtIndex(indexPath.row) as! String
            //          //  cell.lbl.text = self.array.objectAtIndex(indexPath.section).valueAtIndex(indexPath.row)
            //            cell.lbl.text = self.rowsinheader[indexPath.section][indexPath.row]
            //            var myString: String = self.rowsinheader[indexPath.section][indexPath.row]
            //            var myStringArr = myString.componentsSeparatedByString(":")
            //
            //
            //        let a =  myStringArr [1]
            //        let b =  myStringArr [0]
            //
            //        let first = "    " + a
            //        let second = "    " + b
            let tempdic = dict! as NSDictionary
            
            
            for (key, value) in dict!
            {
                print("Key: \(key) - Value: \(value)")
                cell.lbl.text = value as! String
                cell.valuelbl.text = key as! String
            }
            
            for (index, element) in dict!.enumerate() {
                if (indexPath.row == index)
                {
                    cell.lbl.text = element.value as! String
                    cell.valuelbl.text = element.key as! String
                    print(element.value as! String)
                    print(element.key as! String)
                    
                }
                //                print("Item \(index): \(element)")
                //                print(element.key)
                //                 print(element.value)
                //                keyarr.addObject(element.key)
                //                valuearr.addObject(element.value)
                //cell.lbl.text =
            }
            //            for (id key, id obj) in tempdic
            //            {
            //                print("key=\(key) value=\(myDict[key] as! String)")
            //            }
            //            print(dict!["Depth (mm)"]!)
            //print(dict![indexPath.row].value)
            
            
            //       cell.lbl.text = keyarr.objectAtIndex(indexPath.row) as! String
            //        cell.valuelbl.text = valuearr.objectAtIndex(indexPath.row) as! String
            
            
            
            
        }
        cell.contentView.layer.borderWidth = 0.4
        cell.contentView.layer.borderColor = UIColor (red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0).CGColor
        return cell
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

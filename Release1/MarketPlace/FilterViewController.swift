//
//  FilterViewController.swift
//  MarketPlace
//
//  Created by Administrator on 17/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

@objc protocol filterDElegate
{
    optional func returnDataToPrev(vendrDet:NSMutableArray,priceArray:NSMutableArray,techSpecAray:NSMutableArray,categoryArray:NSMutableArray,fileteApplied:NSString,reviewArray:NSMutableArray)
}
class FilterViewController: UIViewController {
    @IBOutlet var filterKeyTable:UITableView!
    @IBOutlet var filterValueTable:UITableView!
    var optionArray:NSMutableArray! = NSMutableArray()
   // var valueArray:NSArray!
  //  var option2Array:NSArray!
   // var option3Array:NSArray!
    var optionSel:NSString!
    var titlewithoutCount :NSString!
   // var techSpecKeysArray:NSArray!
   // var techSpecValArray:NSArray!
  //  var selectedValDict :  NSMutableDictionary!
    var brandArray:NSArray! = NSArray()
    var selectedBrandValArray : NSMutableArray! = NSMutableArray()
     var delegates : filterDElegate?
    var priceRangeArray:NSArray! = NSArray()
    var selectedPriceArray:NSMutableArray! = NSMutableArray()
    var techSpecArray:NSMutableArray = NSMutableArray()
    var selectedTechSpecArray:NSMutableArray! = NSMutableArray()
    var filterApplied:NSString! = ""
    var categoryArray:NSArray = NSArray()
    var selectedCategoryArray : NSMutableArray! = NSMutableArray()
    var techCatArray : NSMutableArray! = NSMutableArray()
    var selReviewArray : NSMutableArray! = NSMutableArray()
    var reviewArray : NSArray! = NSArray()
    @IBOutlet var clearBtn:UIButton!
    @IBOutlet var applyBtn:UIButton!
    @IBOutlet weak var applyResetView: UIView!
    
    var selectedTech:NSMutableArray!=NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
      //  selectedValDict = NSMutableDictionary()
//        selectedBrandValArray = NSMutableArray()
//        selectedPriceArray = NSMutableArray()
//        selectedTechSpecArray = NSMutableArray()
//        selectedCategoryArray = NSMutableArray()
        self.title = "Filter"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
        //filterApplied = ""
        let buttonleft = UIButton(type: UIButtonType.Custom)
        buttonleft.frame = CGRectMake(0, 0, 60, 60)
        buttonleft.imageEdgeInsets =  UIEdgeInsetsMake(0, 0, 0, 40)
        //buttonleft.titleLabel?.text = "back"
        buttonleft.titleLabel?.textColor = UIColor.blackColor()
        buttonleft.setImage(UIImage(named:"closeBtn"), forState: UIControlState.Normal)
        
        buttonleft.addTarget(self, action: #selector(FilterViewController.backClicked), forControlEvents: UIControlEvents.TouchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
       // techSpecKeysArray = ["Display Size","Manufacturer","RAM Size","abc"]
        
        clearBtn.layer.shadowColor = UIColor.blackColor().CGColor
        clearBtn.layer.shadowOpacity = 0.1
        clearBtn.layer.shadowOffset = CGSizeMake(2.0, 0.0)
        
        applyBtn.layer.shadowColor = UIColor.blackColor().CGColor
        applyBtn.layer.shadowOpacity = 0.8
        applyBtn.layer.shadowOffset = CGSizeMake(2.0, 0.0)
        
        applyResetView.layer.shadowColor = UIColor.blackColor().CGColor
        applyResetView.layer.shadowOpacity = 0.3
        applyResetView.layer.shadowOffset = CGSizeZero
        
        if(categoryArray.count > 0){
            optionSel = "Category"
        }else if(brandArray.count > 0){
            optionSel = "Brand"
        }else if(priceRangeArray.count > 0)
        {
             optionSel = "Price"
        }else{
            optionSel = "Technical    Specs"
        }
       // optionArray = ["Category","Brand","Price","Technical    Specs"]
        optionArray = ["Category","Brand","Price"]
        optionArray.addObject("Review")
        var rv = reviewArray.objectAtIndex(0) as! LstUserReview
       // print("review array cnt \(rv.rid)")
        
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.init(colorLiteralRed: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 0.5).CGColor
        border.frame = CGRect(x: 0 , y: 0, width:  0.5, height: screenSize.height-60)
        
        border.borderWidth = width
        filterValueTable.layer.addSublayer(border)
        filterValueTable.layer.masksToBounds = true
        
        for (index,elmnt) in techSpecArray.enumerate(){
            let rowscnt = techSpecArray.objectAtIndex(index) as! LstTechSpecs
            //let vendor  = techSpecArray[indexPath.section] as! LstTechSpecs
            let optionval = rowscnt.lstTechOptions! as NSArray
            optionArray.addObject(rowscnt.techName!)
            techCatArray.addObject(optionval)
        }
        
        filterKeyTable.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.title = ""
    }
    func backClicked()  {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func applyFilterClk(){
       // let vc = self.navigationController?.viewControllers
        if(selectedPriceArray.count == 0 && selectedBrandValArray.count == 0 && selectedTechSpecArray.count == 0 && selectedCategoryArray.count == 0 && selReviewArray.count == 0){
            self.delegates?.returnDataToPrev!([], priceArray: [], techSpecAray: [], categoryArray: [], fileteApplied: filterApplied,reviewArray:[])
             NSNotificationCenter.defaultCenter().postNotificationName("hideResultCount", object: nil, userInfo: nil )
             self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        }else{
        let vendorIDs = selectedBrandValArray.componentsJoinedByString(",")
       // print("vendorIDs \(selectedPriceArray)")
            NSNotificationCenter.defaultCenter().postNotificationName("hideResultCount", object: nil, userInfo: nil )
        self.delegates?.returnDataToPrev!(selectedBrandValArray, priceArray: selectedPriceArray, techSpecAray: selectedTechSpecArray, categoryArray: selectedCategoryArray, fileteApplied: filterApplied,reviewArray:self.selReviewArray)
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func resetFilterBtnClk(){
        filterApplied = ""
        for i in 0 ..< optionArray.count{
            let indx : NSIndexPath = NSIndexPath(forRow: i, inSection: 0)
            let cell = filterKeyTable.cellForRowAtIndexPath(indx) as? FilterKeyCell
            cell?.countBtn.badgeString = ""
        }
        selReviewArray.removeAllObjects()
        selectedTechSpecArray.removeAllObjects()
        selectedBrandValArray.removeAllObjects()
        selectedPriceArray.removeAllObjects()
        selectedCategoryArray.removeAllObjects()
        filterValueTable.reloadData()
      
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(optionSel == "Technical    Specs"){
            if(tableView == filterValueTable){
                return techSpecArray.count
            }
        }
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == filterKeyTable){
            
            return optionArray.count
        }
        if(optionSel == "Brand"){
            return brandArray.count
        }
       else if(optionSel == "Price"){
            return priceRangeArray.count
        }

       else if(optionSel == "Category"){
            return categoryArray.count
        }
        else if(optionSel == "Review"){
            return reviewArray.count
        }
        else {
            
            return selectedTech.count
          
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        if(tableView == filterKeyTable){
            if(indexPath.row == 0){
            if(categoryArray.count==0){
                //optionSel = "Brand"
                return 0.0
            }else{
                return 60.0
                }
            
            }
            
            if(indexPath.row == 1){
            if(brandArray.count==0){
                return 0.0
                }else{
                return 60.0
            }
            }
            if(indexPath.row == 2){
                if(priceRangeArray.count==0){
                    return 0.0
                    
                }else{
                    return 60.0
                }
            }
            if(indexPath.row == 3){
                if(reviewArray.count == 1){
                    let usrrv = reviewArray.objectAtIndex(0) as! LstUserReview
                    if(usrrv.rid == 0 || usrrv.rid == nil){
                        return 0.0
                    }
                }
            if(reviewArray.count==0){
                return 0.0
            
            }else{
                return 60.0
            }
            }
            
          return 60.0
            
        }else{
            return 60.0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(tableView == filterKeyTable){
            let cell = tableView.dequeueReusableCellWithIdentifier("keycell", forIndexPath: indexPath) as! FilterKeyCell
            
            cell.countBtn.badgeEdgeInsets =  UIEdgeInsetsMake(20, 0, 0, 20)
            cell.countBtn.badgeTextColor = UIColor.whiteColor()
            cell.optionLabl.adjustsFontSizeToFitWidth = true
            cell.optionLabl.minimumScaleFactor=0.5;
            cell.optionLabl.text = optionArray[indexPath.row] as? String
            if(optionSel == "Brand"){
                if(indexPath.row == 0){
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    //cell.countBtn.badgeString = String(selectedCategoryArray.count)
                    if(selectedCategoryArray.count != 0){
                        cell.countBtn.badgeString = String(selectedCategoryArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    cell.optionLabl.textColor = UIColor.darkGrayColor()
                    cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                }else if(indexPath.row == 1){
                    cell.contentView.backgroundColor =  UIColor.whiteColor()
                    if(selectedBrandValArray.count != 0){
                        cell.countBtn.badgeString = String(selectedBrandValArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    
                    cell.optionLabl.textColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                    cell.countBtn.badgeBackgroundColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                }else if(indexPath.row == 2){
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    if(selectedPriceArray.count != 0){
                        cell.countBtn.badgeString = String(selectedPriceArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    cell.optionLabl.textColor = UIColor.darkGrayColor()
                    cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                }else if(indexPath.row == 3){
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    if(selReviewArray.count != 0){
                        cell.countBtn.badgeString = String(selReviewArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    cell.optionLabl.textColor = UIColor.darkGrayColor()
                    cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                }
                else{
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    
                    var rowdata11 = optionArray.objectAtIndex(indexPath.row)
                    let rowData = self.techSpecArray.objectAtIndex(indexPath.row - 4) as! LstTechSpecs
                    var selTech : NSMutableArray! = NSMutableArray()
                    selTech = rowData.lstTechOptions as! NSMutableArray
                    var indexofA = optionArray.indexOfObject(optionSel)
                    for i in 0..<optionArray.count{
                        if(i==indexofA){
                            
                        }else{
                            
                            
                        }
                    }
                    
                    if(selectedTechSpecArray.count != 0){
                        
                        var i : Int! = 0
                        for (y,elemt) in selTech.enumerate() {
                            var rowData = selTech.objectAtIndex(y) as! LstTechOptions
                            for (z,elmt) in selectedTechSpecArray.enumerate() {
                                if rowData.dimensionValueId! == elmt as! String{
                                    i = i + 1
                                    
                                }
                            }
                            
                        }
                        if(i != 0){
                            cell.countBtn.badgeString = String(i)
                        }else{
                            cell.countBtn.badgeString = ""
                        }
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    if(indexofA == indexPath.row){
                        cell.contentView.backgroundColor =  UIColor.whiteColor()
                        cell.optionLabl.textColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                        cell.countBtn.badgeBackgroundColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                    }else{
                        cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                        cell.optionLabl.textColor = UIColor.darkGrayColor()
                        cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                    }
                    
                }
        }else if(optionSel == "Price"){
                if(indexPath.row == 0){
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    if(selectedCategoryArray.count != 0){
                        cell.countBtn.badgeString = String(selectedCategoryArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    cell.optionLabl.textColor = UIColor.darkGrayColor()
                    cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                }else if(indexPath.row == 1){
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    if(selectedBrandValArray.count != 0){
                        cell.countBtn.badgeString = String(selectedBrandValArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    
                    cell.optionLabl.textColor = UIColor.darkGrayColor()
                    cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                }else if(indexPath.row == 3){
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    if(selReviewArray.count != 0){
                        cell.countBtn.badgeString = String(selReviewArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    cell.optionLabl.textColor = UIColor.darkGrayColor()
                    cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                }

                else if(indexPath.row == 2){
                     cell.contentView.backgroundColor =  UIColor.whiteColor()
                    if(selectedPriceArray.count != 0){
                        cell.countBtn.badgeString = String(selectedPriceArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    cell.optionLabl.textColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                    cell.countBtn.badgeBackgroundColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                }
                else{
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    // cell.countBtn.badgeString = String(selectedTechSpecArray.count)
                    var rowdata11 = optionArray.objectAtIndex(indexPath.row)
                    //var indxA = optionArray.indexOfObject(optionSel)
                    let rowData = self.techSpecArray.objectAtIndex(indexPath.row - 4) as! LstTechSpecs
                    var selTech : NSMutableArray! = NSMutableArray()
                    selTech = rowData.lstTechOptions as! NSMutableArray
                    var indexofA = optionArray.indexOfObject(optionSel)
                    for i in 0..<optionArray.count{
                        if(i==indexofA){
                            
                        }else{
                            
                            
                        }
                    }
                    
                    if(selectedTechSpecArray.count != 0){
                        
                        var i : Int! = 0
                        for (y,elemt) in selTech.enumerate() {
                            var rowData = selTech.objectAtIndex(y) as! LstTechOptions
                            for (z,elmt) in selectedTechSpecArray.enumerate() {
                                if rowData.dimensionValueId! == elmt as! String{
                                    i = i + 1
                                    // self.boolValue = true
                                }
                            }
                            //self.boolArray.append(self.boolValue)
                        }
                        if(i != 0){
                            cell.countBtn.badgeString = String(i)
                        }else{
                            cell.countBtn.badgeString = ""
                        }
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    if(indexofA == indexPath.row){
                        cell.contentView.backgroundColor =  UIColor.whiteColor()
                        cell.optionLabl.textColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                        cell.countBtn.badgeBackgroundColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                    }else{
                        cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                        cell.optionLabl.textColor = UIColor.darkGrayColor()
                        cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                    }
                    
                }
            } else  if(optionSel == "Category"){
                if(indexPath.row == 0){
                    cell.contentView.backgroundColor =  UIColor.whiteColor()
                    // cell.countBtn.badgeString = String(selectedCategoryArray.count)
                    if(selectedCategoryArray.count != 0){
                        cell.countBtn.badgeString = String(selectedCategoryArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    cell.optionLabl.textColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                    cell.countBtn.badgeBackgroundColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                }
                else if(indexPath.row == 1){
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    if(selectedBrandValArray.count != 0){
                        cell.countBtn.badgeString = String(selectedBrandValArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    
                    cell.optionLabl.textColor = UIColor.darkGrayColor()
                    cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                }
               else if(indexPath.row == 2){
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    if(selectedPriceArray.count != 0){
                        cell.countBtn.badgeString = String(selectedPriceArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    cell.optionLabl.textColor = UIColor.darkGrayColor()
                    cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                }else if(indexPath.row == 3){
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    if(selReviewArray.count != 0){
                        cell.countBtn.badgeString = String(selReviewArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    cell.optionLabl.textColor = UIColor.darkGrayColor()
                    cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                }

                else{
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    // cell.countBtn.badgeString = String(selectedTechSpecArray.count)
                    var rowdata11 = optionArray.objectAtIndex(indexPath.row)
                    //var indxA = optionArray.indexOfObject(optionSel)
                    let rowData = self.techSpecArray.objectAtIndex(indexPath.row - 4) as! LstTechSpecs
                    var selTech : NSMutableArray! = NSMutableArray()
                    selTech = rowData.lstTechOptions as! NSMutableArray
                    var indexofA = optionArray.indexOfObject(optionSel)
                    for i in 0..<optionArray.count{
                        if(i==indexofA){
                            
                        }else{
                            
                            
                        }
                    }
                    
                    if(selectedTechSpecArray.count != 0){
                        
                        var i : Int! = 0
                        for (y,elemt) in selTech.enumerate() {
                            var rowData = selTech.objectAtIndex(y) as! LstTechOptions
                            for (z,elmt) in selectedTechSpecArray.enumerate() {
                                if rowData.dimensionValueId! == elmt as! String{
                                    i = i + 1
                                    // self.boolValue = true
                                }
                            }
                            //self.boolArray.append(self.boolValue)
                        }
                        if(i != 0){
                            cell.countBtn.badgeString = String(i)
                        }else{
                            cell.countBtn.badgeString = ""
                        }
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    if(indexofA == indexPath.row){
                        cell.contentView.backgroundColor =  UIColor.whiteColor()
                        cell.optionLabl.textColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                        cell.countBtn.badgeBackgroundColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                    }else{
                        cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                        cell.optionLabl.textColor = UIColor.darkGrayColor()
                        cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                    }
                    
                }
                
            }else if(optionSel == "Review"){
                if(indexPath.row == 0){
                    
                    // cell.countBtn.badgeString = String(selectedCategoryArray.count)
                    if(selectedCategoryArray.count != 0){
                        cell.countBtn.badgeString = String(selectedCategoryArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    cell.optionLabl.textColor = UIColor.darkGrayColor()
                    cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                }
                else if(indexPath.row == 1){
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    if(selectedBrandValArray.count != 0){
                        cell.countBtn.badgeString = String(selectedBrandValArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    
                    cell.optionLabl.textColor = UIColor.darkGrayColor()
                    cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                }
                else if(indexPath.row == 2){
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    if(selectedPriceArray.count != 0){
                        cell.countBtn.badgeString = String(selectedPriceArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    cell.optionLabl.textColor = UIColor.darkGrayColor()
                    cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                }else if(indexPath.row == 3){
                    
                    if(selReviewArray.count != 0){
                        cell.countBtn.badgeString = String(selReviewArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    
                    cell.contentView.backgroundColor =  UIColor.whiteColor()
                    cell.optionLabl.textColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                    cell.countBtn.badgeBackgroundColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                }
                    
                else{
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    // cell.countBtn.badgeString = String(selectedTechSpecArray.count)
                    var rowdata11 = optionArray.objectAtIndex(indexPath.row)
                    //var indxA = optionArray.indexOfObject(optionSel)
                    let rowData = self.techSpecArray.objectAtIndex(indexPath.row - 4) as! LstTechSpecs
                    var selTech : NSMutableArray! = NSMutableArray()
                    selTech = rowData.lstTechOptions as! NSMutableArray
                    var indexofA = optionArray.indexOfObject(optionSel)
                    for i in 0..<optionArray.count{
                        if(i==indexofA){
                            
                        }else{
                            
                            
                        }
                    }
                    
                    if(selectedTechSpecArray.count != 0){
                        
                        var i : Int! = 0
                        for (y,elemt) in selTech.enumerate() {
                            var rowData = selTech.objectAtIndex(y) as! LstTechOptions
                            for (z,elmt) in selectedTechSpecArray.enumerate() {
                                if rowData.dimensionValueId! == elmt as! String{
                                    i = i + 1
                                    // self.boolValue = true
                                }
                            }
                            //self.boolArray.append(self.boolValue)
                        }
                        if(i != 0){
                            cell.countBtn.badgeString = String(i)
                        }else{
                            cell.countBtn.badgeString = ""
                        }
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    if(indexofA == indexPath.row){
                        cell.contentView.backgroundColor =  UIColor.whiteColor()
                        cell.optionLabl.textColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                        cell.countBtn.badgeBackgroundColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                    }else{
                        cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                        cell.optionLabl.textColor = UIColor.darkGrayColor()
                        cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                    }
                    
                }
            }
            
            
            else
           {
                if(indexPath.row == 0){
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    if(selectedCategoryArray.count != 0){
                        cell.countBtn.badgeString = String(selectedCategoryArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    cell.optionLabl.textColor = UIColor.darkGrayColor()
                    cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                }
               else if(indexPath.row == 1){
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    if(selectedBrandValArray.count != 0){
                        cell.countBtn.badgeString = String(selectedBrandValArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    
                    cell.optionLabl.textColor = UIColor.darkGrayColor()
                    cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                }
               else if(indexPath.row == 2){
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    if(selectedPriceArray.count != 0){
                        cell.countBtn.badgeString = String(selectedPriceArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    cell.optionLabl.textColor = UIColor.darkGrayColor()
                    cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                }else if(indexPath.row == 3){
                    cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                    if(selReviewArray.count != 0){
                        cell.countBtn.badgeString = String(selReviewArray.count)
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    cell.optionLabl.textColor = UIColor.darkGrayColor()
                    cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                }

                else{
                    var rowdata11 = optionArray.objectAtIndex(indexPath.row)
                    //var indxA = optionArray.indexOfObject(optionSel)
                    let rowData = self.techSpecArray.objectAtIndex(indexPath.row - 4) as! LstTechSpecs
                    var selTech : NSMutableArray! = NSMutableArray()
                    selTech = rowData.lstTechOptions as! NSMutableArray
                    var indexofA = optionArray.indexOfObject(optionSel)
                    for i in 0..<optionArray.count{
                        if(i==indexofA){
                            
                        }else{
                            
   
                        }
                    }
                    
                    if(selectedTechSpecArray.count != 0){
                        
                        var i : Int! = 0
                        for (y,elemt) in selTech.enumerate() {
                            var rowData = selTech.objectAtIndex(y) as! LstTechOptions
                            for (z,elmt) in selectedTechSpecArray.enumerate() {
                                if rowData.dimensionValueId! == elmt as! String{
                                    i = i + 1
                                    // self.boolValue = true
                                }
                            }
                            //self.boolArray.append(self.boolValue)
                        }
                        if(i != 0){
                        cell.countBtn.badgeString = String(i)
                        }else{
                             cell.countBtn.badgeString = ""
                        }
                    }else{
                        cell.countBtn.badgeString = ""
                    }
                    if(indexofA == indexPath.row){
                        cell.contentView.backgroundColor =  UIColor.whiteColor()
                        cell.optionLabl.textColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                        cell.countBtn.badgeBackgroundColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                    }else{
                         cell.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                        cell.optionLabl.textColor = UIColor.darkGrayColor()
                        cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                    }
                    
                }
            }
           
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("valuecell", forIndexPath: indexPath) as! FilterValueCell
            cell.valueLbl.hidden = false
            cell.userReviwImg.hidden = true
            cell.prodCntLbl.hidden = true
             cell.chkBbtn.hidden = false
            cell.selectionStyle = .None
            if(optionSel == "Brand" ){
                filterValueTable.allowsMultipleSelection = true
            }
            if(optionSel == "Review" || optionSel == "Price"){
                filterValueTable.allowsMultipleSelection = false
            }
            if(optionSel == "Brand"){
                 cell.chkBbtn.hidden = false
                let vendor  = brandArray[indexPath.row] as! VndrList
                
                cell.valueLbl.text = vendor.name
                cell.uniqueId = vendor.vendorId
                if selectedBrandValArray.containsObject(vendor.vendorId!){
                   cell.chkBbtn.setImage(UIImage(named: "checkboxenable.png"), forState: .Normal)
                }else{
                    cell.chkBbtn.setImage(UIImage(named: "checkboxDisable.png"), forState: .Normal)
                    
                }
                
            }else  if(optionSel == "Price"){
                let vendor  = priceRangeArray[indexPath.row] as! LstPices
                cell.valueLbl.text = vendor.name
                cell.uniqueId = vendor.name
                cell.pId = vendor.pid
                 cell.chkBbtn.hidden = false
                if let price = vendor.name
                {
                if selectedPriceArray.containsObject(vendor.pid!)
                {
                    cell.chkBbtn.setImage(UIImage(named: "checkboxenable.png"), forState: .Normal)
                }
                else
                {
                    cell.chkBbtn.setImage(UIImage(named: "checkboxDisable.png"), forState: .Normal)
                    // cell.chkBbtn.backgroundColor =  UIColor.lightGrayColor()
                    }
                }
                else
                {
                    cell.chkBbtn.setImage(UIImage(named: "checkboxDisable.png"), forState: .Normal)
                }

            }

            else  if(optionSel == "Category"){
                 cell.chkBbtn.hidden = false
                let vendor  = categoryArray[indexPath.row] as! category3List
                cell.valueLbl.text = vendor.category3Name
                cell.uniqueId = vendor.category3Id
                if selectedCategoryArray.containsObject(vendor.category3Id!){
                    cell.chkBbtn.setImage(UIImage(named: "checkboxenable.png"), forState: .Normal)
                }else{
                    cell.chkBbtn.setImage(UIImage(named: "checkboxDisable.png"), forState: .Normal)
                    // cell.chkBbtn.backgroundColor =  UIColor.lightGrayColor()
                }

            }
            else if(optionSel == "Review"){
                filterValueTable.allowsMultipleSelection = false
                 let vendor  = reviewArray[indexPath.row] as! LstUserReview
                cell.valueLbl.text = vendor.name
                cell.uniqueId = String(vendor.rid!)
                cell.valueLbl.hidden = true
                cell.userReviwImg.hidden = false
                cell.prodCntLbl.hidden = true
                cell.chkBbtn.hidden = false
                if vendor.name != nil{
                let numberFormatter = NSNumberFormatter()
                let number = numberFormatter.numberFromString(vendor.name!)
                cell.userReviwImg.rating = (number?.floatValue)!
                }else{
                    cell.userReviwImg.hidden = true
                    cell.prodCntLbl.hidden = true
                    cell.chkBbtn.hidden = true
                    cell.uniqueId = nil
                }
                
                cell.prodCntLbl.text = "(\(String(vendor.productCount!)))"
                if selReviewArray.containsObject(String(vendor.rid!)){
                    cell.chkBbtn.setImage(UIImage(named: "checkboxenable.png"), forState: .Normal)
                }else{
                    cell.chkBbtn.setImage(UIImage(named: "checkboxDisable.png"), forState: .Normal)
                    // cell.chkBbtn.backgroundColor =  UIColor.lightGrayColor()
                }
                
                
            }
            
            else{
//                let vendor  = s[indexPath.row] as! [LstTechOptions]
//                print("vendor  \(vendor)")
                //print("index \(indexPath.row)")
                let optionval = selectedTech[indexPath.row] as! LstTechOptions
                //print("opt \(optionval.specName)")
                cell.valueLbl.text = optionval.specName
                cell.uniqueId = optionval.dimensionValueId
                if selectedTechSpecArray.containsObject(optionval.dimensionValueId!){
                    cell.chkBbtn.setImage(UIImage(named: "checkboxenable.png"), forState: .Normal)
                }else{
                    cell.chkBbtn.setImage(UIImage(named: "checkboxDisable.png"), forState: .Normal)
                    // cell.chkBbtn.backgroundColor =  UIColor.lightGrayColor()
                }
            }

           
            return cell
        }
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if(tableView == filterValueTable){
          //  filterValueTable.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
            if(optionSel == "Brand"){
               filterApplied = "vendor"
                let indexPath1 : NSIndexPath = NSIndexPath(forRow: 1, inSection: 0)
                let cell = filterKeyTable.cellForRowAtIndexPath(indexPath1) as! FilterKeyCell
                 let indx : NSIndexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
                let valcell = filterValueTable.cellForRowAtIndexPath(indx) as! FilterValueCell
                if selectedBrandValArray.containsObject(valcell.uniqueId){
                     valcell.chkBbtn.setImage(UIImage(named: "checkboxDisable.png"), forState: .Normal)
                    selectedBrandValArray.removeObject(valcell.uniqueId)
                    if selectedBrandValArray.count == 0{
                        cell.countBtn.badgeString = ""
                    }else{
                    cell.countBtn.badgeString = String(selectedBrandValArray.count)
                    }
                
                }else{
                    valcell.chkBbtn.setImage(UIImage(named: "checkboxenable.png"), forState: .Normal)
                    selectedBrandValArray.addObject(valcell.uniqueId)
                    if selectedBrandValArray.count == 0{
                        cell.countBtn.badgeString = ""
                    }else{
                    cell.countBtn.badgeString = String(selectedBrandValArray.count)
                    }
                    cell.countBtn.badgeBackgroundColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                }
                
            }else  if(optionSel == "Price"){
                filterApplied = "price"
                let indexPath1 : NSIndexPath = NSIndexPath(forRow: 2, inSection: 0)
                let cell = filterKeyTable.cellForRowAtIndexPath(indexPath1) as! FilterKeyCell
              
                let indx : NSIndexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
                let valcell = filterValueTable.cellForRowAtIndexPath(indx) as! FilterValueCell
                if let price = valcell.pId
                {
                if selectedPriceArray.containsObject(valcell.pId){
                    valcell.chkBbtn.setImage(UIImage(named: "checkboxDisable.png"), forState: .Normal)
                    selectedPriceArray.removeObject(valcell.pId)
                    if selectedPriceArray.count == 0{
                        cell.countBtn.badgeString = ""
                    }else{
                    cell.countBtn.badgeString = String(selectedPriceArray.count)
                    //cell.countBtn
                    }
                }else{
                    valcell.chkBbtn.setImage(UIImage(named: "checkboxenable.png"), forState: .Normal)
                    selectedPriceArray.removeAllObjects()
                   // selectedPriceArray.addObject(valcell.uniqueId)
                    selectedPriceArray.addObject(valcell.pId)
                    if selectedPriceArray.count == 0{
                        cell.countBtn.badgeString = ""
                    }else{
                    cell.countBtn.badgeString = String(selectedPriceArray.count)
                    }
                    cell.countBtn.badgeBackgroundColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                }

                }
            }else  if(optionSel == "Review"){
                filterApplied = "review"
                let indexPath1 : NSIndexPath = NSIndexPath(forRow: 3, inSection: 0)
                let cell = filterKeyTable.cellForRowAtIndexPath(indexPath1) as! FilterKeyCell
                
                let indx : NSIndexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
                let valcell = filterValueTable.cellForRowAtIndexPath(indx) as! FilterValueCell
                let vendor  = reviewArray[indexPath.row] as! LstUserReview
                if valcell.uniqueId != nil
                {
                    if selReviewArray.containsObject(valcell.uniqueId){
                        valcell.chkBbtn.setImage(UIImage(named: "checkboxDisable.png"), forState: .Normal)
                        selReviewArray.removeObject(valcell.uniqueId)
                        if selReviewArray.count == 0{
                            cell.countBtn.badgeString = ""
                        }else{
                            cell.countBtn.badgeString = String(selReviewArray.count)
                            //cell.countBtn
                        }
                    }else{
                        valcell.chkBbtn.setImage(UIImage(named: "checkboxenable.png"), forState: .Normal)
                        //  selectedPriceArray.removeAllObjects()
                        // selectedPriceArray.addObject(valcell.uniqueId)
                        selReviewArray.removeAllObjects()
                        selReviewArray.addObject(valcell.uniqueId)
                        if selReviewArray.count == 0{
                            cell.countBtn.badgeString = ""
                        }else{
                            cell.countBtn.badgeString = String(selReviewArray.count)
                        }
                        cell.countBtn.badgeBackgroundColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                    }
                    
                }
            }
//            else if (optionSel == "Technical    Specs"){
//                 filterApplied = "spec"
//                let indexPat : NSIndexPath = NSIndexPath(forRow: 3, inSection: 0)
//                let cell = filterKeyTable.cellForRowAtIndexPath(indexPat) as! FilterKeyCell
//               
//                print("row -- \(indexPath.row)  section  \(indexPath.section)")
//                let indx : NSIndexPath = NSIndexPath(forRow: indexPath.row, inSection: indexPath.section)
//                let valcell = filterValueTable.cellForRowAtIndexPath(indx) as! FilterValueCell
//                if selectedTechSpecArray.containsObject(valcell.uniqueId){
//                    valcell.chkBbtn.setImage(UIImage(named: "checkboxDisable.png"), forState: .Normal)
//                    selectedTechSpecArray.removeObject(valcell.uniqueId)
//                    if selectedTechSpecArray.count == 0{
//                        cell.countBtn.badgeString = ""
//                    }else{
//                    cell.countBtn.badgeString = String(selectedTechSpecArray.count)
//                    }
//                    //cell.countBtn
//                    
//                }else{
//                    valcell.chkBbtn.setImage(UIImage(named: "checkboxenable.png"), forState: .Normal)
//                    selectedTechSpecArray.addObject(valcell.uniqueId)
//                    if selectedTechSpecArray.count == 0{
//                        cell.countBtn.badgeString = ""
//                    }else{
//                    cell.countBtn.badgeString = String(selectedTechSpecArray.count)
//                    }
//                    cell.countBtn.badgeBackgroundColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
//                }
//               // filterApplied = ""
//                
//            }
            else if(optionSel == "Category"){
                filterApplied = ""
                let indexPath1 : NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
                let cell = filterKeyTable.cellForRowAtIndexPath(indexPath1) as! FilterKeyCell
                

                let indx : NSIndexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
                let valcell = filterValueTable.cellForRowAtIndexPath(indx) as! FilterValueCell
               // valcell.chkBbtn.backgroundColor = UIColor.blueColor()
                if selectedCategoryArray.containsObject(valcell.uniqueId){
                    valcell.chkBbtn.setImage(UIImage(named: "checkboxDisable.png"), forState: .Normal)
                    selectedCategoryArray.removeObject(valcell.uniqueId)
                    if selectedCategoryArray.count == 0{
                        cell.countBtn.badgeString = ""
                    }else{
                    cell.countBtn.badgeString = String(selectedCategoryArray.count)
                    }
                    //cell.countBtn
                    
                }else{
                    valcell.chkBbtn.setImage(UIImage(named: "checkboxenable.png"), forState: .Normal)
                    selectedCategoryArray.removeAllObjects()
                    selectedCategoryArray.addObject(valcell.uniqueId)
                    if selectedCategoryArray.count == 0{
                        cell.countBtn.badgeString = ""
                    }else{
                    cell.countBtn.badgeString = String(selectedCategoryArray.count)
                    }
                    cell.countBtn.badgeBackgroundColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                }
            }else{
                filterApplied = "spec"
                let indexOfA = optionArray.indexOfObject(optionSel)
                let indexPat : NSIndexPath = NSIndexPath(forRow: indexOfA, inSection: 0)
                let cell = filterKeyTable.cellForRowAtIndexPath(indexPat) as? FilterKeyCell
                
               // print("row -- \(indexPath.row)  section  \(indexPath.section)")
                let indx : NSIndexPath = NSIndexPath(forRow: indexPath.row, inSection: indexPath.section)
                let valcell = filterValueTable.cellForRowAtIndexPath(indx) as! FilterValueCell
                if selectedTechSpecArray.containsObject(valcell.uniqueId){
                    valcell.chkBbtn.setImage(UIImage(named: "checkboxDisable.png"), forState: .Normal)
                    selectedTechSpecArray.removeObject(valcell.uniqueId)
                    if selectedTechSpecArray.count == 0{
                        cell?.countBtn.badgeString = ""
                    }else{
                        var i : Int! = 0
                        for (y,elemt) in selectedTech.enumerate() {
                           var rowData = selectedTech.objectAtIndex(y) as! LstTechOptions
                            for (z,elmt) in selectedTechSpecArray.enumerate() {
                                if rowData.dimensionValueId! == elmt as! String{
                                    i = i + 1
                                   // self.boolValue = true
                                }
                            }
                            //self.boolArray.append(self.boolValue)
                        }

                        
                        if(i != 0){
                            cell?.countBtn.badgeString = String(i)
                        }else{
                            cell?.countBtn.badgeString = ""
                        }
                    }
                    //cell.countBtn
                    
                }else{
                    valcell.chkBbtn.setImage(UIImage(named: "checkboxenable.png"), forState: .Normal)
                    selectedTechSpecArray.addObject(valcell.uniqueId)
                    if selectedTechSpecArray.count == 0{
                        cell?.countBtn.badgeString = ""
                    }else{
                        var i : Int! = 0
                        for (y,elemt) in selectedTech.enumerate() {
                            var rowData = selectedTech.objectAtIndex(y) as! LstTechOptions
                            for (z,elmt) in selectedTechSpecArray.enumerate() {
                                if rowData.dimensionValueId! == elmt as! String{
                                    i = i + 1
                                    // self.boolValue = true
                                }
                            }
                            //self.boolArray.append(self.boolValue)
                        }
                        if(i != 0){
                            cell?.countBtn.badgeString = String(i)
                        }else{
                            cell?.countBtn.badgeString = ""
                        }
                    }
                    cell?.countBtn.badgeBackgroundColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
                }
            }
            filterValueTable.reloadData()
        }else{
            let cell = filterKeyTable.cellForRowAtIndexPath(indexPath) as! FilterKeyCell
            cell.optionLabl.textColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
            optionSel = optionArray[indexPath.row] as! NSString
             cell.countBtn.badgeBackgroundColor = UIColor.init(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
            cell.contentView.backgroundColor = UIColor.whiteColor()
            cell.countBtn.badgeEdgeInsets =  UIEdgeInsetsMake(20, 0, 0, 20)
            
           
            let indexofA = optionArray.indexOfObject(optionSel)
            for i in 0..<optionArray.count{
                if(i==indexofA){
                    
                }else{
                    let indxPath1 : NSIndexPath = NSIndexPath(forRow: i, inSection: 0)
                    let cell = filterKeyTable.cellForRowAtIndexPath(indxPath1) as? FilterKeyCell
                    cell?.optionLabl.textColor = UIColor.darkGrayColor()
                    cell?.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
                    cell?.contentView.backgroundColor =  UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
                }
            }
            
            if(optionSel == "Brand"){

                
             filterApplied = "vendor"
            }else  if(optionSel == "Price"){

                filterApplied = "price"
            }
           else  if(optionSel == "Review"){

              filterApplied = "review"
            }
            else  if(optionSel == "Category"){

            }else{

                 filterApplied = "spec"
                let rowData = self.techSpecArray.objectAtIndex(indexPath.row - 4) as! LstTechSpecs
                selectedTech = NSMutableArray()
                selectedTech = rowData.lstTechOptions as! NSMutableArray
                filterValueTable.reloadData()
                //selectedTech = rowVal as! NSMutableArray
            }
             filterKeyTable.reloadData()
            filterValueTable.reloadData()
        }
     
        
    }
//    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        if(tableView == filterValueTable){
//           
//            if(optionSel == "Brand"){
//                
//                let indexPath : NSIndexPath = NSIndexPath(forRow: 1, inSection: 0)
//                let cell = filterKeyTable.cellForRowAtIndexPath(indexPath) as! FilterKeyCell
//                
//                 let vendor  = brandArray[indexPath.row] as! VndrList
//              
//                selectedBrandValArray.removeObject(vendor.vendorId!)
//                if let rows = self.filterValueTable.indexPathsForSelectedRows?.count{
//                    cell.countBtn.badgeString = String(rows)
//                }else{
//                    cell.countBtn.badgeString = ""
//                }
//                let indx : NSIndexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
//                let valcell = filterValueTable.cellForRowAtIndexPath(indx) as! FilterValueCell
//                valcell.chkBbtn.backgroundColor = UIColor.lightGrayColor()
//                
//            }else  if(optionSel == "Price"){
//                let indexPath : NSIndexPath = NSIndexPath(forRow: 2, inSection: 0)
//                let cell = filterKeyTable.cellForRowAtIndexPath(indexPath) as! FilterKeyCell
//                if let rows = self.filterValueTable.indexPathsForSelectedRows?.count{
//                    cell.countBtn.badgeString = String(rows)
//                }else{
//                    cell.countBtn.badgeString = ""
//                }
//                let price = priceRangeArray[indexPath.row] as! LstPices
//                selectedPriceArray.removeObject(price.name!)
//                let indx : NSIndexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
//                let valcell = filterValueTable.cellForRowAtIndexPath(indx) as! FilterValueCell
//                valcell.chkBbtn.backgroundColor = UIColor.lightGrayColor()
//            }
//            else if(optionSel == "Technical    Specs"){
//                // valueArray = option2Array
//                let indexPat : NSIndexPath = NSIndexPath(forRow: 3, inSection: 0)
//                let cell = filterKeyTable.cellForRowAtIndexPath(indexPat) as! FilterKeyCell
//                //let rows = self.filterValueTable.indexPathsForSelectedRows?.count
//                
//               
//               
//                let indx : NSIndexPath = NSIndexPath(forRow: indexPath.row, inSection: indexPath.section)
//                let valcell = filterValueTable.cellForRowAtIndexPath(indx) as! FilterValueCell
//                valcell.chkBbtn.backgroundColor = UIColor.lightGrayColor()
//                 selectedTechSpecArray.removeObject(valcell.uniqueId)
//                cell.countBtn.badgeString = String(selectedTechSpecArray.count)
//            }
//            else{
//                let indexPath : NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
//                let cell = filterKeyTable.cellForRowAtIndexPath(indexPath) as! FilterKeyCell
//                if let rows = self.filterValueTable.indexPathsForSelectedRows?.count{
//                    cell.countBtn.badgeString = String(rows)
//                }else{
//                    cell.countBtn.badgeString = ""
//                }
//                let price = categoryArray[indexPath.row] as! category3List
//                selectedCategoryArray.removeObject(price.category3Id!)
//                let indx : NSIndexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
//                let valcell = filterValueTable.cellForRowAtIndexPath(indx) as! FilterValueCell
//                valcell.chkBbtn.backgroundColor = UIColor.lightGrayColor()
//            }
//        }else{
//            let cell = filterKeyTable.cellForRowAtIndexPath(indexPath) as! FilterKeyCell
//            cell.optionLabl.textColor = UIColor.darkGrayColor()
//            cell.countBtn.badgeBackgroundColor = UIColor.darkGrayColor()
//        }
//        
//    }
    
    
    
//     func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
//    {
//        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
////        header.textLabel!.textColor = UIColor.darkGrayColor()
////        header.textLabel!.font = UIFont.boldSystemFontOfSize(14)
//       // header.textLabel!.frame = header.frame
//        //header.textLabel!.textAlignment = NSTextAlignment.Left
//        
////        let title = UILabel()
////        title.font = UIFont.boldSystemFontOfSize(14)
////        title.textColor = UIColor.darkGrayColor()
////        title.frame = CGRectMake(10, 0, 100, 20)
////        
////        let header = view as! UITableViewHeaderFooterView
////        header.textLabel?.font=title.font
////        header.textLabel?.textColor=title.textColor
////        header.addSubview(title)
//        //header.backgroundColor = UIColor(red: 238.0/255.0, green: 239.0/255.0, blue: 242.0/255.0, alpha: 1)
//        //header.contentView.backgroundColor = UIColor.clearColor()
//        //header.tintColor  = UIColor.clearColor()
//        
//        let border = CALayer()
//        let width = CGFloat(1.0)
//        border.borderColor = UIColor.darkGrayColor().CGColor
//        border.frame = CGRect(x: 0 , y: 0, width:  1, height: screenSize.height-60)
//        border.borderWidth = width
//        header.layer.addSublayer(border)
//    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{

        let headerFrame = tableView.frame
        
        let title = UILabel()
        title.frame =  CGRectMake(10, 5, headerFrame.size.width-20, 20) //width equals to parent view with 10 left and right margin
        title.font = UIFont.boldSystemFontOfSize(14)
        title.text = self.tableView(tableView, titleForHeaderInSection: section) //This will take title of section from 'titleForHeaderInSection' method or you can write directly
        title.textColor = UIColor.darkGrayColor()
        
        let headerView:UIView = UIView(frame: CGRectMake(0, 0, headerFrame.size.width, headerFrame.size.height))
        headerView.addSubview(title)
        headerView.backgroundColor = UIColor(red: 238.0/255.0, green: 239.0/255.0, blue: 242.0/255.0, alpha: 1)
        
        let border = CALayer()
                let width = CGFloat(1.0)
                border.borderColor = UIColor.lightGrayColor().CGColor
                border.frame = CGRect(x: 0 , y: 0, width:  1, height: screenSize.height-60)
                border.borderWidth = width
                headerView.layer.addSublayer(border)
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        if(optionSel == "Technical    Specs"){
            if(tableView == filterValueTable){
                return 30.0
            }
        }
        return 1
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        if(optionSel == "Technical    Specs"){
            if(tableView == filterValueTable){
                 let rowscnt = techSpecArray.objectAtIndex(section) as! LstTechSpecs
                return rowscnt.techName
            }
        }
        return ""
    }
    
    //    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
    //        return 0.0
    //    }
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

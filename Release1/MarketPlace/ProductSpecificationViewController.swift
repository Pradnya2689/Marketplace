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
    var descProd : NSMutableAttributedString!
    @IBOutlet var prodDetailSegment:UISegmentedControl!
    @IBOutlet var prodImg: UIImageView!
    @IBOutlet var prodTitle:UILabel!
    @IBOutlet var prodDetTxt:UITextView!
    var imgStr:String!=""
    var prodTitleStr:String!=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Product Details"
        
        if(self.descProd != nil){
            self.prodDetTxt.attributedText = self.descProd
        }else{
            self.prodDetTxt.text = "No Description"
        }
        self.prodTitle.text = self.prodTitleStr
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
    override func viewDidAppear(animated: Bool) {
        self.prodDetTable.rowHeight = UITableViewAutomaticDimension
        self.prodDetTable.estimatedRowHeight = 100
        prodDetTable.reloadData()
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 40.0
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(self.sheader.count > 0){
              return "  \(self.sheader[section].uppercaseString)"
        }
       
        return " "
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
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
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(self.sheader.count > 0){
        if(self.rowsinheader[section ].count ==  0){
            return 0.0
        }
        }
        return 30.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(self.sheader.count > 0){
              return self.rowsinheader[section].count
        }
    
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       // tableView.registerNib(UINib(nibName: "CustomViewCell", bundle: nil), forCellReuseIdentifier:"cell")
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! CustomViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        if(self.sheader.count == 0){
            cell.noResultLbl.text = "     Product doesnt have any specification."
            cell.noResultLbl.hidden = false
            
           // cell.valuelbl.text = "Product info"
            // cell.lbl.text = self.rowsinheader[indexPath.section][indexPath.row]
        }else{
            cell.noResultLbl.hidden = true
            
        cell.lbl.text = self.rowsinheader[indexPath.section][indexPath.row]
        var myString: String = self.rowsinheader[indexPath.section][indexPath.row]
        var myStringArr = myString.componentsSeparatedByString(":")
        
        
        let a =  myStringArr [1]
        let b =  myStringArr [0]
        
        let first = "    " + a
        let second = "    " + b
        
        cell.lbl.text =  "     " + myStringArr [1]
        cell.valuelbl.text =  "     " + myStringArr [0]
        
        }
        cell.contentView.layer.borderWidth = 0.4
        cell.contentView.layer.borderColor = UIColor (red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0).CGColor
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

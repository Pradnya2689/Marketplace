//
//  FreebieViewController.swift
//  MarketPlace
//
//  Created by pradnya on 08/11/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class FreebieViewController: UIViewController {

     @IBOutlet var freeBeTable:UITableView!
      var lstBasketArray:NSMutableArray!=NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Freebie Products"
        let button1 = UIBarButtonItem(image: UIImage(named: "closeBtn"), style: .Plain, target: self, action: #selector(FreebieViewController.btnaction)) // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.leftBarButtonItem  = button1
        self.navigationController!.navigationBar.tintColor = UIColor.blackColor()
        // Do any additional setup after loading the view.
    }
    func btnaction(){
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
            return 1
       
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return lstBasketArray.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCellWithIdentifier("freebrcel", forIndexPath: indexPath) as! FreeBeCell
            cell.selectionStyle = .None
            cell.prodNamelbl.text = self.lstBasketArray.valueForKey("description").objectAtIndex(indexPath.row) as? String
        
        if let prc = self.lstBasketArray.valueForKey("placedPriceDisplayString").objectAtIndex(indexPath.row) as? String{
            cell.prodPriceLbl.text = "₹ \(prc)"
            //cell.placedPrice = prc
        }else{
            cell.prodPriceLbl.text = ""
        }
            //cell.prodPriceLbl.text = "₹ \(self.lstBasketArray.valueForKey("placedPriceDisplayString").objectAtIndex(indexPath.row) as! String)"
            
            cell.qntBtn.layer.borderWidth = 1
            // self.QtyBtn.layer.borderColor = UIColor.blueColor().CGColor
            cell.qntBtn.layer.borderColor = UIColor (red: 31/255.0, green: 75/255.0, blue: 164/255.0, alpha: 1.0).CGColor
            cell.qntBtn.titleLabel?.textAlignment = NSTextAlignment.Center
            
            
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

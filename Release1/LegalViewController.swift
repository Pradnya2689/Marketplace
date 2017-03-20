//
//  LegalViewController.swift
//  MarketPlace
//
//  Created by Administrator on 05/12/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class LegalViewController: UIViewController {
    
    
    var label = ["Privacy Policy","Refund And Cancellation Policy","Shipping And Delivery Policy"]

    override func viewDidLoad() {
        super.viewDidLoad()

         self.title = "Legal"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName : headerColor,
             NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 20)!]
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

extension LegalViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return label.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("legalID", forIndexPath: indexPath) as! LegalTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.legalNameLabel.text = label[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        if (indexPath?.row == 0)
        {
                let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("policyView") as? PolicyViewController
                AccountSettingObj?.iscalledPolicy = "PrivacyPolicy"
                // let NavigationController = UINavigationController(rootViewController: AccountSettingObj!)
                //   self.presentViewController(NavigationController, animated: true, completion: nil)
                self.navigationController?.pushViewController(AccountSettingObj!, animated: true)
        }
        if(indexPath?.row == 1){
            let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("policyView") as? PolicyViewController
            AccountSettingObj?.iscalledPolicy = "refund"
            // let NavigationController = UINavigationController(rootViewController: AccountSettingObj!)
            //   self.presentViewController(NavigationController, animated: true, completion: nil)
            self.navigationController?.pushViewController(AccountSettingObj!, animated: true)

        }
        if(indexPath?.row == 2){
            let AccountSettingObj = self.storyboard?.instantiateViewControllerWithIdentifier("policyView") as? PolicyViewController
            AccountSettingObj?.iscalledPolicy = "shipping"
            // let NavigationController = UINavigationController(rootViewController: AccountSettingObj!)
            //   self.presentViewController(NavigationController, animated: true, completion: nil)
            self.navigationController?.pushViewController(AccountSettingObj!, animated: true)

        }
        
        
    }
}
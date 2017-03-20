//
//  ViewController.swift
//  Myaccount
//
//  Created by Developer on 8/12/16.
//  Copyright © 2016 Ingram. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController {
    
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var accountTableView: UITableView!
    
    @IBOutlet weak var profileHeader: UIView!
    
    
    
    var labels = ["My Profile", "My Location", "My Orders", "Wishlist", "Notification", "Logout"]
    var labels1 = ["My Profile", "My Location", "My Orders", "Wishlist", "Notification", "Login"]
    
    
    var photo = [UIImage(named: "user"), UIImage(named: "location"), UIImage(named: "order"), UIImage(named: "wishlist"), UIImage(named: "notification"), UIImage(named: "logout")]
    
    override func viewDidLoad()
    
    {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        // Do any additional setup after loading the view, typically from a nib.
        // accountTableView.tableHeaderView = profileHeader
        
        profileImg.layer.cornerRadius = 30.0
        profileImg.clipsToBounds = true
        
//        accountTableView.layoutMargins = UIEdgeInsetsZero
//        accountTableView.separatorInset = UIEdgeInsetsZero
//        accountTableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
        //accountTableView.preservesSuperviewLayoutMargins = false;
        accountTableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension MyAccountViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return profileHeader
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 170.0
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("accountId", forIndexPath: indexPath) as! AccountCell
        cell.cellPhoto.image = photo[indexPath.row]
        
        let defaults = NSUserDefaults.standardUserDefaults()
           if let usernm = defaults.valueForKey("email") , let pwd = defaults.valueForKey("password"),let fullname = defaults.valueForKey("fullname")
            {
        cell.accountLabel.text = labels[indexPath.row]
        }
        else
           {
         cell.accountLabel.text = labels1[indexPath.row]
        
        }
        // cell.preservesSuperviewLayoutMargins = false;
        cell.layoutMargins = UIEdgeInsetsZero
        
        if indexPath.row == 1{
            cell.locaationLabel.hidden = false
            return cell
        }else{
            cell.locaationLabel.hidden = true
            return cell
        }
    }
    
}

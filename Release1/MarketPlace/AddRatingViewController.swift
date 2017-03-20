//
//  AddRatingViewController.swift
//  MarketPlace
//
//  Created by pradnya on 19/09/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit

class AddRatingViewController: UIViewController,UIGestureRecognizerDelegate {
    @IBOutlet var innerView:UIView!
    @IBOutlet var givRatingView:FloatRatingView!
    @IBOutlet var titileLbl:UITextField!
    @IBOutlet var decrLbl:UITextField!
    @IBOutlet var errorLbl:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.navigationController?.navigationBar.hidden = true
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.dismissViewControllerAnimated(false, completion: nil)
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

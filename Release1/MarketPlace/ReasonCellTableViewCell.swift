//
//  ReasonCellTableViewCell.swift
//  MarketPlace
//
//  Created by Administrator on 28/09/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
@objc protocol returnRequestDelegate
{
    //optional  func ratebuttonClicked(orderId:String,customerLineNumber:String)
    optional  func returnreasonbuttonClicked(val:String)
    
}
class ReasonCellTableViewCell: UITableViewCell {

    @IBOutlet weak var chkBoxBtn1: UIButton!
    @IBOutlet weak var chkBoxBtn2: UIButton!
    @IBOutlet weak var chkBoxBtn3: UIButton!
    weak var delegates:returnRequestDelegate!
    
    @IBAction func reason1Action(sender: AnyObject) {
        
        if chkBoxBtn1.currentImage!.isEqual(UIImage(named: "checkboxDisable.png")){
            
            chkBoxBtn1.setImage(UIImage(named: "checkboxenable.png"), forState: UIControlState.Normal)
            chkBoxBtn2.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
            chkBoxBtn3.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
            self.delegates.returnreasonbuttonClicked!("MP1")
        }else{
            
            chkBoxBtn1.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
            chkBoxBtn2.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
            chkBoxBtn3.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
            self.delegates.returnreasonbuttonClicked!("")
        }


    }
    
    @IBAction func reason2Action(sender: AnyObject) {
        if chkBoxBtn2.currentImage!.isEqual(UIImage(named: "checkboxDisable.png")){
            
            chkBoxBtn2.setImage(UIImage(named: "checkboxenable.png"), forState: UIControlState.Normal)
            chkBoxBtn1.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
            chkBoxBtn3.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
            self.delegates.returnreasonbuttonClicked!("MP2")
            
        }else{
            
            chkBoxBtn2.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
            chkBoxBtn1.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
            chkBoxBtn3.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
            self.delegates.returnreasonbuttonClicked!("")
        }
        
    }
    
    @IBAction func reason3Action(sender: AnyObject) {
        
        if chkBoxBtn3.currentImage!.isEqual(UIImage(named: "checkboxDisable.png")){
            
            chkBoxBtn3.setImage(UIImage(named: "checkboxenable.png"), forState: UIControlState.Normal)
            chkBoxBtn1.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
            chkBoxBtn2.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
            self.delegates.returnreasonbuttonClicked!("MP3")
        }else{
            
            chkBoxBtn3.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
            chkBoxBtn1.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
            chkBoxBtn2.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
            self.delegates.returnreasonbuttonClicked!("")
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

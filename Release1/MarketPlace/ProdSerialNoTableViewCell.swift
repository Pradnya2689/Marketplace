//
//  ProdSerialNoTableViewCell.swift
//  MarketPlace
//
//  Created by Administrator on 28/09/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
@objc protocol returnProdRequestDelegate
{
    //optional  func ratebuttonClicked(orderId:String,customerLineNumber:String)
    optional  func prodselectedbuttonClicked(val:String)
    optional  func prodUnselectedbuttonClicked(val:String)
    
}
class ProdSerialNoTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBoxBtn: UIButton!
    @IBOutlet weak var checkbox1Btn: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberLabel1: UILabel!
    weak var delegates:returnProdRequestDelegate?
    var isChecked:Bool = true
    
    
        @IBAction func chkAction1(sender: AnyObject) {
            
            if checkBoxBtn.currentImage!.isEqual(UIImage(named: "checkboxDisable.png")){
                
                checkBoxBtn.setImage(UIImage(named: "checkboxenable.png"), forState: UIControlState.Normal)
                self.delegates?.prodselectedbuttonClicked!(self.numberLabel.text!)

            }else{
                
                checkBoxBtn.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
                self.delegates?.prodUnselectedbuttonClicked!(self.numberLabel.text!)
            }
        
    }
    
    @IBAction func chkAction2(sender: AnyObject) {
        
        if checkbox1Btn.currentImage!.isEqual(UIImage(named: "checkboxDisable.png")){
            
            checkbox1Btn.setImage(UIImage(named: "checkboxenable.png"), forState: UIControlState.Normal)
            self.delegates?.prodselectedbuttonClicked!(self.numberLabel1.text!)
            
        }else{
            
            checkbox1Btn.setImage(UIImage(named: "checkboxDisable.png"), forState: UIControlState.Normal)
             self.delegates?.prodUnselectedbuttonClicked!(self.numberLabel1.text!)
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

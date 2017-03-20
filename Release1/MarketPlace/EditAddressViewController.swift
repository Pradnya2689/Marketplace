//
//  EditAddressViewController.swift
//  MarketPlace
//
//  Created by Administrator on 25/08/16.
//  Copyright © 2016 inpanr07. All rights reserved.
//

import UIKit
import ObjectMapper

class Country: Mappable {
    var stateCode: String?
    var stateId: String?
    var stateName: String?
   
    //
    required init?(_ map: Map){
        
    }
    //
    func mapping(map: Map) {
        stateCode <- map["stateCode"]
        stateId <- map["stateId"]
        stateName <- map["stateName"]
//        subCategory <- map["subCategory"]
    }
}


class EditAddressViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate,webServiceDelegate{
    
    @IBOutlet weak var editScrollView: UIScrollView!
    @IBOutlet weak var editAddressView: UIView!
    @IBOutlet weak var addSegmentoutlet: UISegmentedControl!
    @IBOutlet weak var addressTableView: UITableView!
    @IBOutlet weak var addressBookView: UIView!
    
    var arrayCities : NSMutableArray = NSMutableArray()
    @IBAction func addressSegment(sender: UISegmentedControl) {
        

        print(EditFlag)
        if (EditFlag == "EditOff")
        {
            self.stateTF.text = ""
            self.cityTF.text = ""
            self.pincodeTF.text = ""
            self.landmarkTF.text = ""
            self.streetAddressTF.text = ""
            self.addTitleTF.text = ""
            self.addViewNameTF.text = ""
            
            switch addSegmentoutlet.selectedSegmentIndex
            {
            case 0:
                addressBookView.hidden = false
                editAddressView.hidden = true
            case 1:
                editAddressView.hidden = false
                addressBookView.hidden = true
            default:
                break;
            }
            
        }
        else
        {
            
            switch addSegmentoutlet.selectedSegmentIndex
            {
            case 0:
                EditFlag = "EditOff"
                addressBookView.hidden = false
                editAddressView.hidden = true
            case 1:
                editAddressView.hidden = false
                addressBookView.hidden = true
            default:
                break;
                
                
            }
        }

    }
    
    @IBOutlet weak var addTitleTF: UITextField!
    
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var pincodeTF: UITextField!
    @IBOutlet weak var landmarkTF: UITextField!
    @IBOutlet weak var streetAddressTF: UITextField!
    @IBOutlet weak var addViewNameTF: UITextField!
    
    
    @IBOutlet weak var titleLabel1: UILabel!
    @IBOutlet weak var streetLabel3: UILabel!
    @IBOutlet weak var landmarkLabel4: UILabel!
    @IBOutlet weak var pincodeLabel5: UILabel!
    @IBOutlet weak var cityLabel6: UILabel!
    @IBOutlet weak var stateLabel7: UILabel!
    @IBOutlet weak var nameLabel2: UILabel!
    let boundss = UIScreen.mainScreen().bounds
    let wsm : WebServiceClass = WebServiceClass.sharedInstance
    
    
    var NoAddrFlag : String!
    var UID : Int!
    var USRID : String!
    var stateID : String!
      var addressIDEdit : String!=""
     var EditFlag : String!
    var isdeault : Bool!
    
    
   // var AddressRow: [Int] = [1,2]
    var AddressRow : NSMutableArray = NSMutableArray()
    var AddressRow1 : NSMutableArray = NSMutableArray()
    var stateDict:NSDictionary=NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(EditAddressViewController.getStateApiResponse(_:)),
                                                         name: "stateResp",
                                                         object: nil)
      
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditAddressViewController.AddressList(_:)), name: "refresh1", object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "country", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditAddressViewController.countryList(_:)), name: "country", object: nil)
        

        let titleAddress = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        titleAddress.font = UIFont(name: "MyriadPro-Regular", size: 20.0)
        titleAddress.textColor = headerColor
        titleAddress.text = "My Addresses"
        self.navigationItem.titleView = titleAddress
        self.addSegmentoutlet.selectedSegmentIndex = 0;
        wsm.delegates=self
        // Do any additional setup after loading the view.
        
        editAddressView.hidden = true
        addressTableView.hidden = true
        self.EditFlag = "EditOff"
        if (self.NoAddrFlag == "NoAddress")
        {
            print("NoAddress")
            self.addSegmentoutlet.selectedSegmentIndex = 1;
            self.addSegmentoutlet .setEnabled(false, forSegmentAtIndex: 0)
//           
            self.addSegmentoutlet.sendActionsForControlEvents(UIControlEvents.ValueChanged)
            
           
        }
        else if (self.NoAddrFlag == "Address")
        {
        print("Address")
            self.addSegmentoutlet .setEnabled(true, forSegmentAtIndex: 0)
            self.addSegmentoutlet.selectedSegmentIndex = 0;
            self.addSegmentoutlet.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        
        let wsm : WebServiceClass = WebServiceClass.sharedInstance
        wsm.delegates=self
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let data = defaults.objectForKey("LoginObject") as? NSData
        {
            //            let unarc = NSKeyedUnarchiver(forReadingWithData: data)
            // let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
            
            if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
            {
                //self.UID = blog.valueForKey("userId")! as! Int
                var myString = String(blog.valueForKey("userId")! as! Int)
                self.USRID = myString
                dispatch_async(dispatch_get_main_queue())
                {
                LoadingOverlay.shared.showOverlay(self.view)
                }
                 wsm.delegates=self
                wsm.callAdressApiForEdit(blog.valueForKey("userId")! as! Int)
                
            }}
        }
        else if (self.NoAddrFlag == "ChangeAdressCheckout")
        {
            let wsm : WebServiceClass = WebServiceClass.sharedInstance
            wsm.delegates=self
            let defaults = NSUserDefaults.standardUserDefaults()
            if let userId = defaults.objectForKey("userId") as? Int
            {
    
                dispatch_async(dispatch_get_main_queue())
                {
                    LoadingOverlay.shared.showOverlay(self.view)
                }
                 wsm.delegates=self
                    wsm.callAdressApiForEdit(userId)
                    
                }
            
    }
        let tap = UITapGestureRecognizer(target: self, action: #selector(EditAddressViewController.handleTap(_:)))
        tap.delegate = self
        editScrollView.addGestureRecognizer(tap)
        
        let contentInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        self.editScrollView.contentInset = contentInsets
        self.editScrollView.scrollIndicatorInsets = contentInsets
        
        if(screenSize.width == 320){
            let contentInsets = UIEdgeInsetsMake(0, 0, 150, 0)
            self.editScrollView.contentInset = contentInsets
            self.editScrollView.scrollIndicatorInsets = contentInsets
        }
        
//        if(AddressRow1.count == 0){
//             self.addSegmentoutlet.selectedSegmentIndex = 1;
//            editAddressView.hidden = false
//            addressBookView.hidden = true
//        }
        let keyboardDoneButtonView = UIToolbar.init()
        keyboardDoneButtonView.sizeToFit()
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done,
                                              target: self,
                                              action: #selector(doneClicked))
        let doneButton1 = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace,
                                              target: nil,
                                              action: nil)
        doneButton1.width = screenWidth-80
        keyboardDoneButtonView.items = [doneButton1,doneButton]
        pincodeTF.inputAccessoryView = keyboardDoneButtonView
        
        addSegmentoutlet.hidden = false
        
//        let wsmm : WebServiceClass = WebServiceClass.sharedInstance
//       wsmm.callstateApii()

        //citystateResp
    }
    func doneClicked(sender: AnyObject) {
        self.view.endEditing(true)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyboardNotifications()
          NSNotificationCenter.defaultCenter().removeObserver(self, name: "cityResp", object: nil)
         NSNotificationCenter.defaultCenter().removeObserver(self, name: "citystateResp", object: nil)
    }
    
    func registerKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    func  callAddressapiFailedDelegate()
    {
        print("ERROR")
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "IMOL"
        alertView.message = ConstantsFile.requestFail_msg
        alertView.delegate = nil
        alertView.addButtonWithTitle("OK")
        alertView.show()
        
        
    }
    func unregisterKeyboardNotifications() {
        //NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo!
        let keyboardSize = userInfo.objectForKey(UIKeyboardFrameBeginUserInfoKey)!.CGRectValue.size
        let contentInsets = UIEdgeInsetsMake(0, 0, 180, 0)
        self.editScrollView.contentInset = contentInsets
        self.editScrollView.scrollIndicatorInsets = contentInsets
        
        var viewRect = view.frame
        viewRect.size.height -= keyboardSize.height
        
    
    }
    
    
    func keyboardWillHide(notification: NSNotification)
    {
//        self.editScrollView.contentInset = UIEdgeInsetsZero
//        self.editScrollView.scrollIndicatorInsets = UIEdgeInsetsZero
        
    }

    override func  viewWillAppear(animated: Bool)
    {
        let wsmm : WebServiceClass = WebServiceClass.sharedInstance
        wsmm.callstateApii()
        //super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
       
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(EditAddressViewController.getCityApiResponse(_:)),
                                                         name: "cityResp",
                                                         object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(EditAddressViewController.getCityStateApiResponse(_:)),
                                                         name: "citystateResp",
                                                         object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "country", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditAddressViewController.countryList(_:)), name: "country", object: nil)
//
//         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditAddressViewController.countryList(_:)), name: "country", object: nil)
        //super.viewWillAppear(animated)country
        self.tabBarController?.tabBar.hidden = false
       
         registerKeyboardNotifications()
        
    }
    
    func AddressList(notification: NSNotification)
    {
         LoadingOverlay.shared.hideOverlayView()
        let dict : AnyObject = notification.userInfo!
        let receivednumber : String = dict["valueToPass"] as! String
        
        self.cityTF.text = receivednumber
        var escapepercent = receivednumber.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
         wsm.delegates=self
        wsm.callCityApiTogetState(escapepercent)
        print("****** \(escapepercent)")
    }
    func countryList(notification: NSNotification)
    {
         LoadingOverlay.shared.hideOverlayView()
        let dict : AnyObject = notification.userInfo!
       // let receivednumber : String = dict["valueToPass"] as! String
         let receivednumber1  = dict["valueToPass"] as! NSDictionary
        if let STAid = receivednumber1["stateId"]
        {
            
            self.stateID = STAid as! String
            // self.tableArr.addObject(add!)
        }
        if let add = receivednumber1["stateName"]
        {
            
            self.stateTF.text = add as! String
           // self.tableArr.addObject(add!)
        }
        
//        self.stateTF.text = receivednumber
//        print(receivednumber)
    }
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        addTitleTF.resignFirstResponder()
        addViewNameTF.resignFirstResponder()
        streetAddressTF.resignFirstResponder()
        landmarkTF.resignFirstResponder()
        pincodeTF.resignFirstResponder()
        cityTF.resignFirstResponder()
        stateTF.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {

        switch textField{
        case addTitleTF :
            titleLabel1.backgroundColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
        case addViewNameTF :
            nameLabel2.backgroundColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
        case streetAddressTF :
            streetLabel3.backgroundColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
        case landmarkTF:
            landmarkLabel4.backgroundColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
        case pincodeTF:
            pincodeLabel5.backgroundColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
        case cityTF :
             LoadingOverlay.shared.showOverlay(view)
             wsm.callCityApi()
             

            cityLabel6.backgroundColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
        case stateTF:
            // LoadingOverlay.shared.showOverlay(view)
            
             let SearchAddressControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("SearchAddress") as? SearchAddressController
             print(arrayCountries)
             SearchAddressControllerObj?.countryToPass = arrayCountries
             SearchAddressControllerObj?.flagset = "country"
             
             let NavigationController = UINavigationController(rootViewController: SearchAddressControllerObj!)
             self.presentViewController(NavigationController, animated: true, completion: nil)

            stateLabel7.backgroundColor = UIColor(red: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
        default :
            print("")

        }

    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        switch textField{
        case addTitleTF :
            titleLabel1.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
        case addViewNameTF :
            nameLabel2.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
        case streetAddressTF :
            streetLabel3.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
        case landmarkTF:
            landmarkLabel4.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
        case pincodeTF:
            pincodeLabel5.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
        case cityTF :
            cityLabel6.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
        case stateTF:
            stateLabel7.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
        default :
            print("")
            
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.addTitleTF {
            let currentCharacterCount = self.addTitleTF.text?.characters.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.characters.count - range.length
            return newLength <= 20
        }
        
        if textField == self.addViewNameTF {
            let currentCharacterCount = self.addViewNameTF.text?.characters.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.characters.count - range.length
            return newLength <= 35
        }
        
        if textField == self.streetAddressTF {
            let currentCharacterCount = self.streetAddressTF.text?.characters.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.characters.count - range.length
            return newLength <= 70
        }
        
        if textField == self.landmarkTF {
            let currentCharacterCount = self.landmarkTF.text?.characters.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.characters.count - range.length
            return newLength <= 35
        }
        
        if textField == self.pincodeTF {
            let currentCharacterCount = self.pincodeTF.text?.characters.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.characters.count - range.length
            return newLength <= 6
        }
        
        return true
    }
    
    func moveTextField(textField: UITextField, moveDistance: Int, up: Bool){
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        UIView.commitAnimations()
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


extension EditAddressViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return AddressRow.count
        }else{
            return AddressRow1.count
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (self.NoAddrFlag == "ChangeAdressCheckout")
        {
            
            return 110.0

        }
        return 160.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("addressCell", forIndexPath: indexPath) as! AddressTableViewCell
        
        if (self.NoAddrFlag == "ChangeAdressCheckout")
        {
            tableView.allowsSelection = true
            
        }else{
             tableView.allowsSelection = false
        }
       // cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        if (self.NoAddrFlag == "ChangeAdressCheckout")
        {
            cell.addEditBtn.hidden = true
            cell.addSetBtn.hidden = true
            cell.deleteBtn.hidden = true
            cell.separatorLabel.translatesAutoresizingMaskIntoConstraints = true
            cell.separatorLabel.frame = CGRectMake(0, 100, screenWidth, 1)
            
            if indexPath.section == 0{
                cell.addTitleLabel.text = self.AddressRow.objectAtIndex(indexPath.row).valueForKey("title") as! String
                cell.addNameLabel.text = self.AddressRow.objectAtIndex(indexPath.row).valueForKey("name") as! String
                let address = "\(self.AddressRow.objectAtIndex(indexPath.row).valueForKey("address1") as! String), \(self.AddressRow.objectAtIndex(indexPath.row).valueForKey("area") as! String), \( self.AddressRow.objectAtIndex(indexPath.row).valueForKey("city") as! String), \(self.AddressRow.objectAtIndex(indexPath.row).valueForKey("stateName") as! String), \(self.AddressRow.objectAtIndex(indexPath.row).valueForKey("zipCode") as! String)"
                cell.editaddressLabel.text = address
                //            cell.addEditBtn.hidden = false
                //            cell.deleteBtn.hidden = true
                // cell.editaddressLabel.text = "Ingram Micro India SSC Ltd,Unit No 202, Akruti Corporation park, G.E.Gardens, Kanjurmarg, Mumbai, MAHARASHTRA(400078)"
                //      return cell
            }
            else
            {
               
                cell.addTitleLabel.text = self.AddressRow1.objectAtIndex(indexPath.row).valueForKey("title") as! String
                cell.addNameLabel.text = self.AddressRow1.objectAtIndex(indexPath.row).valueForKey("name") as! String
                let address = "\(self.AddressRow1.objectAtIndex(indexPath.row).valueForKey("address1") as! String), \(self.AddressRow1.objectAtIndex(indexPath.row).valueForKey("area") as! String), \( self.AddressRow1.objectAtIndex(indexPath.row).valueForKey("city") as! String), \(self.AddressRow1.objectAtIndex(indexPath.row).valueForKey("stateName") as! String), \(self.AddressRow1.objectAtIndex(indexPath.row).valueForKey("zipCode") as! String)"
                
                
                cell.editaddressLabel.text = address
                //          return cell
                
            }
        }
        else
       {
        cell.addEditBtn.tag = indexPath.row
        cell.addEditBtn.addTarget(self, action: "EditbuttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.addSetBtn.addTarget(self, action: "SetDefaultAdressClicked:", forControlEvents: UIControlEvents.TouchUpInside)
         cell.deleteBtn.addTarget(self, action: "DeleteAdressClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.addEditBtn.hidden = false
        
         if indexPath.section == 0{
            cell.addSetBtn.hidden = true
            cell.deleteBtn.hidden = true
            cell.addTitleLabel.text = self.AddressRow.objectAtIndex(indexPath.row).valueForKey("title") as! String
            cell.addNameLabel.text = self.AddressRow.objectAtIndex(indexPath.row).valueForKey("name") as! String
            let address = "\(self.AddressRow.objectAtIndex(indexPath.row).valueForKey("address1") as! String), \(self.AddressRow.objectAtIndex(indexPath.row).valueForKey("area") as! String), \( self.AddressRow.objectAtIndex(indexPath.row).valueForKey("city") as! String), \(self.AddressRow.objectAtIndex(indexPath.row).valueForKey("stateName") as! String), \(self.AddressRow.objectAtIndex(indexPath.row).valueForKey("zipCode") as! String)"
            cell.editaddressLabel.text = address
//            cell.addEditBtn.hidden = false
//            cell.deleteBtn.hidden = true
           // cell.editaddressLabel.text = "Ingram Micro India SSC Ltd,Unit No 202, Akruti Corporation park, G.E.Gardens, Kanjurmarg, Mumbai, MAHARASHTRA(400078)"
//      return cell
        }
         else
         {
            cell.addSetBtn.hidden = false
            cell.deleteBtn.hidden = false
            cell.addTitleLabel.text = self.AddressRow1.objectAtIndex(indexPath.row).valueForKey("title") as! String
            cell.addNameLabel.text = self.AddressRow1.objectAtIndex(indexPath.row).valueForKey("name") as! String
            let address = "\(self.AddressRow1.objectAtIndex(indexPath.row).valueForKey("address1") as! String), \(self.AddressRow1.objectAtIndex(indexPath.row).valueForKey("area") as! String), \( self.AddressRow1.objectAtIndex(indexPath.row).valueForKey("city") as! String), \(self.AddressRow1.objectAtIndex(indexPath.row).valueForKey("stateName") as! String), \(self.AddressRow1.objectAtIndex(indexPath.row).valueForKey("zipCode") as! String)"
            
            cell.editaddressLabel.text = address
//          return cell
            
        }
        
        }
   return cell
    }
    func cancelClicked()
    {
         LoadingOverlay.shared.hideOverlayView()
        self.dismissViewControllerAnimated(true, completion: nil)
                
    }
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0{
//            return "DEFAULT ADDRESS"
//        }else{
//            if (self.AddressRow1.count == 0)
//            {
//                 return ""
//            }
//            return "OTHER ADDRESSES"
//        }
//    }

    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerVc = UIView.init(frame: CGRectMake(0, 0, boundss.width, 30))
        let title = UILabel()
        title.frame = CGRectMake(0, 0, boundss.width, 30)
        title.textColor = UIColor.darkGrayColor()
        if section == 0{
            title.text = "  DEFAULT ADDRESS"
        }else{
            if (self.AddressRow1.count == 0)
            {
                title.text = ""
            }
            else
            {
            title.text = "  OTHER ADDRESSES"
            }
        }
         title.backgroundColor = UIColor(red: 238.0/255.0, green: 239.0/255.0, blue: 242.0/255.0, alpha: 1)
        headerVc.addSubview(title)
        return headerVc
    }
//    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
//    {
//        let title = UILabel()
//        title.font = UIFont(name: "MyriadPro-Regular", size: 17)!
//       
//        let header = view as! UITableViewHeaderFooterView
//        header.textLabel?.font=title.font
//        header.textLabel?.textColor=title.textColor
//        title.backgroundColor = UIColor(red: 238.0/255.0, green: 239.0/255.0, blue: 242.0/255.0, alpha: 1)
//        header.addSubview(title)
//       // header.contentView.backgroundColor = UIColor.clearColor()
//        header.tintColor  = UIColor.clearColor()
//
//    }
    
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.tintColor = UIColor.clearColor()

    }
    
//     func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        
//        if indexPath.section == 1{
//        cell.contentView.backgroundColor = UIColor.clearColor()
//        
//        let whiteRoundedView : UIView = UIView(frame: CGRectMake(0, 50, self.view.frame.size.width, 50))
//        
//        whiteRoundedView.layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 1.0, 1.0, 1.0])
//        whiteRoundedView.layer.masksToBounds = false
//        whiteRoundedView.layer.cornerRadius = 2.0
//        whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
//        whiteRoundedView.layer.shadowOpacity = 0.2
//        
//        cell.contentView.addSubview(whiteRoundedView)
//       // cell.contentView.sendSubviewToBack(whiteRoundedView)
//        }
//    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
       
        let cell = tableView.dequeueReusableCellWithIdentifier("addressCell", forIndexPath: indexPath) as! AddressTableViewCell
        //cell.selectionStyle = UITableViewCellSelectionStyle.None
        if (self.NoAddrFlag == "ChangeAdressCheckout")
        {
            
        
        if indexPath.section == 0
        {
            cell.addEditBtn.hidden = true
            cell.addSetBtn.hidden = true
            cell.deleteBtn.hidden = true
             NSNotificationCenter.defaultCenter().postNotificationName("SelectedAddress", object: nil, userInfo: ["valueToPass":self.AddressRow.objectAtIndex(0)])
            

            //self.AddressRow.objectAtIndex(indexPath.row)
        }
        else if indexPath.section == 1
        {
            cell.addEditBtn.hidden = true
            cell.addSetBtn.hidden = true
            cell.deleteBtn.hidden = true
            
             NSNotificationCenter.defaultCenter().postNotificationName("SelectedAddress", object: nil, userInfo: ["valueToPass":self.AddressRow1.objectAtIndex(indexPath.row)])
        
        }
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
////         let cell = tableView.dequeueReusableCellWithIdentifier("addressCell", forIndexPath: indexPath) as! AddressTableViewCell
////        cell.addEditBtn.addTarget(self, action: #selector(EditAddressViewController.addmethod), forControlEvents: UIControlEvents.TouchUpInside)
//        
//        let indexPath = NSIndexPath(forRow: 1, inSection: 0)
//        let cell = tableView.cellForRowAtIndexPath(indexPath) as! AddressTableViewCell
//        
//    }
    func EditbuttonClicked(sender:UIButton) {
        
        self.EditFlag = "EditOn"
        let buttonRow = sender.tag
        let buttonPosition = sender.convertPoint(CGPointZero, toView: self.addressTableView)
        let indexPath = self.addressTableView.indexPathForRowAtPoint(buttonPosition)
        print(indexPath?.section)
        print(indexPath?.row)
        if indexPath != nil {
        
        
        //if indexPath?.row == 0 && indexPath?.section == 0
          if  indexPath?.section == 0
         {
        self.addTitleTF.text = self.AddressRow.objectAtIndex(0).valueForKey("title") as! String
            self.addViewNameTF.text = self.AddressRow.objectAtIndex(0).valueForKey("name") as! String
             self.streetAddressTF.text = self.AddressRow.objectAtIndex(0).valueForKey("address1") as! String
             self.landmarkTF.text = self.AddressRow.objectAtIndex(0).valueForKey("area") as! String
             self.pincodeTF.text = self.AddressRow.objectAtIndex(0).valueForKey("zipCode") as! String
             self.cityTF.text = self.AddressRow.objectAtIndex(0).valueForKey("city") as! String
             self.stateTF.text = self.AddressRow.objectAtIndex(0).valueForKey("stateName") as! String
            self.addressIDEdit = self.AddressRow.objectAtIndex(0).valueForKey("addressId") as! String
            self.stateID = self.AddressRow.objectAtIndex(0).valueForKey("stateId") as! String
            
            self.isdeault = true
//             self.addViewNameTF.text = self.AddressRow.objectAtIndex(0).valueForKey("name") as! String
        }
        else  if  indexPath?.section == 1
        {
            self.addTitleTF.text = self.AddressRow1.objectAtIndex((indexPath?.row)!).valueForKey("title") as! String
            self.addViewNameTF.text = self.AddressRow1.objectAtIndex((indexPath?.row)!).valueForKey("name") as! String
            self.streetAddressTF.text = self.AddressRow1.objectAtIndex((indexPath?.row)!).valueForKey("address1") as! String
            self.landmarkTF.text = self.AddressRow1.objectAtIndex((indexPath?.row)!).valueForKey("area") as! String
            self.pincodeTF.text = self.AddressRow1.objectAtIndex((indexPath?.row)!).valueForKey("zipCode") as! String
            self.cityTF.text = self.AddressRow1.objectAtIndex((indexPath?.row)!).valueForKey("city") as! String
            self.stateTF.text = self.AddressRow1.objectAtIndex((indexPath?.row)!).valueForKey("stateName") as! String
            self.addressIDEdit = self.AddressRow1.objectAtIndex((indexPath?.row)!).valueForKey("addressId") as! String
            self.stateID = self.AddressRow1.objectAtIndex((indexPath?.row)!).valueForKey("stateId") as! String
             self.isdeault = false
        }
               self.addSegmentoutlet.selectedSegmentIndex = 1;
        self.addSegmentoutlet.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        
        }
    }
    
    @IBAction func SaveAddressClicked(sender: AnyObject) {
        
       // print(UID)
//        print(self.stateID)
//        print(self.streetAddressTF.text!)
//        print(self.landmarkTF.text!)
//        print(self.cityTF.text!)
//        print(self.addViewNameTF.text!)
//        print(self.addTitleTF.text!)
//        print(self.pincodeTF.text!)
//        print(self.addressIDEdit)
//        print(USRID)
        if let titletext = self.addTitleTF.text where !titletext.isEmpty ,  let Nametext = self.addViewNameTF.text where !Nametext.isEmpty, let streetAddressText = self.streetAddressTF.text where !streetAddressText.isEmpty ,  let landmarktext = self.landmarkTF.text  where !landmarktext.isEmpty ,  let pincode = self.pincodeTF.text where !pincode.isEmpty,  let citytext = self.cityTF.text  where !citytext.isEmpty,  let statetext = self.stateTF.text where !statetext.isEmpty
        {
        
        if (EditFlag == "EditOn")
        {
             LoadingOverlay.shared.showOverlay(view)
            let defaults = NSUserDefaults.standardUserDefaults()
            let userId = defaults.objectForKey("userId") as? Int
            wsm.delegates = self
       wsm.callUpdateAdressApi(String(userId!), stateID: self.stateID, address: self.streetAddressTF.text!, area: self.landmarkTF.text!, city: self.cityTF.text!, name: self.addViewNameTF.text!, title: self.addTitleTF.text!, zipcode: self.pincodeTF.text!, addressID: self.addressIDEdit , isDefault: self.isdeault)
        }
        else if (EditFlag == "EditOff")
        {
             LoadingOverlay.shared.showOverlay(view)
            let defaults = NSUserDefaults.standardUserDefaults()
            let userId = defaults.objectForKey("userId") as? Int
            wsm.delegates = self
            wsm.callSaveAdressApi( String(userId!), stateID: self.stateID, address: self.streetAddressTF.text!, area: self.landmarkTF.text!, city: self.cityTF.text!, name: self.addViewNameTF.text!, title: self.addTitleTF.text!, zipcode: self.pincodeTF.text!)
        
        }
        }
        else

        {
            // for case let textField as UITextField in self.view.subviews {
            if let titletext = self.addTitleTF.text where titletext.isEmpty{
                self.showAlert("Enter Address Title")
                // return
            }
            else  if let Nametext = self.addViewNameTF.text where Nametext.isEmpty{
                self.showAlert("Enter Name")
                // return
            }
            else  if let streetAddressText = self.streetAddressTF.text where streetAddressText.isEmpty
            {
                self.showAlert("Enter Street Address")
                // return
            }
            else  if let landmarktext = self.landmarkTF.text  where landmarktext.isEmpty
            {
                self.showAlert("Enter Landmark or Area")
                // return
            }
            else  if let pincode = self.pincodeTF.text where pincode.isEmpty
            {
                self.showAlert("Enter Pincode")
                // return
            }
            else  if let citytext = self.cityTF.text  where citytext.isEmpty
            {
                self.showAlert("select City")
                // return
            }
            else  if let statetext = self.stateTF.text where !statetext.isEmpty
            {
                self.showAlert("Select State")
                // return
            }
            
            // }
            //self.showAlert("Please Enter all mandatory fields")
            
        }
    }
    
    func showAlert(Message: String)
    {
        LoadingOverlay.shared.hideOverlayView()
        let alert = UIAlertController(title:"IMOL", message:Message , preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    func DeleteAdressClicked(sender:UIButton)
    {
        
        let buttonRow = sender.tag
        let buttonPosition = sender.convertPoint(CGPointZero, toView: self.addressTableView)
        let indexPath = self.addressTableView.indexPathForRowAtPoint(buttonPosition)
        print(indexPath?.section)
        print(indexPath?.row)
        let row = indexPath?.row
        print(self.AddressRow1)
      

        if  indexPath?.section == 1
        {
            let addressid = self.AddressRow1.objectAtIndex(row!).valueForKey("addressId") as! String
            let x: Int? = Int(addressid)
             LoadingOverlay.shared.showOverlay(view)
             wsm.delegates=self
           wsm.callDeleteAdressApi(x!)
        }
        
        
    }
    func SetDefaultAdressClicked(sender:UIButton)
    {
        let buttonRow = sender.tag
        let buttonPosition = sender.convertPoint(CGPointZero, toView: self.addressTableView)
        let indexPath = self.addressTableView.indexPathForRowAtPoint(buttonPosition)
        print(indexPath?.section)
        print(indexPath?.row)
        print(self.AddressRow1.objectAtIndex((indexPath?.row)!))
        
        let dict = self.AddressRow1.objectAtIndex((indexPath?.row)!) as! NSDictionary
       
        print(dict["addressId"]!)
        let defaults = NSUserDefaults.standardUserDefaults()
       
    
    
        if  indexPath?.section == 1
        {
    
    
            if let data = defaults.objectForKey("LoginObject") as? NSData
            {
                //            let unarc = NSKeyedUnarchiver(forReadingWithData: data)
                // let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                
                if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                {
                    //self.UID = blog.valueForKey("userId")! as! Int
                    
                    let dict = self.AddressRow1.objectAtIndex((indexPath?.row)!) as! NSDictionary
                    if let addressid = dict["addressId"]
                    {
                       // print(self.USRID)
                        print(addressid)
                       LoadingOverlay.shared.showOverlay(view)
                         wsm.delegates=self
                        wsm.callSetDefaultApi(String(blog.valueForKey("userId")!), addressID: addressid as! String)
                        
                    }
                    
                }}

        }

        
        
        
    }
    func callAddressEditapiresponse(string:NSArray)
    {
        //    print(string.objectAtIndex(0))
        LoadingOverlay.shared.hideOverlayView()
        self.AddressRow.removeAllObjects()
        self.AddressRow1.removeAllObjects()
        for address in string
        {
            if let dfaultadd : Bool = address["isDefault"] as! Bool
            {
                print(dfaultadd)
                if(dfaultadd == true)
                {
                    self.AddressRow.addObject(address)
                print(self.AddressRow)
                }
                else
                {
                self.AddressRow1.addObject(address)
                }
            }
            
        }
        print(self.AddressRow)
        print(self.AddressRow1)
        if(AddressRow.count > 0){
            addressTableView.hidden = false
            addSegmentoutlet.selectedSegmentIndex = 0
            addressBookView.hidden = false
            editAddressView.hidden = true

        }else{
            addSegmentoutlet.selectedSegmentIndex = 1
            addressBookView.hidden = true
            editAddressView.hidden = false
        }
         addSegmentoutlet.hidden = false
        self.addressTableView.reloadData()
        //print(string["state"]!.objectAtIndex(0).valueForKey("stateName")!)
    }
    func  callAddressEditapiFailedDelegate()
    {
        print("ERROR")
        LoadingOverlay.shared.hideOverlayView()
        addSegmentoutlet.hidden = false
        addressTableView.hidden = false
        
    }
    func saveAddressapiFailedDelegate(string:String)
   {
    LoadingOverlay.shared.hideOverlayView()
    let arry = string.componentsSeparatedByString(",") as NSArray
    if let arobj = arry[1] as? String{
    let arj = arobj.stringByReplacingOccurrencesOfString("\"", withString: "")

        let notAllowedCharactersSet = NSCharacterSet(charactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ. ").invertedSet
        let filtered = (arj.componentsSeparatedByCharactersInSet(notAllowedCharactersSet) as NSArray).componentsJoinedByString("")

    let alertView:UIAlertView = UIAlertView()
    alertView.title = ""
    alertView.message = filtered
    alertView.delegate = nil
    alertView.addButtonWithTitle("OK")
    alertView.show()
    }
    }
   
  func  saveAddressapiresponse(string:String)
  {

    LoadingOverlay.shared.hideOverlayView()
        self.AddressRow.removeAllObjects()
        self.AddressRow1.removeAllObjects()
    self.addSegmentoutlet .setEnabled(true, forSegmentAtIndex: 0)
    self.addSegmentoutlet .setEnabled(true, forSegmentAtIndex: 1)
        self.addSegmentoutlet.selectedSegmentIndex = 0;
    self.addSegmentoutlet.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        let defaults = NSUserDefaults.standardUserDefaults()
        if let data = defaults.objectForKey("LoginObject") as? NSData
        {
            
            if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
            {
             wsm.delegates=self
                wsm.callAdressApiForEdit(blog.valueForKey("userId")! as! Int)
            }}
  
    }
    //getCityStateApiResponse
    func getCityStateApiResponse(notification: NSNotification)  {
        LoadingOverlay.shared.hideOverlayView()
        let dict : AnyObject = notification.userInfo!
        if  let stateIdd = dict["stateId"] as? String{
        print(arrayCountries)
        for address in arrayCountries
        {
            print(address["stateId"])
            if let addr = address["stateId"]
            {
                var sts = addr as! String
                if(sts == stateIdd){
                    self.stateID = sts
                    self.stateTF.text = address["stateName"] as! String
               }
               
            }
        }
        }
   }
    
    func getStateApiResponse(notification: NSNotification)  {
        
    }
    
    func  StateApiFailedDelegate(string:String)
    {
        print(string)
        
    }
    
    func deleteAddressapiresponse(string:String)
    {
        LoadingOverlay.shared.hideOverlayView()
        let defaults = NSUserDefaults.standardUserDefaults()
        if let data = defaults.objectForKey("LoginObject") as? NSData
        {
            
            if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
            {
               LoadingOverlay.shared.showOverlay(view)
                 wsm.delegates=self
                wsm.callAdressApiForEdit(blog.valueForKey("userId")! as! Int)
            }}
     self.addressTableView.reloadData()
    }
    func deleteAddressapiFailedDelegate(string:String)
    {
         LoadingOverlay.shared.hideOverlayView()
        print(String)
    }
    
    func getCityApiResponse(notification: NSNotification)  {
        LoadingOverlay.shared.hideOverlayView()
        
        let dict : AnyObject = notification.userInfo!
            // wsm.callstateApi()
        let cityArr = dict["city"] as! NSArray
        //let country = Country!()
        self.arrayCities = NSMutableArray()
        //
        for city  in cityArr
        {
            print(city)
            self.arrayCities.addObject(city)
        }
        LoadingOverlay.shared.hideOverlayView()
        let SearchAddressControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("SearchAddress") as? SearchAddressController
        SearchAddressControllerObj?.citiesToPass = self.arrayCities
         SearchAddressControllerObj?.flagset = "cities"
        let NavigationController = UINavigationController(rootViewController: SearchAddressControllerObj!)
        self.presentViewController(NavigationController, animated: true, completion: nil)
        
        
//        let obj = self.arrayCities.objectAtIndex(0)
//        
//        print(obj["cityName"]!)
        
        //        print(obj.stateCode)
        //        print(obj.stateId)
        
    }
    
    func  CityApiFailedDelegate(string:String)
    {
         LoadingOverlay.shared.hideOverlayView()
        print(string)
        
    }
   func SetDefaultApiResponse (string:String)
   {
    LoadingOverlay.shared.hideOverlayView()
    let defaults = NSUserDefaults.standardUserDefaults()
    if let data = defaults.objectForKey("LoginObject") as? NSData
    {
        //            let unarc = NSKeyedUnarchiver(forReadingWithData: data)
        // let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
        
        if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
        {
            //self.UID = blog.valueForKey("userId")! as! Int
            LoadingOverlay.shared.showOverlay(view)
             wsm.delegates=self
            wsm.callAdressApiForEdit(blog.valueForKey("userId")! as! Int)
        }}
    }
    func SetDefaultApiFailedDelegate (string:String)
    {
        LoadingOverlay.shared.hideOverlayView()
    }
    
  func  UpdateAddressapiFailedDelegate (string:String)
  {
    let notAllowedCharactersSet = NSCharacterSet(charactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ. ").invertedSet
    let filtered = (string.componentsSeparatedByCharactersInSet(notAllowedCharactersSet) as NSArray).componentsJoinedByString("")
    LoadingOverlay.shared.hideOverlayView()
    let alertView:UIAlertView = UIAlertView()
    alertView.title = "IMOL"
    alertView.message = filtered
    alertView.delegate = nil
    alertView.addButtonWithTitle("OK")
    alertView.show()
    }
  func  UpdateAddressapiresponse (string:String)
  {
    LoadingOverlay.shared.hideOverlayView()
    self.AddressRow.removeAllObjects()
    self.AddressRow1.removeAllObjects()
    let defaults = NSUserDefaults.standardUserDefaults()
    if let data = defaults.objectForKey("LoginObject") as? NSData
    {
        //            let unarc = NSKeyedUnarchiver(forReadingWithData: data)
        // let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
        
        if let blog = NSKeyedUnarchiver.unarchiveObjectWithData(data)
        {
            //self.UID = blog.valueForKey("userId")! as! Int
            LoadingOverlay.shared.showOverlay(view)
             wsm.delegates=self
           wsm.callAdressApiForEdit(blog.valueForKey("userId")! as! Int)
            self.addressTableView.reloadData()
            self.addSegmentoutlet.selectedSegmentIndex = 0;
            self.addSegmentoutlet.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        }}
    
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
}

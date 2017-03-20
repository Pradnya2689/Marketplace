//
//  JHProgressHUD.swift
//  JHProgressHUD
//
//  Created by Harikrishnan on 02/12/14.
//  Copyright (c) 2014 Harikrishnan T. All rights reserved.
//

import UIKit

class JHProgressHUD: UIView
{
    
    private var backGroundView : UIView?
    private var progressIndicator : UIActivityIndicatorView?
    private var titleLabel : UILabel?
    private var footerLabel : UILabel?
    
    var headerColor : UIColor
    var footerColor : UIColor
    var backGroundColor : UIColor
    var loaderColor : UIColor

    class var sharedHUD : JHProgressHUD {
    struct Static {
        static var instance : JHProgressHUD?
        static var token : dispatch_once_t = 0
        }
        dispatch_once(&Static.token) {
            Static.instance = JHProgressHUD()
        }
        return Static.instance!
    }
    
    init()
    {
        //Initialising Code
        headerColor = UIColor.whiteColor()
        footerColor = UIColor.whiteColor()
        backGroundColor = UIColor.clearColor()
        loaderColor = UIColor.init(colorLiteralRed: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
        super.init(frame: CGRectZero)
    }

    required init(coder aDecoder: NSCoder)
    {
        headerColor = UIColor.whiteColor()
        footerColor = UIColor.whiteColor()
        backGroundColor = UIColor.clearColor()
        loaderColor = UIColor.init(colorLiteralRed: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect)
    {
        headerColor = UIColor.whiteColor()
        footerColor = UIColor.whiteColor()
        backGroundColor = UIColor.clearColor()
        loaderColor = UIColor.init(colorLiteralRed: 31.0/255.0, green: 75.0/255.0, blue: 164.0/255.0, alpha: 1)
        super.init(frame: frame)
    }
    
    // MARK: -Public Methods
    
    // Show the loader added to the mentioned view with the provided title and footer texts
    func showInView(view : UIView, withHeader title : String?, andFooter footer : String?)
    {
         let scrSize: CGRect = UIScreen.mainScreen().bounds
        self.hide()
        self.frame = scrSize
        setIndicator()
        
        if title != nil && !isCleanedStringEmpty(title!)
        {
            setTitleLabel(title!)
            titleLabel!.frame = CGRectMake(0, 0, getLabelSize().width, getLabelSize().height)
        }
        if footer != nil && !isCleanedStringEmpty(footer!)
        {
            setFooterLabel(footer!)
            footerLabel!.frame = CGRectMake(0, 0, getLabelSize().width, getLabelSize().height)
        }
        setBackGround(self)
        if title != nil && !isCleanedStringEmpty(title!)
        {
            titleLabel!.frame.origin = getHeaderOrigin(backGroundView!)
            titleLabel?.adjustsFontSizeToFitWidth = true
            backGroundView?.addSubview(titleLabel!)
        }
        if footer != nil && !isCleanedStringEmpty(footer!)
        {
            footerLabel!.frame.origin = getFooterOrigin(backGroundView!)
            footerLabel?.adjustsFontSizeToFitWidth = true
            backGroundView?.addSubview(footerLabel!)
        }
      //  progressIndicator?.frame = CGRectMake(, <#T##y: CGFloat##CGFloat#>, <#T##width: CGFloat##CGFloat#>, <#T##height: CGFloat##CGFloat#>)
        progressIndicator?.frame.origin = getIndicatorOrigin(backGroundView!, activityIndicatorView: progressIndicator!)
        backGroundView?.addSubview(progressIndicator!)
        view.addSubview(self)
    }
    
    // Show the loader added to the mentioned window with the provided title and footer texts
    func showInWindow(window : UIWindow, withHeader title : String?, andFooter footer : String?)
    {
        self.showInView(window, withHeader: title, andFooter: footer)
    }
    
    // Show the loader added to the mentioned view with no title and footer texts
    func showInView(view : UIView)
    {
        self.showInView(view, withHeader: nil, andFooter: nil)
    }
    
    // Show the loader added to the mentioned window with no title and footer texts
    func showInWindow(window : UIWindow)
    {
        self.showInView(window, withHeader: nil, andFooter: nil)
    }
    
    // Removes the loader from its superview
    func hide()
    {
        if self.superview != nil
        {
            self.removeFromSuperview()
            progressIndicator?.stopAnimating()
        }
    }
    
    // MARK: -Set view properties
    
    private func setBackGround(view : UIView)
    {
           let scrSize: CGRect = UIScreen.mainScreen().bounds
        if backGroundView?.superview != nil
        {
            backGroundView?.removeFromSuperview()
            var aView = backGroundView?.viewWithTag(1001) as UIView?
            aView?.removeFromSuperview()
        }
        backGroundView = UIView(frame: getBackGroundFrame(self))
        backGroundView?.frame = CGRectMake(0, 0, scrSize.width, scrSize.height)
        backGroundView?.backgroundColor = UIColor.clearColor()
        var translucentView = UIView(frame: backGroundView!.bounds)
        translucentView.backgroundColor = backGroundColor
        translucentView.alpha = 0.85
        translucentView.tag = 1001;
        translucentView.layer.cornerRadius = 15.0
        backGroundView?.addSubview(translucentView)
        backGroundView?.layer.cornerRadius = 15.0
        self.addSubview(backGroundView!)
    }
    
    private func setIndicator()
    {
        if progressIndicator?.superview != nil
        {
            progressIndicator?.removeFromSuperview()
        }
        progressIndicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        progressIndicator?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        progressIndicator?.color = loaderColor
        progressIndicator?.backgroundColor = UIColor.clearColor()
        progressIndicator?.startAnimating()
    }
    
    private func setTitleLabel(text : String)
    {
        if titleLabel?.superview != nil
        {
            titleLabel?.removeFromSuperview()
        }
        titleLabel = UILabel()
        titleLabel?.text = text
        titleLabel?.font = self.boldFontWithFont(titleLabel?.font)
        titleLabel?.textColor = headerColor
        titleLabel?.textAlignment = .Center
    }
    
    private func setFooterLabel(text : String)
    {
        if footerLabel?.superview != nil
        {
            footerLabel?.removeFromSuperview()
        }
        footerLabel = UILabel()
        footerLabel?.text = text
        footerLabel?.textColor = footerColor
        footerLabel?.textAlignment = .Center
    }
    
    // MARK: -Get Frame
    
    private func getBackGroundFrame(view : UIView) -> CGRect
    {
        let scrSize: CGRect = UIScreen.mainScreen().bounds
        let sideMargin:CGFloat = 20.0
        var side = progressIndicator!.frame.height + sideMargin
        if titleLabel?.text != nil && !isCleanedStringEmpty((titleLabel?.text)!)
        {
            side = progressIndicator!.frame.height + titleLabel!.frame.width
        }
        else if (footerLabel?.text != nil && !isCleanedStringEmpty((footerLabel?.text)!))
        {
            side = progressIndicator!.frame.height + footerLabel!.frame.width
        }
      //  var originX = view.center.x - (side/2)
        var originX = (scrSize.width-side)/2
       // var originY = view.center.y - (side/2)
        var originY = (scrSize.height-side)/2
        return CGRectMake(originX, originY, side, side)
    }
    
    // MARK: Get Size
    
    private func getLabelSize() -> CGSize
    {
        var width = progressIndicator!.frame.width * 3
        var height = progressIndicator!.frame.height / 1.5
        return CGSizeMake(width, height)
    }
    
    // MARK: -Get Origin
    
    private func getIndicatorOrigin(view : UIView, activityIndicatorView indicator : UIActivityIndicatorView) -> CGPoint
    {
         let scrSize: CGRect = UIScreen.mainScreen().bounds
        var side = indicator.frame.size.height
        var originX = (view.bounds.width/2) - (side/2)
        var originY = (view.bounds.height/2) - (side/2)
        return CGPointMake(originX, originY)
    }
    
    private func getHeaderOrigin(view : UIView) -> CGPoint
    {
        var width = titleLabel!.frame.size.width
        var originX = (view.bounds.width/2) - (width/2)
        return CGPointMake(originX, 1)
    }
    
    private func getFooterOrigin(view : UIView) -> CGPoint
    {
        var width = footerLabel!.frame.width
        var height = footerLabel!.frame.height
        var originX = (view.bounds.width/2) - (width/2)
        var originY = view.frame.height - (height + 1)
        return CGPointMake(originX, originY)
    }
    
    private func isCleanedStringEmpty(string: String) -> Bool
    {
        let cleanString = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return cleanString.isEmpty
    }
    
    // MARK: -Set Font
    func boldFontWithFont(font : UIFont?) -> UIFont
    {
        var fontDescriptor : UIFontDescriptor = font!.fontDescriptor().fontDescriptorWithSymbolicTraits(.TraitBold)
        return UIFont(descriptor: fontDescriptor, size: 0)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}

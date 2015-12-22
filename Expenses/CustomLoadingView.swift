//
//  CustomLoadingView.swift
//  Expenses
//
//  Created by Patel, Ashish on 12/20/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import Foundation
import UIKit

class CustomLoadingView: UIView{
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var backgroundView: UIView!
    
    static func showLoadingViewFor(view: UIView) -> CustomLoadingView{
        let customLoadingView =  CustomLoadingView(frame: UIScreen.mainScreen().bounds)
        view.addSubview(customLoadingView)
        return customLoadingView
    }
    
    private override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    // Our custom view from the XIB file
    private var view: UIView!
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        containerView.layer.cornerRadius = 5.0
        backgroundView.backgroundColor = UIColor.blackColor()
        backgroundView.alpha = 0.8
        backgroundView.userInteractionEnabled = false
        activityIndicator.startAnimating()
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CustomLoadingView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
}

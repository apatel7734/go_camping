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
    
    static let sharedView = CustomLoadingView()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    func showLoadingViewFor(view: UIView, withMessage message: String?){
        if let message = message where !message.isEmpty{
            messageLabel.text = message
        }
        self.hidden = false
        view.addSubview(self)
    }
    
    func hideLoadingView(){
        self.hidden = true
    }
    
    override init(frame: CGRect) {
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
    private var backgroundView: UIView!
    
    func xibSetup() {
        backgroundView = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        backgroundView.frame = UIScreen.mainScreen().bounds
        
        // Make the view stretch with containing view
        backgroundView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        backgroundView.backgroundColor = UIColor.blackColor()
        backgroundView.alpha = 0.8
        backgroundView.userInteractionEnabled = false
        
        containerView.layer.cornerRadius = 5.0
        activityIndicator.startAnimating()
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(backgroundView)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CustomLoadingView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
}

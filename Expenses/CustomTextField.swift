//
//  CustomTextField.swift
//  Expenses
//
//  Created by Ashish Patel on 8/19/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
     let padding = UIEdgeInsets(top: 15, left: 15, bottom: 10, right: 5);
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        self.borderStyle = UITextBorderStyle.Line
        //to set custom color we've to set borderWidth
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.font = UIFont(name: "ArialHebrewScholar-Light", size: 30)
    }
    
    //padding for placeholder before editing begins
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return newBoundsFor(bounds)
    }
    
    //padding for placeholder and text after editing begins
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return newBoundsFor(bounds)
    }
    
    
    func newBoundsFor(bounds: CGRect) -> CGRect{
        var newBounds = bounds
        newBounds.origin.x += padding.left
        newBounds.origin.y += padding.top
        newBounds.size.height -= padding.top + padding.bottom
        newBounds.size.width -= padding.left + padding.right
        return newBounds
    }
    
}

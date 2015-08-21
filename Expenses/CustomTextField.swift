//
//  CustomTextField.swift
//  Expenses
//
//  Created by Ashish Patel on 8/19/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        println("Setup CustomTextField");
        self.borderStyle = UITextBorderStyle.Line
        //to set custom color we've to set borderWidth
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGrayColor().CGColor

    }
    //padding for placeholder before editing begins
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    //padding for placeholder and text after editing begins
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
}

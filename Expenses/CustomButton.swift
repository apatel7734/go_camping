//
//  CustomButton.swift
//  Expenses
//
//  Created by Ashish Patel on 8/19/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDefault()
    }
    
    func setupDefault(){
        self.layer.cornerRadius = 5.0
        self.backgroundColor = UIColor.blueColor()
    }
    
    func lightButton(){
        self.backgroundColor = UIColor.lightGrayColor()
    }
    
    func darkButton(){
        self.backgroundColor = UIColor.blueColor()
    }
}

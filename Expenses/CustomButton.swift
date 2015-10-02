//
//  CustomButton.swift
//  Expenses
//
//  Created by Ashish Patel on 8/19/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDefault()
    }
    
    func setupDefault(){
        self.layer.cornerRadius = 3.0

        self.backgroundColor = UIColor.blueColor()
        self.titleLabel?.font = UIFont(name: "Arial", size: 20)
        self.titleLabel?.textColor = UIColor.whiteColor()
        self.contentEdgeInsets.bottom = 15
        self.contentEdgeInsets.top = 15

    }
    
    func lightButton(){
        self.backgroundColor = UIColor.lightGrayColor()
    }
    
    func darkButton(){
        self.backgroundColor = UIColor.blueColor()
    }
}

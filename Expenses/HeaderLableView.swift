//
//  HeaderLableView.swift
//  Expenses
//
//  Created by Ashish Patel on 8/20/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

class HeaderLableView: UILabel {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        self.textColor = UIColor.blueColor()
        self.font.fontWithSize(30)
        
    }


}

//
//  CircularImageView.swift
//  Expenses
//
//  Created by Ashish Patel on 8/20/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

class CircularImageView: UIImageView {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup(){
        //clips to bound is required to make cornerRadius work
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }

}

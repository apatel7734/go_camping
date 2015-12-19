//
//  UIKitExtensions.swift
//  Expenses
//
//  Created by Patel, Ashish on 12/19/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import Foundation
import UIKit


extension UINavigationBar{
    
    func configureAsTransparentBar() {
        let blankImage = UIImage()
        self.setBackgroundImage(blankImage, forBarMetrics: UIBarMetrics.Default)
        self.shadowImage = blankImage
        
        self.translucent = true
        self.backgroundColor = UIColor.clearColor()
        self.tintColor = UIColor.whiteColor()
    }
    
}
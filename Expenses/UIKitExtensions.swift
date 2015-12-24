//
//  UIKitExtensions.swift
//  Expenses
//
//  Created by Patel, Ashish on 12/19/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    class func colorWithHexString(hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        var rgbValue: UInt32 = 0
        let scanner = NSScanner(string: hexString)
        scanner.scanLocation = 1
        scanner.scanHexInt(&rgbValue)
        let red = (CGFloat((rgbValue & 0xFF0000) >> 16)) / 255.0
        let green = (CGFloat((rgbValue & 0xFF00) >> 8)) / 255.0
        let blue = CGFloat((rgbValue & 0xFF)) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    class func darkBlue() -> UIColor {
        return UIColor.colorWithHexString("#273B49")
    }

}


extension String{
    /*
    it formatS phoneNumber into formate of "XXX XXX XXXX"
    */
    func formatPhoneNumberWithSpaces() -> String{
        var formattedPhoneNumber = self.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        if formattedPhoneNumber.characters.count > 3 {
            let thirdIndex = formattedPhoneNumber.startIndex.advancedBy(3)
            formattedPhoneNumber.insert(" ", atIndex: thirdIndex)
        }
        
        if formattedPhoneNumber.characters.count > 7 {
            let seventhIndex = formattedPhoneNumber.startIndex.advancedBy(7)
            formattedPhoneNumber.insert(" ", atIndex: seventhIndex)
        }
        
        return formattedPhoneNumber
    }
    
}


extension UINavigationBar{
    
    func configureAsTransparentBar() {
        let blankImage = UIImage()
        self.setBackgroundImage(blankImage, forBarMetrics: UIBarMetrics.Default)
        self.shadowImage = blankImage
        
        self.translucent = true
        self.backgroundColor = UIColor.clearColor()
        self.tintColor = UIColor.whiteColor()
    }
    
    func configureAsBlueBar(){
        self.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.barTintColor = UIColor.darkBlue()
        self.translucent = true
        setTitleTextAttributesWithColor(UIColor.whiteColor())
    }
    
    func setTitleTextAttributesWithColor(color: UIColor) {
        let attributes: [String : AnyObject] = [NSForegroundColorAttributeName : color]
        titleTextAttributes = attributes
    }
    
}
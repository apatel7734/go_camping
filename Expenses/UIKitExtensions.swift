//
//  UIKitExtensions.swift
//  Expenses
//
//  Created by Patel, Ashish on 12/19/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import Foundation
import UIKit

extension NSNumber{
    func millisecondsToDate() -> String{
        let seconds = self.doubleValue / 1000.0
        let aDate = NSDate(timeIntervalSince1970: seconds)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM dd YYYY, EEE hh:mm"
        return dateFormatter.stringFromDate(aDate)
    }
    
}

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
    
    class func darkGreen() -> UIColor {
        return UIColor.colorWithHexString("#1B5E20")
    }
    
    class func lightGreen() -> UIColor{
        return UIColor.colorWithHexString("#199A5C")
    }
    
    class func darkRed() -> UIColor{
        return UIColor.colorWithHexString("#B71C1C")
    }
    
    class func lightOrange() -> UIColor{
        return UIColor.colorWithHexString("#FF7043")
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
    
    func removeWhiteSpaces() -> String{
        return self.stringByReplacingOccurrencesOfString(" ", withString: "");
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
        self.setTitleTextAttributesWithColor(UIColor.whiteColor())
        self.tintColor = UIColor.whiteColor()
    }
    
    func setTitleTextAttributesWithColor(color: UIColor) {
        let attributes: [String : AnyObject] = [NSForegroundColorAttributeName : color]
        titleTextAttributes = attributes
    }
    
}
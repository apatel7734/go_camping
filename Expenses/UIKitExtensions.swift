//
//  UIKitExtensions.swift
//  Expenses
//
//  Created by Patel, Ashish on 12/19/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import Foundation
import UIKit

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
    
}
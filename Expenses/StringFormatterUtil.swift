//
//  FormatUtil.swift
//  Expenses
//
//  Created by Patel, Ashish on 10/25/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import Foundation

class StringFormatterUtil{
    
    static let sharedInstance = StringFormatterUtil()
    
    func formatPhoneNumber(phoneNumber: String) -> String{
        
        let string: NSMutableString = NSMutableString(string: phoneNumber)

        if string.length > 0 {
            string.insertString("(", atIndex: 0)
        }
        if string.length > 4{
            string.insertString(")", atIndex: 4)
        }
        if string.length > 5{
            string.insertString("-", atIndex: 5)
        }
        if string.length > 9{
            string.insertString("-", atIndex: 9)
        }
        return string as String
    }
}
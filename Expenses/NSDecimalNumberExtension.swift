//
//  NSDecimalNumberExtension.swift
//  Expenses
//
//  Created by Patel, Ashish on 10/31/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import Foundation


extension NSDecimalNumber{
    
    static func defaultHandler() -> NSDecimalNumberHandler{
        let handler = NSDecimalNumberHandler(roundingMode: NSRoundingMode.RoundUp, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return handler
    }
    
    func currencyFormattedValueWithDollarPrefix() -> String{
        var formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.currencySymbol = "$"
        return formatter.stringFromNumber(self)!
    }
}
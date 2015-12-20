//
//  NSUserDefaultCoordinator.swift
//  Expenses
//
//  Created by Patel, Ashish on 10/31/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import Foundation

struct NSUserDefaultConstants {
    static let totalExpenseForEvent = "TotalExpenseForEvent"
    static let totalMembersCountForEvent = "TotalMembersCountForEvent"
    static let originalLastModifiedExpenseAmount = "OriginalLastModifiedExpenseAmount"
}

class NSUserDefaultCoordinator {
    
    internal static let sharedInstance = NSUserDefaultCoordinator()
    
    var totalExpenseForEvent :NSDecimalNumber{
        get{
            let defaults = NSUserDefaults.standardUserDefaults()
            let totalExpenseForEvent = defaults.doubleForKey(NSUserDefaultConstants.totalExpenseForEvent)
            let returnValue = NSDecimalNumber(double: totalExpenseForEvent)
            return returnValue
        }
        
        set(newTotalExpense){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setDouble(newTotalExpense.doubleValue, forKey: NSUserDefaultConstants.totalExpenseForEvent)
        }
    }
    
    
    var totalMembersCountForEvent : Int{
        get{
            let defaults = NSUserDefaults.standardUserDefaults()
            return defaults.integerForKey(NSUserDefaultConstants.totalMembersCountForEvent)
        }
        
        set(newTotalmembersCount){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(newTotalmembersCount, forKey: NSUserDefaultConstants.totalMembersCountForEvent)
        }
    }
    
    var originalExpenseAmount: NSDecimalNumber{
        get{
            let defaults = NSUserDefaults.standardUserDefaults()
            let lastModifiedExpenseOriginalAmount = defaults.doubleForKey(NSUserDefaultConstants.originalLastModifiedExpenseAmount)
            return NSDecimalNumber(double: lastModifiedExpenseOriginalAmount)
        }
        
        set(originalExpenseAmount){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setDouble(originalExpenseAmount.doubleValue, forKey: NSUserDefaultConstants.originalLastModifiedExpenseAmount)
        }
    }
}
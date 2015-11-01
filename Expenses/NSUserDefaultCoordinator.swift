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
}

class NSUserDefaultCoordinator {
    
    internal static let sharedInstance = NSUserDefaultCoordinator()
    
    var totalExpenseForEvent :NSDecimalNumber{
        get{
            let defaults = NSUserDefaults.standardUserDefaults()
            let totalExpenseForEvent = defaults.doubleForKey(NSUserDefaultConstants.totalExpenseForEvent)
            let returnValue = NSDecimalNumber(double: totalExpenseForEvent)
            print("totalExpenseForEvent doubleValue= \(totalExpenseForEvent), returnValue = \(returnValue)")
            return returnValue
        }
        
        set(newTotalExpense){
            print("newTotalExpense = \(newTotalExpense)")
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
}
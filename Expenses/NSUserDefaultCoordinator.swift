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
    
    //User Account Info
    static let UserPhonenumber = "userphonenumber"
    static let UserEmail = "useremailaddress"
    static let UserFullName = "userfullname"
}

class NSUserDefaultCoordinator {
    internal static let sharedInstance = NSUserDefaultCoordinator()
    private var user: GTLGocampingUserAccount!
    
    var loggedInUser: GTLGocampingUserAccount{
        set(newUser){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(newUser.phoneNumber.integerValue, forKey: NSUserDefaultConstants.UserPhonenumber)
            defaults.setObject(newUser.fullName, forKey: NSUserDefaultConstants.UserFullName)
            defaults.setObject(newUser.email, forKey: NSUserDefaultConstants.UserEmail)
        }
        
        get{
            if user == nil{
                user = GTLGocampingUserAccount()
                let defaults = NSUserDefaults.standardUserDefaults()
                user.phoneNumber = defaults.integerForKey(NSUserDefaultConstants.UserPhonenumber)
                user.fullName = defaults.stringForKey(NSUserDefaultConstants.UserFullName)
                user.email = defaults.stringForKey(NSUserDefaultConstants.UserEmail)
            }
            return user
        }
    }
    
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
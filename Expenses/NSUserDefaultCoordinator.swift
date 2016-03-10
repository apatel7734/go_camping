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
    
    var loggedInUser: GTLGocampingUserAccount?{
        set(newUser){
            
            guard let newUser = newUser else{
                setLoggedinUserDefaults(0, fullName: nil, email: nil)
                return
            }
            setLoggedinUserDefaults(newUser.phoneNumber.integerValue, fullName: newUser.fullName, email: newUser.email)
        }
        
        get{
            if user == nil{
                let defaults = NSUserDefaults.standardUserDefaults()
                let phoneNumber = defaults.integerForKey(NSUserDefaultConstants.UserPhonenumber)
                let fullName = defaults.stringForKey(NSUserDefaultConstants.UserFullName)
                let email = defaults.stringForKey(NSUserDefaultConstants.UserEmail)
                if phoneNumber != 0 {
                    user = GTLGocampingUserAccount()
                    user.phoneNumber = phoneNumber
                    user.fullName = fullName
                    user.email = email
                }
            }
            
            return user
        }
    }
    
    private func setLoggedinUserDefaults(phoneNumber: Int, fullName: String?, email: String?){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(phoneNumber, forKey: NSUserDefaultConstants.UserPhonenumber)
        defaults.setObject(fullName, forKey: NSUserDefaultConstants.UserFullName)
        defaults.setObject(email, forKey: NSUserDefaultConstants.UserEmail)
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
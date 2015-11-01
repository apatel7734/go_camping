//
//  CommonUtility.swift
//  Expenses
//
//  Created by Patel, Ashish on 10/28/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import Foundation

class CommonUtility {
    
    internal static let sharedInstance = CommonUtility()
    
    func updateTotalExpenseForEvent(expense: Expense){
        var currentTotalExpense = NSUserDefaultCoordinator.sharedInstance.totalExpenseForEvent
        print("currentTotalExpense = \(currentTotalExpense)")
        print("expense.amount = \(expense.amount?.decimalValue)")
        if let decimalExpenseAmount = expense.amount?.decimalValue{
            currentTotalExpense = currentTotalExpense.decimalNumberByAdding(NSDecimalNumber(decimal: decimalExpenseAmount))
            NSUserDefaultCoordinator.sharedInstance.totalExpenseForEvent = currentTotalExpense
        }
    }
    
    func incrementTotalMembersCountForEvent(){
        var currentTotalMembersCount = NSUserDefaultCoordinator.sharedInstance.totalMembersCountForEvent
        currentTotalMembersCount++
        NSUserDefaultCoordinator.sharedInstance.totalMembersCountForEvent = currentTotalMembersCount
    }
    
    /**
     calculates total expense for whole event by adding each family's expenses.
     */
    func totalExpenseForEvent(families: [Family]?) -> NSDecimalNumber{
        var totalExpense = NSDecimalNumber.zero()
        guard let families = families else{
            return totalExpense
        }
        
        for family in families{
            let totalFamilyExpense = totalExpenseForFamily(family)
            totalExpense = totalExpense.decimalNumberByAdding(totalFamilyExpense)
        }
        return totalExpense
    }
    
    
    func totalExpenseForFamily(family: Family?, totalExpensePerFamily: NSDecimalNumber) -> NSDecimalNumber{
        guard let family = family else{
            return NSDecimalNumber.zero()
        }
        let totalFamilyMembers = family.members.count
        
        return totalExpensePerFamily.decimalNumberByMultiplyingBy(NSDecimalNumber(integer: totalFamilyMembers))
    }
    
    /**
     calculates totalExpense each family suppose to pay.
     */
    func totalExpensePerFamily(totalExpenseForEvent: NSDecimalNumber?, totalMembersCountForEvent: Int) -> NSDecimalNumber{
        let zero = NSDecimalNumber.zero()
        
        guard let totalExpenseForEvent = totalExpenseForEvent
            where totalExpenseForEvent.compare(zero) == .OrderedAscending
            else{
                return zero
        }
        return totalExpenseForEvent.decimalNumberByDividingBy(NSDecimalNumber(integer: totalMembersCountForEvent))
    }
    
    /**
     calculates and return total members for this event
     */
    func totalMembersForEvent(families: [Family]?) -> Int{
        var totalMembers = 0
        guard let families = families else{
            return totalMembers
        }
        
        for family in families{
            totalMembers += family.members.count
        }
        return totalMembers
    }
    
    /**
     calculates expense for each family by adding each expense bill submitted.
     */
    func totalExpenseForFamily(family: Family) -> NSDecimalNumber{
        var totalExpense: NSDecimalNumber = NSDecimalNumber.zero()
        for expense in family.expenses{
            if let expenseAmout = expense.amount{
                totalExpense = totalExpense.decimalNumberByAdding(NSDecimalNumber(decimal: expenseAmout.decimalValue))
            }
        }
        return totalExpense
    }
}
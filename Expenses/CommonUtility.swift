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
    
    func amountDifferenceToPayOrTakeForFamily(family: Family) -> NSDecimalNumber{
        var totalFamilyPaidExpense = NSDecimalNumber.zero()
        if let familyPaidDecimalExpense = family.totalExpense?.decimalValue{
            totalFamilyPaidExpense = NSDecimalNumber(decimal: familyPaidDecimalExpense)
        }
        let amountOwedByFamily = totalAmountOwedByFamily(family)
        return totalFamilyPaidExpense.decimalNumberBySubtracting(amountOwedByFamily)
    }
    
    /**
     calculates totalExpense each family suppose to pay.
     */
    func totalExpenseEachFamilySupposeToPay() -> NSDecimalNumber{
        let totalExpenseForEvent = NSUserDefaultCoordinator.sharedInstance.totalExpenseForEvent
        let zero = NSDecimalNumber.zero()
        let isValidTotalMember = NSUserDefaultCoordinator.sharedInstance.totalMembersCountForEvent > 0 ? true : false
        let result = zero.compare(totalExpenseForEvent)
        let isValidTotalExpense = result == NSComparisonResult.OrderedAscending
        if isValidTotalExpense && isValidTotalMember{
            let totalMembersCountForEvent = NSDecimalNumber(integer: NSUserDefaultCoordinator.sharedInstance.totalMembersCountForEvent)
            return totalExpenseForEvent.decimalNumberByDividingBy(totalMembersCountForEvent, withBehavior: NSDecimalNumber.defaultHandler())
        }
        return zero
    }
    
    /**
     calculates expense for each family by adding each expense bill submitted.
     */
    func totalAmountOwedByFamily(family: Family) -> NSDecimalNumber{
        let perFamilyExpense = totalExpenseEachFamilySupposeToPay()
        let totalFamilyMembers = family.members.count
        let returnValue = perFamilyExpense.decimalNumberByMultiplyingBy(NSDecimalNumber(integer: totalFamilyMembers), withBehavior: NSDecimalNumber.defaultHandler())
        return returnValue
    }
}
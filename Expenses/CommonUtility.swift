//
//  CommonUtility.swift
//  Expenses
//
//  Created by Patel, Ashish on 10/28/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import Foundation
import CoreData

class CommonUtility {
    
    internal static let sharedInstance = CommonUtility()
    
    func memberParams(familyId: String, campingTripId: String, name: String?, age: String?, email: String?, phoneNumber: String?) -> [NSObject: AnyObject]{
        
        var membersParam = [NSObject:AnyObject]()
        
        if let name = name{
            membersParam[ParseMember.Name] = name
        }
        if let age = age, intValue = Int(age){
            membersParam[ParseMember.Age] = intValue
        }
        
        if let email = email{
            membersParam[ParseMember.Email] = email
        }
        
        if let phoneNumber = phoneNumber{
            membersParam[ParseMember.PhoneNumber] = phoneNumber
        }
        
        membersParam[ParseFamily.FamilyId] = familyId
        membersParam[ParseTrip.CampingTripId] = campingTripId
        
        return membersParam
    }
    
    
    func expenseParams(familyId: String, campingTripId: String, name: String?, amount: NSDecimalNumber?, description: String?) -> [NSObject: AnyObject]{
        
        var expenseParams = [NSObject:AnyObject]()
        
        if let name = name{
            expenseParams[ParseExpense.Name] = name
        }
        if let amount = amount{
            expenseParams[ParseExpense.Amount] = amount
        }
        
        if let description = description{
            expenseParams[ParseExpense.Description] = description
        }
    
        
        expenseParams[ParseFamily.FamilyId] = familyId
        expenseParams[ParseTrip.CampingTripId] = campingTripId
        
        return expenseParams
    }
    
    func incrementTotalMembersCountForEvent(){
        var currentTotalMembersCount = NSUserDefaultCoordinator.sharedInstance.totalMembersCountForEvent
        currentTotalMembersCount++
        NSUserDefaultCoordinator.sharedInstance.totalMembersCountForEvent = currentTotalMembersCount
    }
    
    func decrementTotalMembersCountForEvent(){
        var currentTotalMembersCount = NSUserDefaultCoordinator.sharedInstance.totalMembersCountForEvent
        currentTotalMembersCount--
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
        //        let totalFamilyMembers = family.members.count
        //        let returnValue = perFamilyExpense.decimalNumberByMultiplyingBy(NSDecimalNumber(integer: totalFamilyMembers), withBehavior: NSDecimalNumber.defaultHandler())
        //        return returnValue
        return 21.0
    }
    
    func updateTotalMembersCountForEvent(){
        //        let fetchRequest = NSFetchRequest(entityName: "Member")
        //        do{
        //            let members = try CoreDataStackManager.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest) as! [Member]
        //            NSUserDefaultCoordinator.sharedInstance.totalMembersCountForEvent = members.count
        //        }catch{
        //            print("Error in fetching members in updateTotalMembersCountForEvent.")
        //        }
    }
    
    
    func updateFamilyTotalExpense(family: Family?){
        //        var totalExpense: NSDecimalNumber = NSDecimalNumber.zero()
        //        if let expenses = family?.expenses{
        //            for expense in expenses{
        //                if let expenseAmout = expense.amount{
        //                    totalExpense = totalExpense.decimalNumberByAdding(NSDecimalNumber(decimal: expenseAmout.decimalValue))
        //                }
        //            }
        //        }
        //        family?.totalExpense = totalExpense
    }
    
    func updateTotalExpenseAmountForEvent(){
        //        let fetchRequest = NSFetchRequest(entityName: "Expense")
        //        do{
        //            let expenses = try CoreDataStackManager.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest) as! [Expense]
        //            var totalExpenseAmount = NSDecimalNumber.zero()
        //            for expense in expenses{
        //                if let expenseAmount = expense.amount?.decimalValue{
        //                    totalExpenseAmount = totalExpenseAmount.decimalNumberByAdding(NSDecimalNumber(decimal: expenseAmount))
        //                }
        //            }
        //            NSUserDefaultCoordinator.sharedInstance.totalExpenseForEvent = totalExpenseAmount
        //        }catch{
        //            print("Error in fetching expenses in updateTotalExpenseAmountForEvent.")
        //        }
    }
}
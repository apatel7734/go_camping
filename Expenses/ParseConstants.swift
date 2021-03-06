//
//  ParseConstants.swift
//  Expenses
//
//  Created by Patel, Ashish on 1/1/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import Foundation

struct ParseTrip {
    static let ObjectId = "objectId"
    static let CampingTrip = "CampingTrip"
    static let LocationTitle = "locationTitle"
    static let Title = "title"
    static let DateFrom = "dateFrom"
    static let DateTo = "dateTo"
    static let Address = "locationAddress"
    static let CampingTripId = "campingTripId"
}

struct ParseFamily {
    static let ObjectId = "objectId"
    static let Family = "Family"
    static let Name = "name"
    static let ExpenseIds = "expenseIds"
    static let MemberIds = "memberIds"
    static let TotalExpense = "totalExpense"
    static let Address = "address"
    static let PhoneNumber = "phoneNumber"
    static let Email = "email"
    static let CampingTripIds = "campingTripIds"
    static let UserId = "userId"
    static let FamilyId = "familyId"
    static let TotalOwedExpense = "totalOwedExpense"
}

struct ParseUser {
    static let ObjectId = "objectId"
    static let User = "User"
    static let UserName = "username"
    static let Email = "email"
    static let Password = "password"
}

struct ParseExpense {
    static let ObjectId = "objectId"
    static let Expense = "Expense"
    static let Name = "name"
    static let Amount = "amount"
    static let Description = "description"
    static let FamilyId = "familyId"
    static let ExpenseId = "expenseId"
}

struct ParseMember {
    static let ObjectId = "objectId"
    static let Member = "Member"
    static let PhoneNumber = "phoneNumber"
    static let Name = "name"
    static let Email = "email"
    static let Age = "age"
    static let MemberId = "memberId"
}
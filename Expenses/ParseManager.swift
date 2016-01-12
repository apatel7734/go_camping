//
//  ParseManager.swift
//  Expenses
//
//  Created by Patel, Ashish on 1/1/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import Foundation
import Parse

class ParseManager {
    
    static func fetchCampingTrips(pageNumber: Int, totalResultsPerPage: Int, completionBlock: (campingTrips: [CampingTrip]?, error: NSError?) -> Void){
        let query = PFQuery(className: ParseTrip.CampingTrip)
        query.skip = pageNumber * totalResultsPerPage
        query.findObjectsInBackgroundWithBlock { (trips: [PFObject]?, error:NSError?) -> Void in
            if let campingTrips = trips as? [CampingTrip]{
                completionBlock(campingTrips: campingTrips, error: nil)
            }else{
                completionBlock(campingTrips: nil, error: NSError(domain: "CampingTrips Error domain", code: 101, userInfo: nil))
            }
        }
    }
    
    static func fetchFamiliesFor(campingTripId: String, pageNumber: Int, totalResultPerPage: Int, completionBlock: (families: [Family]?, error: NSError?) -> Void){
        let query = PFQuery(className: ParseFamily.Family)
        query.whereKey(ParseFamily.CampingTripIds, equalTo: campingTripId)
        query.skip = pageNumber * totalResultPerPage
        query.findObjectsInBackgroundWithBlock { (pfObjects: [PFObject]?, error:NSError?) -> Void in
            if let families = pfObjects as? [Family]{
                completionBlock(families: families, error: nil)
            }else{
                completionBlock(families: nil, error: NSError(domain: "Families Error domain", code: 101, userInfo: nil))
            }
        }
    }
    
    static func fetchMembersFor(familyId: String, pageNumber: Int, totalResultPerPage: Int, completionBlock: (members: [Member]?, error: NSError?) -> Void){
        let query = PFQuery(className: ParseMember.Member)
        query.whereKey(ParseMember.FamilyId, equalTo: familyId)
        query.skip = pageNumber * totalResultPerPage
        query.findObjectsInBackgroundWithBlock { (pfObjects: [PFObject]?, error:NSError?) -> Void in
            if let members = pfObjects as? [Member]{
                completionBlock(members: members, error: nil)
            }else{
                completionBlock(members: nil, error: NSError(domain: "Members Error domain", code: 101, userInfo: nil))
            }
        }
    }
    
    static func fetchExpensesFor(familyId: String, pageNumber: Int, totalResultPerPage: Int, completionBlock: (expenses: [Expense]?, error: NSError?) -> Void){
        let query = PFQuery(className: ParseExpense.Expense)
        query.whereKey(ParseExpense.FamilyId, equalTo: familyId)
        query.skip = pageNumber * totalResultPerPage
        query.findObjectsInBackgroundWithBlock { (pfObjects: [PFObject]?, error:NSError?) -> Void in
            if let expenses = pfObjects as? [Expense]{
                completionBlock(expenses: expenses, error: nil)
            }else{
                completionBlock(expenses: nil, error: NSError(domain: "Expenses Error domain", code: 101, userInfo: nil))
            }
        }
    }
    
    static func addFamilyToParse(family: Family, completionBlock: (success: Bool, error: NSError?) -> Void){
        family.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            completionBlock(success: success, error: error)
        }
    }
    
    static func addNewMember(memberParams: [NSObject : AnyObject], completionBlock: (success: Bool, error: NSError?) -> Void){
        print("memberParams = \(memberParams)")
        PFCloud.callFunctionInBackground("addNewMember", withParameters: memberParams) { (success: AnyObject?, error: NSError?) -> Void in
            print("Error = \(error)")
            completionBlock(success: true, error: error)
        }
    }
}
//
//  Family.swift
//  Expenses
//
//  Created by Ashish Patel on 7/19/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import Foundation
//Step 1. import coredata
import CoreData

//Step 2. Make Family available to Objective-C code
@objc(Family)

//Step 3. Make Family Subclass of NSManagedObject
class Family: NSManagedObject {
    
    struct Keys {
        static let Name = "name"
        static let TotalExpense = "totalexpense"
        static let Address = "address"
        static let PhoneNumber = "phonenumber"
        static let Email = "email"
    }
    
    //Step 4. Promot these properties to core data attributes
    @NSManaged var name: String?
    @NSManaged var totalExpense: NSNumber?
    @NSManaged var phoneNumber: NSNumber?
    @NSManaged var email: String?
    @NSManaged var address: String?
    @NSManaged var members: [Member]
    @NSManaged var expenses: [Expense]
    
    
    // 5. Include this standard Core Data init method.
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    /**
    * 6. The two argument init method
    */
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
    
        let entity =  NSEntityDescription.entityForName("Family", inManagedObjectContext: context)!
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        name = dictionary[Keys.Name] as? String
        address = dictionary[Keys.Address] as? String
        phoneNumber = 51046174
        totalExpense = 20
        email = "email@test.com"
    }
}
//
//  Expense.swift
//  Expenses
//
//  Created by Ashish Patel on 7/19/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import Foundation
//1. import coredata
import CoreData
//2. make this class available to objective c
@objc(Expense)
//3. managed object

class Expense : NSManagedObject{
    struct Keys {
        static let Name = "name"
        static let Desc = "desc"
        static let Amount = "amount"
    }

    //4. Promote below properties to coredata
    @NSManaged var name: String?
    @NSManaged var desc: String?
    @NSManaged var amount: NSNumber?
    @NSManaged var family: Family?
    
    // 5. Include this standard Core Data init method.
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    /**
    * 6. The two argument init method
    *
    * The Two argument Init method. The method has two goals:
    *  - insert the new Person into a Core Data Managed Object Context
    *  - initialze the Person's properties from a dictionary
    */
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        
        // Get the entity associated with the "Person" type.  This is an object that contains
        // the information from the Model.xcdatamodeld file. We will talk about this file in
        // Lesson 4.
        let entity =  NSEntityDescription.entityForName("Expense", inManagedObjectContext: context)!
        
        // Now we can call an init method that we have inherited from NSManagedObject. Remember that
        // the Person class is a subclass of NSManagedObject. This inherited init method does the
        // work of "inserting" our object into the context that was passed in as a parameter
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        // After the Core Data work has been taken care of we can init the properties from the
        // dictionary. This works in the same way that it did before we started on Core Data
        name = dictionary[Keys.Name] as? String
        desc = dictionary[Keys.Desc] as? String
        amount = 32.0
        //TODO: save more properties here..
    }

}
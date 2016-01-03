//
//  Expense.swift
//  Expenses
//
//  Created by Patel, Ashish on 1/1/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import Foundation
import Parse
class Expense: PFObject, PFSubclassing {
    var id: String?{
        get{
            return self.objectId
        }
    }
    
    var amount: NSDecimalNumber?{
        get{
            return NSDecimalNumber(double: 20.0)
        }
    }
    
    
    var desc: String?{
        get{
            return self[ParseExpense.Description] as? String
        }
    }
    
    var name: String?{
        get{
            return self[ParseExpense.Name] as? String
        }
    }
    
    override static func initialize(){
        superclass()?.load()
        self.registerSubclass()
    }
    
    static func parseClassName() -> String {
        return ParseExpense.Expense
    }
}
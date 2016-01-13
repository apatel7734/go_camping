//
//  Family.swift
//  Expenses
//
//  Created by Patel, Ashish on 1/1/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import Foundation
import Parse

class Family: PFObject, PFSubclassing {
    
    var id: String?{
        get{
            return self.objectId
        }
    }
    
    var name: String?{
        get{
            return self[ParseFamily.Name] as? String
        }
        
        set(newValue){
            self[ParseFamily.Name] = newValue
        }
    }
    
    var totalExpense: NSDecimalNumber?{
        get{
            if let totalExpense = self[ParseFamily.TotalExpense] as? NSNumber{
                return NSDecimalNumber(decimal: totalExpense.decimalValue)
            }else{
                return nil
            }
            
        }
    }
    
    var totalOwedExpense: NSDecimalNumber?{
        get{
            if let totalOwedExpense = self[ParseFamily.TotalOwedExpense] as? NSNumber{
                return NSDecimalNumber(decimal: totalOwedExpense.decimalValue)
            }else{
                return nil
            }
        }
    }
    
    var address: String?{
        get{
            return self[ParseFamily.Address] as? String
        }
    }
    
    var phoneNumber: String?{
        get{
            return self[ParseFamily.PhoneNumber] as? String
        }
        set{
            self[ParseFamily.PhoneNumber] = newValue
        }
    }
    
    var email: String?{
        get{
            return self[ParseFamily.Email] as? String
        }
        
        set{
            self[ParseFamily.Email] = newValue
        }
    }
    
    var campingTripsIds: [String]?{
        get{
            return self[ParseFamily.CampingTripIds] as? [String]
        }
    }
    var expenseIds: [String]?{
        get{
            return self[ParseFamily.ExpenseIds] as? [String]
        }
    }
    
    var membersIds: [String]?{
        get{
            return self[ParseFamily.MemberIds] as? [String]
        }
    }
    
    var userId: String?{
        get{
            return self[ParseFamily.UserId] as? String
        }
        set{
            self[ParseFamily.UserId] = newValue
        }
    }
    
    
    override static func initialize(){
        superclass()?.load()
        self.registerSubclass()
    }
    
    static func parseClassName() -> String {
        return ParseFamily.Family
    }
}
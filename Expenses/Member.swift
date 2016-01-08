//
//  Member.swift
//  Expenses
//
//  Created by Patel, Ashish on 1/1/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import Foundation
import Parse
class Member: PFObject, PFSubclassing {
    
    var id: String?{
        get{
            return self.objectId
        }
    }
    
    var phoneNumber:String?{
        get{
            return self[ParseMember.PhoneNumber] as? String
        }
    }
    
    
    var age: Int?{
        get{
            return self[ParseMember.Age] as? Int
        }
    }
    
    var name: String?{
        get{
            return self[ParseMember.Name] as? String
        }
    }
    
    var familyId: String?{
        get{
            return self[ParseMember.FamilyId] as? String
        }
    }
    
    
    override static func initialize(){
        superclass()?.load()
        self.registerSubclass()
    }
    
    static func parseClassName() -> String {
        return ParseMember.Member
    }
}
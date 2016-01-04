//
//  CampingTrip.swift
//  Expenses
//
//  Created by Patel, Ashish on 1/1/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import Foundation
import Parse
class CampingTrip : PFObject, PFSubclassing{
    
    var title: String?{
        get{
            return self[ParseTrip.Title] as? String
        }
    }
    
    var locationTitle: String?{
        get{
            return self[ParseTrip.LocationTitle] as? String
        }
    }
    
    var id: String?{
        get{
            return self.objectId
        }
    }
    
    var dateFrom: String?{
        get{
            let date = self[ParseTrip.DateFrom] as? NSDate
            return date?.fullStyleString()
        }
    }
    
    var dateTo: String?{
        get{
            let date = self[ParseTrip.DateTo] as? NSDate
            return date?.fullStyleString()
        }
    }
    
    var address: String?{
        get{
            return self[ParseTrip.Address] as? String
        }
    }
    
    class func parseClassName() -> String{
        return ParseTrip.CampingTrip
    }
    
    override class func initialize(){
        superclass()?.load()
        self.registerSubclass()
    }
}
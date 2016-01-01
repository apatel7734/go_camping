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
    
    static func campingTrips(pageNumber: Int, totalTripsPerPage: Int, completionBlock: (campingTrips: [CampingTrip]?, error: NSError?) -> Void){
        let query = PFQuery(className: ParseTrip.CampingTrip)
        query.skip = pageNumber * totalTripsPerPage
        query.findObjectsInBackgroundWithBlock { (trips: [PFObject]?, error:NSError?) -> Void in
            print("Total Objects in background = \(trips?.count)")
            if let campingTrips = trips as? [CampingTrip]{
                completionBlock(campingTrips: campingTrips, error: nil)
            }else{
                completionBlock(campingTrips: nil, error: NSError(domain: "Error domain", code: 101, userInfo: nil))
            }
        }
    }
    
}
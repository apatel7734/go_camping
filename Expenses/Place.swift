//
//  Place.swift
//  Expenses
//
//  Created by Emma on 11/5/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import RestKit
import Foundation

class Place: NSObject {
    
    var name: String!
    var rating: NSNumber?
    var vicinity: String?
    
    private var mapping: RKObjectMapping
    
    override init() {
        mapping = RKObjectMapping(forClass: Place.self)
        mapping.addAttributeMappingsFromArray(["name", "rating", "vicinity"])
    }
    
    func getMapping() -> RKObjectMapping {
        return mapping
    }
}
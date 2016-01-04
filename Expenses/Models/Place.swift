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
    var placeId: String!
    var rating: NSNumber?
    var vicinity: String?
    var geometry: Geometry?
    
    static func getMapping() -> RKObjectMapping {
        let mapping = RKObjectMapping(forClass: Place.self)
        mapping.addAttributeMappingsFromDictionary([
            "name": "name",
            "place_id": "placeId",
            "rating": "rating",
            "vicinity": "vicinity"])
        
        mapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "geometry", toKeyPath: "geometry", withMapping: Geometry.getMapping()))
        
        return mapping
    }
}
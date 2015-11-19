//
//  Geocoding.swift
//  Expenses
//
//  Created by Emma on 11/10/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import RestKit

class Geocoding: NSObject {

    var geometry: Geometry?
    
    static func getMapping() -> RKObjectMapping {
        let mapping = RKObjectMapping(forClass: Geocoding.self)
        mapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "geometry", toKeyPath: "geometry", withMapping: Geometry.getMapping()))
        
        return mapping
    }
}

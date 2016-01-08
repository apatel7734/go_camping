//
//  Geometry.swift
//  Expenses
//
//  Created by Miyuki Suzuki on 11/19/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import RestKit

class Geometry: NSObject {
    
    var location: Location?
    
    static func getMapping() -> RKObjectMapping {
        let mapping = RKObjectMapping(forClass: Geometry.self)
        mapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "location", toKeyPath: "location", withMapping: Location.getMapping()))
        
        return mapping
    }
    
    class Location: NSObject {
        var latitude: NSNumber!
        var longitude: NSNumber!
        
        static func getMapping() -> RKObjectMapping {
            let mapping = RKObjectMapping(forClass: Location.self)
            mapping.addAttributeMappingsFromDictionary([
                "lat": "latitude",
                "lng": "longitude"])
            return mapping
        }
    }
}
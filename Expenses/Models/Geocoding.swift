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
    
    private var mapping: RKObjectMapping
    
    override init() {
        mapping = RKObjectMapping(forClass: Geocoding.self)
        
        let geometryMapping = RKObjectMapping(forClass: Geometry.self)
        geometryMapping.addAttributeMappingsFromArray(["location"])
        
        let locationMapping = RKObjectMapping(forClass: Location.self)
        locationMapping.addAttributeMappingsFromDictionary([
            "lat": "latitude",
            "lng": "longitude"])
        
        mapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "location", toKeyPath: "location", withMapping: locationMapping))
        mapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "geometry", toKeyPath: "geometry", withMapping: geometryMapping))
    }
    
    func getMapping() -> RKObjectMapping {
        return mapping
    }
    
    class Geometry: NSObject {
        var location: Location?
    }
    
    class Location: NSObject {
        var latitude: NSNumber!
        var longitude: NSNumber!
    }
}

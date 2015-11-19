//
//  PlaceDetail.swift
//  Expenses
//
//  Created by Miyuki Suzuki on 11/16/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import RestKit
import Foundation

class PlaceDetail: NSObject {

    var name: String!
    var address: String?
    var geometry: Geometry?
    var phoneNumber: String?
    var website: String?
    var photos: [Photo]?
    
    static func getMapping() -> RKObjectMapping {
        let mapping = RKObjectMapping(forClass: PlaceDetail.self)
        mapping.addAttributeMappingsFromDictionary([
            "name": "name",
            "formatted_address": "address",
            "formatted_phone_number": "phoneNumber",
            "website": "website"
            ])
        
        mapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "photos", toKeyPath: "photos", withMapping: Photo.getMapping()))
    
        mapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "geometry", toKeyPath: "geometry", withMapping: Geometry.getMapping()))
        
        return mapping
    }
    
    class Photo: NSObject {
        
        var photoRef: String!
   
        static func getMapping() -> RKObjectMapping {
            let mapping = RKObjectMapping(forClass: Photo.self)
            mapping.addAttributeMappingsFromDictionary([
                "photo_reference": "photoRef"])
            
            return mapping
        }
    }
}

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
    var phoneNumber: String?
    var website: String?
    var photos: [Photo]?
    
    private let mapping: RKObjectMapping
    
    override init() {
        mapping = RKObjectMapping(forClass: PlaceDetail.self)
        mapping.addAttributeMappingsFromDictionary([
            "name": "name",
            "formatted_address": "address",
            "formatted_phone_number": "phoneNumber",
            "website": "website"
            ])
        
        let photoMapping = RKObjectMapping(forClass: Photo.self)
        photoMapping.addAttributeMappingsFromDictionary([
            "photo_reference": "photoRef"])
        
        mapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "photos", toKeyPath: "photos", withMapping: photoMapping))
    }
    
    func getMapping() -> RKObjectMapping {
        return mapping
    }
    
    class Photo: NSObject {
        var photoRef: String!
    }
}

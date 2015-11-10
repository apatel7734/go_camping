//
//  PlacesApi.swift
//  Expenses
//
//  Created by Emma on 11/5/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import CoreLocation

class GoogleMapApi {
    
    private let basePath = "https://maps.googleapis.com/maps/api"
    
    private let apiController: ApiController
    
    init(apiController: ApiController) {
        self.apiController = apiController
    }
    
    func getLatLngFromAddress(address: String?, success: (geocoding: Geocoding?) -> Void, failure: (error: Error?) -> Void) {
        guard let aAddress = address else {
            failure(error: Error(.BadRequest, title: "Error", message: "Cannot identify the address"))
            return
        }
        
        let path = "\(basePath)/geocode/json?key=\(Constants.googleApiKey)&address=\(aAddress)"
        
        let geocoding = Geocoding()
        apiController.callGetRequestForPath(path, mapping: geocoding.getMapping(), keyPath: "results") {
            (statusCode, response) in
            if statusCode == .Success {
                print(response)
            } else {
                print(response)
            }
        }
    }
    
    func getCampingSitesForLocation(location: CLLocation?, radius: Int,
        success: (places: [Place]?) -> Void, failure: (error: Error?) -> Void) {
            guard let aLocation = location else {
                failure(error: Error(.BadRequest, title: "Error", message: "Cannot identify the location"))
                return
            }
            
            var path = "\(basePath)/place/nearbysearch/json?types=campground&key=\(Constants.googleApiKey)"
            path += "&location=\(aLocation.coordinate.latitude),\(aLocation.coordinate.longitude)&radius=\(radius)"
            
            let place = Place()
            apiController.callGetRequestForPath(path, mapping: place.getMapping(), keyPath: "results") { (statusCode, response) in
                if statusCode == .Success {
                    success(places: response as? [Place])
                } else {
                    failure(error: response as? Error)
                }
            }
    }
}
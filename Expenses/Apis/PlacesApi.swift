//
//  PlacesApi.swift
//  Expenses
//
//  Created by Emma on 11/5/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import CoreLocation

class PlacesApi {
    
    private let basePath = "https://maps.googleapis.com/maps/api/place"
    
    private let apiController: ApiController
    private let place: Place
    
    init(apiController: ApiController) {
        self.apiController = apiController
        place = Place()
    }
    
    func getCampingSitesForLocation(location: CLLocation, radius: Int,
        success: (places: [Place]?) -> Void, failure: (error: Error?) -> Void) {
            
        var path = "\(basePath)/nearbysearch/json?types=campground&key=\(Constants.googleApiKey)"
        path += "&location=\(location.coordinate.latitude),\(location.coordinate.longitude)&radius=\(radius)"
            
        apiController.callGetRequestForPath(path, mapping: place.getMapping(), keyPath: "results") { (statusCode, response) in
            if statusCode == .Success {
                success(places: response as? [Place])
            } else {
                failure(error: response as? Error)
            }
        }
    }
}
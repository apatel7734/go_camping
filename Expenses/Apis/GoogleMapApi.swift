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
    
    func getLatLngFromAddress(address: String?, success: (location: CLLocation?) -> Void, failure: (error: Error?) -> Void) {
        guard let aAddress = address else {
            failure(error: Error(.BadRequest, title: "Error", message: "Cannot identify the address"))
            return
        }
        
        let path = "\(basePath)/geocode/json?key=\(Constants.googleApiKey)&address=\(aAddress)"
        
        apiController.callGetRequestForPath(path, mapping: Geocoding.getMapping(), keyPath: "results") {
            (statusCode, response) in
            if statusCode == .Success {
                let geocoding = response as? [Geocoding]
                if geocoding?.count > 0, let location = geocoding?[0].geometry?.location {
                    success(location: CLLocation(latitude: Double(location.latitude), longitude: Double(location.longitude)))
                } else {
                    failure(error: Error(.Unknown))
                }
            } else {
                failure(error: response as? Error)
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
            
            apiController.callGetRequestForPath(path, mapping: Place.getMapping(), keyPath: "results") { (statusCode, response) in
                if statusCode == .Success {
                    success(places: response as? [Place])
                } else {
                    failure(error: response as? Error)
                }
            }
    }
    
    func getPlaceDetailForPlaceId(placeId: String, success: (placeDetail: PlaceDetail?) -> Void, failure: (error: Error?) -> Void) {
        let path = "\(basePath)/place/details/json?placeid=\(placeId)&key=\(Constants.googleApiKey)"
        
        apiController.callGetRequestForPath(path, mapping: PlaceDetail.getMapping(), keyPath: "result") { (statusCode, response) in
            if statusCode == .Success {
                success(placeDetail: response?[0] as? PlaceDetail)
            } else {
                failure(error: response as? Error)
            }
        }
    }
    
    func getPhotoUrlForReference(photoRef: String?, maxWidth: Int) -> String? {
        guard let reference = photoRef else {
            return nil
        }
        
        return "\(basePath)/place/photo?photoreference=\(reference)&maxwidth=\(maxWidth)&key=\(Constants.googleApiKey)"
    }
}
//
//  PlaceApiTests.swift
//  Expenses
//
//  Created by Emma on 11/5/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import CoreLocation
import XCTest
import Nimble

class PlaceApiTests: XCTestCase {

    var placeApi: PlacesApi!
    var fakeApiController = FakeApiController()
    
    override func setUp() {
        placeApi = PlacesApi(apiController: fakeApiController)
    }
    
    func testGetCampingSitesForLocation_callGetRequest() {
        let location = CLLocation(latitude: 30.000, longitude: 100.000)
        let radius = 500
        placeApi.getCampingSitesForLocation(location, radius: radius, success: { (places) in
            
            }) { (error) in
                
        }
        
        expect(self.fakeApiController.apiPath).to(contain("location=\(location.coordinate.latitude),\(location.coordinate.longitude)&radius=\(radius)"))
        expect(self.fakeApiController.keyPath).to(equal("results"))
    }
}

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

class GoogleMapApiTests: XCTestCase {

    var googleMapApi: GoogleMapApi!
    var fakeApiController = FakeApiController()
    
    override func setUp() {
        googleMapApi = GoogleMapApi(apiController: fakeApiController)
    }
    
    func testGetLatLngFromAddress_callGetRequest() {
        let address = "San Francisco"
        googleMapApi.getLatLngFromAddress(address, success: { (geocoding) in
            }) { (error) in
        }
        
        expect(self.fakeApiController.apiPath).to(contain("address=\(address)"))
        expect(self.fakeApiController.keyPath).to(equal("results"))
    }
    
    func testGetLatLngFromAddress_notCallGetRequest() {
        googleMapApi.getLatLngFromAddress(nil, success: { (geocoding) in
            }) { (error) in
        }
        
        expect(self.fakeApiController.apiPath).to(beNil())
        expect(self.fakeApiController.mapping).to(beNil())
        expect(self.fakeApiController.keyPath).to(beNil())
    }
    
    func testGetCampingSitesForLocation_callGetRequest() {
        let location = CLLocation(latitude: 30.000, longitude: 100.000)
        let radius = 500
        googleMapApi.getCampingSitesForLocation(location, radius: radius, success: { (places) in
            }) { (error) in
        }
        
        expect(self.fakeApiController.apiPath).to(contain("location=\(location.coordinate.latitude),\(location.coordinate.longitude)&radius=\(radius)"))
        expect(self.fakeApiController.keyPath).to(equal("results"))
    }
    
    func testGetCampingSitesForLocation_notCallGetRequest() {
        googleMapApi.getCampingSitesForLocation(nil, radius: 500, success: { (places) in
            }) { (error) in
        }
        
        expect(self.fakeApiController.apiPath).to(beNil())
        expect(self.fakeApiController.mapping).to(beNil())
        expect(self.fakeApiController.keyPath).to(beNil())
    }
}

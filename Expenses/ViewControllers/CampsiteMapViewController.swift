//
//  CampsiteMapViewController.swift
//  Expenses
//
//  Created by Emma on 11/10/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit
import MapKit

class CampsiteMapViewController: UIViewController {

    var campsiteList: [Place]? {
        didSet {
            self.showPlacesOnMap()
        }
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func showPlacesOnMap() {
        guard let aCampsiteList = campsiteList else {
            return
        }
        
        for place in aCampsiteList {
            if let location = place.geometry?.location {
                let pointAnnotation = MKPointAnnotation()
                pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: Double(location.latitude), longitude: Double(location.longitude))
                mapView.addAnnotation(pointAnnotation)
            }
        }
    }
}

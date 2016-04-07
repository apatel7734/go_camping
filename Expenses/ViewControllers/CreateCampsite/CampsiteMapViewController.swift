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
    
    private func showPlacesOnMap() {
        guard let aCampsiteList = campsiteList else {
            return
        }
        
        var annotations: [MKAnnotation] = []
        for place in aCampsiteList {
            if let location = place.geometry?.location {
                let pointAnnotation = MKPointAnnotation()
                let coordinate = CLLocationCoordinate2D(latitude: Double(location.latitude), longitude: Double(location.longitude))
                pointAnnotation.coordinate = coordinate
                pointAnnotation.title = place.name
                pointAnnotation.subtitle = place.vicinity
                annotations.append(pointAnnotation)
            }
        }
        
        mapView.showAnnotations(annotations, animated: true)
    }
}

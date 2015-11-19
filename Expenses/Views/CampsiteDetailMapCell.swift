//
//  CampsiteDetailMapCell.swift
//  Expenses
//
//  Created by Miyuki Suzuki on 11/19/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class CampsiteDetailMapCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    
    func configureCellWithLocation(location: CLLocationCoordinate2D?) {
        guard let aLocation = location else {
            return
        }
        
        mapView.centerCoordinate = aLocation
    
        let region = MKCoordinateRegionMakeWithDistance(aLocation, 1000.0, 1000.0)
        mapView.setRegion(region, animated: false)
    }
}

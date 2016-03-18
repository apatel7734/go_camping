//
//  TripDetailsViewController.swift
//  Expenses
//
//  Created by Patel, Ashish on 12/27/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit
import MapKit

class TripDetailsViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var locationAddressLabel: UILabel!
    @IBOutlet weak var fromDate: UILabel!
    @IBOutlet weak var toDate: UILabel!
    @IBOutlet weak var familiesRSVPSegmentedControl: UISegmentedControl!
    @IBOutlet weak var totalFamiliesRSVPLabel: UILabel!
    
    let regionRadius: CLLocationDistance = 1000
    var locationManager: CLLocationManager!
    
    //MARK:- Properties
    var campingTrip: GTLGocampingCampingTrip?
    
    @IBOutlet weak var rsvpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initMap()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        displayData()
    }
    
    private func displayData(){
        locationTitleLabel.text = self.campingTrip?.title
        fromDate.text = campingTrip?.dateFrom.millisecondsToDate()
        toDate.text = campingTrip?.dateTo.millisecondsToDate()
    }
    
    private func initMap(){
        locationManager = CLLocationManager()
        checkLocationAuthorizationStatus()
        
        
        if let longitude = self.campingTrip?.locationPoint.longitude.doubleValue, let latitude = self.campingTrip?.locationPoint.latitude.doubleValue{
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            centerMapOnLocation(location)
        }
        
    }
    
    
    @IBAction func didTapOnRSVPButton(sender: AnyObject) {
        
    }
    
    func centerMapOnLocation(location: CLLocationCoordinate2D){
        let region = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2, regionRadius * 2)
        mapView.setRegion(region, animated: true)
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
}

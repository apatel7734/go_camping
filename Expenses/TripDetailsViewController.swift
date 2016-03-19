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
    
    let regionRadius: CLLocationDistance = 500
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
        mapView.delegate = self
        mapView.scrollEnabled = false
        mapView.rotateEnabled = false
        mapView.pitchEnabled = false
        mapView.zoomEnabled = false
        
        locationManager = CLLocationManager()
        checkLocationAuthorizationStatus()
        if let longitude = self.campingTrip?.locationPoint.longitude.doubleValue, let latitude = self.campingTrip?.locationPoint.latitude.doubleValue, let title = self.campingTrip?.title{
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            centerMapOnLocation(location)
            
            //show annotation
            let campsiteAnnotation = CampsiteAnnotation(title: title , locationName: "", coordinate: location)
            mapView.addAnnotation(campsiteAnnotation)
            mapView.selectAnnotation(campsiteAnnotation, animated: true)
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

extension TripDetailsViewController : MKMapViewDelegate{
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? CampsiteAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.animatesDrop = true
                
                if let image = UIImage(named: "direction") as UIImage?{
                    let directionButton   = UIButton(type: UIButtonType.Custom)
                    directionButton.frame = CGRectMake(0, 0, 29, 29)
                    directionButton.setImage(image, forState: .Normal)
                    view.enabled = true
                    view.rightCalloutAccessoryView = directionButton as UIView
                }
            }
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //TODO: open google/apple map for direction....
    }
}


class CampsiteAnnotation : NSObject, MKAnnotation{
    
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        super.init()
    }
    
    var subTitle: String{
        return locationName
    }
}

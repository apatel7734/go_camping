//
//  CampsiteListViewController.swift
//  Expenses
//
//  Created by Emma on 11/10/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit
import CoreLocation

class CampsiteMainViewController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var listView: UIView!
    
    private lazy var googleMapApi: GoogleMapApi = self.initGoogleMapApi()

    private var listVC: CampsiteListViewController!
    private var mapVC: CampsiteMapViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBarHidden = true
        
        searchField.delegate = self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "containerForList" {
            listVC = segue.destinationViewController as! CampsiteListViewController
        } else if segue.identifier == "containerForMap" {
            mapVC = segue.destinationViewController as! CampsiteMapViewController
        }
    }
}

// MARK: - TextField delegate methods
extension CampsiteMainViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let address = textField.text where address.characters.count > 0 {
            searchCampsiteFromAddress(address)
        }
        
        return true
    }
}

// MARK: - Action methods
extension CampsiteMainViewController {
    
    @IBAction func viewSwitchTapped(sender: UIButton!) {
        let buttonTitle = sender.titleLabel?.text
        
        if buttonTitle == "Map" {
            sender.setTitle("List", forState: .Normal)
            UIView.transitionFromView(listView, toView: mapView, duration: 1.0, options: [.TransitionFlipFromRight, .ShowHideTransitionViews], completion: nil)
        } else {
            sender.setTitle("Map", forState: .Normal)
            UIView.transitionFromView(mapView, toView: listView, duration: 1.0, options: [.TransitionFlipFromRight, .ShowHideTransitionViews], completion: nil)
        }
    }
}

// MARK: - Private methods
extension CampsiteMainViewController {
    
    private func searchCampsiteFromAddress(address: String) {
        googleMapApi.getLatLngFromAddress(address, success: { (location) in
            if let aLocation = location {
                self.searchCampsiteForLocation(aLocation)
            }
            }) { (error) in
                //TODO handle this
        }
    }
    
    private func searchCampsiteForLocation(location: CLLocation) {
        googleMapApi.getCampingSitesForLocation(location, radius: 4000, success: { (places) in
            self.listVC.campsiteList = places
            
            }) { (error) in
            //TODO handle this
        }
    }
    
    private func initGoogleMapApi() -> GoogleMapApi {
        return GoogleMapApi(apiController: ApiController.sharedInstance)
    }
}

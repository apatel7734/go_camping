//
//  CampsiteListViewController.swift
//  Expenses
//
//  Created by Emma on 11/10/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

class CampsiteMainViewController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var listView: UIView!
    
    private lazy var googleMapApi: GoogleMapApi = self.initGoogleMapApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBarHidden = true
        
        searchField.delegate = self
        
        googleMapApi.getLatLngFromAddress("San Francisco", success: { (geocoding) -> Void in
            
            }) { (error) -> Void in
                
        }
    }
}

// MARK: - TextField delegate methods
extension CampsiteMainViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        
        return true
    }
}

// MARK: - Action methods
extension CampsiteMainViewController {
    
    @IBAction func viewSwitchTapped(sender: UIButton!) {
        let buttonTitle = sender.titleLabel?.text
        
        if buttonTitle == "Map" {
            sender.setTitle("List", forState: .Normal)
            UIView.transitionFromView(listView, toView: mapView, duration: 1.0, options: .TransitionFlipFromRight, completion: nil)
        } else {
            sender.setTitle("Map", forState: .Normal)
            UIView.transitionFromView(mapView, toView: listView, duration: 1.0, options: .TransitionFlipFromRight, completion: nil)
        }
    }
}

// MARK: - Private methods
extension CampsiteMainViewController {
    
    private func initGoogleMapApi() -> GoogleMapApi {
        return GoogleMapApi(apiController: ApiController())
    }
}

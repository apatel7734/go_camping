//
//  CampsiteListViewController.swift
//  Expenses
//
//  Created by Emma on 11/10/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

class CampsiteListViewController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var mapView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBarHidden = true
    }
}

// MARK: - Action methods
extension CampsiteListViewController {
    
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

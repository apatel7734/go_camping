//
//  ListCampingTripsViewController.swift
//  Expenses
//
//  Created by Patel, Ashish on 12/23/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

class ListCampingTripsViewController: UIViewController{
    
    @IBOutlet weak var campingTripsTableView: UITableView!
    var campingTrips = [GTLGocampingCampingTrip]()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        campingTripsTableView.delegate = self
        campingTripsTableView.dataSource = self
        
        campingTripsTableView.estimatedRowHeight = 125
        campingTripsTableView.rowHeight = UITableViewAutomaticDimension
        
        //this removes empty lines from tableview.
        campingTripsTableView.tableFooterView = UIView()
        configureNavigationBar()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        
        fetchCampingTripData()
    }
    
    private func configureNavigationBar(){
        self.navigationController?.navigationBar.configureAsBlueBar()
    }
    
    private func fetchCampingTripData(){
        let user = NSUserDefaultCoordinator.sharedInstance.loggedInUser
        let getCampingTripsQuery = GTLQueryGocamping.queryForGetCampingTripsWithObject(user)
        let service  = GTLServiceGocamping()

        self.activityIndicator.startAnimating()
        
        service.executeQuery(getCampingTripsQuery) { (tkt: GTLServiceTicket!, object: AnyObject!, error: NSError!) -> Void in
            self.activityIndicator.stopAnimating()
            if (error != nil) {
                //display error.
                print("Error = \(error)")
            }else{
                if let campingTripCollection = object as? GTLGocampingCampingTripCollection{
                    if let campingTrips = campingTripCollection.items() as? [GTLGocampingCampingTrip]{
                        self.campingTrips = campingTrips
                        self.campingTripsTableView.reloadData()
                    }
                }
            }
        }
        
    }
}

//MARK: - TableView Delegate and DataSource
extension ListCampingTripsViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return campingTrips.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = storyboard.instantiateViewControllerWithIdentifier("tripDetailAndFamilyTabbar")
        for tabBarChildVC in tabBar.childViewControllers{
            
            if let navigationVC = tabBarChildVC as? UINavigationController, familyVC = navigationVC.topViewController as? FamilyViewController{
                                familyVC.campingTrip = campingTrips[indexPath.row]
            }else if let navigationVC = tabBarChildVC as? UINavigationController, tripDetailsVC = navigationVC.topViewController as? TripDetailsViewController{
                tripDetailsVC.campingTrip = campingTrips[indexPath.row]
            }
            
        }
        presentViewController(tabBar, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = campingTripsTableView.dequeueReusableCellWithIdentifier("campingtripstableviewcell") as! CampingTripsTableViewCell
        cell.displayData(self.campingTrips[indexPath.row])
        
        return cell
    }
}

// MARK: - Action methods
extension ListCampingTripsViewController {
    
    @IBAction func createButtonTapped(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Campsite", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("CampsiteMainViewController")
        
        showViewController(vc, sender: self)
    }
}
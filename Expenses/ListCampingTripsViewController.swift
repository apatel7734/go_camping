//
//  ListCampingTripsViewController.swift
//  Expenses
//
//  Created by Patel, Ashish on 12/23/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

class ListCampingTripsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var campingTripsTableView: UITableView!
    
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
    }
    
    private func configureNavigationBar(){
        self.navigationController?.navigationBar.configureAsBlueBar()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = storyboard.instantiateViewControllerWithIdentifier("tripDetailAndFamilyTabbar")
        presentViewController(tabBar, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = campingTripsTableView.dequeueReusableCellWithIdentifier("campingtripstableviewcell") as! CampingTripsTableViewCell
        
        return cell
    }
    
}

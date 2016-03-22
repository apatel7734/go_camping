//
//  ViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 7/19/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit
import CoreData

class FamilyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource ,NSFetchedResultsControllerDelegate{
    
    var currentIndexPath: NSIndexPath?
    var campingTrip: GTLGocampingCampingTrip?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var familyTableView: UITableView!
    var families = [GTLGocampingFamily]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        familyTableView.delegate = self
        familyTableView.dataSource = self
        configureNavigationBar()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        
        if let trip = campingTrip{
            familiesForCampingtripId(trip)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        familyTableView.tableFooterView = UIView()
        //        updateFamilies()
    }
    
    func configureNavigationBar(){
        self.navigationController?.navigationBar.configureAsBlueBar()
        let addbutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "didTapAddButton")
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "didTapCancelBarButton")
        self.navigationItem.rightBarButtonItem = addbutton
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    
    func didTapAddButton(){
        performSegueWithIdentifier("presentaddnewfamily", sender: self)
    }
    
    func didTapCancelBarButton(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK - tableView datasource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let familyCell = tableView.dequeueReusableCellWithIdentifier("familycell") as! FamilyUITableViewCell
        let family = families[indexPath.row]
        familyCell.loadData(family)
        return familyCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return families.count
    }
    
    
    //MARK - tableView delegates
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.familyTableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.currentIndexPath = indexPath
        performSegueWithIdentifier("familyInfoPushSegue", sender: nil)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            families.removeAtIndex(indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.endUpdates()
            CommonUtility.sharedInstance.updateTotalExpenseAmountForEvent()
            CommonUtility.sharedInstance.updateTotalMembersCountForEvent()
        }
    }
    
    
    //MARK - segue methods on + button clicked.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let rootViewController = segue.destinationViewController as? RootViewController, indexPath = self.currentIndexPath{
            rootViewController.family = families[indexPath.row]
            rootViewController.campingTrip = campingTrip
        }
    }
    
    
    private func familiesForCampingtripId(campingTrip : GTLGocampingCampingTrip){
        if let tripId: Int64 = campingTrip.identifier.int64Value(){
            let query = GTLQueryGocamping.queryForGetFamiliesForCampingTripWithCampingTripId(tripId)
            let service  = GTLServiceGocamping()
            activityIndicator.startAnimating()
            service.executeQuery(query) { (tkt: GTLServiceTicket!, object: AnyObject!, error: NSError!) -> Void in
                self.activityIndicator.stopAnimating()
                if (error != nil) {
                    //display error.
                    print("Error : \(error)")
                }else{
                    //save logged in user
                    if let familyCollection = object as? GTLGocampingFamilyCollection{
                        if let families = familyCollection.items() as? [GTLGocampingFamily]{
                            self.families = families
                            self.familyTableView.reloadData()
                        }
                    }
                }
            }
        }
    }
}


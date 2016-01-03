//
//  FamilyMembersViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 7/31/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit


class FamilyMembersViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, AddEditFamilyMembersViewControllerDelegate {
    
    @IBOutlet weak var membersTableView: UITableView!

    var campingTrip: CampingTrip?
    var family: Family?
    var members = [Member]()
    var pageIndex: Int = 0
    
    //MARK: UIView Callback methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setup topbar button
        
        
        //delegates
        membersTableView.dataSource = self
        membersTableView.delegate = self
        
        membersTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(animated: Bool) {
        let addRightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addMembersButtonPressed:")
        if let navigationController = self.navigationController{
            navigationController.topViewController?.navigationItem.rightBarButtonItem = addRightBarButtonItem
        }
        self.navigationController?.topViewController?.navigationItem.title = "Members"
    }
    
    
    
    func didPickFamilyMember(member: Member, actionType: ActionType) {
        switch(actionType){
        case .Add:
            CommonUtility.sharedInstance.incrementTotalMembersCountForEvent()
        case .Update:
            //nothing to update
            break
        }
        self.membersTableView.reloadData()
    }
    
    //MARK: @IBActions
    func addMembersButtonPressed(sender: UIBarButtonItem){
        presentNextViewcontroller(nil)
    }
    
    func presentNextViewcontroller(member: Member?){
        let destVC = self.storyboard?.instantiateViewControllerWithIdentifier("addfamilymembersvc") as! AddEditFamilyMembersViewController
        if let member = member{
            destVC.member = member
        }
        destVC.delegate = self
        self.presentViewController(destVC, animated: true, completion: nil)
    }
    
    
    //MARK: UITableViewDelegates
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("membertableviewcell") as! MemberTableViewCell
        let member = members[indexPath.row]
        cell.loadData(member)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        membersTableView.deselectRowAtIndexPath(indexPath, animated: true)
        let member = members[indexPath.row]
        presentNextViewcontroller(member)
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch(editingStyle){
        case .Delete:
            members.removeAtIndex(indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.endUpdates()
            CommonUtility.sharedInstance.decrementTotalMembersCountForEvent()
        default:
            print("Not supported yet.")
        }
    }
}

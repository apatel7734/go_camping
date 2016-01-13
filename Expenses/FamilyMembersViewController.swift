//
//  FamilyMembersViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 7/31/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit


class FamilyMembersViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var membersTableView: UITableView!
    
    var campingTrip: CampingTrip?
    var family: Family?
    var members = [Member]()
    var pageIndex: Int = 0
    
    //MARK: UIView Callback methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //delegates
        membersTableView.dataSource = self
        membersTableView.delegate = self
        
        membersTableView.tableFooterView = UIView()
        
        updateMembers()
    }
    
    override func viewWillAppear(animated: Bool) {
        let addRightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addMembersButtonPressed:")
        if let navigationController = self.navigationController{
            navigationController.topViewController?.navigationItem.rightBarButtonItem = addRightBarButtonItem
        }
        self.navigationController?.topViewController?.navigationItem.title = "Members"
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
        destVC.family = family
        destVC.campingTrip = campingTrip
        self.presentViewController(destVC, animated: true, completion: nil)
    }
    
    
    //MARK: UITableViewDelegates
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("membertableviewcell") as! MemberTableViewCell
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressedCell:")
        cell.addGestureRecognizer(longPressGestureRecognizer)
        
        let member = members[indexPath.row]
        cell.loadData(member)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        membersTableView.deselectRowAtIndexPath(indexPath, animated: true)
        let member = members[indexPath.row]
        presentNextViewcontroller(member)
    }
    
    private func updateMembers(){
        if let familyId = family?.id{
            ParseManager.fetchMembersFor(familyId, pageNumber: 0, totalResultPerPage: 10) { (members, error) -> Void in
                if let members = members{
                    self.members = members
                    self.membersTableView.reloadData()
                }
            }
        }
    }
    
    func longPressedCell(longPressedGesuture: UILongPressGestureRecognizer){
        if let cell = longPressedGesuture.view as? MemberTableViewCell{
            if let indexPath = self.membersTableView.indexPathForCell(cell), campingTripId = campingTrip?.id, memberId = members[indexPath.row].id{
                showAlertAction(indexPath, memberId: memberId, campingTripId: campingTripId)
            }
        }
    }
    
    
    private func showAlertAction(indexPath: NSIndexPath, memberId: String, campingTripId: String){
        let optionMenu = UIAlertController(title: nil, message: "Choose option.", preferredStyle: .ActionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive) { (alertAction: UIAlertAction) -> Void in
            //handle DeleteAction here.
            ParseManager.deleteMember(memberId, campingTripId: campingTripId, completionBlock: { (success, error) -> Void in
                self.members.removeAtIndex(indexPath.row)
                self.membersTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (alertAction: UIAlertAction) -> Void in
            //handle cancel here.
            print("Do Nothing.")
        }
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    
}

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
    
    var campingTrip: GTLGocampingCampingTrip?
    var family: GTLGocampingFamily?
    var members = [GTLGocampingMember]()
    var pageIndex: Int = 0
    
    //MARK: UIView Callback methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //delegates
        membersTableView.dataSource = self
        membersTableView.delegate = self
        
        membersTableView.tableFooterView = UIView()
        
        fetchMembersForFamily()
    }
    
    override func viewWillAppear(animated: Bool) {
        let addRightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(FamilyMembersViewController.addMembersButtonPressed(_:)))
        if let navigationController = self.navigationController{
            navigationController.topViewController?.navigationItem.rightBarButtonItem = addRightBarButtonItem
        }
        self.navigationController?.topViewController?.navigationItem.title = "Members"
    }
    
    //MARK: @IBActions
    func addMembersButtonPressed(sender: UIBarButtonItem){
        presentNextViewcontroller(nil)
    }
    
    func presentNextViewcontroller(member: GTLGocampingMember?){
        let destVC = self.storyboard?.instantiateViewControllerWithIdentifier("addfamilymembersvc") as! AddEditFamilyMembersViewController
        if let member = member{
            //            destVC.member = member
        }
        //        destVC.family = family
        //        destVC.campingTrip = campingTrip
        self.presentViewController(destVC, animated: true, completion: nil)
    }
    
    
    //MARK: UITableViewDelegates
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("membertableviewcell") as! MemberTableViewCell
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(FamilyMembersViewController.longPressedCell(_:)))
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
    
    private func fetchMembersForFamily(){
        if let familyId = family?.identifier.int64Value(){
            let query = GTLQueryGocamping.queryForGetAllFamilyMembersWithFamilyId(familyId)
            let service  = GTLServiceGocamping()
            service.executeQuery(query) { (tkt: GTLServiceTicket!, object: AnyObject!, error: NSError!) -> Void in
                if (error != nil) {
                    //display error.
                    print("There was an error.")
                }else{
                    if let membersCollection = object as? GTLGocampingMemberCollection{
                        if let members = membersCollection.items() as? [GTLGocampingMember]{
                            self.members = members
                            self.membersTableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    func longPressedCell(longPressedGesuture: UILongPressGestureRecognizer){
        if let cell = longPressedGesuture.view as? MemberTableViewCell{
            if let indexPath = self.membersTableView.indexPathForCell(cell), tripId = campingTrip?.identifier, memberId = members[indexPath.row].identifier{
                showAlertAction(indexPath, memberId: memberId.stringValue, campingTripId: tripId.stringValue)
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

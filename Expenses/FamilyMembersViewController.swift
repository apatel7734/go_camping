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
    
    var family: Family?
    
    //MARK: UIView Callback methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setup topbar button
        let addRightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addMembersButtonPressed:")
        self.navigationController?.topViewController?.navigationItem.rightBarButtonItem = addRightBarButtonItem
        
        //delegates
        membersTableView.dataSource = self
        membersTableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.topViewController?.navigationItem.title = "Members"
    }
    
    
    
    func didPickFamilyMember(member: Member, actionType: ActionType) {
        member.family = self.family
        CoreDataStackManager.sharedInstance.saveContext()
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
        if let count = family?.members.count{
            return count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("membertableviewcell") as! MemberTableViewCell
        if let members = family?.members{
            cell.memberNameLabel.text = members[indexPath.row].name
            cell.memberImageView.showFirstCharacterFor(members[indexPath.row].name)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        membersTableView.deselectRowAtIndexPath(indexPath, animated: true)
        let member = family?.members[indexPath.row]
        presentNextViewcontroller(member)
    }
    
}

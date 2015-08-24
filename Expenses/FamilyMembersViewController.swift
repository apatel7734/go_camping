//
//  FamilyMembersViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 7/31/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

class FamilyMembersViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var membersTableView: UITableView!
    
    var family: Family?
    
    //MARK: UIView Callback methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setup topbar button
        var addRightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addMembersButtonPressed:")
        self.navigationController?.topViewController.navigationItem.rightBarButtonItem = addRightBarButtonItem
        
        //delegates
        membersTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.topViewController.navigationItem.title = "Members"
    }
    
    
    //MARK: @IBActions
    func addMembersButtonPressed(sender: UIBarButtonItem){
        println("addMembersButtonPressed()")
        var destVC = self.storyboard?.instantiateViewControllerWithIdentifier("addfamilymembersvc") as!AddFamilyMembersViewController
        self.presentViewController(destVC, animated: true, completion: nil)
    }
    
    
    //MARK: UITableViewDataSourceDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = family?.members.count{
            return count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("") as! MemberTableViewCell
        if let members = family?.members{
            cell.memberNameLabel.text = members[indexPath.row].name
        }
        return cell
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

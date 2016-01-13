//
//  InviteFamiliesViewController.swift
//  Expenses
//
//  Created by Patel, Ashish on 1/12/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import UIKit

class InviteFamiliesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - IBOutlets
    @IBOutlet weak var contactsTableView: UITableView!
    
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        contactsTableView.tableFooterView = UIView()
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        contactsTableView.estimatedRowHeight = 125
        contactsTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    //MARK: - TableView Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("contactInviteeTableViewCell") as!ContactsInviteeTableViewCell
        
        return cell
    }
    
    
}

//
//  CampsiteListViewController.swift
//  Expenses
//
//  Created by Emma on 11/10/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

class CampsiteListViewController: UITableViewController {

    var campsiteList: [Place]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CampsiteListViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return campsiteList?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("campsiteCell", forIndexPath: indexPath) as! CampsiteListCell
    
        if let list = campsiteList where indexPath.row < list.count {
            let campsite = list[indexPath.row]
            cell.configureCellWithName(campsite.name, address: campsite.vicinity, rating: Double(campsite.rating ?? 0))
        }
        
        return cell
    }
}

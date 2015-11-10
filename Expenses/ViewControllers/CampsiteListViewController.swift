//
//  CampsiteListViewController.swift
//  Expenses
//
//  Created by Emma on 11/10/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

class CampsiteListViewController: UITableViewController {

    var campsiteList: [Place]?
    
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
}

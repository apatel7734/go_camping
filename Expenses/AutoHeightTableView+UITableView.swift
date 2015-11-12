//
//  AutoHeightTableView+UITableView.swift
//  Expenses
//
//  Created by Emma on 11/12/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

extension UITableView {

    public override func awakeFromNib() {
        super.awakeFromNib()
        
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = 100.0;
    }
}

//
//  CampsiteListCell.swift
//  Expenses
//
//  Created by Emma on 11/12/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit
import Cosmos

class CampsiteListCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    func configureCellWithName(name: String, address: String?, rating: Double?) {
        nameLabel.text = name
        addressLabel.text = address
        ratingView.rating = rating ?? 0
    }
}

//
//  CampsiteDetailInfoCell.swift
//  Expenses
//
//  Created by Miyuki Suzuki on 11/19/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

class CampsiteDetailInfoCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    func configureCellWithPlaceDetail(place: PlaceDetail?) {
        nameLabel.text = place?.name
        addressLabel.text = place?.address
        phoneLabel.text = place?.phoneNumber
        websiteLabel.text = place?.website
    }
}

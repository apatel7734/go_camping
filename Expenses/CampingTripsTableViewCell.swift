//
//  CampingTripsTableViewCell.swift
//  Expenses
//
//  Created by Patel, Ashish on 12/23/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

class CampingTripsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var campingTripTitleLabel: UILabel!
    
    @IBOutlet weak var campingTripFromDateLabel: UILabel!
    
    @IBOutlet weak var campingTripToDateLabel: UILabel!
    
    @IBOutlet weak var campingTripAddressLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayData(campingTrip: CampingTrip){
        campingTripTitleLabel.text = campingTrip.title
        
        if let dateFrom = campingTrip.dateFrom{
            campingTripFromDateLabel.text = "\(dateFrom) To"
        }
        
        if let dateTo = campingTrip.dateTo{
            campingTripToDateLabel.text = dateTo
        }
        
        campingTripAddressLabel.text = campingTrip.address
    }
    
    
}
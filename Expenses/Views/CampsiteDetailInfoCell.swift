//
//  CampsiteDetailInfoCell.swift
//  Expenses
//
//  Created by Miyuki Suzuki on 11/19/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

protocol CampsiteDetailInfoCellDelegate: class {
    
    func phoneButtonTapped(phoneNumber: String!)
    func websiteButtonTapped(website: NSURL!)
}

class CampsiteDetailInfoCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var websiteButton: UIButton!
    
    weak var delegate: CampsiteDetailInfoCellDelegate?
    
    var place: PlaceDetail?
    
    private var originalVerticalConstraint: [NSLayoutConstraint]?
    
    override func awakeFromNib() {
         originalVerticalConstraint = phoneButton.constraintsAffectingLayoutForAxis(.Vertical)
    }
    
    func configureCellWithPlaceDetail(place: PlaceDetail?, delegate: CampsiteDetailInfoCellDelegate? = nil) {
        self.place = place
        self.delegate = delegate
        
        nameLabel.text = place?.name
        addressLabel.text = place?.address
        phoneButton.setTitle(place?.phoneNumber, forState: .Normal)
        websiteButton.setTitle(place?.website, forState: .Normal)
        
        if let constraint = originalVerticalConstraint {
            if place?.phoneNumber == nil {
                phoneButton.removeConstraints(constraint)
                phoneButton.frame = CGRectZero
            } else {
                phoneButton.addConstraints(constraint)
            }
        }
        
        phoneButton.addTarget(self, action: "phoneButtonTapped", forControlEvents: .TouchUpInside)
        websiteButton.addTarget(self, action: "websiteButtonTapped", forControlEvents: .TouchUpInside)
    }
    
    func phoneButtonTapped() {
        if let phoneNumber = place?.phoneNumber {
            delegate?.phoneButtonTapped(phoneNumber)
        }
    }
    
    func websiteButtonTapped() {
        if let website = place?.website, url = NSURL(string: website) {
            delegate?.websiteButtonTapped(url)
        }
    }
}

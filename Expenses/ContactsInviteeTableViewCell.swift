//
//  ContactsInviteeTableViewCell.swift
//  Expenses
//
//  Created by Patel, Ashish on 1/12/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import UIKit


class ContactsInviteeTableViewCell: UITableViewCell {

    @IBOutlet weak var inviteeImageView: CircularImageView!
    
    @IBOutlet weak var inviteeFullNameLabel: UILabel!
    
    @IBOutlet weak var inviteePhoneNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func loadData(){
        
    }

}

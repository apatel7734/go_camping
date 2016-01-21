//
//  ContactsInviteeTableViewCell.swift
//  Expenses
//
//  Created by Patel, Ashish on 1/12/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import UIKit
import Contacts


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
    
    
    func loadData(contact: CNContact){
        let fullName = CNContactFormatter.stringFromContact(contact, style: .FullName)
        self.inviteeFullNameLabel.text = fullName
        
        inviteePhoneNumberLabel.text = ContactsManager.commaSeparatedPhoneNumbers(contact)
        
        if let imageData = contact.imageData{
            inviteeImageView.image = UIImage(data: imageData)
        }else{
            inviteeImageView.showFirstCharacterFor(fullName)
            inviteeImageView.backgroundColor = UIColor.darkBlue()
        }
        if contact.phoneNumbers.count < 2 {
            self.accessoryType = UITableViewCellAccessoryType.Checkmark
        }else{
            self.accessoryType = UITableViewCellAccessoryType.DetailButton
        }
        
        
    }
    
}

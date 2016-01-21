//
//  ContactsManager.swift
//  Expenses
//
//  Created by Patel, Ashish on 1/12/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import Foundation
import Contacts

class ContactsManager {
    
    /*
    let predicate = CNContact.predicateForContactsMatchingName(self.txtLastName.text!)
    let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey, CNContactBirthdayKey]
    var contacts = [CNContact]()
    var message: String!
    */
    static func fetchContacts(){
        
    }
    
    
    static func commaSeparatedPhoneNumbers(contact: CNContact) -> String{
        var phoneNumbers = ""
        let firstIndex = contact.phoneNumbers.startIndex
        let lastIndex = contact.phoneNumbers.endIndex-1
        
        for index: Int in firstIndex...lastIndex{
            if let phoneNumber = contact.phoneNumbers[index].value as? CNPhoneNumber{
                phoneNumbers.appendContentsOf(phoneNumber.stringValue)
                if index != lastIndex{
                    phoneNumbers.appendContentsOf(", ")
                }
            }
        }
        
        return phoneNumbers
    }
    
}
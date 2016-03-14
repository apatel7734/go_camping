//
//  FamilyUITableViewCell.swift
//  Expenses
//
//  Created by Ashish Patel on 7/19/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

class FamilyUITableViewCell: UITableViewCell {
    
    @IBOutlet weak var familyName: UILabel!
    @IBOutlet weak var totalMembers: UILabel!
    @IBOutlet weak var totalExpenses: UILabel!
    
    @IBOutlet weak var familyImage: CircularImageView!
    
    
    func loadData(family: GTLGocampingFamily){

        self.familyName.text = family.fullName
        if let memberIds = family.memberIds{
            self.totalMembers.text = "\(memberIds.count)"
        }
        self.totalExpenses.text = NSDecimalNumber(decimal: family.totalOwedExpenseAmount.decimalValue).currencyFormattedValueWithDollarPrefix()
        self.familyImage.showFirstCharacterFor(family.fullName)
    }
    
}

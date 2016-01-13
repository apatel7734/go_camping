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
    
    
    func loadData(family: Family){
        self.familyName.text = family.name
        if let count = family.membersIds?.count{
            self.totalMembers.text = "\(count)"
        }
        self.totalExpenses.text = family.totalOwedExpense?.currencyFormattedValueWithDollarPrefix()
        self.familyImage.showFirstCharacterFor(family.name)
    }
    
}

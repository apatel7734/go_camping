//
//  ExpenseTableViewCell.swift
//  Expenses
//
//  Created by Patel, Ashish on 10/20/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var expenseImageView: CircularImageView!
    
    @IBOutlet weak var expenseName: UILabel!

    @IBOutlet weak var expenseAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

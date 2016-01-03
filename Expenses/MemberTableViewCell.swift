//
//  MemberTableViewCell.swift
//  Expenses
//
//  Created by Ashish Patel on 8/23/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {
    @IBOutlet weak var memberNameLabel: UILabel!
    
    @IBOutlet weak var memberImageView: CircularImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func loadData(member: Member){
        self.memberNameLabel.text = member.name
        self.memberImageView.showFirstCharacterFor(member.name)
    }
    
}

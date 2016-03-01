//
//  DateFormatterUtil.swift
//  Expenses
//
//  Created by Emma on 3/1/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import Foundation

class DateFormatterUtil {
    
    static let mediumDateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        
        return formatter
    }()
}

//
//  UIColorExtension.swift
//  Expenses
//
//  Created by Ashish Patel on 7/19/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import Foundation
import UIKit

extension NSDate{
    
    func fullStyleString() -> String{
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.FullStyle
        formatter.timeStyle = .ShortStyle
        return formatter.stringFromDate(self)
    }
    
    func before(date: NSDate) -> Bool {
        return self.compare(date) == .OrderedAscending
    }
    
    func after(date: NSDate) -> Bool {
        return self.compare(date) == .OrderedDescending
    }
}

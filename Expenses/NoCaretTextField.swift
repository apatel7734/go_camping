//
//  NoCaretTextField.swift
//  Expenses
//
//  Created by Patel, Ashish on 12/19/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

class NoCaretTextField: UITextField {
    
    override func caretRectForPosition(position: UITextPosition) -> CGRect {
        return CGRectZero
    }
}

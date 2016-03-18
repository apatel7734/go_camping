//
//  AutoHeightButton.swift
//  Expenses
//
//  Created by Emma on 3/18/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import UIKit

class AutoHeightButton: UIButton {

    override func intrinsicContentSize() -> CGSize {
        if titleLabel?.text == nil {
            return CGSizeZero
        } else {
            return super.intrinsicContentSize()
        }
    }
}

//
//  EnterPhoneNumberViewController.swift
//  Expenses
//
//  Created by Patel, Ashish on 11/7/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

class EnterPhoneNumberViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberTextField: CustomTextField!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var submitButonBottomLayoutConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        self.phoneNumberTextField.becomeFirstResponder()
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height {
                submitButonBottomLayoutConstraint.constant = keyboardHeight + 20
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
}
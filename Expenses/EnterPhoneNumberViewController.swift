//
//  EnterPhoneNumberViewController.swift
//  Expenses
//
//  Created by Patel, Ashish on 11/7/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

class EnterPhoneNumberViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var phoneNumberTextField: CustomTextField!
    
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var submitButonBottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var codeTextFieldLeadingLayoutConstraint: NSLayoutConstraint!
    
    
    private var phoneNumber: String = ""{
        didSet{
            phoneNumberTextField.text = StringFormatterUtil.sharedInstance.formatPhoneNumber(phoneNumber)
        }
    }
    
    //MARK - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //observers
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        //delegates
        self.phoneNumberTextField.becomeFirstResponder()
        self.phoneNumberTextField.delegate = self
        codeTextFieldLeadingLayoutConstraint.constant = 375 - 16
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    //@IBActions
    
    @IBAction func didSubmitTapped(sender: AnyObject) {
        animateToShowCodeTextField()
    }
    
    //MARK - UITextfield delegate methods
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        //check empty string for return
        if string.isEmpty && phoneNumber.characters.count > 0{
            phoneNumber.removeAtIndex(phoneNumber.endIndex.predecessor())
        }else if phoneNumber.characters.count < 10{
            phoneNumber.append(Character(string))
        }
        return false
    }
    
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        phoneNumber = ""
        return true
    }
    
    //MARK - Utilities methods
    
    private func animateToShowCodeTextField(){
        let phoneNumberFrame = phoneNumberTextField.frame
        let xToHidePhoneNumber = 0 - phoneNumberFrame.origin.x - phoneNumberFrame.width
        let xToShowCode = xToHidePhoneNumber
        let translateHidePhoneNumberBounds = CGAffineTransformMakeTranslation(xToHidePhoneNumber, 0)
        let translateShowCodeNumber = CGAffineTransformMakeTranslation(xToShowCode, 0)
        UIView.animateWithDuration(0.5) { () -> Void in
            self.phoneNumberTextField.transform = translateHidePhoneNumberBounds
            self.codeTextField.transform = translateShowCodeNumber
        }
    }
    
    private func animateToHideCodeTextField(){
        let phoneNumberFrame = phoneNumberTextField.frame
        let xToHidePhoneNumber = 0 - phoneNumberFrame.origin.x - phoneNumberFrame.width
        let xToShowCode = xToHidePhoneNumber
        let translateHidePhoneNumberBounds = CGAffineTransformMakeTranslation(xToHidePhoneNumber, 0)
        let translateShowCodeNumber = CGAffineTransformMakeTranslation(xToShowCode, 0)
        UIView.animateWithDuration(0.5) { () -> Void in
            self.phoneNumberTextField.transform = translateHidePhoneNumberBounds
            self.codeTextField.transform = translateShowCodeNumber
        }
    }
    
    
    //MARK - Keyboard methods
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

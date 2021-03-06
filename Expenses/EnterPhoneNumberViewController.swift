//
//  EnterPhoneNumberViewController.swift
//  Expenses
//
//  Created by Patel, Ashish on 11/7/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

class EnterPhoneNumberViewController: UIViewController,UITextFieldDelegate {
    
    //MARK: - @IBOutlets
    @IBOutlet weak var phoneNumberTextField: CustomTextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var submitButonBottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var codeTextFieldLeadingLayoutConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    private var isPhoneNumberVisible: Bool = true{
        didSet{
            if isPhoneNumberVisible{
                phoneNumberTextField.becomeFirstResponder()
                submitButton.setTitle("Submit", forState: UIControlState.Normal)
            }else{
                codeTextField.becomeFirstResponder()
                submitButton.setTitle("Login", forState: UIControlState.Normal)
            }
            updateSubmitButtonUI()
        }
    }
    
    private var phoneNumber: String = ""{
        didSet{
            phoneNumberTextField.text = StringFormatterUtil.sharedInstance.formatPhoneNumber(phoneNumber)
            updateSubmitButtonUI()
        }
    }
    
    private var loginCode: String = ""{
        didSet{
            codeTextField.text = loginCode
            updateSubmitButtonUI()
        }
    }
    
    private var enableSubmitButton: Bool = false{
        didSet{
            if enableSubmitButton{
                submitButton.backgroundColor = UIColor.greenColor()
                submitButton.enabled = true
            }else{
                submitButton.backgroundColor = UIColor.darkGrayColor()
                submitButton.enabled = false
            }
        }
    }
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //observers
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        //delegates
        self.phoneNumberTextField.becomeFirstResponder()
        self.phoneNumberTextField.delegate = self
        self.codeTextField.delegate = self
        let margins = self.view.layoutMargins
        codeTextFieldLeadingLayoutConstraint.constant = UIScreen.mainScreen().bounds.width - (margins.left + margins.right)
        enableSubmitButton = false
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    //MARK: - @IBActions
    @IBAction func didSubmitTapped(sender: UIButton) {
        if isPhoneNumberVisible && sender.titleLabel?.text == "Submit"{
            submitPhoneNumber()
        }else if sender.titleLabel?.text == "Login"{
            submitConfirmationCode()
        }
    }
    
    //MARK: - UITextfield delegate methods
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        switch(textField){
        case phoneNumberTextField:
            handlePhoneNumbeTextFieldChange(string)
            
        case codeTextField:
            handleCodeTextFieldChange(string)
            
        default:
            break
        }
        
        return false
    }
    
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        switch(textField){
        case phoneNumberTextField:
            phoneNumber = ""
        case codeTextField:
            loginCode = ""
        default:
            break;
        }
        return true
    }
    
    //MARK: - Utilities methods
    private func submitPhoneNumber(){
        APICoordinator.submitPhoneNumber(phoneNumber) { (response, error) -> Void in
            print("submitPhoneNumber - response - \(response) and error \(error)")
            if self.isPhoneNumberVisible{
                self.animateToShowCodeTextField()
            }else{
                self.animateToHideCodeTextField()
            }
        }
    }
    
    private func submitConfirmationCode(){
        APICoordinator.submitCode(loginCode, phoneNumber: phoneNumber) { (response, error) -> Void in
            print("submitConfirmationCode - response - \(response) and error \(error)")
        }
    }
    
    
    private func animateToShowCodeTextField(){
        let phoneNumberFrame = phoneNumberTextField.frame
        let xToHidePhoneNumber = 0 - phoneNumberFrame.origin.x - phoneNumberFrame.width
        let xToShowCode = xToHidePhoneNumber
        let translateHidePhoneNumberBounds = CGAffineTransformMakeTranslation(xToHidePhoneNumber, 0)
        let translateShowCodeNumber = CGAffineTransformMakeTranslation(xToShowCode, 0)
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.phoneNumberTextField.transform = translateHidePhoneNumberBounds
            self.codeTextField.transform = translateShowCodeNumber
            }) { (success: Bool) -> Void in
                self.isPhoneNumberVisible = false
        }
    }
    
    private func animateToHideCodeTextField(){
        let translateHidePhoneNumberBounds = CGAffineTransformMakeTranslation(0, 0)
        let translateShowCodeNumber = CGAffineTransformMakeTranslation(0, 0)
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.phoneNumberTextField.transform = translateHidePhoneNumberBounds
            self.codeTextField.transform = translateShowCodeNumber
            }) { (success: Bool) -> Void in
                self.isPhoneNumberVisible = true
        }
    }
    
    private func handlePhoneNumbeTextFieldChange(string: String){
        //check empty string for return
        if string.isEmpty && phoneNumber.characters.count > 0{
            phoneNumber.removeAtIndex(phoneNumber.endIndex.predecessor())
        }else if phoneNumber.characters.count < 10{
            phoneNumber.append(Character(string))
        }
    }
    
    private func handleCodeTextFieldChange(string: String){
        //check empty string for return
        if string.isEmpty && loginCode.characters.count > 0{
            loginCode.removeAtIndex(loginCode.endIndex.predecessor())
        }else if loginCode.characters.count < 4{
            loginCode.append(Character(string))
        }
    }
    
    private func updateSubmitButtonUI(){
        if isPhoneNumberVisible{
            if phoneNumber.characters.count == 10{
                enableSubmitButton = true
            }else{
                enableSubmitButton = false
            }
        }else{
            if loginCode.characters.count == 4{
                enableSubmitButton = true
            }else{
                enableSubmitButton = false
            }
        }
        
    }
    
    //MARK: - Keyboard methods
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

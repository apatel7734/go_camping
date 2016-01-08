//
//  AddFamilyUIViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 7/31/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit
import CoreData

class AddFamilyUIViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var familyNameTextField: CustomTextField!
    @IBOutlet weak var phoneNumberTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addFamilyButton: UIButton!
    
    private var phoneNumber: String = ""{
        didSet{
            let formattedPhoneNumber = StringFormatterUtil.sharedInstance.formatPhoneNumber(phoneNumber)
            phoneNumberTextField.text = formattedPhoneNumber
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cancelButton.layer.cornerRadius = 8
        addFamilyButton.layer.cornerRadius = 8
        
        familyNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
    }
    
    //MARK - UITextFieldDelegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        switch(textField){
            
        case familyNameTextField:
            if let isNameEmpty = familyNameTextField.text?.isEmpty{
                let charCount = familyNameTextField.text?.characters.count
                if isNameEmpty || charCount < 15{
                    return true
                }
            }
            
        case phoneNumberTextField:
            return phoneNumberTextField(string)
            
        case emailTextField:
            
            var email = ""
            if let currentText = emailTextField.text{
                email.appendContentsOf(currentText)
            }
            email.appendContentsOf(string)
            
            let validationResponse = ValidationUtil.sharedValidationUtil.isValidEmail(email)
            if(validationResponse.isValid){
                return true
            }else{
                print("Not valid Email...: \(validationResponse.errorMessage)")
            }
            
        default:
            print("Cant find textFieldType")
        }
        return false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    
    
    private func phoneNumberTextField(string: String) -> Bool{
        var number = phoneNumber
        
        if string.isEmpty{
            //remove button pressed.
            phoneNumber = number.substringToIndex(number.endIndex.predecessor())
            return true
        }else{
            number.append(Character(string))
        }
        
        let charCount = phoneNumber.characters.count
        
        if (charCount < 10){
            phoneNumber = number
        }else{
            // move to next textfield
            emailTextField.becomeFirstResponder()
        }
        return false
    }
    
    private func areDataValidTobeSaved() -> Bool{
        //validate family Name
        let validationResponse = ValidationUtil.sharedValidationUtil.isValidName(familyNameTextField.text)
        if !validationResponse.isValid{
            ErrorView.sharedView.showErrorMessage(self.view, message: validationResponse.errorMessage!)
            return false
        }
        
        //validate phoneNumber
        let phoneResponse = ValidationUtil.sharedValidationUtil.isValidPhoneNumber(phoneNumber)
        if !phoneResponse.isValid{
            ErrorView.sharedView.showErrorMessage(self.view, message: phoneResponse.errorMessage!)
            return false
        }
        
        //validate email
        let emailResponse = ValidationUtil.sharedValidationUtil.isValidEmail(emailTextField.text)
        if !emailResponse.isValid{
            ErrorView.sharedView.showErrorMessage(self.view, message: emailResponse.errorMessage!)
            return false
        }
        
        return true
    }
    
    //MARK - IBActions
    @IBAction func onTapCancelButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onTapView(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    @IBAction func onTapAddFamilyButton(sender: UIButton) {
        if !areDataValidTobeSaved(){
            return
        }
        
        let familyName = familyNameTextField.text!
        let phone =  phoneNumber
        let email = emailTextField.text!
        
        let family = Family()
        family.name = familyName
        family.phoneNumber = phone
        family.email = email
        ParseManager.addFamilyToParse(family) { (success, error) -> Void in
            if success{
                print("Add Family Success!")
                self.dismissViewControllerAnimated(true, completion: nil)
            }else if let error = error{
                print("Add Family Error = \(error)")
            }
        }
    }
    
}


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
    var phoneNumber: String = ""{
        didSet{
            let formattedPhoneNumber = StringFormatterUtil.sharedStringFormatterUtil.formatPhoneNumber(phoneNumber)
            phoneNumberTextField.text = formattedPhoneNumber
        }
    }
    
    @IBOutlet weak var emailTextField: CustomTextField!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addFamilyButton: UIButton!
    
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
            familyNameTextField(string)
            
        case phoneNumberTextField:
            phoneNumberTextField(string)
            
        case emailTextField:
            emailTextField(string)
            
        default:
            print("Cant find textFieldType")
        }
        return false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    
    private func phoneNumberTextField(string: String){
        var number = phoneNumber
        if string.isEmpty{
            //remove button pressed.
            phoneNumber = number.substringToIndex(number.endIndex.predecessor())
        }else{
            number.append(Character(string))
        }
        let validateResponse = ValidationUtil.sharedValidationUtil.isValidPhoneNumber(number)
        if (validateResponse.isValid){
            phoneNumber = number
        }else{
            // move to next
            emailTextField.becomeFirstResponder()
        }
    }
    
    private func familyNameTextField(string: String){
        
    }
    
    private func emailTextField(string: String){
        
    }
    
    
    @IBAction func onTapCancelButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onTapView(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    @IBAction func onTapAddFamilyButton(sender: UIButton) {
        
        let dictionary : [String: AnyObject] = [Family.Keys.Name : familyNameTextField.text!]
        
        let _ = Family(dictionary: dictionary, context: CoreDataStackManager.sharedInstance.managedObjectContext)
        
        CoreDataStackManager.sharedInstance.saveContext()
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

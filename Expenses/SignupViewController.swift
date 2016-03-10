//
//  SignupViewController.swift
//  Expenses
//
//  Created by Patel, Ashish on 2/21/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberTextField.delegate = self
        nameTextField.delegate = self
        passwordTextField.delegate = self
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if textField == phoneNumberTextField{
            let newNumber = phoneNumberTextField.text?.formatPhoneNumberWithSpaces()
            if(!ValidationUtil.sharedValidationUtil.isValidPhoneNumber(newNumber).isValid){
                phoneNumberTextField.text = newNumber
                return true
            }
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch(textField){
        case nameTextField:
            phoneNumberTextField.becomeFirstResponder()
            
        case phoneNumberTextField:
            passwordTextField.becomeFirstResponder()
            
        case passwordTextField:
            view.endEditing(true)
            
        default:
            break;
        }
        return true
    }
    
    
    @IBAction func didTapOnSignupButton(sender: AnyObject) {
        let userAccount = GTLGocampingUserAccount()
        guard let phoneNumber = phoneNumberTextField.text, numberInt = Int(phoneNumber.removeWhiteSpaces()) else {
            print("Error, phoneNumber can't be empty.")
            return
        }
        userAccount.phoneNumber = NSNumber(integer: numberInt)
        userAccount.fullName = nameTextField.text!

        let query = GTLQueryGocamping.queryForRegisterUserWithObject(userAccount);
        let service  = GTLServiceGocamping()
        service.executeQuery(query) { (tkt: GTLServiceTicket!, object: AnyObject!, error: NSError!) -> Void in
            if (error != nil) {
                //display error.
                print("There was an error.")
            }else{
                //save logged in user
                NSUserDefaultCoordinator.sharedInstance.loggedInUser = userAccount
                //go to next step.
                let storyboard = UIStoryboard(name: "ManageTrip", bundle: nil)
                self.presentViewController(storyboard.instantiateInitialViewController()!, animated: true, completion: nil)
            }
            
        }
    }
}

//
//  AddEditFamilyMembersViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 8/21/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

class AddEditFamilyMembersViewController: UIViewController, UITextFieldDelegate {
    
    var family: Family?
    var campingTrip: CampingTrip?
    var member: Member?
    
    //MARK:@IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var memberImageView: CircularImageView!
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var phoneNumberTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var ageTextField: CustomTextField!
    
    @IBOutlet weak var updateActionButton: CustomButton!
    
    private var phoneNumber: String = ""{
        didSet{
            let formattedPhoneNumber = StringFormatterUtil.sharedInstance.formatPhoneNumber(phoneNumber)
            phoneNumberTextField.text = formattedPhoneNumber
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //        updateViewControllerForAddorEdit()
        
        nameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        ageTextField.delegate = self
    }
    
    @IBAction func updateActionButtonPressed(sender: AnyObject) {
        if dataValidTobeSaved(){
            addOrUpdateFamilyMember()
        }
    }
    
    
    
    //MARK - UITextFieldDelegate method
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        switch(textField){
        case emailTextField:
            return true
            
        case nameTextField:
            return true
        case phoneNumberTextField:
            return phoneNumberTextField(string)
            
        case ageTextField:
            if string == "" || ageTextField.text?.characters.count < 3{
                return true
            }
            
        default:
            break;
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
        
        if (phoneNumber.characters.count < 10){
            phoneNumber = number
        }else{
            // move to next textfield
            emailTextField.becomeFirstResponder()
        }
        return false
    }
    
    
    private func dataValidTobeSaved() -> Bool{
        //validate Name
        let nameResponse = ValidationUtil.sharedValidationUtil.isValidName(nameTextField.text)
        if !nameResponse.isValid {
            
            ErrorView.sharedView.showErrorMessage(self.view, message: nameResponse.errorMessage!)
            return false
        }
        //validate email
        let emailResponse = ValidationUtil.sharedValidationUtil.isValidEmail(emailTextField.text)
        if !emailResponse.isValid{
            ErrorView.sharedView.showErrorMessage(self.view, message: emailResponse.errorMessage!)
            return false
        }
        
        //validate phoneNumber
        let phoneNumberResponse = ValidationUtil.sharedValidationUtil.isValidPhoneNumber(phoneNumber)
        if !phoneNumberResponse.isValid{
            ErrorView.sharedView.showErrorMessage(self.view, message: phoneNumberResponse.errorMessage!)
            return false
        }
        
        //validate age
        let ageResponse = ValidationUtil.sharedValidationUtil.isValidAge(ageTextField.text)
        if !ageResponse.isValid{
            ErrorView.sharedView.showErrorMessage(self.view, message: emailResponse.errorMessage!)
            return false
        }
        
        return true
    }
    
    func addOrUpdateFamilyMember(){
        if let familyId = family?.id, campingTripId = campingTrip?.id{
            let memberParams = CommonUtility.sharedInstance.memberParams(familyId, campingTripId: campingTripId,  name: nameTextField.text, age: ageTextField.text, email: emailTextField.text, phoneNumber: self.phoneNumber)
            ParseManager.addNewMember(memberParams) { (success, error) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelButtonClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onViewTapped(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    
    //MARK: - helper methods
    func updateViewControllerForAddorEdit(){
        if let member = member{
            //edit view controller
            titleLabel.text = Constants.editMember
            
            if let memberName = member.name{
                nameTextField.text = memberName
            }
            if let memberPhone = member.phoneNumber{
                phoneNumber = "\(memberPhone)"
            }
            if let memberAge = member.age{
                ageTextField.text = "\(memberAge)"
            }
            updateActionButton.setTitle(Constants.update, forState: UIControlState.Normal)
            memberImageView.showFirstCharacterFor(member.name)
            
        }else{
            //add view controller
            titleLabel.text = Constants.addNewMember
            nameTextField.text = Constants.emptyString
            phoneNumberTextField.text = Constants.emptyString
            emailTextField.text = Constants.emptyString
            ageTextField.text = Constants.emptyString
            updateActionButton.setTitle(Constants.add, forState: UIControlState.Normal)
        }
    }
    
}

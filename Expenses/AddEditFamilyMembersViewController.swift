//
//  AddEditFamilyMembersViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 8/21/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

protocol AddEditFamilyMembersViewControllerDelegate{
    func didPickFamilyMember(member: Member, actionType: ActionType)
}

class AddEditFamilyMembersViewController: UIViewController, UITextFieldDelegate {
    
    var delegate: AddEditFamilyMembersViewControllerDelegate?
    
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
    
    
    var member: Member?
    
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
            self.dismissViewControllerAnimated(true, completion: nil)
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
        let name = nameTextField.text!
        let phone = phoneNumber
        let age = ageTextField.text!
        let email = emailTextField.text!
        var actionType = ActionType.Add
        
        if let _ = member{
            //            member?.name = name
            //            member?.phoneNumber = Int(phone)
            //            member?.email = email
            //            member?.age = Int(age)
            //            actionType = .Update
            //
            //        }else{
            //            let memberDict = [Member.Keys.Name: name, Member.Keys.PhoneNumber : phone, Member.Keys.Age : age, Member.Keys.Email : email]
            //
            //            self.member = Member(dictionary: memberDict, context: CoreDataStackManager.sharedInstance.managedObjectContext)
        }
        delegate?.didPickFamilyMember(member!, actionType: actionType)
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
            //            if let memberEmail = member.email{
            //                emailTextField.text = memberEmail
            //            }
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

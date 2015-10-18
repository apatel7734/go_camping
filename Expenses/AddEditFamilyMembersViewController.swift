//
//  AddEditFamilyMembersViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 8/21/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

protocol AddEditFamilyMembersViewControllerDelegate{
    func didPickFamilyMember(member: Member, actionType: ActionTypes)
}

class AddEditFamilyMembersViewController: UIViewController {
    
    var delegate: AddEditFamilyMembersViewControllerDelegate?
    
    //MARK:@IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var memberImageView: CircularImageView!
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var phoneNumberTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var ageTextField: CustomTextField!
    
    @IBOutlet weak var updateActionButton: CustomButton!
    
    var member: Member?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateViewControllerForAddorEdit()
    }
    
    @IBAction func updateActionButtonPressed(sender: AnyObject) {
        addOrUpdateFamilyMember()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addOrUpdateFamilyMember(){
        let name = nameTextField.text!
        let phoneNumber = phoneNumberTextField.text!
        let age = ageTextField.text!
        let email = emailTextField.text!
        var actionType = ActionTypes.Add
        
        if let _ = member{
            member?.name = name
            member?.phoneNumber = Int(phoneNumber)
            member?.name = name
            member?.age = Int(age)
            actionType = ActionTypes.Edit
            
        }else{
            let memberDict = [Member.Keys.Name: name, Member.Keys.PhoneNumber : phoneNumber, Member.Keys.Age : age, Member.Keys.Email : email]
            
            self.member = Member(dictionary: memberDict, context: CoreDataStackManager.sharedInstance.managedObjectContext)
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
            nameTextField.text = member.name != nil ? member.name : Constants.emptyString
            phoneNumberTextField.text = member.phoneNumber != nil ? "\(member.phoneNumber)" : Constants.emptyString
            emailTextField.text = member.email != nil ? member.email : Constants.emptyString
            ageTextField.text = member.age != nil ? "\(member.age)" : Constants.emptyString
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

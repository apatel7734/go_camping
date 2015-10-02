//
//  AddEditFamilyMembersViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 8/21/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

//protocol AddEditFamilyMembersDelegate{
//    func newAddedOrUpdated(#member: Member, with actionType: ActionTypes)
//}

class AddEditFamilyMembersViewController: UIViewController {
    
    //    var delegate: AddEditFamilyMembersDelegate?
    
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
        let updateActionButtonTitle = updateActionButton.titleLabel?.text
        if let updateActionButtonTitle = updateActionButtonTitle{
            switch(updateActionButtonTitle){
            case Constants.update:
                print("\(Constants.update) Clicked.")
                break;
            case Constants.add:
                print("\(Constants.add) Clicked.")
                break;
            default:
                break;
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

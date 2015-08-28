//
//  AddEditFamilyMembersViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 8/21/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

class AddEditFamilyMembersViewController: UIViewController {
    
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
            titleLabel.text = "Edit Member"
            nameTextField.text = member.name != nil ? member.name : ""
            phoneNumberTextField.text = member.phoneNumber != nil ? "\(member.phoneNumber)" : ""
            emailTextField.text = member.email != nil ? member.email : ""
            ageTextField.text = member.age != nil ? "\(member.age)" : ""
            updateActionButton.setTitle("Update", forState: UIControlState.Normal)
            
        }else{
            println("Member Add")
            //add view controller
            titleLabel.text = "Add New Member"
            nameTextField.text = ""
            phoneNumberTextField.text = ""
            emailTextField.text = ""
            ageTextField.text = ""
            updateActionButton.setTitle("Add", forState: UIControlState.Normal)
        }
    }
    
}

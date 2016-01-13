//
//  AddEditFamilyExpensesViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 8/21/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

protocol AddEditFamilyExpensesViewControllerDelegate{
    func didPickExpense(expense: Expense, actionType: ActionType)
}

class AddEditFamilyExpensesViewController: UIViewController {
    
    
    var delegate: AddEditFamilyExpensesViewControllerDelegate?
    var expense: Expense?
    var family: Family?
    var campingTrip: CampingTrip?
    
    //MARK: - IBOutlets
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var descTextField: CustomTextField!
    @IBOutlet weak var amountTextfield: CustomTextField!
    
    @IBOutlet weak var addUpdateButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateLabels()
        
        if let expense = expense{
            displayExpensesInfo(expense)
        }
    }
    
    private func dataValidTobeSaved() -> Bool{
        //validate name
        let nameResponse = ValidationUtil.sharedValidationUtil.isValidName(nameTextField.text)
        if (!nameResponse.isValid){
            print("Not valid name : \(nameResponse.errorMessage)")
            ErrorView.sharedView.showErrorMessage(self.view, message: nameResponse.errorMessage!)
        }
        
        //validate short desc
        
        
        //validate amount
        
        
        return true
    }
    
    func displayExpensesInfo(expense: Expense){
        nameTextField.text = expense.name
        descTextField.text = expense.desc
        //        amountTextfield.text = expense.amount?.stringValue
    }
    
    func updateLabels(){
        if (expense == nil){
            addUpdateButton.setTitle("Add", forState: UIControlState.Normal)
        }else{
            addUpdateButton.setTitle("Update", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func addOrUpdateButtonClicked(sender: AnyObject) {
        if dataValidTobeSaved(){
            addOrUpdateFamilyExpense()
        }
    }
    
    
    @IBAction func cancelButtonClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onViewTapped(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    func addOrUpdateFamilyExpense(){
        if let familyId = family?.id, campingTripId = campingTrip?.id, amount = amountTextfield.text{
            let amountDecimalValue = NSDecimalNumber(string: amount)
            let expenseParams = CommonUtility.sharedInstance.expenseParams(familyId, campingTripId: campingTripId, name: nameTextField.text, amount: amountDecimalValue, description: descTextField.text)
            ParseManager.addNewExpense(expenseParams, completionBlock: { (success, error) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        }
    }
    
    
}

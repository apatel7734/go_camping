//
//  AddEditFamilyExpensesViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 8/21/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

protocol AddEditFamilyExpensesViewControllerDelegate{
    func didExpenseAdded(expense: Expense)
}

class AddEditFamilyExpensesViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var descTextField: CustomTextField!
    @IBOutlet weak var amountTextfield: CustomTextField!
    
    @IBOutlet weak var addUpdateButton: CustomButton!
    
    var delegate: AddEditFamilyExpensesViewControllerDelegate?
    var expense: Expense?
    
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
        }
        
        //validate short desc
        
        
        //validate amount
        
        
        return true
    }
    
    func displayExpensesInfo(expense: Expense){
        nameTextField.text = expense.name
        descTextField.text = expense.desc
        amountTextfield.text = expense.amount?.stringValue
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
        let name = nameTextField.text!
        let desc = descTextField.text!
        let  amount = NSDecimalNumber(string: amountTextfield.text)
        
        if let expense = expense{
            expense.name = name
            expense.amount = amount
            expense.desc = desc
        }else{
            let expenseDictionary = [Expense.Keys.Name: name, Expense.Keys.Desc: desc, Expense.Keys.Amount: amount]
            self.expense = Expense(dictionary: expenseDictionary, context: CoreDataStackManager.sharedInstance.managedObjectContext)
        }
        delegate?.didExpenseAdded(expense!)
    }
}

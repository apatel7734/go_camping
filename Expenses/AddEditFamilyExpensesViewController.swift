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
        addOrUpdateFamilyExpense()
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
        var amount: Double = 0.0
        if let isAmountEmpty = amountTextfield.text?.isEmpty{
            if !isAmountEmpty{
                amount = Double(isAmountEmpty)
            }
        }
        if let expense = expense{
            expense.name = name
            expense.amount = amount
            expense.desc = desc
//            CoreDataStackManager.sharedInstance.saveContext()
//            self.dismissViewControllerAnimated(true, completion: nil)
        }else{
            let expenseDictionary = [Expense.Keys.Name: name, Expense.Keys.Desc: desc, Expense.Keys.Amount: amount]
            self.expense = Expense(dictionary: expenseDictionary as! [String : AnyObject], context: CoreDataStackManager.sharedInstance.managedObjectContext)
        }
        delegate?.didExpenseAdded(expense!)
    }
}

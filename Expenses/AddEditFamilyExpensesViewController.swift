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
    
    var delegate: AddEditFamilyExpensesViewControllerDelegate?
    var expense: Expense?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addOrUpdateButtonClicked(sender: AnyObject) {
        addOrUpdateFamilyExpense()
    }
    
    
    @IBAction func cancelButtonClicked(sender: AnyObject) {
        print("CancelButtonClicked")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onViewTapped(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    func addOrUpdateFamilyExpense(){
        let name = nameTextField.text!
        let desc = descTextField.text!
        var amount: Double = 0.0
        if let amountStr = amountTextfield.text{
            amount = Double(amountStr)!
        }
        
        
        if let expense = expense{
            expense.name = name
            expense.amount = amount
            expense.desc = desc
            
        }else{
            let expenseDictionary = [Expense.Keys.Name: name, Expense.Keys.Desc: desc, Expense.Keys.Amount: amount]
            
            self.expense = Expense(dictionary: expenseDictionary as! [String : AnyObject], context: CoreDataStackManager.sharedInstance.managedObjectContext)
            delegate?.didExpenseAdded(expense!)
        }
    }
    
}

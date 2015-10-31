//
//  FamilyExpensesViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 7/31/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

class FamilyExpensesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, AddEditFamilyExpensesViewControllerDelegate {
    
    @IBOutlet weak var expenseTableView: UITableView!
    
    
    var family: Family?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let addRightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addExpensesButtonPressed:")
        self.navigationController?.topViewController?.navigationItem.rightBarButtonItem = addRightBarButtonItem
        
        expenseTableView.dataSource = self
        expenseTableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.topViewController?.navigationItem.title = "Expenses"
    }
    
    //MARK: TableViewDataSource, TableViewDelegates
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let expenses = family?.expenses{
            return expenses.count
        }else{
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        addEditExpenseFor(indexPath)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("expensetableviewcell") as! ExpenseTableViewCell
        cell.expenseName.text = family?.expenses[indexPath.row].name
        return cell
    }
    
    func didExpenseAdded(expense: Expense) {
        expense.family = family
        updateTotalExpense()
        CoreDataStackManager.sharedInstance.saveContext()
        self.dismissViewControllerAnimated(true, completion: nil)
        self.expenseTableView.reloadData()
    }
    
    private func updateTotalExpense(){
        var totalExpense: NSDecimalNumber = NSDecimalNumber.zero()
        if let expenses = family?.expenses{
            for expense in expenses{
                if let expenseAmout = expense.amount{
                    totalExpense = totalExpense.decimalNumberByAdding(NSDecimalNumber(decimal: expenseAmout.decimalValue))
                }
            }
        }
        family?.totalExpense = totalExpense
    }
    
    func addExpensesButtonPressed(sender: UIBarButtonItem){
        addEditExpenseFor(nil)
    }
    
    func addEditExpenseFor(indexPath: NSIndexPath?){
        let destVC = self.storyboard?.instantiateViewControllerWithIdentifier("addfamilyexpensesvc") as! AddEditFamilyExpensesViewController
        destVC.delegate = self
        if let expenses = family?.expenses, selectedIndexPath = indexPath{
            if expenses.count > selectedIndexPath.row{
                destVC.expense = expenses[selectedIndexPath.row]
            }
        }
        self.presentViewController(destVC, animated: true, completion: nil)
    }
    
}

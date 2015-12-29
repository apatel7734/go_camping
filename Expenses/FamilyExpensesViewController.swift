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
    var pageIndex: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        expenseTableView.dataSource = self
        expenseTableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        let addRightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addExpensesButtonPressed:")
        if let navigationController = self.navigationController{
            navigationController.topViewController?.navigationItem.rightBarButtonItem = addRightBarButtonItem
        }
        
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
        if let amountStringVal = family?.expenses[indexPath.row].amount?.stringValue{
            cell.expenseAmountLabel.text = "$\(amountStringVal)"
        }
        return cell
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch(editingStyle){
        case .Delete:
            if let expenseTobeDeleted = family?.expenses[indexPath.row]{
                CoreDataStackManager.sharedInstance.managedObjectContext.deleteObject(expenseTobeDeleted)
                CoreDataStackManager.sharedInstance.saveContext()
                tableView.beginUpdates()
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                tableView.endUpdates()
                CommonUtility.sharedInstance.updateFamilyTotalExpense(family)
                CommonUtility.sharedInstance.updateTotalExpenseAmountForEvent()
            }
        default:
            print("Not supported yet.")
        }
    }
    
    
    
    func didPickExpense(expense: Expense, actionType: ActionType) {
        expense.family = family
        CommonUtility.sharedInstance.updateFamilyTotalExpense(family)
        CoreDataStackManager.sharedInstance.saveContext()
        CommonUtility.sharedInstance.updateTotalExpenseAmountForEvent()
        self.expenseTableView.reloadData()
        self.dismissViewControllerAnimated(true, completion: nil)
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

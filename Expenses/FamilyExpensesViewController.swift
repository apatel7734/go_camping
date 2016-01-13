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
    var campingTrip: CampingTrip?
    var pageIndex: Int = 1
    var expenses = [Expense]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        expenseTableView.dataSource = self
        expenseTableView.delegate = self
        
        let emptyFooterView = UIView()
        expenseTableView.tableFooterView = emptyFooterView
        
        updateExpenses()
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
        return expenses.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        addEditExpenseFor(indexPath)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("expensetableviewcell") as! ExpenseTableViewCell
        cell.loadData(expenses[indexPath.row])
        
        return cell
    }
    
    func didPickExpense(expense: Expense, actionType: ActionType) {
        
        CommonUtility.sharedInstance.updateFamilyTotalExpense(family)
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
        if let selectedIndexPath = indexPath where expenses.count > selectedIndexPath.row{
            destVC.expense = expenses[selectedIndexPath.row]
        }
        
        destVC.family = family
        destVC.campingTrip = campingTrip
        self.presentViewController(destVC, animated: true, completion: nil)
    }
    
    private func updateExpenses(){
        if let familyId = family?.id{
            ParseManager.fetchExpensesFor(familyId, pageNumber: 0, totalResultPerPage: 10, completionBlock: { (expenses, error) -> Void in
                if let expenses = expenses{
                    self.expenses = expenses
                    self.expenseTableView.reloadData()
                }
            })
        }
    }
    
}

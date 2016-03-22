//
//  FamilyExpensesViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 7/31/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

class FamilyExpensesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var expenseTableView: UITableView!
    
    var family: GTLGocampingFamily?
    var campingTrip: GTLGocampingCampingTrip?
    var pageIndex: Int = 1
    var expenses = [GTLGocampingExpense]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        expenseTableView.dataSource = self
        expenseTableView.delegate = self
        
        let emptyFooterView = UIView()
        expenseTableView.tableFooterView = emptyFooterView
        
        fetchExpensesForFamily()
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
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressedCell:")
        cell.addGestureRecognizer(longPressGestureRecognizer)
        
        cell.loadData(expenses[indexPath.row])
        
        return cell
    }
    
    func addExpensesButtonPressed(sender: UIBarButtonItem){
        addEditExpenseFor(nil)
    }
    
    func addEditExpenseFor(indexPath: NSIndexPath?){
        let destVC = self.storyboard?.instantiateViewControllerWithIdentifier("addfamilyexpensesvc") as! AddEditFamilyExpensesViewController
        if let selectedIndexPath = indexPath where expenses.count > selectedIndexPath.row{
            //            destVC.expense = expenses[selectedIndexPath.row]
        }
        
        //        destVC.family = family
        //        destVC.campingTrip = campingTrip
        self.presentViewController(destVC, animated: true, completion: nil)
    }
    
    private func fetchExpensesForFamily(){
        if let familyId = family?.identifier.int64Value(){
            let query = GTLQueryGocamping.queryForGetAllFamilyExpensesWithFamilyID(familyId)
            let service  = GTLServiceGocamping()
            service.executeQuery(query) { (tkt: GTLServiceTicket!, object: AnyObject!, error: NSError!) -> Void in
                if (error != nil) {
                    //display error.
                    print("There was an error.")
                }else{
                    if let expenseCollection = object as? GTLGocampingExpenseCollection{
                        if let expenses = expenseCollection.items() as? [GTLGocampingExpense]{
                            self.expenses = expenses
                            self.expenseTableView.reloadData()
                        }
                    }
                }
            }
            
            
        }
    }
    
    func longPressedCell(longPressedGesuture: UILongPressGestureRecognizer){
        if let cell = longPressedGesuture.view as? ExpenseTableViewCell{
            if let indexPath = self.expenseTableView.indexPathForCell(cell), campingTripId = campingTrip?.identifier, expenseId = expenses[indexPath.row].identifier{
                showAlertAction(indexPath, expenseId: expenseId.stringValue, campingTripId: campingTripId.stringValue)
            }
        }
    }
    
    private func showAlertAction(indexPath: NSIndexPath, expenseId: String, campingTripId: String){
        let optionMenu = UIAlertController(title: nil, message: "Choose option.", preferredStyle: .ActionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive) { (alertAction: UIAlertAction) -> Void in
            //handle DeleteAction here.
            ParseManager.deleteExpense(expenseId, campingTripId: campingTripId, completionBlock: { (success, error) -> Void in
                self.expenses.removeAtIndex(indexPath.row)
                self.expenseTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (alertAction: UIAlertAction) -> Void in
            //handle cancel here.
            print("Do Nothing.")
        }
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
}

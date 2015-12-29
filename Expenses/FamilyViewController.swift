//
//  ViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 7/19/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit
import CoreData
import Parse
//pushfamily

class FamilyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource ,NSFetchedResultsControllerDelegate{
    
    var currentIndexPath: NSIndexPath?
    
    @IBOutlet weak var familyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        familyTableView.delegate = self
        familyTableView.dataSource = self
        
        do{
            try fetchedResultsController.performFetch()
        }catch{
            print("error perfoming fetch.")
        }
        fetchedResultsController.delegate = self
        
        configureNavigationBar()
    }
   
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        familyTableView.reloadData()
    }
    
    func configureNavigationBar(){
        self.navigationController?.navigationBar.configureAsBlueBar()
        let addbutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "didTapAddButton")
        self.navigationItem.rightBarButtonItem = addbutton
    }
    
    func didTapAddButton(){
        performSegueWithIdentifier("presentaddnewfamily", sender: self)
    }
    
    //MARK - tableView datasource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let familyCell = tableView.dequeueReusableCellWithIdentifier("familycell") as! FamilyUITableViewCell
        let family = fetchedResultsController.objectAtIndexPath(indexPath) as? Family
        
        if let family  = family {
            self.configureCell(familyCell, withFamily: family)
        }
        return familyCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    
    //MARK - tableView delegates
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.familyTableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.currentIndexPath = indexPath
//        self.performSegueWithIdentifier("pushfamilyInfo", sender: nil)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            if let objectToRemove = self.fetchedResultsController.objectAtIndexPath(indexPath) as? NSManagedObject{
                
                CoreDataStackManager.sharedInstance.managedObjectContext.deleteObject(objectToRemove)
                CommonUtility.sharedInstance.updateTotalExpenseAmountForEvent()
                CommonUtility.sharedInstance.updateTotalMembersCountForEvent()
                CoreDataStackManager.sharedInstance.saveContext()
                tableView.reloadData()
            }
        }
    }
    
    
    //MARK - segue methods on + button clicked.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVC = segue.destinationViewController as? UITabBarController;
        
        if let tabBarVC = destVC{
            let viewControllers = tabBarVC.viewControllers
            
            if let indexPath = self.currentIndexPath{
                
                let family = fetchedResultsController.objectAtIndexPath(indexPath) as? Family
                
                if let familyMembersVC = findFamilyMembersViewController(viewControllers), family = family{
                    familyMembersVC.family = family
                }
                
                if let familyExpensesVC = findFamilyExpensesViewController(viewControllers), family = family{
                    familyExpensesVC.family = family
                }
            }
        }
    }
    
    func findFamilyMembersViewController(var viewControllers: [AnyObject]?) -> FamilyMembersViewController?{
        if let familyMemberVC: FamilyMembersViewController = viewControllers?[0] as? FamilyMembersViewController{
            return familyMemberVC
        }
        if let familyMemberVC: FamilyMembersViewController = viewControllers?[1] as? FamilyMembersViewController{
            return familyMemberVC
        }
        return nil
    }
    
    func findFamilyExpensesViewController(var viewControllers: [AnyObject]?) -> FamilyExpensesViewController?{
        
        if let familyExpenseVC: FamilyExpensesViewController = viewControllers?[0] as? FamilyExpensesViewController{
            return familyExpenseVC
        }
        if let familyExpenseVC: FamilyExpensesViewController = viewControllers?[1] as? FamilyExpensesViewController{
            return familyExpenseVC
        }
        return nil
    }
    
    
    func configureCell(familyCell: FamilyUITableViewCell, withFamily family: Family){
        familyCell.familyName.text = family.name
        familyCell.totalMembers.text = "\(family.members.count)"
        let familyCalculatedExpense = CommonUtility.sharedInstance.amountDifferenceToPayOrTakeForFamily(family)
        familyCell.totalExpenses.text = familyCalculatedExpense.currencyFormattedValueWithDollarPrefix()
        familyCell.familyImage.showFirstCharacterFor(family.name)
    }
    
    //Step 1. add lazy controller to fetch result
    lazy var fetchedResultsController: NSFetchedResultsController = {
        
        let fetchRequest = NSFetchRequest(entityName: "Family")
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchRequest.returnsObjectsAsFaults = false
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
            managedObjectContext: CoreDataStackManager.sharedInstance.managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        return fetchedResultsController
        
    }()
    
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.familyTableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController,
        didChangeSection sectionInfo: NSFetchedResultsSectionInfo,
        atIndex sectionIndex: Int,
        forChangeType type: NSFetchedResultsChangeType) {
            
            switch type {
            case .Insert:
                self.familyTableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
                
            case .Delete:
                self.familyTableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
                
            default:
                return
            }
    }
    
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            familyTableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            
        case .Delete:
            familyTableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            
        case .Update:
            let cell = familyTableView.cellForRowAtIndexPath(indexPath!) as! FamilyUITableViewCell
            let family = controller.objectAtIndexPath(indexPath!) as! Family
            self.configureCell(cell, withFamily: family)
            
        case .Move:
            familyTableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            familyTableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.familyTableView.endUpdates()
    }
    
}

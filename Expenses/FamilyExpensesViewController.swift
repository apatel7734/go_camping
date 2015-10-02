//
//  FamilyExpensesViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 7/31/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

class FamilyExpensesViewController: UIViewController {
    
    var family: Family?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let addRightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addExpensesButtonPressed:")
        self.navigationController?.topViewController?.navigationItem.rightBarButtonItem = addRightBarButtonItem
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.topViewController?.navigationItem.title = "Expenses"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addExpensesButtonPressed(sender: UIBarButtonItem){
        print("addExpensesButtonPressed()")
        let destVC = self.storyboard?.instantiateViewControllerWithIdentifier("addfamilyexpensesvc") as! AddEditFamilyExpensesViewController
        self.presentViewController(destVC, animated: true, completion: nil)
    }
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

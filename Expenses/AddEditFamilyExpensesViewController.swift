//
//  AddEditFamilyExpensesViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 8/21/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

class AddEditFamilyExpensesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonClicked(sender: AnyObject) {
        println("AddButtonClicked")
    }
    
    
    @IBAction func cancelButtonClicked(sender: AnyObject) {
        println("CancelButtonClicked")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onViewTapped(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
}

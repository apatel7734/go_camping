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
    }
    
    override func viewWillAppear(animated: Bool) {
        println("Family = \(family)")
        println("Family name Expenses = \(family?.name) ")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

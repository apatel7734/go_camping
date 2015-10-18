//
//  AddFamilyUIViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 7/31/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit
import CoreData

class AddFamilyUIViewController: UIViewController {
    
    @IBOutlet weak var familyNameTextField: CustomTextField!
    
    @IBOutlet weak var phoneNumberTextField: CustomTextField!
    
    @IBOutlet weak var emailTextField: CustomTextField!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addFamilyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cancelButton.layer.cornerRadius = 8
        addFamilyButton.layer.cornerRadius = 8
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onTapCancelButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func onTapView(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func onTapAddFamilyButton(sender: UIButton) {
        print("familyNameTextField \(familyNameTextField.text)")
        print("phoneNumberTextField \(phoneNumberTextField.text)")
        print("emailTextField \(emailTextField.text)")
        
        let dictionary : [String: AnyObject] = [Family.Keys.Name : familyNameTextField.text!]
        
        let _ = Family(dictionary: dictionary, context: CoreDataStackManager.sharedInstance.managedObjectContext)
        
        CoreDataStackManager.sharedInstance.saveContext()
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

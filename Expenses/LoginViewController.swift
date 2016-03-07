//
//  LoginViewController.swift
//  Expenses
//
//  Created by Patel, Ashish on 3/6/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var phoneNumber: NoCaretTextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnLoginButton(sender: AnyObject) {
    
        print("Login Tapped.")
    }
    
    @IBAction func didTapoMainView(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func didTaponSignupButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}

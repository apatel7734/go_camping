//
//  PhoneNumberViewController.swift
//  Expenses
//
//  Created by Patel, Ashish on 12/19/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

class PhoneNumberViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    private var phoneNumber: String = ""{
        didSet{
            phoneNumberTextField.text = phoneNumber
            if phoneNumber.characters.count >= 10 {
                moveToEnterCodeScreen()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        phoneNumberTextField.delegate = self
        phoneNumberTextField.becomeFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty && !phoneNumber.isEmpty{
            phoneNumber = String(phoneNumber.characters.dropLast())
        }
        
        phoneNumber = phoneNumber + string
        
        return false
    }
    
    private func moveToEnterCodeScreen(){
        if let enterCodeVC = storyboard?.instantiateViewControllerWithIdentifier("entercodeviewcontroller") as? EnterCodeViewController{
            self.navigationController?.pushViewController(enterCodeVC, animated: true)
        }
    }
    
}

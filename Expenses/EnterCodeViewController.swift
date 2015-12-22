//
//  EnterCodeViewController.swift
//  Expenses
//
//  Created by Patel, Ashish on 12/19/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

class EnterCodeViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var enterCodeTextField: NoCaretTextField!
    var phoneNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterCodeTextField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.configureAsTransparentBar()
    }
    
    override func viewDidAppear(animated: Bool) {
        enterCodeTextField.becomeFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty || textField.text?.characters.count < 4{
            return true
        }
        submitConfirmationCode()
        
        return false
    }
    
    private func submitConfirmationCode(){
        APICoordinator.submitCode(enterCodeTextField.text!, phoneNumber: phoneNumber) { (response, error) -> Void in
            self.moveToFamilisVC()
        }
    }
    
    private func moveToFamilisVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let familyVC = storyboard.instantiateViewControllerWithIdentifier("FamilyViewController") as? FamilyViewController{
            self.navigationController?.pushViewController(familyVC, animated: true)
        }
    }
}

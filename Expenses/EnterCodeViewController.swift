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
    private var verificationCode: String = ""{
        didSet{
            if verificationCode.characters.count < 5{
                enterCodeTextField.text = verificationCode
                if verificationCode.characters.count == 4 {
                    doVerifyCodeFromServer()
                }
            }
        }
    }
    
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
        
        if string.isEmpty {
            verificationCode = String(verificationCode.characters.dropLast())
        }else if verificationCode.characters.count < 4{
            verificationCode = verificationCode + string
        }
        
        return false
    }
    
    private func doVerifyCodeFromServer(){
        CustomLoadingView.sharedView.showLoadingViewFor(self.view, withMessage: "verifying code...")
        APICoordinator.submitCode(enterCodeTextField.text!, phoneNumber: phoneNumber) { (response, error) -> Void in
            CustomLoadingView.sharedView.hideLoadingView()
            if let error = error{
                let errors = error.userInfo as Dictionary
                if let errorMessage = errors["NSLocalizedDescription"] as? String{
                    ErrorView.sharedView.showErrorMessage(self.view, message: errorMessage)
                }
            }else{
                self.moveToFamilisVC()
            }
        }
    }
    
    private func moveToFamilisVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let familyVC = storyboard.instantiateViewControllerWithIdentifier("FamilyViewController") as? FamilyViewController{
            self.navigationItem.title = ""
            self.navigationController?.pushViewController(familyVC, animated: true)
        }
    }
}

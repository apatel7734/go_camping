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
            phoneNumberTextField.text = phoneNumber.formatPhoneNumberWithSpaces()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        phoneNumberTextField.delegate = self
        configureNavigationBar()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.configureAsTransparentBar()
        phoneNumberTextField.becomeFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        ErrorView.sharedView.hideErrorView()
        if string.isEmpty && !phoneNumber.isEmpty{
            phoneNumber = String(phoneNumber.characters.dropLast())
        }
        
        if phoneNumber.characters.count < 10 {
            phoneNumber = phoneNumber + string
        }
        
        return false
    }
    
    private func configureNavigationBar(){
        let sendCodeButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: "didTapNextButton")
        self.navigationItem.rightBarButtonItem = sendCodeButton
    }
    
    func didTapNextButton(){
        submitPhoneNumber()
    }
    
    private func moveToEnterCodeScreen(){
        if let enterCodeVC = storyboard?.instantiateViewControllerWithIdentifier("entercodeviewcontroller") as? EnterCodeViewController{
            enterCodeVC.phoneNumber = phoneNumber
            self.navigationItem.title = ""
            self.navigationController?.pushViewController(enterCodeVC, animated: true)
        }
    }
    
    
    private func submitPhoneNumber(){
        CustomLoadingView.sharedView.showLoadingViewFor(self.view, withMessage: nil)
        APICoordinator.submitPhoneNumber(phoneNumber) { (response, error) -> Void in
            CustomLoadingView.sharedView.hideLoadingView()
            if let error = error {
                let errors = error.userInfo as Dictionary
                if let errorMessage = errors["NSLocalizedDescription"] as? String{
                    ErrorView.sharedView.showErrorMessage(self.view, message: errorMessage)
                }
            }else{
                self.moveToEnterCodeScreen()
            }
        }
    }
    
}

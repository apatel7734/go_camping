//
//  LoginViewController.swift
//  Expenses
//
//  Created by Patel, Ashish on 3/6/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var phoneNumber: NoCaretTextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
    }
    
    @IBAction func didTapOnLoginButton(sender: AnyObject) {
        guard let phoneNumber = phoneNumber.text, let password = password.text else{
            return
        }
        
        
        if let intNumber = Int64(phoneNumber){
            let query = GTLQueryGocamping.queryForLoginWithPhoneNumber(intNumber, password: password)
            let service  = GTLServiceGocamping()
            activityIndicator.startAnimating()
            service.executeQuery(query, completionHandler: { (serviceTicket: GTLServiceTicket!, response: AnyObject!, error: NSError!) -> Void in
                self.activityIndicator.stopAnimating()
                if (error != nil) {
                    //display error.
                    self.displayUserDoesnotExistError()
                }else{
                    //save logged in user
                    NSUserDefaultCoordinator.sharedInstance.loggedInUser = response as? GTLGocampingUserAccount
                    //go to next step.
                    let storyboard = UIStoryboard(name: "ManageTrip", bundle: nil)
                    self.presentViewController(storyboard.instantiateInitialViewController()!, animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func didTapoMainView(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func didTaponSignupButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func displayUserDoesnotExistError(){
        displayErrorAlertMessage("Unable to login.", message: "Please try correct username and password Or Signing up if you havenot registered yet.")
    }
    
    
    func displayErrorAlertMessage(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            
        }
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
}

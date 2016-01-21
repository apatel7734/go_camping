//
//  InviteFamiliesViewController.swift
//  Expenses
//
//  Created by Patel, Ashish on 1/12/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class InviteFamiliesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, CNContactPickerDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var contactsTableView: UITableView!
    
    @IBOutlet weak var selectExistingContactButton: UIButton!
    
    @IBOutlet weak var addNewContactButton: UIButton!
    var contacts = [CNContact]()
    
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        contactsTableView.tableFooterView = UIView()
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        contactsTableView.estimatedRowHeight = 125
        contactsTableView.rowHeight = UITableViewAutomaticDimension
        
        selectExistingContactButton.layer.cornerRadius = 5.0
        addNewContactButton.layer.cornerRadius = 5.0
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send Invite", style: UIBarButtonItemStyle.Plain, target: self, action: "didTapInviteFamiliesBarButtonItem:")
    }
    
    
    override func viewDidAppear(animated: Bool) {
        requestForAccess { (accessGranted) -> Void in
            if accessGranted {
                
            }
        }
    }
    
    func didTapInviteFamiliesBarButtonItem(button: UIBarButtonItem){
        print("Invite Tap..")
    }
    
    //MARK: - TableView Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("contactInviteeTableViewCell") as!ContactsInviteeTableViewCell
        
        
        return cell
    }
    
    //MARK: - IBActions
    
    @IBAction func didTapSelectContactButton(sender: UIButton) {
        
        showContactPicker()
    }
    
    
    @IBAction func didTapOnAddNewContactButton(sender: UIButton) {
        
    }
    
    
    //MARK: - CNContact Utility
    private func showContactPicker(){
        let contactPicker = CNContactPickerViewController()
        contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey,CNContactGivenNameKey, CNContactFamilyNameKey]
        contactPicker.delegate = self
        presentViewController(contactPicker, animated: true, completion: nil)
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContacts contacts: [CNContact]) {
        didFetchContacts(contacts)
    }
    
    func didFetchContacts(contacts: [CNContact]) {
        for contact in contacts {
            self.contacts.append(contact)
            let fullName = CNContactFormatter.stringFromContact(contact, style: .FullName)
            let phoneNumberAvailable = contact.isKeyAvailable(CNContactPhoneNumbersKey)
            print("Contact.FullName = \(fullName), phoneNumberAvailable = \(phoneNumberAvailable), contact.imageDataAvailable = \(contact.imageDataAvailable)")
            for phoneNumber: CNLabeledValue in contact.phoneNumbers{
                print("phoneNumber.label = \(phoneNumber.label), phoneNumber.value = \(phoneNumber.value)")
            }
            print("******* End ******")
        }
        
        //        self.contactsTableView.reloadData()
    }
    
    
    //MARK: - Utility functions
    func requestForAccess(completionBlock: (accssGranted: Bool) -> Void){
        let authorizationStatus = CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts)
        switch(authorizationStatus){
        case .Authorized:
            completionBlock(accssGranted: true)
            
        case .Denied, .NotDetermined:
            AppDelegate.getAppDelegate().contactStore.requestAccessForEntityType(CNEntityType.Contacts, completionHandler: { (access, accessError) -> Void in
                if access {
                    completionBlock(accssGranted: true)
                }else{
                    if authorizationStatus == .Denied{
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let message = "\(accessError!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
                            self.showMessage(message)
                        })
                    }
                }
            })
            
        default:
            completionBlock(accssGranted: false)
        }
    }
    
    
    func showMessage(message: String){
        let alertController = UIAlertController(title: "Go Camping", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let dismissAction =  UIAlertAction(title: "Later", style: UIAlertActionStyle.Cancel) { (alertAction: UIAlertAction) -> Void in
        }
        let goToSettingsAction = UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default) { (alertAction: UIAlertAction) -> Void in
            if let settingsUrl = NSURL(string: UIApplicationOpenSettingsURLString){
                UIApplication.sharedApplication().openURL(settingsUrl)
            }
        }
        
        alertController.addAction(dismissAction)
        alertController.addAction(goToSettingsAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
}

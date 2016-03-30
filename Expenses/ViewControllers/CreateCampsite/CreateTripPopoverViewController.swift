//
//  CreateTripPopoverViewController.swift
//  Expenses
//
//  Created by Emma on 2/28/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import UIKit

protocol CreateTripPopoverVCDelegate: class {
    func createTripSuccessed(vc: CreateTripPopoverViewController)
}

class CreateTripPopoverViewController: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var startDateField: UITextField!
    @IBOutlet weak var endDateField: UITextField!
    
    var campingTrip: GTLGocampingCampingTrip!
    
    weak var delegate: CreateTripPopoverVCDelegate?
    
    private let startDatePicker = UIDatePicker()
    private let endDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startDatePicker.datePickerMode = .Date
        endDatePicker.datePickerMode = .Date
        startDateField.inputView = startDatePicker
        endDateField.inputView = endDatePicker
        
        let accessoryView = UIToolbar(frame: CGRectMake(0, 0, view.bounds.width, 50))
        accessoryView.items = [
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .Done, target: self, action: "accessoryDoneButtonTapped:")
        ]
        accessoryView.sizeToFit()
        
        startDateField.inputAccessoryView = accessoryView
        endDateField.inputAccessoryView = accessoryView
    }
    
    func accessoryDoneButtonTapped(sender: UIView) {
        if startDateField.isFirstResponder() {
            startDateField.text = DateFormatterUtil.mediumDateFormatter.stringFromDate(startDatePicker.date)
        
            startDateField.resignFirstResponder()
            
        } else if endDateField.isFirstResponder() {
            endDateField.text = DateFormatterUtil.mediumDateFormatter.stringFromDate(endDatePicker.date)
    
            endDateField.resignFirstResponder()
        }
    }
    
    @IBAction func createTripButtonTapped(sender: AnyObject) {
        let tripWrapper = GTLGocampingCampingTripWrapper()
        let user = NSUserDefaultCoordinator.sharedInstance.loggedInUser
        tripWrapper.userAccount = user
        
        campingTrip.title = titleField.text
        campingTrip.dateFrom = startDatePicker.date.timeIntervalSince1970 * 1000
        campingTrip.dateTo = endDatePicker.date.timeIntervalSince1970 * 1000
        
        tripWrapper.campingTrip = campingTrip
        
        let query = GTLQueryGocamping.queryForCreateCampingTripWithObject(tripWrapper)
        GTLServiceGocamping().executeQuery(query) { (serviceTicket: GTLServiceTicket!, response: AnyObject!, error: NSError!) in
            if (error != nil) {
                print("There was an error.")
            } else {
                self.delegate?.createTripSuccessed(self)
            }
        }
    }
}

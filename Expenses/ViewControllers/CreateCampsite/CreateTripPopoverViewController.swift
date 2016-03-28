//
//  CreateTripPopoverViewController.swift
//  Expenses
//
//  Created by Emma on 2/28/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import UIKit

class CreateTripPopoverViewController: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var startDateField: UITextField!
    @IBOutlet weak var endDateField: UITextField!
    
    var campingTrip: GTLGocampingCampingTrip
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .Date
        startDateField.inputView = datePicker
        endDateField.inputView = datePicker
        
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
            let datePicker = startDateField.inputView as! UIDatePicker
            startDateField.text = DateFormatterUtil.mediumDateFormatter.stringFromDate(datePicker.date)
        
            startDateField.resignFirstResponder()
            
        } else if endDateField.isFirstResponder() {
            let datePicker = endDateField.inputView as! UIDatePicker
            endDateField.text = DateFormatterUtil.mediumDateFormatter.stringFromDate(datePicker.date)
    
            endDateField.resignFirstResponder()
        }
    }
    
    @IBAction func createTripButtonTapped(sender: AnyObject) {
        let tripWrapper = GTLGocampingCampingTripWrapper()
        let user = NSUserDefaultCoordinator.sharedInstance.loggedInUser
        tripWrapper.userAccount = user
        
        campingTrip.title = titleField.text
        var datePicker = startDateField.inputView as! UIDatePicker
        campingTrip.dateFrom = datePicker.date.timeIntervalSince1970 * 1000
        datePicker = endDateField.inputView as! UIDatePicker
        campingTrip.dateTo = datePicker.date.timeIntervalSince1970 * 1000
        
        tripWrapper.campingTrip = campingTrip
        
        let query = GTLQueryGocamping.queryForCreateCampingTripWithObject(tripWrapper)
        GTLServiceGocamping().executeQuery(query) { (serviceTicket: GTLServiceTicket!, response: AnyObject!, error: NSError!) in
            // do something
            print(response)
        }
    }
}

//
//  TripRSVPViewController.swift
//  Expenses
//
//  Created by Patel Ashish on 4/14/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import UIKit

protocol TripRSVPVCDelegate: class {
    func rsvpSuccessed(vc: TripRSVPViewController)
}

class TripRSVPViewController: UIViewController {
    
    @IBOutlet weak var totalMembersLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    var campingTripId: Int64!
    
    weak var delegate: TripRSVPVCDelegate?
    
    private var totalMembers: Int = 0 {
        didSet{
            
        }
        
        willSet(newTotalMembers){
            if newTotalMembers < 0 {
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func didModifyRSVPMembersTotal(sender: UIButton) {
        switch sender {
        case minusButton:
            totalMembers = totalMembers - 1
        case plusButton:
            totalMembers = totalMembers + 1
        default:
            print("Not supported.")
        }
        
    }
    
    @IBAction func didTapRSVPButton(sender: UIButton) {
        if totalMembers < 1 {
            return
        }
        
        getFamilyId { (familyId) in
            let rsvpWrapper = GTLGocampingFamilyRSVPWrapper()
            rsvpWrapper.campingTripId = NSNumber(longLong: self.campingTripId)
            rsvpWrapper.familyId = familyId
            rsvpWrapper.totalMembersComing = self.totalMembers
            rsvpWrapper.familyRSVPedResponse = "YES"
    
            let query = GTLQueryGocamping.queryForRsvpForTheFamilyWithObject(rsvpWrapper)
            GTLServiceGocamping().executeQuery(query, completionHandler: { (ticket, response, error) in
                if (error != nil) {
                    print("There was an error")
                } else {
                    self.delegate?.rsvpSuccessed(self)
                }
            })
        }
    }
    
    private func getFamilyId(callback: (familyId: NSNumber) -> Void) {
        if let user = NSUserDefaultCoordinator.sharedInstance.loggedInUser {
            let query = GTLQueryGocamping.queryForGetUserFamilyByCampingTripWithObject(user, campingTripId: campingTripId)
            GTLServiceGocamping().executeQuery(query, completionHandler: { (serviceTicket, response, error) in
                if (error != nil) {
                    print("There was an error")
                } else {
                    let family = response as! GTLGocampingFamily
                    callback(familyId: family.identifier)
                }
            })
        }
    }
}

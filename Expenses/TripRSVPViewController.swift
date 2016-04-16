//
//  TripRSVPViewController.swift
//  Expenses
//
//  Created by Patel Ashish on 4/14/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import UIKit

class TripRSVPViewController: UIViewController {
    
    @IBOutlet weak var totalMembersLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
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
        print("Total Members coming = \(totalMembers)")
    }
    
}

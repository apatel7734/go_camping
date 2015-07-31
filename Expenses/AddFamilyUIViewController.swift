//
//  AddFamilyUIViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 7/31/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

class AddFamilyUIViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addFamilyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cancelButton.layer.cornerRadius = 8
        addFamilyButton.layer.cornerRadius = 8
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onTapCancelButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func onTapAddFamilyButton(sender: UIButton) {
    }
    
    
}

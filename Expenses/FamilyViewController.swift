//
//  ViewController.swift
//  Expenses
//
//  Created by Ashish Patel on 7/19/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import UIKit

class FamilyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var families = [Family]()
    var currentIndexPath: NSIndexPath?
    
    @IBOutlet weak var familyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        familyTableView.delegate = self
        familyTableView.dataSource = self
        
        //TODO : Remove this
        generateTestData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK - tableView datasource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var familyCell = tableView.dequeueReusableCellWithIdentifier("familycell") as! FamilyUITableViewCell
        familyCell.familyName.text = families[indexPath.row].name
        
        return familyCell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.families.count
    }
    
    
    //MARK - tableView delegates
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.familyTableView.deselectRowAtIndexPath(indexPath, animated: true)
        println("didSelectRowAtIndexPath = \(indexPath.row)")
        self.currentIndexPath = indexPath
        self.performSegueWithIdentifier("pushfamily", sender: nil)
    }
    
    
    //MARK - segue methods
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destVC = segue.destinationViewController as? UITabBarController;
        if let tabBarVC = destVC{
            var viewControllers = tabBarVC.viewControllers
            println("prepareForSegue Before = \(self.currentIndexPath?.row)")
            if let baseVC = viewControllers?[0] as? BaseUIViewController{
                if let indexPath = currentIndexPath{
                    println("prepareForSegue = \(indexPath.row)")
                    baseVC.family = families[indexPath.row]
                }
            }
            
            
        }
    }
    
    
    func generateTestData(){
        
        var family = Family()
        family.name = "Kumar"
        var family2 = Family()
        family2.name = "Ashish"
        families.append(family)
        families.append(family2)
    }
    
}


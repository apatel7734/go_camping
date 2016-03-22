//
//  RootViewController.swift
//  SwiperDemo2
//
//  Created by Patel, Ashish on 12/28/15.
//  Copyright © 2015 Patel, Ashish. All rights reserved.
//

import UIKit
//Step.1 confirm to protocol UIPageViewControllerDataSource
class RootViewController: UIViewController, UIPageViewControllerDataSource , UIPageViewControllerDelegate{
    
    @IBOutlet weak var membersLabel: UIButton!
    @IBOutlet weak var expenseLabel: UIButton!
    
    private var pageViewController: UIPageViewController!
    private var viewControllersInDisplayOrder = [UIViewController]()
    
    @IBOutlet weak var containerView: UIView!
    var pageViewcontrollers = [UIViewController]()
    var family: GTLGocampingFamily?
    var campingTrip: GTLGocampingCampingTrip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initializePageViewcontrollers()
        createPageViewController()
        
        self.addChildViewController(pageViewController)
        self.containerView.addSubview(self.pageViewController.view)
        self.pageViewController.view.frame = self.containerView.bounds
        self.pageViewController.didMoveToParentViewController(self)
        
        self.view.gestureRecognizers = self.pageViewController.gestureRecognizers
    }
    
    //step. 2 create PageViewController method.
    private func createPageViewController(){
        pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        pageViewController.dataSource = self
        let startVC = pageViewcontrollers[0]
        
        pageViewController.setViewControllers([startVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    private func initializePageViewcontrollers(){
        if let storyboard = self.storyboard{
            let familyMembersVC = storyboard.instantiateViewControllerWithIdentifier("FamilyMembersViewController") as! FamilyMembersViewController
            familyMembersVC.pageIndex = 0
            familyMembersVC.family = self.family
            familyMembersVC.campingTrip = self.campingTrip
            
            pageViewcontrollers.append(familyMembersVC)
            let familyExpenseVC = storyboard.instantiateViewControllerWithIdentifier("FamilyExpensesViewController") as! FamilyExpensesViewController
            familyExpenseVC.pageIndex = 1
            familyExpenseVC.family = self.family
            familyExpenseVC.campingTrip = self.campingTrip
            
            pageViewcontrollers.append(familyExpenseVC)
        }
    }
    
    enum IndexOrderType: Int{
        case After, Before
    }
    
    func getPageViewController(viewController: UIViewController?, indexOrderType: IndexOrderType) -> UIViewController?{
        
        var pageIndex: Int = 0
        if let familyExpenseVC = viewController as? FamilyExpensesViewController{
            pageIndex = familyExpenseVC.pageIndex
            
        }else if let familyMembersVC = viewController as? FamilyMembersViewController{
            pageIndex = familyMembersVC.pageIndex
        }
        
        switch(indexOrderType){
        case .After:
            pageIndex += 1
        case .Before:
            pageIndex -= 1
        }
        
        if pageIndex < 0 || pageIndex > pageViewcontrollers.count - 1{
            return nil
        }
        
        return pageViewcontrollers[pageIndex]
    }
    
    //MARK: - UIPageViewControllerDataSource
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return getPageViewController(viewController, indexOrderType: .After)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return getPageViewController(viewController, indexOrderType: .Before)
    }
    
}

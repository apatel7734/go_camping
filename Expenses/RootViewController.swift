//
//  RootViewController.swift
//  SwiperDemo2
//
//  Created by Patel, Ashish on 12/28/15.
//  Copyright © 2015 Patel, Ashish. All rights reserved.
//

import UIKit
//Step.1 confirm to protocol UIPageViewControllerDataSource
class RootViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var membersLabel: UIButton!
    @IBOutlet weak var expenseLabel: UIButton!
    @IBOutlet weak var slideView: UIView!
    
    private var scrollView: UIScrollView!
    private var viewControllersInDisplayOrder = [UIViewController]()
    
    @IBOutlet weak var containerView: UIView!
    var viewControllers = [UIViewController]()
    var family: GTLGocampingFamily?
    var campingTrip: GTLGocampingCampingTrip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createScrollView()
        // Do any additional setup after loading the view.
        initializePageViewcontrollers()
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.configureAsTransparentBar()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = containerView.bounds
        let scrollViewBounds = scrollView.bounds
        let width = scrollViewBounds.size.width
        let height = scrollViewBounds.size.height
        scrollView.contentSize = CGSizeMake(width * CGFloat(viewControllers.count), height)
        var idX = 0
        for viewController in viewControllers{
            addChildViewController(viewController)
            let originX = CGFloat(idX) * width
            viewController.view.frame = CGRect(x: originX, y: 0.0, width: width, height: height)
            scrollView.addSubview(viewController.view)
            viewController.didMoveToParentViewController(self)
            idX += 1
        }
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        slideView.frame.origin.x = scrollView.contentOffset.x / 2
    }
    
    //step. 2 create scrollView
    private func createScrollView(){
        scrollView = UIScrollView()
        scrollView.scrollEnabled = true
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        containerView.addSubview(scrollView)
    }
    
    private func initializePageViewcontrollers(){
        if let storyboard = self.storyboard{
            let familyMembersVC = storyboard.instantiateViewControllerWithIdentifier("FamilyMembersViewController") as! FamilyMembersViewController
            familyMembersVC.pageIndex = 0
            familyMembersVC.family = self.family
            familyMembersVC.campingTrip = self.campingTrip
            viewControllers.append(familyMembersVC)
            let familyExpenseVC = storyboard.instantiateViewControllerWithIdentifier("FamilyExpensesViewController") as! FamilyExpensesViewController
            familyExpenseVC.pageIndex = 1
            familyExpenseVC.family = self.family
            familyExpenseVC.campingTrip = self.campingTrip
            viewControllers.append(familyExpenseVC)
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
        
        if pageIndex < 0 || pageIndex > viewControllers.count - 1{
            return nil
        }
        
        return viewControllers[pageIndex]
    }
    
    //MARK: - UIPageViewControllerDataSource
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return getPageViewController(viewController, indexOrderType: .After)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return getPageViewController(viewController, indexOrderType: .Before)
    }
    
}

//
//  PopoverPresentationController.swift
//  Expenses
//
//  Created by Miyuki Suzuki on 2/24/16.
//  Copyright © 2016 Ashish Patel. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {
    
    private var dimmingView: UIView!
    private var xOffset: CGFloat = 0
    private var yOffset: CGFloat = 0
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        setUpDimmingView()
    }
    
    func setUpDimmingView() {
        dimmingView = UIView(frame: presentingViewController.view.bounds)
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        visualEffectView.frame = dimmingView.bounds
        visualEffectView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        dimmingView.addSubview(visualEffectView)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "dimmingViewTapped")
        dimmingView.addGestureRecognizer(tapRecognizer)
    }
    
    func setXOffset(offset: CGFloat) {
        xOffset = offset
    }
    
    func setYOffset(offset: CGFloat) {
        yOffset = offset
    }
    
    func dimmingViewTapped() {
        presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - Layout methods
extension PopoverPresentationController {
    
    override func containerViewWillLayoutSubviews() {
        dimmingView.frame = containerView!.bounds
        presentedView()?.frame = frameOfPresentedViewInContainerView()
        presentedView()?.layer.cornerRadius = 8
    }
    
    override func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSizeMake(parentSize.width - xOffset * 2, parentSize.height - yOffset * 2)
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        var presentedViewFrame = CGRectZero
        presentedViewFrame.size = sizeForChildContentContainer(presentedViewController, withParentContainerSize: containerView!.bounds.size)
        presentedViewFrame.origin.x = xOffset
        presentedViewFrame.origin.y = yOffset
        
        return presentedViewFrame
    }
}

// MARK: - Transition methods
extension PopoverPresentationController {
    
    override func presentationTransitionWillBegin() {
        dimmingView.frame = containerView!.bounds
        dimmingView.alpha = 0.0
        
        containerView?.insertSubview(dimmingView, atIndex: 0)
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ (coor) in
            self.dimmingView.alpha = 1.0
            }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ (coor) in
            self.dimmingView.alpha = 0.0
            }, completion: nil)
    }
}
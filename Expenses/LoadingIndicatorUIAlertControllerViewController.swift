//
//  LoadingIndicatorUIAlertControllerViewController.swift
//  Expenses
//
//  Created by Patel, Ashish on 12/20/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

class LoadingIndicatorUIAlertControllerViewController {
    
    private func startLoadingIndicator(){
        let alert = UIAlertController(title: nil, message: "sending code...", preferredStyle: .Alert)
        
        alert.view.tintColor = UIColor.blackColor()
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
    }
    
}

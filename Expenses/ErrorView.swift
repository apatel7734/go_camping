//
//  ErrorView.swift
//  Expenses
//
//  Created by Patel, Ashish on 11/2/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

class ErrorView {
    
    static let sharedView = ErrorView()
    private let errorLabel: UILabel!
    private let viewHeight: CGFloat = 70.0
    
    private init(){
        let errorView = NSBundle.mainBundle().loadNibNamed("ErrorView", owner: nil, options: nil)
        errorLabel = errorView[0] as? UILabel
    }
    
    func showErrorMessage(view:UIView, message: String){
        errorLabel.text = message
        setErrorLabelFrame(view)
        view.addSubview(errorLabel)
        animateErrorView()
    }
    
    func hideErrorView(){
        UIView.animateWithDuration(1.0) { () -> Void in
            self.errorLabel.frame.origin.y = -self.viewHeight
        }
    }
    
    private func setErrorLabelFrame(view: UIView){
        errorLabel.frame = view.frame
        errorLabel.frame.size.height = viewHeight
        errorLabel.frame.origin.y = -viewHeight
    }
    
    private func animateErrorView(){
        UIView.animateWithDuration(1.0) { () -> Void in
            self.errorLabel.frame.origin.y = 0.0
        }
    }
}

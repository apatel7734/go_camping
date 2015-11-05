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
    private let viewHeight: CGFloat = 50.0
    private let affineTranslate = CGAffineTransformMakeTranslation(0, 50)
    private var errorViewOriginalBounds: CGRect!
    
    private init(){
        let errorView = NSBundle.mainBundle().loadNibNamed("ErrorView", owner: nil, options: nil)
        errorLabel = errorView[0] as? UILabel
    }
    
    func showErrorMessage(view:UIView, message: String){
        errorLabel.text = message
        setErrorLabelFrame(view)
        view.addSubview(errorLabel)
        resetTransform()
        animateErrorView()
    }

    private func setErrorLabelFrame(view: UIView){
        errorViewOriginalBounds = view.bounds
        errorLabel.frame = view.bounds
        errorLabel.frame.size.height = viewHeight
    }
    
    private func animateErrorView(){
        UIView.animateWithDuration(1.0) { () -> Void in
            let affineTranslate = CGAffineTransformMakeTranslation(self.errorViewOriginalBounds.origin.x,self.errorViewOriginalBounds.origin.y)
            self.errorLabel.transform = affineTranslate
        }
    }
    
    private func resetTransform(){
        let affineTranslate = CGAffineTransformMakeTranslation(self.errorViewOriginalBounds.origin.x,self.errorViewOriginalBounds.origin.y - viewHeight)
        self.errorLabel.transform = affineTranslate
    }
}

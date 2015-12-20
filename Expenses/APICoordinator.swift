//
//  APICoordinator.swift
//  Expenses
//
//  Created by Patel, Ashish on 11/8/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import Foundation
import Parse

class APICoordinator {

    static func submitPhoneNumber(phoneNumber: String , completionBlock: (response: AnyObject?, error: NSError?) -> Void){
        let params = [TwilioKey.phoneNumber : phoneNumber]
        PFCloud.callFunctionInBackground(TwilioKey.sendCode, withParameters: params, block: completionBlock)
    }
    
    static func submitCode(code: String, phoneNumber: String, completionBlock: (response: AnyObject?, error: NSError?) -> Void){
        let params = [TwilioKey.phoneNumber : phoneNumber, TwilioKey.codeEntry : code]
        PFCloud.callFunctionInBackground(TwilioKey.logIn, withParameters:
            params, block: completionBlock)
    }
}

struct TwilioKey {
    static let phoneNumber = "phoneNumber"
    static let codeEntry = "codeEntry"
    static let logIn = "logIn"
    static let sendCode = "sendCode"
}
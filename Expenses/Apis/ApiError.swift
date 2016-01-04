//
//  ApiError.swift
//  Expenses
//
//  Created by Emma on 11/5/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

class Error {
    
    var statusCode: ApiStatusCode?
    var title: String?
    var message: String?
    
    init(_ statusCode: ApiStatusCode, title: String?, message: String?) {
        self.statusCode = statusCode
        self.title = title
        self.message = message
    }
    
    convenience init(_ statusCode: ApiStatusCode) {
        switch(statusCode) {
        case .Success:
            self.init(statusCode, title: nil, message: nil)
            
        case .ServerError:
            self.init(statusCode, title: "Unexpected Error", message: "Server seems not responding")
            
        case .NetworkOffline:
            self.init(statusCode, title: "Network Connection Error", message: "Please check your network connection")
            
        case .Unknown:
            self.init(statusCode, title: "Error", message: "Please try again")
            
        default:
            self.init(statusCode, title: nil, message: nil)
        }
    }
}
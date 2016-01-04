//
//  ApiStatusCode.swift
//  Expenses
//
//  Created by Emma on 11/5/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

public enum ApiStatusCode: Int {
    
    case Success = 200
    case BadRequest = 400
    case UnAuthorized = 401
    case NotFound = 404
    case ServerError = 500
    case Maintenance = 503
    case Unknown = -1
    case NetworkOffline = -1009
    
    init(code: Int) {
        switch(code) {
        case 200:
            self = .Success
            
        case 400:
            self = .BadRequest
            
        case 401:
            self = .UnAuthorized
            
        case 404:
            self = .NotFound
            
        case 500, -1004:
            self = .ServerError
            
        case 503:
            self = .Maintenance
            
        case -1009:
            self = .NetworkOffline
            
        default:
            self = .Unknown
        }
    }
}
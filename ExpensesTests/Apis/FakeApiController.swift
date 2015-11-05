//
//  FakeApiController.swift
//  Expenses
//
//  Created by Emma on 11/5/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import RestKit

class FakeApiController: ApiController {
    
    var apiPath: String?
    var mapping: RKObjectMapping?
    var keyPath: String?
    
    override init() {
        super.init()
    }
    
    override func callGetRequestForPath(apiPath: String, mapping: RKObjectMapping, keyPath: String, completion: (statusCode: ApiStatusCode, response: AnyObject?) -> Void) {
        self.apiPath = apiPath
        self.mapping = mapping
        self.keyPath = keyPath
        
        completion(statusCode: .Success, response: nil)
    }
}

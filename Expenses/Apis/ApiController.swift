//
//  ApiController.swift
//  Expenses
//
//  Created by Emma on 11/5/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import RestKit

class ApiController {
    
    static let sharedInstance = ApiController()
    // TODO should be private but do not figure out how to override singleton yet
    internal init() {
        statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClass.Successful)
    }
    
    private let statusCodes: NSIndexSet!
    private var confDict: NSDictionary?
    
    internal func callGetRequestForPath(apiPath: String, mapping: RKObjectMapping, keyPath: String, completion: (statusCode: ApiStatusCode, response: AnyObject?) -> Void) {
        
        let descriptor: RKResponseDescriptor = RKResponseDescriptor(mapping: mapping, method: RKRequestMethod.GET,
            pathPattern: nil, keyPath: keyPath, statusCodes: statusCodes)
        let encodedPath = apiPath.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
        
        if let path = encodedPath, url = NSURL(string: path) {
            let request: NSURLRequest = NSURLRequest(URL: url)
            let operation: RKObjectRequestOperation = RKObjectRequestOperation(request: request, responseDescriptors: [descriptor])
            
            operation.setCompletionBlockWithSuccess({ (operation: RKObjectRequestOperation!, result: RKMappingResult!) in
                print("API response: \(result.array())")
                let statusCode = ApiStatusCode(code: operation.HTTPRequestOperation.response.statusCode)
                completion(statusCode: statusCode, response: result.array())
                
                }, failure: { (operation: RKObjectRequestOperation!, error: NSError!) in
                    print("API failed with error: \(error.localizedDescription)")
                    let statusCode = ApiStatusCode(code: operation.HTTPRequestOperation.response?.statusCode ?? -1)
                    completion(statusCode: statusCode, response: nil)
            })
            
            operation.start()
        }
    }
}

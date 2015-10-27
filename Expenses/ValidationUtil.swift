//
//  ValidationUtil.swift
//  Expenses
//
//  Created by Patel, Ashish on 10/25/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import Foundation

struct ValidationResponse {
    var isValid: Bool
    var errorMessage: String?
    
    init(isValidResponse: Bool, message: String?){
        isValid = isValidResponse
        errorMessage = message
    }
}

class ValidationUtil {
    
    static let sharedValidationUtil = ValidationUtil()
    private init(){
        
    }
    
    func isValidAge(age: Int) -> ValidationResponse{
        var isValid: Bool = true
        //validate age here
        if age < 1{
            isValid = false
        }
        
        
        return ValidationResponse(isValidResponse: isValid, message: "Age must be greater than 0.");
    }
    
    func isValidName(name: String) -> ValidationResponse{
        var isValid: Bool = true
        
        if name.characters.count < 5 && name.characters.count > 20{
            isValid = false
        }
        return ValidationResponse(isValidResponse: isValid, message: "Name must contains characters between 5 to 20.");
    }
    
    
    func isValidEmail(email: String) -> ValidationResponse{
        var isValid: Bool = true
        //validate email here.
        let isCharCountValid = email.characters.count < 15
        let isEmailFormatValid = emailPredicate.evaluateWithObject(email)
        isValid =  isCharCountValid || isEmailFormatValid
        
        return ValidationResponse(isValidResponse: isValid, message: "Maximum length of email should be less than 15 and Please make sure entered email is in valid format.");
    }
    
    //validate phoneNumber in format 555-555-55555 and only digits
    func isValidPhoneNumber(phoneNumber: String) -> ValidationResponse{
        var isValid: Bool = true
        //validate phone number here.
//        isValid = phonePredicate.evaluateWithObject(phoneNumber)
        if(phoneNumber.characters.count > 10){
            isValid = false
        }
        
        return ValidationResponse(isValidResponse: isValid, message: "Phone number should only contain 10 digits.");
    }
    
    lazy var emailPredicate: NSPredicate = {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    }()
    
    lazy var phonePredicate: NSPredicate = {
        let phoneRegEx = "^\\d{3}-\\d{3}-\\d{4}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
    }()
}
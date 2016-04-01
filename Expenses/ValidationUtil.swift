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
    
    func isValidAge(age: String?) -> ValidationResponse{
        var isValid: Bool = false
        //validate age here
        if let age = age{
            let ageInt: Int? = Int(age)
            if ageInt > 1{
                isValid = true
            }
        }
        
        return ValidationResponse(isValidResponse: isValid, message: "Age must be greater than 0.");
    }
    
    func isValidName(name: String?) -> ValidationResponse{
        var isValid: Bool = false
        if let name = name{
            if name.characters.count > 5 && name.characters.count < 20{
                isValid = true
            }
        }
        return ValidationResponse(isValidResponse: isValid, message: "Name must contains characters between 5 to 20.");
    }
    
    
    func isValidEmail(email: String?) -> ValidationResponse{
        var isValid: Bool = false
        //validate email here.
        if let email = email{
            if email.characters.count < 15 || emailPredicate.evaluateWithObject(email){
                isValid = true
            }
        }
        
        return ValidationResponse(isValidResponse: isValid, message: "Maximum length of email should be less than 15 and Please make sure entered email is valid.");
    }
    
    func isValidPhoneNumber(phoneNumber: String?) -> ValidationResponse{
        var isValid: Bool = false
        
        guard let phoneNumber = phoneNumber else{
            return ValidationResponse(isValidResponse: isValid, message: "Phone number should only contain 10 digits.")
        }
        let number = phoneNumber.removeWhiteSpaces()
        //validate phone number here.
        if(number.characters.count == 10 ){
            isValid = true
        }
        return ValidationResponse(isValidResponse: isValid, message: "Phone number should only contain 10 digits.");
    }
    
    func isValidPassword(password: String?) -> Bool{
        var isValid: Bool = false
        guard let password = password else {
            return isValid
        }
        
        if !password.isEmpty && password.characters.count > 4 && password.characters.count < 6{
            isValid = true
        }
        
        return isValid
    }
    
    static func isEmpty(str: String?) -> Bool {
        if let aStr = str where !aStr.isEmpty {
            return false
        }
        
        return true
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
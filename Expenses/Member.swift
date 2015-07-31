//
//  Member.swift
//  Expenses
//
//  Created by Ashish Patel on 7/19/15.
//  Copyright (c) 2015 Ashish Patel. All rights reserved.
//

import Foundation

class Member {
    var firstName: String?
    var lastName: String?
    var email: String?
    var phoneNumber: Int?
    var age: Int?
    var gender: Gender?
    var address: String?
}

enum Gender{
    case Male
    case Female
}
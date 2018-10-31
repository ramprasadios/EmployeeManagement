//
//  ErrorManager.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 24/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import Foundation

class ErrorManager {
    
    enum ErrorTypes: String {
        case invalidEmail = "Please enter valid E-Mail"
        case emptyField = "Field cannot be empty"
        case invalidPassword = "Password is Invalid"
        case noError = "Validation Success"
    }
}

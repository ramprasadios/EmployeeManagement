
//
//  LoginViewModel.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 24/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LoginViewModel {
    
    enum LoginType: String {
        case employee = "Employee"
        case employer = "Employer"
        
        var placeholderText: String {
            return "\(self.rawValue) Email ID"
        }
    }
    
    var employeeType: LoginType = .employer {
        didSet {
            self.viewModelDelegate?.updateUI()
        }
    }
    
    var userName: String?
    var password: String?
    weak var viewModelDelegate: LoginViewUpdatable?
    
    func validation() -> (ErrorManager.ErrorTypes, Bool) {
        guard let _ = userName?.isValidEmail(), self.userName != "" else { return (ErrorManager.ErrorTypes.invalidEmail, false) }
        guard let _ = self.password?.isEmpty else { return (ErrorManager.ErrorTypes.invalidPassword, false) }
        return (ErrorManager.ErrorTypes.noError, true)
    }
    
    func updateModel(of type: Int, and value: String) {
        
        switch type {
        case 101:
            self.userName = value
        case 102:
            self.password = value
        default:
            break
        }
    }
    
    func isUserAvaialble<T: NSManagedObject>() -> T? {
        switch self.employeeType {
        case .employee:
            let employees = Employee.getAllEmployees()
            let employee = employees?.filter({(($0.employeeEmail == self.userName) && ($0.employeePassword == self.password))})
    
            return employee?.first as? T
        case .employer:
            let employers = Employer.getAllEmployers()
            let employer = employers?.filter({(($0.employerEmial == self.userName) && ($0.employerPassword == self.password))})
            return employer?.first as? T
        }
    }
}

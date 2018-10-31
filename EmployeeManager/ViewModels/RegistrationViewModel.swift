//
//  RegistrationViewModel.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 25/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import Foundation

class RegistrationViewModel {
    
    var name: String?
    var emailId: String?
    var password: String?
    var employeeType: LoginViewModel.LoginType = .employer
    var gender: Gender = .male
    
    func validation() -> (ErrorManager.ErrorTypes, Bool) {

        guard let userName = self.name, userName != "" else { return (ErrorManager.ErrorTypes.emptyField, false) }
        guard let _ = emailId?.isValidEmail(), emailId != "" else { return (ErrorManager.ErrorTypes.invalidEmail, false) }
        guard let _ = self.password?.isEmpty else { return (ErrorManager.ErrorTypes.invalidPassword, false) }
        
        return (ErrorManager.ErrorTypes.noError, true)
    }
    
    func createRecord() {
        
        switch self.employeeType {
        case .employee:
            let employee = Employee.initEntity() as Employee
            employee.employeeName = self.name
            employee.employeeEmail = self.emailId
            employee.employeePassword = self.password
            employee.employeeGender = self.gender.rawValue
            
            CoreDataManager.default.saveContext()
            
        case .employer:
            
            let employer = Employer.initEntity() as Employer
            employer.employerName = self.name
            employer.employerEmial = self.emailId
            employer.employerPassword = self.password
            employer.employerGender = self.gender.rawValue
            
            CoreDataManager.default.saveContext()
        }
    }
    
    func updateModel(of type: Int, and value: String) {
        
        switch type {
        case 103:
            self.name = value
        case 104:
            self.emailId = value
        case 105:
            self.password = value
        case 106:
            self.employeeType = LoginViewModel.LoginType(rawValue: value) ?? .employee
        default:
            break
        }
    }
}

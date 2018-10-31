//
//  EmployeeViewModel.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 28/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import Foundation
import UIKit

class UserViewModel {
    
    enum EmployeeOptions: String {
        case team = "Team members"
        case salary = "My Salary"
        case project = "Project Allotted"
        case deadline = "Project Completion Date"
        case employer = "My Employer"
        case logout = "Logout"
        
        static var dataSource: [EmployeeOptions] = [.team, .salary, .project, .deadline, .employer, .logout]
        
        static func count() -> Int {
            return self.dataSource.count
        }
    }
    
    enum EmployerOptions: String {
        case empAdd = "Add Employee"
        case edit = "Edit Employee"
        case delete = "Delete Employee"
        case viewEmployee = "View Employee Profile"
        case assign = "Assign Teams"
        case logout = "Logout"
        
        static var dataSource: [EmployerOptions] = [.empAdd, .edit, .delete, .viewEmployee, .assign, .logout]
        
        static func count() -> Int {
            return self.dataSource.count
        }
    }
    
    var loggedInUserType: LoginViewModel.LoginType? {
        guard let user = UserInfo.getUser() else { return nil }
        guard let loginType = user.loginType else { return nil }
        guard let type = LoginViewModel.LoginType(rawValue: loginType) else { return nil }
        return type
    }
    
    var numberOfOptions: Int {
        guard let type = self.loggedInUserType else { return 0 }
        switch type {
        case .employee:
            return UserViewModel.EmployeeOptions.count()
        case .employer:
            return UserViewModel.EmployerOptions.count()
        }
        
    }
    
    func optionValue(atIndex index: Int) -> String {
        guard let type = self.loggedInUserType else { return "" }
        switch type {
        case .employee:
            return UserViewModel.EmployeeOptions.dataSource[index].rawValue
        case .employer:
            return UserViewModel.EmployerOptions.dataSource[index].rawValue
        }
    }
    
    func selectedOption(atIndex index: Int) -> AnyObject? {
        guard let type = self.loggedInUserType else { return nil }
        switch type {
        case .employee:
            return UserViewModel.EmployeeOptions.dataSource[index] as AnyObject
        case .employer:
            return UserViewModel.EmployerOptions.dataSource[index] as AnyObject
        }
    }
}

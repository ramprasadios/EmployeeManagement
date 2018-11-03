//
//  ProfileViewModel.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 03/11/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import Foundation

class ProfileViewModel {
    
    enum ProfileMenu: String {
        case designation = "Designation"
        case salary = "Salary"
        case gender = "Gender"
        case chageImage = "Change Profile Image"
        case changeName = "Change Profile Name"
        case changeEmail = "Change Email ID"
        
        static let caseValues: [ProfileMenu] = [.designation, .salary, .gender, .chageImage, .changeName, .changeEmail]
    }
    
    var currentUser: AnyObject?
    
    var userType: LoginViewModel.LoginType? {
        guard let user = self.currentUser else { return nil }
        guard let _ = user as? Employee else { return .employer }
        return .employee
    }
}

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
        
        var image: UIImage? {
            switch self {
            case .deadline:
                return UIImage(named: "my_project_deadline")
            case .employer:
                return UIImage(named: "my_employer")
            case .logout:
                return UIImage(named: "logout")
            case .project:
                return UIImage(named: "project_allotted")
            case .salary:
                return UIImage(named: "my_salary")
            case .team:
                return UIImage(named: "my_team")
            }
        }
    }
    
    enum EmployerOptions: String {
        case addProject = "Add New Project"
        case edit = "Edit Employee"
        case viewEmployee = "View Employee Profile"
        case assign = "Assign Teams"
        case logout = "Logout"
        
        static var dataSource: [EmployerOptions] = [.addProject, .edit, .viewEmployee, .assign, .logout]
        
        static func count() -> Int {
            return self.dataSource.count
        }
        
        var image: UIImage? {
            switch self {
            case .addProject:
                return UIImage(named: "new_project_add")
            case .assign:
                return UIImage(named: "assign_team")
            case .edit:
                return UIImage(named: "edit_employee")
            case .logout:
                return UIImage(named: "logout")
            case .viewEmployee:
                return UIImage(named: "view_profile")
            }
        }
    }
    
    var userName: String!
    var userRole: String!
    var userEmial: String!
    var userType: String!
    var gender: Gender!
    var userImage: UIImage?
    var user: UserInfo?
    
    var fullName: String {
        switch self.gender {
        case .male?:
           return "Mr. " + self.userName
        case .female?:
           return "Ms. " + self.userName
        case .none:
            return ""
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
    
    init() {
        self.getInitialValue()
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
    
    func getInitialValue() {
        self.user = UserInfo.getUser()
        switch self.loggedInUserType! {
        case .employee:
            self.userName = user?.employee?.employeeName
            self.userRole = "Software Developer"
            self.userType = "Employee"
            self.userEmial = user?.employee?.employeeEmail
            self.gender = Gender(rawValue: user?.employee?.employeeGender ?? "")
            guard let userImageData = user?.employee?.employeeImage else { return }
            guard let userImage = UIImage(data: userImageData as Data) else { return }
            self.userImage = userImage
        case .employer:
            self.userName = user?.employer?.employerName
            self.userRole = "Project Manager"
            self.userType = "Employer"
            self.userEmial = user?.employer?.employerEmial
            self.gender = Gender(rawValue: user?.employer?.employerGender ?? "")
            guard let userImageData = user?.employer?.employerImage else { return }
            guard let userImage = UIImage(data: userImageData as Data) else { return }
            self.userImage = userImage
        }
    }
    
    func addNewproject(withName name: String, andDeadline deadline: String) {
        let project = Project.initEntity() as Project
        project.projectName = name
        project.projetDate = deadline
        
        CoreDataManager.default.saveContext(with: project.managedObjectContext)
    }
    
    func setUserImage(with image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
        guard let type = self.loggedInUserType else { return }
        switch type {
        case .employee:
            self.user?.employee?.employeeImage = imageData as NSData
        case .employer:
            self.user?.employer?.employerImage = imageData as NSData
        }
        CoreDataManager.default.saveContext()
    }
}

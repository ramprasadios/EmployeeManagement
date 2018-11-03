//
//  ProjectInfo.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 30/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import Foundation
import CoreData

class ProjectInfo {
    
    var projects: [Project] {
        guard let projects = Project.getAllProjects() else { return [] }
        return projects
    }
    
    var projectNames: [String] {
        var array: [String] = []
        for project in self.projects {
            array.append(project.projectName ?? "")
        }
        return array
    }
    
    func getEmployees(_ project: Project, _ areIn: Bool) -> [Employee] {
        
        guard let employees = Employee.getAllEmployees() else { return [] }
        var filteredEmployees: [Employee] = []
        if areIn {
            filteredEmployees = employees.filter({ $0.project == project })
        } else {
            filteredEmployees = employees.filter({ $0.project != project })
        }
        return filteredEmployees
    }

    func handleEmployee(options type: UserViewModel.EmployerOptions, ofEmployee employee: Employee, toProject project: Project? = nil) {
        switch type {
        case .edit:
            employee.project = nil
        case .assign:
            employee.project = project
            employee.employer = UserInfo.getUser()?.employer
        default:
            break
        }
        CoreDataManager.default.saveContext()
    }
}

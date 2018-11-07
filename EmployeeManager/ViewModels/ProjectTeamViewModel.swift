
//
//  ProjectTeamViewModel.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 03/11/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import Foundation

class ProjectTeamViewModel {
    
    func getMyProjects() -> [Project]? {
        guard let projects = Project.getAllProjects() else { return nil}
//        guard let currentEmployee = UserInfo.getUser()?.employee else { return nil}
//        let myProjects = projects.filter({$0.employee == currentEmployee})
        return projects
    }
    
    func getMyTeam(in project: Project) -> [Employee]? {
//        guard let employees = Employee.getAllEmployees() else { return nil }
//        let myTeam = employees.filter({$0.project == project})
        let myTeam = project.employee?.allObjects as? [Employee]
        return myTeam
    }
}

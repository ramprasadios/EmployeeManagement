//
//  ProjectTeamViewController.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 03/11/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import UIKit

class ProjectTeamViewController: UIViewController {
    
    
    @IBOutlet weak var projectTeamTableView: UITableView!
    
    var projectTeamViewModel = ProjectTeamViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.projectTeamTableView.register(EmployeeTableViewCell.self)
    }
}

extension ProjectTeamViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.projectTeamViewModel.getMyProjects()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let myProjects = self.projectTeamViewModel.getMyProjects() else { return 0 }
        return self.projectTeamViewModel.getMyTeam(in: myProjects[section])?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeCell(forIndexPath: indexPath) as EmployeeTableViewCell
        let project = self.projectTeamViewModel.getMyProjects()?[indexPath.section]
        let employee = project?.employee?.allObjects[indexPath.row] as? Employee
        cell.employeeNameLabel.text = employee?.employeeName
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let myProjects = self.projectTeamViewModel.getMyProjects() else {
            return ""
        }
        return myProjects[section].projectName
    }
}

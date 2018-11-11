//
//  ProjectManagementViewController.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 31/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import UIKit
import DropDown
import Toast_Swift

class ProjectManagementViewController: UIViewController {
    
    @IBOutlet weak var projectTableView: UITableView!
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var projectNameLabel: UILabel!
    
    var projectViewModel = ProjectInfo()
    let dropDown = DropDown()
    var project: Project?
    var employerOptions: UserViewModel.EmployerOptions = .edit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    @objc
    func dropDownTapped() {
        self.dropDown.show()
    }
}

extension ProjectManagementViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let currentProject = self.project else { return 0 }
        if section == 0 {
            return projectViewModel.getEmployees(currentProject, true).count
        } else {
            return projectViewModel.getEmployees(currentProject, false).count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoramlCell", for: indexPath)
        if let currentProject = self.project {
            if indexPath.section == 0 {
                cell.textLabel?.text = self.projectViewModel.getEmployees(currentProject, true)[indexPath.row].employeeName
            } else {
                cell.textLabel?.text = self.projectViewModel.getEmployees(currentProject, false)[indexPath.row].employeeName
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section == 0) ? "Empoyees Alloted in Project" : "Employees available to be allotted"
    }
}

extension ProjectManagementViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        if indexPath.section == 0 {
            return .delete
        }
        return .insert
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        var employee: Employee?
        if let currentProject = self.project {
            switch indexPath.section {
            case 0:
                employee = self.projectViewModel.getEmployees(currentProject, true)[indexPath.row]
            case 1:
                employee = self.projectViewModel.getEmployees(currentProject, false)[indexPath.row]
            default:
                break
            }
            
            switch editingStyle {
            case .delete:
                self.projectViewModel.handleEmployee(options: .edit, ofEmployee: employee!, toProject: currentProject)
                self.view.makeToast("Employee Removed from the Project Successfully")
            case .insert:
                self.projectViewModel.handleEmployee(options: .assign, ofEmployee: employee!, toProject: currentProject)
                self.view.makeToast("Employee Added to the Project Successfully")
            default:
                break
            }
            
            self.projectTableView.reloadData()
        }
    }
}

extension ProjectManagementViewController {
    
    func initialSetup() {
        if AppManager.loggedInUserType! == .employer {
            self.projectTableView.setEditing(true, animated: true)
        }
        
        dropDown.anchorView = self.dropDownView
        dropDown.dataSource = self.projectViewModel.projectNames
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProjectManagementViewController.dropDownTapped))
        self.dropDownView.addGestureRecognizer(tap)
        
        self.projectNameLabel.text = dropDown.dataSource.first
        
        dropDown.selectionAction = { (index: Int, item: String) in
            self.projectNameLabel.text = item
            self.project = self.projectViewModel.projects[index]
            self.projectTableView.reloadData()
        }
        
        self.project = self.projectViewModel.projects.first
        self.projectTableView.reloadData()
    }
}

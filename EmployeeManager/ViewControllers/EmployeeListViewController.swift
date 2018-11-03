//
//  EmployeeListViewController.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 03/11/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import UIKit

class EmployeeListViewController: UIViewController {

    @IBOutlet weak var employeeManagementTableView: UITableView!
    
    var employeeViewModel = EmployeeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initalSetup()
    }
    
    func initalSetup() {
        self.employeeManagementTableView.register(EmployeeTableViewCell.self)
    }
}

extension EmployeeListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? employeeViewModel.employers.count : employeeViewModel.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeCell(forIndexPath: indexPath) as EmployeeTableViewCell
        if indexPath.section == 0 {
            cell.employeeNameLabel.text = self.employeeViewModel.employers[indexPath.row].employerName
        } else {
            cell.employeeNameLabel.text = self.employeeViewModel.employees[indexPath.row].employeeName
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section == 0) ? "Employers" : "Employees"
    }
}

extension EmployeeListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileVc = StoryboardManager.default.initViewController(storyBoardType: .Home, viewController: .profile) as ProfileViewController
        switch indexPath.section {
        case 0:
            profileVc.profileViewModel.currentUser = self.employeeViewModel.employers[indexPath.row] as AnyObject
        case 1:
            profileVc.profileViewModel.currentUser = self.employeeViewModel.employees[indexPath.row] as AnyObject
        default:
            break
        }
        self.navigationController?.pushViewController(profileVc, animated: true)
    }
}

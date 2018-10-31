//
//  EmployeeViewController.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 27/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import UIKit

class UserDashboardViewController: UIViewController {

    @IBOutlet weak var employeeTableView: UITableView!
    @IBOutlet weak var loginUserTypeLabel: UILabel!
        
    var userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let tableHeaderView = employeeTableView.tableHeaderView {
            let height = tableHeaderView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
            var headerFrame = tableHeaderView.frame
            
            if height != headerFrame.size.height {
                headerFrame.size.height = height + CGFloat(20.0)
                tableHeaderView.frame = headerFrame
                employeeTableView.tableHeaderView = tableHeaderView
            }
        }
    }
}

//MARK:- Helper Methods
extension UserDashboardViewController {
    
    func initialSetup() {
        
        self.employeeTableView.register(OptionsTableViewCell.self)
        
        guard let headerView = Bundle.main.loadNibNamed("ProfileHeaderView", owner: self, options: nil)?.first as? ProfileHeaderView else { return }
        self.employeeTableView.tableHeaderView = headerView
    }
}

extension UserDashboardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userViewModel.numberOfOptions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeCell(forIndexPath: indexPath) as OptionsTableViewCell
        cell.optionTypeLabel.text = self.userViewModel.optionValue(atIndex: indexPath.row)
        cell.optionDescriptionLabel.text = "Click here for more option on \(self.userViewModel.optionValue(atIndex: indexPath.row))"
        cell.selectionStyle = .none
        return cell
    }
}

extension UserDashboardViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = self.userViewModel.loggedInUserType else { return }
        switch type {
        case .employee:
            guard let selectedType = self.userViewModel.selectedOption(atIndex: indexPath.row) as? UserViewModel.EmployeeOptions else { return }
            switch selectedType {
            case .logout:
                AppManager.logoutUser()
            default:
                break
            }
        case .employer:
            guard let selectedType = self.userViewModel.selectedOption(atIndex: indexPath.row) as? UserViewModel.EmployerOptions else { return }
            switch selectedType {
            case .logout:
                AppManager.logoutUser()
            default:
                break
            }
        }
    }
}

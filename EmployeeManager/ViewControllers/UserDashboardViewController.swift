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
    var imageHandler: ((_ image: UIImage) -> Void)?
    var imagePickerContoller: UIImagePickerController?
    
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
        
        headerView.userNameLabel.text = self.userViewModel.fullName
        headerView.userRoleLabel.text = self.userViewModel.userRole
        headerView.userEmailLabel.text = self.userViewModel.userEmial
        headerView.userTypeLabel.text = self.userViewModel.userType

        headerView.userImageView.image = self.userViewModel.userImage
        
        headerView.delegate = self
        
        self.loginUserTypeLabel.text = "Logged in as " + self.userViewModel.userType
        self.title = self.userViewModel.userType
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
        if let type = self.userViewModel.loggedInUserType {
            switch type {
            case .employee:
                cell.optionCellImageView.image = UserViewModel.EmployeeOptions.dataSource[indexPath.row].image
            case .employer:
                cell.optionCellImageView.image = UserViewModel.EmployerOptions.dataSource[indexPath.row].image
            }
        }
        cell.selectionStyle = .none
        return cell
    }
}

extension UserDashboardViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = self.userViewModel.loggedInUserType else { return }
        switch type {
        case .employee:
            guard let selectedType = self.userViewModel.selectedOption(atIndex: indexPath.row) as? UserViewModel.EmployeeOptions else { return }
            switch selectedType {
            case .logout:
                self.logoutConfirmation()
            
            case .project:
                let projVc = StoryboardManager.default.initViewController(storyBoardType: .Home, viewController: .projManagementVc) as ProjectManagementViewController
                self.navigationController?.pushViewController(projVc, animated: true)
                
            case .deadline:
                self.showAlert(with: "Project Completion", and: "My Project deadline is 2 Months")
                
            case .employer:
                guard let employer = UserInfo.getUser()?.employee?.employer?.employerName else {
                    showAlert(with: "Error", and: "No Employer Assigned")
                    return }
                self.showAlert(with: "Employer Detail", and: "My Employer Name is \(String(describing: employer))")
                
            case .salary:
                self.showAlert(with: "Salary Detail", and: "My Salary is 40,000 ₹")
                
            case .team:
                let projectTeamVc = StoryboardManager.default.initViewController(storyBoardType: .Home, viewController: .projectTeam) as ProjectTeamViewController
                self.navigationController?.pushViewController(projectTeamVc, animated: true)
                
            }
        case .employer:
            guard let selectedType = self.userViewModel.selectedOption(atIndex: indexPath.row) as? UserViewModel.EmployerOptions else { return }
            switch selectedType {
            case .logout:
                self.logoutConfirmation()
                
            case .addProject:
                self.getProjectData()
                
            case .assign:
                let projVc = StoryboardManager.default.initViewController(storyBoardType: .Home, viewController: .projManagementVc) as ProjectManagementViewController
                projVc.employerOptions = selectedType
                self.navigationController?.pushViewController(projVc, animated: true)
                
            case .edit:
                let projVc = StoryboardManager.default.initViewController(storyBoardType: .Home, viewController: .projManagementVc) as ProjectManagementViewController
                projVc.employerOptions = selectedType
                self.navigationController?.pushViewController(projVc, animated: true)
                
            case .viewEmployee:
                let empVc = StoryboardManager.default.initViewController(storyBoardType: .Home, viewController: .employeeList) as EmployeeListViewController
                self.navigationController?.pushViewController(empVc, animated: true)
            }
        }
    }
}

extension UserDashboardViewController {
    
    func getProjectData() {
        let alertController = UIAlertController(title: "Add new project...!", message: "Please enter the project name and duration in the text field below", preferredStyle: .alert)
        
        alertController.addTextField { (projectNameTextField) in
            projectNameTextField.placeholder = "Project Name"
        }
        
        alertController.addTextField { (projectDurationTextField) in
            projectDurationTextField.placeholder = "Project Duration"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (projAddAction) in
            
            guard let pnTextField = alertController.textFields?.first,
            let durationTextField = alertController.textFields?.last,
            let projName = pnTextField.text,
                let duration = durationTextField.text, projName != "", duration != "" else { return }
            self.userViewModel.addNewproject(withName: projName, andDeadline: duration)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func logoutConfirmation() {
        let alertController = UIAlertController(title: "Alert...!", message: "Are your sure your want to Logout..?", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Logout", style: .destructive) { (projAddAction) in
            AppManager.logoutUser()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UserDashboardViewController: ImageChnageHandlerProtocol {
   
    func editImageTapped() {
        self.imagePickerContoller = UIImagePickerController()
        self.imagePickerContoller?.sourceType = .photoLibrary
        self.imagePickerContoller?.delegate = self
        
        print("Change image initilized")
        self.present(imagePickerContoller!, animated: true, completion: nil)
    }
}

extension UserDashboardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            guard let headerView = self.employeeTableView.tableHeaderView as? ProfileHeaderView else { return }
            headerView.userImageView.image = image
            self.imagePickerContoller?.delegate = nil
            self.userViewModel.setUserImage(with: image)
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

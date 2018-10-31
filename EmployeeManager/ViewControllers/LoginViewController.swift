//
//  LoginViewController.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 24/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    var loginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginViewModel.viewModelDelegate = self
    }
    
    @IBAction func userTypeSwitching(_ sender: Any) {
        guard let segmentedControl = sender as? UISegmentedControl else { return }
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            loginViewModel.employeeType = .employer
        case 1:
            loginViewModel.employeeType = .employee
        default:
            break
        }
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        self.handleLogin()
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            self.loginViewModel.updateModel(of: textField.tag, and: updatedText)
        }
        return true
    }
}

//MARK:- LoginViewUpdatable Methods:
extension LoginViewController: LoginViewUpdatable {
    
    func updateUI() {
        self.userNameTextField.placeholder = self.loginViewModel.employeeType.placeholderText
    }
}

//MARK:- Helper Methods
extension LoginViewController {
    
    func handleLogin() {
        let loginValidation = self.loginViewModel.validation()
        
        if loginValidation.1 {
            //Navigate to next page
            switch loginViewModel.employeeType {
            case .employee:
                guard let employeeUser = self.loginViewModel.isUserAvaialble() as? Employee else {
                    self.showAlert(with: "Error...!", and: "Username or Password is not correct")
                    return
                }
                let user: UserInfo = UserInfo.initEntity()
                user.employee = employeeUser
                user.loginType = loginViewModel.employeeType.rawValue
                user.loginStatus = loginValidation.1
                CoreDataManager.default.saveContext(with: user.managedObjectContext)
                
                print("Employee Identified \(String(describing: employeeUser.employeeName))")
                AppManager.changeRootWith(rootType: .userHome)
            case .employer:
                guard let employerUser = self.loginViewModel.isUserAvaialble() as? Employer else {
                    self.showAlert(with: "Error...!", and: "Username or Password is not correct")
                    return
                }
                let user: UserInfo = UserInfo.initEntity()
                user.employer = employerUser
                user.loginType = loginViewModel.employeeType.rawValue
                user.loginStatus = loginValidation.1
                CoreDataManager.default.saveContext(with: user.managedObjectContext)
                print("Employer identified with name \(String(describing: employerUser.employerName))")
                AppManager.changeRootWith(rootType: .userHome)
            }
        } else {
            self.showAlert(with: "Error !", and: loginValidation.0.rawValue)
        }
    }
}


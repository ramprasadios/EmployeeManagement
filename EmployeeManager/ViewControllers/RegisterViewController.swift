//
//  RegisterViewController.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 25/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var employeeTypeTextField: UITextField!
    @IBOutlet var genderSelection: [UIButton]!
    
    let registerViewModel = RegistrationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        let registerValidation = self.registerViewModel.validation()
        if registerValidation.1 {
            //Navigate to next page
            self.registerViewModel.createRecord()
            self.dismiss(animated: true, completion: nil)
        } else {
            self.showAlert(with: "Error !", and: registerValidation.0.rawValue)
        }
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func genderSelectionTapped(_ sender: Any) {
        if let tappedButton = sender as? UIButton {
            for button in self.genderSelection {
                if button.tag == tappedButton.tag {
                    button.backgroundColor = UIColor.blue
                } else {
                    button.backgroundColor = UIColor.white
                }
            }
            if tappedButton.tag == self.genderSelection.first?.tag {
                self.registerViewModel.gender = Gender.male
            } else {
                self.registerViewModel.gender = Gender.female
            }
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 106 {
            self.view.endEditing(true)
            self.showLists()
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            self.registerViewModel.updateModel(of: textField.tag, and: updatedText)
        }
        return true
    }
}

extension RegisterViewController {
    
    func showLists() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "OptionsListViewController") as? OptionsListViewController else { return }
        vc.optionsViewModel.optionsArray = ["Employer", "Employee"]
        vc.optionsListDelegate = self
        self.present(vc, animated: false, completion: nil)
    }
}

extension RegisterViewController: ModelPresentable {
    
    func selectedType(with text: String) {
        self.registerViewModel.updateModel(of: 106, and: text)
        self.employeeTypeTextField.text = text
    }
}

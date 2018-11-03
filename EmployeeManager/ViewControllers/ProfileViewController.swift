//
//  ProfileViewController.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 03/11/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profileViewModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileViewModel.ProfileMenu.caseValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
        cell.textLabel?.text = ProfileViewModel.ProfileMenu.caseValues[indexPath.row].rawValue
        cell.detailTextLabel?.text = "More information"
        return cell
    }
}

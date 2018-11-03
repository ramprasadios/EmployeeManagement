//
//  StoryboardManager.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 27/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import Foundation
import UIKit

class StoryboardManager {
    
    enum StoryBoardType: String {
        case main = "Main"
        case Home = "Home"
        
        var storyBoardName: UIStoryboard {
            return UIStoryboard(name: self.rawValue, bundle: nil)
        }
    }
    
    enum ScreenType: String {
        case login = "LoginViewController"
        case register = "RegisterViewController"
        case userHome = "UserDashboardViewController"
        case projManagementVc = "ProjectManagementViewController"
        case employeeList = "EmployeeListViewController"
        case profile = "ProfileViewController"
        case projectTeam = "ProjectTeamViewController"
        
        
        //Nav Controllers :
        case loginNav = "LoginNavigationController"
        case employeeNav = "HomeNavigationController"
        case employerNav = "EmployerNavigationController"
        
    }
    
    static var `default`: StoryboardManager {
        struct Singleton {
            static let instance = StoryboardManager()
        }
        return Singleton.instance
    }
    
    func initViewController<T: UIViewController>(storyBoardType type: StoryBoardType, viewController screen: ScreenType) -> T {
        return type.storyBoardName.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
}

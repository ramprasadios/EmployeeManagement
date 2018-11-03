//
//  AppManager.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 27/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

class AppManager: NSObject {
    
    class var loggedInUserStatus: Bool {
        guard let user = UserInfo.getUser() else { return false }
        return user.loginStatus
    }
    
    class var loggedInUserType: LoginViewModel.LoginType? {
        guard let user = UserInfo.getUser() else { return nil }
        guard let userType = user.loginType else { return nil }
        guard let type = LoginViewModel.LoginType(rawValue: userType) else { return nil }
        return type
    }
    
    class func initialSetup() {
        printCoreDataURL()
        checkLoginNavigation()
        configureDependency()
    }
    
    class func checkLoginNavigation() {
        if self.loggedInUserStatus {
            changeRootWith(rootType: .userHome)
        } else {
            changeRootWith(rootType: .login)
        }
    }
    
    class func configureDependency() {
        IQKeyboardManager.shared.enable = true
    }
    
    class func printCoreDataURL() {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else { return }
        print(url)
    }
    
    class func changeRootWith(rootType type: RootType) {
        switch type {
        case .login:
            let loginNavController = StoryboardManager.default.initViewController(storyBoardType: .main, viewController: .loginNav) as LoginNavigationController
            self.setRootVc(with: loginNavController)
        case .userHome:
            let homeNavController = StoryboardManager.default.initViewController(storyBoardType: .Home, viewController: .employeeNav) as HomeNavigationController
            self.setRootVc(with: homeNavController)
        }
    }
    
    class func setRootVc(with controller: UIViewController) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return }
        
        UIView.transition(with: appDelegate.window!,
                          duration: 0.3,
                          options: .transitionFlipFromLeft,
                          animations: {
                              appDelegate.window?.rootViewController = controller
        }, completion: nil)
    }
    
    class func logoutUser() {
        CoreDataManager.default.deleteEntity(entityName: String(describing: UserInfo.self))
        self.changeRootWith(rootType: .login)
    }
}

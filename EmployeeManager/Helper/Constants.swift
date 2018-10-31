//
//  Constants.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 28/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import Foundation

enum RootType {
    case login, userHome
}

//Projects active in the company
enum Projects: String {
    case iot = "IOT Management"
    case iOS = "iOS App Development"
    case android = "Android App Development"
    case web = "Web App Development"
    case embedded = "Embedded Software Development"
    case java = "Java Backend Development"
    case nodeJs = "Node JS Backend Development"
    
    //Returning the project duration in terms of months.
    var projectDeadlines: Int {
        return self.rawValue.count
    }
}


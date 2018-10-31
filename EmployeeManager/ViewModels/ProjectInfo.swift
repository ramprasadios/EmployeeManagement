//
//  ProjectInfo.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 30/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import Foundation

class ProjectInfo {
    
    
}

extension ProjectInfo: EnumIteratable {
    
    var allProjects: [Projects] {
        return self.iterateEnum(Projects.self).enumerated().map({$0.element})
    }
}

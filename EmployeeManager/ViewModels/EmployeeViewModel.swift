//
//  EmployeeViewModel.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 03/11/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import Foundation
import CoreData

class EmployeeViewModel {
    
    var employees: [Employee] {
        return self.getEmployeeList(ofType: .employee)
    }
    
    var employers: [Employer] {
        return self.getEmployeeList(ofType: .employer)
    }
    
    func getEmployeeList<T: NSManagedObject>(ofType type: LoginViewModel.LoginType) -> [T] {
        switch type {
        case .employee:
            return Employee.getAllEmployees() as! [T]
        case .employer:
            return Employer.getAllEmployers() as! [T]
        }
    }
    
}

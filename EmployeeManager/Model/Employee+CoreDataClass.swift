//
//  Employee+CoreDataClass.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 26/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Employee)
public class Employee: NSManagedObject {
    
    static func getAllEmployees() -> [Employee]? {
        guard let moc = CoreDataManager.default.managedObjectContext else { return nil }
        let fetchRequest: NSFetchRequest<Employee> = self.getFetchRequest()
        do {
            let employees = try moc.fetch(fetchRequest)
            return employees
        } catch let error {
            print("Error Fetching Employer Records \(error.localizedDescription)")
        }
        return nil
    }
}

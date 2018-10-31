//
//  Employee+CoreDataProperties.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 30/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var employeeSalary: Double
    @NSManaged public var employeePassword: String?
    @NSManaged public var employeeName: String?
    @NSManaged public var employeeImage: NSData?
    @NSManaged public var employeeEmail: String?
    @NSManaged public var employer: Employer?
    @NSManaged public var project: Project?
    @NSManaged public var employeeUser: UserInfo?

}

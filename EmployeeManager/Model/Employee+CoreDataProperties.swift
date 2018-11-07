//
//  Employee+CoreDataProperties.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 03/11/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var employeeEmail: String?
    @NSManaged public var employeeGender: String?
    @NSManaged public var employeeImage: NSData?
    @NSManaged public var employeeName: String?
    @NSManaged public var employeePassword: String?
    @NSManaged public var employeeSalary: Double
    @NSManaged public var employeeUser: UserInfo?
    @NSManaged public var employer: Employer?
    @NSManaged public var project: NSSet?

}

// MARK: Generated accessors for project
extension Employee {

    @objc(addProjectObject:)
    @NSManaged public func addToProject(_ value: Project)

    @objc(removeProjectObject:)
    @NSManaged public func removeFromProject(_ value: Project)

    @objc(addProject:)
    @NSManaged public func addToProject(_ values: NSSet)

    @objc(removeProject:)
    @NSManaged public func removeFromProject(_ values: NSSet)

}

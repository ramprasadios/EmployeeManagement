//
//  Project+CoreDataProperties.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 26/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//
//

import Foundation
import CoreData


extension Project {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        return NSFetchRequest<Project>(entityName: "Project")
    }

    @NSManaged public var projectName: String?
    @NSManaged public var projetDate: String?
    @NSManaged public var employee: NSSet?
    @NSManaged public var employer: Employer?

}

// MARK: Generated accessors for employee
extension Project {

    @objc(addEmployeeObject:)
    @NSManaged public func addToEmployee(_ value: Employee)

    @objc(removeEmployeeObject:)
    @NSManaged public func removeFromEmployee(_ value: Employee)

    @objc(addEmployee:)
    @NSManaged public func addToEmployee(_ values: NSSet)

    @objc(removeEmployee:)
    @NSManaged public func removeFromEmployee(_ values: NSSet)

}

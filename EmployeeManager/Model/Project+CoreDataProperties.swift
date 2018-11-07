//
//  Project+CoreDataProperties.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 03/11/18.
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
    @NSManaged public var employer: NSSet?

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

// MARK: Generated accessors for employer
extension Project {

    @objc(addEmployerObject:)
    @NSManaged public func addToEmployer(_ value: Employer)

    @objc(removeEmployerObject:)
    @NSManaged public func removeFromEmployer(_ value: Employer)

    @objc(addEmployer:)
    @NSManaged public func addToEmployer(_ values: NSSet)

    @objc(removeEmployer:)
    @NSManaged public func removeFromEmployer(_ values: NSSet)

}

//
//  Employer+CoreDataProperties.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 30/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//
//

import Foundation
import CoreData


extension Employer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employer> {
        return NSFetchRequest<Employer>(entityName: "Employer")
    }

    @NSManaged public var employerSalary: Double
    @NSManaged public var employerPassword: String?
    @NSManaged public var employerName: String?
    @NSManaged public var employerImage: NSData?
    @NSManaged public var employerEmial: String?
    @NSManaged public var employee: NSSet?
    @NSManaged public var project: NSSet?
    @NSManaged public var employerUser: UserInfo?

}

// MARK: Generated accessors for employee
extension Employer {

    @objc(addEmployeeObject:)
    @NSManaged public func addToEmployee(_ value: Employee)

    @objc(removeEmployeeObject:)
    @NSManaged public func removeFromEmployee(_ value: Employee)

    @objc(addEmployee:)
    @NSManaged public func addToEmployee(_ values: NSSet)

    @objc(removeEmployee:)
    @NSManaged public func removeFromEmployee(_ values: NSSet)

}

// MARK: Generated accessors for project
extension Employer {

    @objc(addProjectObject:)
    @NSManaged public func addToProject(_ value: Project)

    @objc(removeProjectObject:)
    @NSManaged public func removeFromProject(_ value: Project)

    @objc(addProject:)
    @NSManaged public func addToProject(_ values: NSSet)

    @objc(removeProject:)
    @NSManaged public func removeFromProject(_ values: NSSet)

}

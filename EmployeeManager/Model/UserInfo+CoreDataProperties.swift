//
//  UserInfo+CoreDataProperties.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 30/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var loginType: String?
    @NSManaged public var loginStatus: Bool
    @NSManaged public var employee: Employee?
    @NSManaged public var employer: Employer?

}

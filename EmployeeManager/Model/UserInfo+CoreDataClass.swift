//
//  UserInfo+CoreDataClass.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 30/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//
//

import Foundation
import CoreData

@objc(UserInfo)
public class UserInfo: NSManagedObject {
    
    static func getUser() -> UserInfo? {
        guard let moc = CoreDataManager.default.managedObjectContext else { return nil }
        let fetchRequest: NSFetchRequest<UserInfo> = self.getFetchRequest()
        do {
            let userInfo = try moc.fetch(fetchRequest)
            return userInfo.first
        } catch let error {
            print("Error Fetching Employer Records \(error.localizedDescription)")
        }
        return nil
    }
}

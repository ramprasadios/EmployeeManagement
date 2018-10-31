//
//  Employer+CoreDataClass.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 26/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Employer)
public class Employer: NSManagedObject {
    
    static func getAllEmployers() -> [Employer]? {
        guard let moc = CoreDataManager.default.managedObjectContext else { return nil }
        let fetchRequest: NSFetchRequest<Employer> = self.getFetchRequest()
        do {
            let employers = try moc.fetch(fetchRequest)
            return employers
        } catch let error {
            print("Error Fetching Employer Records \(error.localizedDescription)")
        }
        return nil
    }
}

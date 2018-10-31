//
//  Project+CoreDataClass.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 26/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Project)
public class Project: NSManagedObject {

    static func getAllProjects() -> [Project]? {
        guard let moc = CoreDataManager.default.managedObjectContext else { return nil }
        let fetchRequest: NSFetchRequest<Project> = self.getFetchRequest()
        do {
            let projects = try moc.fetch(fetchRequest)
            return projects
        } catch let error {
            print("Error Fetching Employer Records \(error.localizedDescription)")
        }
        return nil
        
    }
}

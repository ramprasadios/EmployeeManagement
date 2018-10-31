//
//  NSManagedObject+Extension.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 27/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    
    static func getFetchRequest<T: NSManagedObject>() -> NSFetchRequest<T> {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        return request
    }
    
    static func initEntity<T: NSManagedObject>(context: NSManagedObjectContext? = nil) -> T {
        var objectContext: NSManagedObjectContext = CoreDataManager.default.managedObjectContext!
        if let value = context {
            objectContext = value
        }
        let entityDescription = NSEntityDescription.entity(forEntityName: String(describing: T.self), in: objectContext)!
        let entity = NSManagedObject(entity: entityDescription, insertInto: objectContext) as! T
        return entity
    }
}

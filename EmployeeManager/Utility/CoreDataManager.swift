//
//  CoreDataManager.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 11/08/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager: NSObject {
    
    class var `default`: CoreDataManager {
        struct Singleton {
            static var instance = CoreDataManager()
        }
        return Singleton.instance
    }
    
    private override init() {}
    
    var managedObjectContext: NSManagedObjectContext? {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }
    
    func deleteEntity(entityName: String) {
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try managedObjectContext?.execute(deleteRequest)
            try managedObjectContext?.save()
            
        } catch {
            print("There was error while deleting Record: \(error.localizedDescription)")
        }
    }
    
    func deleteAllRecords() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let entities = appDelegate.persistentContainer.managedObjectModel.entities.map({$0.name!})
        for entity in entities {
            self.deleteEntity(entityName: entity)
        }
    }
    
    func saveContext(with context: NSManagedObjectContext? = nil) {
        guard var defaultContext = self.managedObjectContext else { return }
        if let objContext = context {
            defaultContext = objContext
        }
        do {
            try defaultContext.save()
        } catch let error {
            print("The Data save failed \(error.localizedDescription)")
        }
    }
}

//
//  CoreDataManager.swift
//  Latest Game
//
//  Created by iPHTech 29 on 30/03/23.
//

import Foundation
import CoreData

class CoreDataManager {
    //added
    static let shared = CoreDataManager()
    //added
    private init() {}
    
    // MARK: - Core Data stack
    lazy var context = persistentContainer.viewContext

    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Latest_Game")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

func fetch(entityName: NSManagedObject.Type, predicate: String) -> [NSManagedObject] {

    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName.description())
    if predicate != "" {
        fetchRequest.predicate = NSPredicate(format: "%K = %@", "mySchool.name", predicate)
    }

    do {
        if let data = try CoreDataManager.shared.context.fetch(fetchRequest) as? [NSManagedObject] {
            return data
        }
    }
    catch {
        print("Error occured during fetch data: \(error)")
    }
    return []
}


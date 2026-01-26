//
//  PersistenceController.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "AnyToolkit")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved Core Data Error \(error), \n\(error.userInfo)")
            }
        }
    }
    var viewContent: NSManagedObjectContext {
        container.viewContext
    }
}

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
//        printSQLitePath()
    }
    var viewContent: NSManagedObjectContext {
        container.viewContext
    }
    
    
   func printSQLitePath() {
       guard let modelURL = Bundle.main.url(forResource: "AnyToolkit", withExtension: "momd") else { return }
       guard let model = NSManagedObjectModel(contentsOf: modelURL) else { return }
    
       let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
       let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
       let storeURL = documents.appendingPathComponent("AnyToolkit_1.0.sqlite")
    
       do {
           try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: [:])
           print("✅ SQLite 路径: \(storeURL.path)")
       } catch {
           print("❌ 错误: \(error.localizedDescription)")
       }
   }
}

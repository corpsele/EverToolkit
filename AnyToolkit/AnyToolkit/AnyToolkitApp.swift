//
//  AnyToolkitApp.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/25.
//

import SwiftUI
import CoreData

@main
struct AnyToolkitApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            PostView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//
//  NoteView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/28.
//

import SwiftUI
import CoreData

struct NoteView: View {
    @Binding var selectedTab: TabEnum
    /// coredata数据
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        NavigationView {
            VStack {
                PostView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
        .navigationTitle("note_tab_title")
    }
}

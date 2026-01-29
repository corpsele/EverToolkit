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
    /// 控制splash
    @State private var isShowSplash = true
    /// 控制引导页
    @AppStorage("hasGuided") private var hasGuided = false

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            if isShowSplash {
                SplashView(isActive: $isShowSplash)
            }
            else if !hasGuided {
                GuideView {
                    hasGuided = true
                }
            }
            else{
//                PostView()
//                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                MainTabView()
            }
            
        }
    }
}

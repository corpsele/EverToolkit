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
    /// 控制splash
    @State private var isShowSplash = true
    /// 控制引导页
    @AppStorage("hasGuided") private var hasGuided = false
    /// 存储当前主题的rawValue 默认为light
    @AppStorage("selectedTheme") private var selectedTheme: String = Theme.light.rawValue
    
    init() {
        
    }

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

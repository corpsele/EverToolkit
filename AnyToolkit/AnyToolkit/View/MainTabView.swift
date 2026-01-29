//
//  MainTabView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/26.
//

import SwiftUI

/// Tab分类
enum TabEnum {
    case home, explore, note, profile
}

/// 主Tab
struct MainTabView: View {
    @State private var selectedTab: TabEnum = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(selectedTab: $selectedTab)
                .tabItem {
                    Label("home_tab_title", systemImage: "house.fill")
                }
                .tag(TabEnum.home)
            ExploreView(selectedTab: $selectedTab)
                .tabItem {
                    Label("explore_tab_title", systemImage: "safari.fill")
                }
                .tag(TabEnum.explore)
            NoteView(selectedTab: $selectedTab)
                .tabItem {
                    Label("note_tab_title", systemImage: "bell.fill")
                }
                .tag(TabEnum.note)
            ProfileView(selectedTab: $selectedTab)
                .tabItem {
                    Label("profile_tab_title", systemImage: "person.fill")
                }
                .tag(TabEnum.profile)
        }
    }
    
}


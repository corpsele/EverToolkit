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

    @AppStorage("selectedTheme") private var selectedTheme: String = Theme.light.rawValue

    @EnvironmentObject private var settings: Settings

    private var currentTheme: Theme {
        Theme(rawValue: selectedTheme) ?? .light
    }

    var body: some View {
        /// 当前主题注入到整个视图树

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
        /// 通过环境值传入当前主题
        .theme(currentTheme)
        
    }
}

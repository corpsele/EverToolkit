//
//  MainTabView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/26.
//

import SwiftUI

/// Tab分类
enum TabEnum {
    case home, explor, note, profile
}

/// 主Tab
struct MainTabView: View {
    @State private var selectedTab: TabEnum = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(selectedTab: $selectedTab)
                .tabItem {
                    
                }
                .tag(0)
        }
    }
    
}


/// 主界面
struct HomeView: View {
    @Binding var selectedTab: TabEnum
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "house.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.blue)
                Text("home_tab_title")
                    .font(.title2)
                Button("go_to_login") {
                    selectedTab = .profile
                }
                .padding()
                .buttonStyle(.borderless)
            }
            .navigationTitle(Text("home_tab_title"))
        }
    }
}


struct ExplorerView: View {
    @Binding var selectedTab: TabEnum
    
    var body: some View {
        NavigationView {
            VStack {
                EmptyView()
                    
            }
        }
        .navigationTitle("explor_tab_title")
    }
}

struct NoteView: View {
    var body: some View {
        NavigationView {
            
        }
        .navigationTitle("")
    }
}

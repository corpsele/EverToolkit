//
//  HomeView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/28.
//

import SwiftUI

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

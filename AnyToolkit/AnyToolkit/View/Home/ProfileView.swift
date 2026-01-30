//
//  ProfileView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/28.
//

import SwiftUI

struct ProfileView: View {
    @Binding var selectedTab: TabEnum

    @State var enableNoti: Bool = false
    @State var enableDark: Bool = false

    @Environment(\.theme) private var theme
    @AppStorage("selectedTheme") private var selectedTheme: String = Theme.light
        .rawValue
    
    private var currentTheme: Theme {
        Theme(rawValue: selectedTheme) ?? .light
    }
    

    var body: some View {
        NavigationView {
            
            ZStack {
                
                    
                
            }
            .navigationTitle("profile_tab_title")
            .navigationBarTitleDisplayMode(.inline)
            .viewBackground(theme.background)
        }
        .viewBackground(theme.background)
        .onAppear {
            
            if currentTheme == Theme.dark {
                enableDark = true
            }
        }
    }

    private func toDark() {
        print("toDark")
        selectedTheme = Theme.dark.rawValue
    }

    private func toLight() {
        print("toLight")
        selectedTheme = Theme.light.rawValue
    }
    
    // MARK: form
    private func viewForm() -> some View {
        return Form
        {
            Section(header: Text("Header Section")) {
                VStack(spacing: 0) {
                    Button(action: {
                        selectedTab = .home
                    }) {
                        Text("去首页")
                            .font(.body)
                            .foregroundColor(theme.primaryText)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(theme.acent)
                    }
                    .listRowBackground(theme.background)
                    .frame(maxHeight: 100)
                    .buttonStyle(.borderless)
                    
                    Divider()
                        .background(Color.gray) // 直接给 divider 上色（可按需调整）
                        .frame(height: 1) // 控制粗细
                    
                    Button(action: {
                        selectedTab = .explore
                    }) {
                        Text("去发现")
                            .font(.body)
                            .foregroundColor(theme.primaryText)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(theme.acent)
                    }
                    .listRowBackground(theme.background)
                    .frame(maxHeight: 100)
                    .buttonStyle(.borderless)
                    
                    
                }
                .listRowInsets(EdgeInsets()) // 根据需要调整，避免系统行内边距影响
                
            }
            .viewBackground(theme.background)
            .foregroundColor(theme.primaryText)
            
            Section(header: Text("设置")) {
                /// 默认.constant(true)
                
                VStack(spacing: 10) {
                    
                    Toggle(isOn: $enableNoti) {
                        Text("开启通知")
                            .font(.body)
                            .foregroundColor(theme.primaryText)
                        //                                    .padding()
                    }
                    .listRowBackground(theme.background)
                    .frame(maxHeight: 100)
                    .padding(10)
                    
                    Divider()
                        .background(Color.gray) // 直接给 divider 上色（可按需调整）
                        .frame(height: 1) // 控制粗细
                    
                    Toggle(isOn: $enableDark) {
                        Text("夜间模式")
                            .font(.body)
                            .foregroundColor(theme.primaryText)
                        //                                    .padding()
                        
                    }
                    .listRowBackground(theme.background)
                    .padding(10)
                    .onChange(of: enableDark) { new in
                        if new {
                            toDark()
                        } else {
                            toLight()
                        }
                    }
                    .frame(maxHeight: 100)
                }
                .viewBackground(theme.background)
                // 根据需要调整，避免系统行内边距影响
                .listRowInsets(EdgeInsets())
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(theme.primaryText, lineWidth: 1)
                )
                .padding()
                
            }
            .frame(maxHeight: 150)
            .viewBackground(theme.background)
            .foregroundColor(theme.primaryText)
            
            Section(header: Text("退出登录")) {
                
            }
            .foregroundColor(.red)
            .viewBackground(theme.background)
        }

        
    }
}

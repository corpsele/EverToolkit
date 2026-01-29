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
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Header Section")) {
                    Button("回到首页") {
                        selectedTab = .home
                    }
                    Button("去发现") {
                        selectedTab = .explore
                    }
                }
                Section(header: Text("设置")) {
                    /// 默认.constant(true)
                    Toggle("打开通知", isOn: .constant(true))
                    Toggle("夜间模式", isOn: .constant(false))
                        
                }
                Section(header: Text("退出登录")) {
                    
                }
                .foregroundColor(.red)
            }
        }
    }
}

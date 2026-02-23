//
//  ModuleView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/14.
//  发现

import SwiftUI

struct ModuleView: View {
    @Binding var selectedTab: TabEnum
    
    @StateObject private var vm = ModuleVM()
    
    @Environment(
        \.theme
    ) private var theme
    
    var body: some View {
        VStack {
            List {
                ForEach(
                    vm.modules.reversed()
                ) { module in
                    
                    HStack {
                        
                        Text(
                            module.title
                        )
                        .foregroundColor(
                            theme.primaryText
                        )
                        
                        Spacer()
                        
                        Text(
                            module.content
                        )
                        .font(
                            .system(
                                size: 14
                            )
                        )
                        .foregroundColor(
                            theme.secondaryText
                        )
                        
                    }
                    .padding()
                    .onTapGesture {
                        print("module id = \(module.id)")
                    }
                    .viewBackground(theme.background)
                    
                    
                }
                .listRowBackground(
                    theme.background
                )
            }
            .viewBackground(
                theme.backgroundGray
            )
        }
        .customNavBar(
            title: "功能列表",
            backgroundColor: theme.acent,
            foregroundColor: theme.primaryText,
        )
        .onAppear {
            if vm.modules.isEmpty {
                vm
                    .saveToLocal()
                vm
                    .loadFromLocal()
            }
        }
    }
}

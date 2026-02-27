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
    
    @EnvironmentObject private var settings: Settings

    @Environment(
        \.theme
    ) private var theme

    var body: some View {
        NavigationView {
            viewWithCustomNavi()
        }

        .onAppear {
            if vm.modules.isEmpty {
                vm
                    .saveToLocal()
                vm
                    .loadFromLocal()
            }
            
        }
        .onDisappear {
            
        }

    }

    private func viewWithCustomNavi() -> some View {

        VStack {
            List {
                ForEach(
                    vm.modules.reversed()
                ) { module in
                    NavigationLink(
                        destination: destinationView(
                            for: module
                        )
                    ) {
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
                            switch module.id {
                            case 0:
                                break
                            case 1:

                                break
                            default:
                                break
                            }
                        }
                        .viewBackground(theme.background)
                    }
                }
                .listRowBackground(
                    theme.background
                )
            }
            .viewBackground(
                theme.backgroundGray
            )
        }

        .navigationBarHidden(true)
        .customNavBar(
            title: "功能列表",
            backgroundColor: theme.acent,
            foregroundColor: theme.primaryText,

        )
        
    }

    @ViewBuilder
    private func destinationView(for item: Module) -> some View {
        switch item.id {
        case 1:
            if #available(iOS 16.0, *) {
                if settings.isTabbarHidden {
                    WaterFallView()
                        .toolbar(.hidden, for: .tabBar)
                } else {
                    WaterFallView()
                        .toolbar(.visible, for: .tabBar)
                }
                    
                
            } else {
                WaterFallView()
            }
            
        case 2:
            if #available(iOS 16.0, *) {
                if settings.isTabbarHidden {
                    TypewriterView()
                        .toolbar(.hidden, for: .tabBar)
                } else {
                    TypewriterView()
                        .toolbar(.visible, for: .tabBar)
                }
                    
                
            } else {
                TypewriterView()
            }
        default:
            VStack {}
        }
    }
}

//
//  HomeView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/28.
//

import SwiftUI
import SwiftUIIntrospect

/// 主界面
struct HomeView: View {
    @Binding var selectedTab: TabEnum

    @Environment(
        \.theme
    ) private var theme
    @AppStorage(
        "selectedTheme"
    ) private var selectedTheme: String = Theme.light
        .rawValue

    private var currentTheme: Theme {
        Theme(
            rawValue: selectedTheme
        ) ?? .light
    }

    @StateObject var naviTitleColorManager = NavigationTitleColorManager()

    @State var naviTitleColor: Color = .black

    var body: some View {

        NavigationView {
            VStack(spacing: 0.1) {
                viewList()
            }
            .padding()
            .background(
                theme.backgroundGrayBlack
            )
            .navigationBarTitle(
                "home_tab_title",
                displayMode: .inline
            )
            .toolbar {
                //            ToolbarItem(placement: .title) {
                //                Text("home_tab_title")
                //                    .foregroundColor(.black)
                //            }
                ToolbarItem(
                    placement: .navigationBarTrailing
                ) {
                    Button {
                        selectedTab = .profile
                    } label: {
                        Text(
                            "go_to_login"
                        )
                        .foregroundColor(
                            theme.primaryText
                        )
                    }
                    .frame(
                        width: 100,
                        height: 50
                    )
                }

            }
        }
        .viewBackground(theme.background)
        .navigationTitleColor(
            $naviTitleColor
        )
        .onAppear {
            naviTitleColor = theme.primaryText
            UITableView
                .appearance().backgroundColor = .clear
            UITableView
                .appearance().isScrollEnabled = false
            UITableView
                .appearance().separatorStyle = .none
            //            UINavigationBar.appearance().largeTitleTextAttributes = [
            //                .foregroundColor: UIColor.black
            //            ]
            //            UINavigationBar.appearance().titleTextAttributes = [
            //                .foregroundColor: UIColor.black
            //            ]
        }
        .onDisappear {
            UITableView
                .appearance().backgroundColor = .systemGroupedBackground
            UITableView
                .appearance().isScrollEnabled = true
            UITableView
                .appearance().separatorStyle = .singleLine
        }

        //        .onChange(of: selectedTheme) { newValue in
        //            naviTitleColor = theme.primaryText
        //        }
    }

    @ViewBuilder
    private func viewBanner() -> some View {
        let imageUrls: [String] = [
            "http://192.168.5.95:8051/downloads/1698418822738795.png",
            "http://192.168.5.95:8051/downloads/1698419482365679.png",
            "http://192.168.5.95:8051/downloads/1698418615416425.png",
            "https://vcg00.cfp.cn/creative/vcg/800/new/VCG211486265562.jpg",
            "https://vcg02.cfp.cn/creative/vcg/800/new/VCG211398477699.jpg",
            "https://vcg00.cfp.cn/creative/vcg/800/new/VCG211373668260.jpg",
        ]

        VStack(
            alignment: .leading,
            spacing: 1
        ) {
            NetworkBannerView(
                imageUrls: imageUrls,
                autoScrollInterval: 3.0
            ) { index in
                print("NetworkBannerView tap index = \(index)")
            }
                .frame(height: 200)
        }
        .frame(height: 200)

    }

    private func viewList() -> some View {
        VStack {
            List {
                VStack {
                    viewBanner()
                }
                VStack(
                    alignment: .center,
                    spacing: 1
                ) {
                    Image(
                        systemName: "house.fill"
                    )
                    .resizable()
                    .frame(
                        width: 60,
                        height: 60
                    )
                    .foregroundColor(
                        theme.acent
                    )
                    Text(
                        "home_tab_title"
                    )
                    .font(
                        .title2
                    )
                    Button(
                        "guide_welcome_title"
                    ) {
                        //                                selectedTab = .profile

                        PrintLog
                            .printLog()
                    }
                    .buttonStyle(
                        .borderless
                    )
                }

                // alignment center
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center
                )
                .background(
                    Color.white
                )
                .padding()
                //                        .clipShape(RoundedRectangle(cornerRadius: 15))
                //                        .shadow(radius: 5)
                // 1. 盖上一层圆角矩形边框
                .overlay(
                    RoundedRectangle(
                        cornerRadius: 15
                    )
                    .stroke(
                        Color.blue,
                        lineWidth: 2
                    )  // 描边颜色和宽度
                )
                .padding()
                .listRowBackground(
                    theme.background
                )
            }
            //            .frame(
            //                maxWidth: .infinity,
            //                alignment: .center
            //            )
            .listStyle(
                .plain
            )
            //                    .listRowSeparator(.hidden)
            .introspect(
                .list,
                on: .iOS(
                    .v14
                )
            ) { list in
                list.separatorStyle = .none
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)

    }
}

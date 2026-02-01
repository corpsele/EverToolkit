//
//  PostView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/26.
//

import SwiftUI
import SwiftUIIntrospect

struct PostView: View {
    @StateObject private var vm = PostVM()
    /// 提示框
    @State private var isShowError = false

    @Environment(\.theme) private var theme
    @AppStorage("selectedTheme") private var selectedTheme: String = Theme.light
        .rawValue

    @State private var listState: ListState = .items

    private var currentTheme: Theme {
        Theme(rawValue: selectedTheme) ?? .light
    }

    @State private var naviTitleColor: Color = .black

    @EnvironmentObject private var naviTitleColorManager:
        NavigationTitleColorManager

    init() {
        UITableView.appearance().backgroundColor = .clear
    }

    var body: some View {
        NavigationView {
            ZStack {
                theme.background
                //                    .ignoresSafeArea(.all)

                //                viewSimpleList()
                viewList()

                if vm.isLoading {
                    ProgressView("加载中...")
                        .padding()
                        .background(Color.systemMaterial)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                        .padding()
                }
            }
            .background(theme.background)

            .navigationTitle("文章列表")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(
                        action: {
                            vm.loadFromLocal()
                        },
                        label: {
                            Label("本地", systemImage: "tray.and.arrow.down")
                                .foregroundColor(theme.primaryText)
                        }
                    )
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        vm.fetchAndSavePosts()
                    } label: {
                        Label("网络", systemImage: "icloud.and.arrow.down")
                            .foregroundColor(theme.secondaryText)
                    }

                }
            }
        }
        //        .onChange(of: naviTitleColor){ newColor in
        //            naviTitleColor = newColor
        //        }
        .background(theme.background)
        .navigationTitleColor($naviTitleColor)
        .onAppear {
            naviTitleColor = theme.primaryText
            UITableView.appearance().backgroundColor = .clear
            /// 首次本地加载
            if vm.posts.isEmpty {
                vm.loadFromLocal()

            }
        }
        .onDisappear {
            naviTitleColor = theme.primaryText
            UITableView.appearance().backgroundColor = .systemGroupedBackground
        }
        //        .onReceive(naviTitleColorManager.$navigationTitleColor) { newValue in
        //            naviTitleColor = newValue
        //        }

        .alert(
            item: Binding<ItemError?>(
                get: {
                    vm.errorMessage.map { ItemError(message: $0) }
                },
                set: { _ in
                    vm.errorMessage = nil
                }
            )
        ) { item in
            Alert(
                title: Text("提示"),
                message: Text(item.message),
                dismissButton: .default(Text("确定"))
            )
        }

    }

    // MARK: 三方list
    private func viewSimpleList() -> some View {
        return SimpleUIList(vm.posts) { post in
            VStack(alignment: .leading, spacing: 6) {
                Text(post.title)
                    .font(.headline)
                    .foregroundColor(theme.primaryText)
                Text(post.body)
                    .font(.subheadline)
                    .foregroundColor(theme.secondaryText)
                    .lineLimit(2)
            }
            .padding(.vertical, 4)
        }
        .background(theme.background)
    }

    // MARK: 三方list
    private func viewAdvanceList() -> some View {
        return AdvancedList(
            vm.posts,
            content: { post in
                VStack(alignment: .leading, spacing: 6) {
                    Text(post.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(post.body)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                .padding(.vertical, 4)
            },
            listState: listState,
            emptyStateView: {
                Text("No Data")
            },
            errorStateView: { error in
                Text(error.localizedDescription)
                    .lineLimit(nil)
            },
            loadingStateView: {

            }
        )
        .background(theme.background)
    }

    // MARK: 系统list
    private func viewList() -> some View {
        return ZStack {
            theme.background
                .ignoresSafeArea()
            List {
                ForEach(vm.posts) { post in
                    //                    VStack(alignment: .leading, spacing: 6) {
                    Text(post.title)
                        .font(.headline)
                        .foregroundColor(theme.primaryText)
                        .listRowBackground(theme.background)
                    Text(post.body)
                        .font(.subheadline)
                        .foregroundColor(theme.secondaryText)
                        .lineLimit(2)
                        .listRowBackground(theme.background)
                        //                    }
                        .background(theme.background)
                        .padding(.vertical, 4)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        withAnimation {
                            vm.delete(post: vm.posts[index])
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

struct ItemError: Identifiable {
    let id = UUID()
    var message: String
}

extension Color {
    static let systemMaterial = Color(UIColor.systemBackground).opacity(0.9)
}

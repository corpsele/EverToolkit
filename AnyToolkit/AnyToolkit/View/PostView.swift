//
//  PostView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/26.
//

import SwiftUI

struct PostView: View {
    @StateObject private var vm = PostVM()
    /// 提示框
    @State private var isShowError = false
    
    @Environment(\.theme) private var theme
    @AppStorage("selectedTheme") private var selectedTheme: String = Theme.light
        .rawValue
    
    var body: some View {
        NavigationView {
            ZStack {
                theme.background
                    .ignoresSafeArea(.all)
                List {
                    ForEach(vm.posts) { post in
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
//                        .background(theme.background)
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            withAnimation {
                                vm.delete(post: vm.posts[index])
                            }
                        }
                    }
                }
                .background(theme.background)
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
                    Button(action: {
                        vm.loadFromLocal()
                    }, label: {
                        Label("本地", systemImage: "tray.and.arrow.down")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        vm.fetchAndSavePosts()
                    } label: {
                        Label("网络", systemImage: "icloud.and.arrow.down")
                    }

                }
            }
        }
        .onAppear {
            
            /// 首次本地加载
            if vm.posts.isEmpty {
                vm.loadFromLocal()
                
            }
        }

        .alert(item: Binding<ItemError?>(
            get: {
                vm.errorMessage.map { ItemError(message: $0) }
            },
            set: { _ in
                vm.errorMessage = nil
            }
        )) { item in
            Alert(title: Text("提示"), message: Text(item.message), dismissButton: .default(Text("确定")))
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

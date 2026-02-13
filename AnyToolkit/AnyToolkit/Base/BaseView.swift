//
//  BaseView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/10.
//

import SwiftUI

protocol BaseView: View {
    
}

// MARK: - Base View Container
/// 基础视图容器：负责处理 Loading、Error、导航栏等通用逻辑
struct BaseViewContainer<VM: BaseViewModel, Content: View>: View {
    
    @ObservedObject var viewModel: VM
    let title: String
    let content: () -> Content // 闭包：子页面自定义的内容
    
    init(viewModel: VM, title: String, @ViewBuilder content: @escaping () -> Content) {
        self.viewModel = viewModel
        self.title = title
        self.content = content
    }
    
    var body: some View {
        ZStack {
            // 1. 子页面自定义的内容
            content()
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.automatic)
                .disabled(viewModel.isLoading) // 加载时禁止交互
            
            // 2. 全局 Loading 遮罩
            if viewModel.isLoading {
                LoadingOverlay()
            }
        }
        // 3. 错误弹窗
        .alert(isPresented: Binding<Bool>(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.errorMessage = nil }
        )) {
            Alert(
                title: Text("提示"),
                message: Text(viewModel.errorMessage ?? "未知错误"),
                dismissButton: .default(Text("确定"))
            )
        }
    }
}

// 简单的 Loading 遮罩组件
struct LoadingOverlay: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            ProgressView()
                .scaleEffect(1.5)
                .padding(20)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
        }
    }
}

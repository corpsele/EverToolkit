//
//  Waterfall.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/27.
//

import SwiftUI
// MARK: - 1. 数据模型
struct WaterFallItem: Identifiable, Equatable {
    let id = UUID()
    let color: Color
    let height: CGFloat // 模拟内容高度
}
// MARK: - 2. 闪光动画修饰符
// 这个修饰符可以让任何 View 拥有骨架屏闪光效果
struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                // 闪光渐变层
                LinearGradient(
                    gradient: Gradient(colors: [
                        .gray.opacity(0.5),  // 更透明
                        .gray.opacity(0.8),  // 高光
                        .gray.opacity(0.5)   // 更透明
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                // iOS 14 风格的旋转，模拟对角线扫过
                .rotationEffect(.degrees(70))
                // 通过 offset 实现位移动画
                .offset(x: phase)
            )
            // 裁剪超出的部分
            .mask(content)
            // 这里的 mask 也可以换成 mask(Rectangle()) 取决于你的需求
            .onAppear {
                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    // 这里的数值取决于 View 的宽度，设置大一点确保完全扫过
                    phase = 400
                }
            }
    }
}
extension View {
    func shimmer() -> some View {
        self.modifier(ShimmerModifier())
    }
}
// MARK: - 3. 瀑布流布局核心逻辑
struct WaterfallLayout: View {
    let items: [WaterFallItem]
    let isLoading: Bool // 是否正在加载（显示占位）
    
    // 两列的高度记录
    @State private var leftColumnHeight: CGFloat = 0
    @State private var rightColumnHeight: CGFloat = 0
    
    // 分组后的数据
    @State private var leftItems: [WaterFallItem] = []
    @State private var rightItems: [WaterFallItem] = []
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            // 左列
            LazyVStack(spacing: 10) {
                ForEach(leftItems) { item in
                    itemView(for: item)
                }
            }
            .frame(maxWidth: .infinity)
            
            // 右列
            LazyVStack(spacing: 10) {
                ForEach(rightItems) { item in
                    itemView(for: item)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal)
        // 当数据变化时，重新计算布局
        .onChange(of: items) { _ in
            recalculateLayout()
        }
        .onChange(of: isLoading) { _ in
            // 如果切换到加载状态，重置高度以便重新排列占位符
            if isLoading {
                leftColumnHeight = 0
                rightColumnHeight = 0
                recalculateLayout()
            }
        }
        .onAppear {
            recalculateLayout()
        }
        
    }
    
    // MARK: - 单个 Item 视图
    @ViewBuilder
    func itemView(for item: WaterFallItem) -> some View {
        if isLoading {
            // 占位动画视图
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: item.height)
                .cornerRadius(8)
                .shimmer() // 应用闪光效果
        } else {
            // 真实内容视图
            Rectangle()
                .fill(item.color)
                .frame(height: item.height)
                .cornerRadius(8)
                .overlay(
                    Text("Item")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                )
        }
    }
    
    // MARK: - 核心算法：将 Item 分配到较短的列
    func recalculateLayout() {
        var left: [WaterFallItem] = []
        var right: [WaterFallItem] = []
        var leftH: CGFloat = 0
        var rightH: CGFloat = 0
        
        for item in items {
            // 哪一列高度小，就加到哪一列
            if leftH <= rightH {
                left.append(item)
                leftH += item.height + 10 // 加上 spacing
            } else {
                right.append(item)
                rightH += item.height + 10
            }
        }
        
        self.leftItems = left
        self.rightItems = right
        self.leftColumnHeight = leftH
        self.rightColumnHeight = rightH
    }
}
// MARK: - 4. 主视图
struct WaterFallView: View {
    @State private var items: [WaterFallItem] = []
    @State private var isLoading = true
    @EnvironmentObject private var settings: Settings
    @State private var showAlert = false
    // iOS 14 使用 presentationMode 来手动关闭当前视图
    @Environment(\.presentationMode) var presentationMode
    
    // 生成随机测试数据
    func generateMockData() -> [WaterFallItem] {
        let colors: [Color] = [.blue, .red, .green, .orange, .purple, .pink]
        return (0..<20).map { _ in
            WaterFallItem(
                color: colors.randomElement() ?? .blue,
                height: CGFloat.random(in: 80...200)
            )
        }
    }
    
    private func showView() -> some View {
        ScrollView {
            if isLoading {
                // 显示骨架屏（使用模拟的固定数据来展示占位）
                WaterfallLayout(items: Array(0..<10).map { _ in WaterFallItem(color: .clear, height: CGFloat.random(in: 80...200)) }, isLoading: true)
                    .redacted(reason: .placeholder) // 这一行可选，配合 shimmer 使用
            } else {
                // 显示真实数据
                WaterfallLayout(items: items, isLoading: false)
            }
        }
    }
    
    func showConfirmOrDoSomething() {
        // 这里可以做任何你想要的逻辑：校验、保存、弹框等
        showAlert = true
    }
    
    var body: some View {
        NavigationView {
            showView()
            .navigationTitle("iOS 14 瀑布流")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(action: {
                    if isLoading {
                        self.items = generateMockData()
                    } else {
                        self.items = []
                    }
                    self.isLoading.toggle()
                }) {
                    Text(isLoading ? "加载完成" : "重新加载")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                                Button {
                                    // 这里写你的“返回前逻辑”
                                    showConfirmOrDoSomething()
                                } label: {
                                    HStack(spacing: 4) {
                                        Image(systemName: "chevron.backward")
//                                        Text("返回")
                                    }
                                }
                            }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(
                    "确定返回吗？"
                ), message: Text(""), primaryButton: .cancel(), secondaryButton: .default(
                    Text("确定")
                ) {
                    // 真正执行返回
                    presentationMode.wrappedValue.dismiss()
                    settings.isTabbarHidden = false
                })

            }
        }
        // 模拟网络请求延迟
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.items = generateMockData()
                self.isLoading = false
                settings.isTabbarHidden = true
            }
        }
        .onDisappear {

        }
        .navigationBarBackButtonHidden(true)
        
    }
}
// MARK: - Preview
struct WaterFallView_Previews: PreviewProvider {
    static var previews: some View {
        WaterFallView()
    }
}

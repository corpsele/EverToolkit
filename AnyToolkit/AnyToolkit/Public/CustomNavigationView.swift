//
//  CustomNavigationView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/11.
//

import SwiftUI

struct CustomNavigationView: View {
    // 配置项
    let title: String
    var backgroundColor: Color = .blue
    var foregroundColor: Color = .white
    var leftAction: (() -> Void)? // 返回或菜单
    var rightAction: (() -> Void)? // 右侧按钮
    
    // 用于计算高度
    @State private var safeAreaTop: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // 1. 背景色层 (必须延伸到状态栏)
                backgroundColor
                    .frame(height: geometry.safeAreaInsets.top + 44) // 状态栏高度 + 栏高度
                    .edgesIgnoringSafeArea(.top)
                
                VStack(spacing: 0) {
                    // 2. 状态栏占位 (确保背景能顶上去)
                    Spacer()
                        .frame(height: geometry.safeAreaInsets.top)
                    
                    // 3. 导航栏内容区域 (固定高度 44)
                    HStack {
                        // 左侧按钮
                        if let left = leftAction {
                            Button(action: left) {
                                Image(systemName: "chevron.left") // 自定义图标
                                    .foregroundColor(foregroundColor)
                                    .imageScale(.large)
                                    .frame(width: 44, height: 44)
//                                    .offset(x: 20)
                                    .contentShape(Rectangle())
                                    .padding()
                            }
                        } else {
                            Spacer().frame(width: 44) // 占位保持标题居中
                        }
                        
                        // 中间标题
                        Text(title)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(foregroundColor)
                            .frame(maxWidth: .infinity)
                            .lineLimit(1)
                        
                        // 右侧按钮
                        if let right = rightAction {
                            Button(action: right) {
                                Image(systemName: "ellipsis") // 自定义图标
                                    .foregroundColor(foregroundColor)
                                    .frame(width: 44, height: 44)
                                    .padding()
                            }
                        } else {
                            Spacer().frame(width: 44) // 占位
                        }
                    }
                    .frame(height: 44)
                    // 适配机型 导航内部组件偏下，需要偏移安全区域 页面也需要偏移
                    .padding(-geometry.safeAreaInsets.top)
                }
            }
        }
        .frame(height: 44) // 自身高度设为 44，内部 GeometryReader 会处理安全区域延伸
    }
}

extension View {
    /// 替换系统导航栏的封装方法
    /// - Parameters:
    ///   - title: 标题
    ///   - backgroundColor: 背景色
    ///   - leftAction: 左侧点击事件 (如返回)
    ///   - rightAction: 右侧点击事件
    func customNavBar(
        title: String,
        backgroundColor: Color = .white,
        foregroundColor: Color = .black,
        leftAction: (() -> Void)? = nil,
        rightAction: (() -> Void)? = nil
    ) -> some View {
        self
            .modifier(CustomNavBarModifier(
                title: title,
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                leftAction: leftAction,
                rightAction: rightAction
            ))
    }
}

// 修饰符具体实现
struct CustomNavBarModifier: ViewModifier {
    let title: String
    let backgroundColor: Color
    let foregroundColor: Color
    let leftAction: (() -> Void)?
    let rightAction: (() -> Void)?
    
    // 获取安全区域高度，用于给内容加 padding
    @State private var safeAreaTop: CGFloat = 0
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            // 底层：页面内容
            content
                .padding(.top, safeAreaTop + 44) // 关键：内容下移，避开导航栏
                .ignoresSafeArea(edges: .top) // 允许内容延伸到顶部，由我们自己控制 padding
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(UIColor.systemGroupedBackground)) // 页面背景
            
            // 顶层：自定义导航栏
            VStack {
                CustomNavigationView(
                    title: title,
                    backgroundColor: backgroundColor,
                    foregroundColor: foregroundColor,
                    leftAction: leftAction,
                    rightAction: rightAction
                )
                // 这里使用 GeometryReader 获取安全区域高度
                .background(GeometryReader { geo in
                    Color.clear.preference(key: SafeAreaKey.self, value: geo.safeAreaInsets.top)
                })
                
                Spacer() // 占满剩余空间，但不阻挡下层点击
            }
        }
        // 监听安全区域变化
        .onPreferenceChange(SafeAreaKey.self) { value in
            safeAreaTop = value
        }
    }
}

// 辅助 PreferenceKey
struct SafeAreaKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

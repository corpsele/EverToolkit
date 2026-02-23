//
//  View+Ex.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/29.
//

import SwiftUI

extension View {
    @ViewBuilder
    /// List/Form 设置背景色
    func viewBackground(_ color: Color) -> some View {
        if #available(iOS 16.0, *) {
            // iOS 15+: 隐藏默认滚动背景再设置自定义背景
            self
                .scrollContentBackground(.hidden)
                .background(color)
        } else {
            // iOS 14: 直接用 background（需要配合 UITableView.appearance().backgroundColor = .clear 才能看到效果）
            self.background(color)
            
        }
    }

    /// 动态修改NavigationTitle颜色
    /// - Parameter color: 颜色值
    /// - Returns: View
    func navigationTitleColor(_ color: Binding<Color>) -> some View {
        self.modifier(NavigationTitleColorModifier(color: color))
    }

}


// 扩展 View，提供一个修饰符来移除分割线
extension View {
    func hideListRowSeparators() -> some View {
        self.onAppear {
            // 延迟执行，确保视图层级已加载
            DispatchQueue.main.async {
                // 找到当前的 UIWindow
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let rootViewController = windowScene.windows.first?.rootViewController else { return }
                
                // 递归遍历所有子视图
                func traverseAndHide(_ view: UIView) {
                    for subview in view.subviews {
                        // 如果发现了分割线视图，将其隐藏
                        // iOS 14+ 的 List 分割线类名
                        if String(describing: type(of: subview)).contains("ListSeparatorView") ||
                           String(describing: type(of: subview)).contains("UICollectionViewListSeparatorView") {
                            subview.isHidden = true
                        }
                        
                        // 或者采用更暴力的方式：设置透明色 (推荐，避免布局异常)
                        if String(describing: type(of: subview)).contains("Separator") {
                             subview.alpha = 0
                        }
                        
                        traverseAndHide(subview)
                    }
                }
                
                traverseAndHide(rootViewController.view)
            }
        }
    }
}

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
}

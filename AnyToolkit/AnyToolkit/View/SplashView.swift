//
//  SplashView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/27.
//

import SwiftUI

struct SplashView: View {
    /// 外部控制view
    @Binding var isActive: Bool
    
    /// 动画，淡入淡出
    @State private var scale: CGFloat = 0.8
    @State private var opacity: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            /// 背景色与assets一致
//            Color("")
//                .ignoresSafeArea()
            
            VStack(spacing: 16) {
//                Image("")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 120, height: 120)
                
                Text("AnyToolkit")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Text("欢迎回来")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .scaleEffect(scale)
            .opacity(opacity)
        }
        .onAppear {
            /// 进入动画
            withAnimation(.easeInOut(duration: 0.6)) {
                scale = 1.0
                opacity = 1.0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeOut(duration: 0.35)) {
                    isActive = false
                }
            }
        }
    }
}

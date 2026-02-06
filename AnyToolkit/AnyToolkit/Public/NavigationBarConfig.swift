//
//  NavigationTitleColor.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/30.
//

import SwiftUI
import Combine

class NavigationTitleColorManager: ObservableObject {
    @Published var navigationTitleColor: Color = .clear
}

/// 动态配置ios14的NavigationBar样式
struct NavigationBarConfig: UIViewControllerRepresentable {
    /// 定义一个闭包传入UINavigationController
    var config: (UIViewController) -> Void = { _ in }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        // 返回一个VC，不需要显示，只拿到parent UINavigationController
        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // 当SwiftUI视图更新时 会被调用
        // 遍历视图找到UINavitaionController
//        if let navigationController = uiViewController.navigationController {
//            config(navigationController)
//        }
        config(uiViewController)
    }
}

/// 定义修改视图
struct NavigationTitleColorModifier: ViewModifier {
    @Binding var color: Color
    typealias SContent = Content
    
    func body(content: Self.Content) -> some View {
        content
            .background(
                NavigationBarConfig { vc in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        let appearance = UINavigationBarAppearance()
                        appearance.largeTitleTextAttributes = [.foregroundColor : UIColor(color)]
                        appearance.titleTextAttributes = [.foregroundColor: UIColor(color)]
                        appearance.configureWithTransparentBackground()
                        UINavigationBar.appearance().standardAppearance = appearance
                        UINavigationBar.appearance().scrollEdgeAppearance = appearance
                        UINavigationBar.appearance().compactAppearance = appearance
                        
                    }

                }
            )
    }
}

//
//  Theme.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/28.
//

import SwiftUI
import Foundation

/// 主题
enum Theme: String, CaseIterable, Identifiable {
    case light
    case dark
    case blue
    case red
    case gray
    
    var id: String { rawValue }
    
    var background: Color {
        switch self {
//        case .light: return Color(white: 0.95, opacity: 1.0)
//        case .dark: return Color(white: 0.11, opacity: 1.0)
        case .light: return .white
        case .dark: return .black
        case .blue: return Color(red: 0.10, green: 0.14, blue: 0.24, opacity: 1.0)
        case .red: return Color(red: 1, green: 0, blue: 0, opacity: 1.0) // #ff00
        case .gray: return Color(red: 0.64, green: 0.64, blue: 0.64, opacity: 1.0) // #a3a3a3
        }
    }
    
    var backgroundGray: Color {
        switch self {
//        case .light: return Color(white: 0.95, opacity: 1.0)
//        case .dark: return Color(white: 0.11, opacity: 1.0)
        case .light: return .gray
        case .dark: return .gray
        case .blue: return Color(red: 0.10, green: 0.14, blue: 0.24, opacity: 1.0)
        case .red: return Color(red: 1, green: 0, blue: 0, opacity: 1.0) // #ff00
        case .gray: return Color(red: 0.64, green: 0.64, blue: 0.64, opacity: 1.0) // #a3a3a3
        }
    }
    
    var backgroundGrayBlack: Color {
        switch self {
//        case .light: return Color(white: 0.95, opacity: 1.0)
//        case .dark: return Color(white: 0.11, opacity: 1.0)
        case .light: return .gray
        case .dark: return .black
        case .blue: return Color(red: 0.10, green: 0.14, blue: 0.24, opacity: 1.0)
        case .red: return Color(red: 1, green: 0, blue: 0, opacity: 1.0) // #ff00
        case .gray: return Color(red: 0.64, green: 0.64, blue: 0.64, opacity: 1.0) // #a3a3a3
        }
    }
    
    var suface: Color {
        switch self {
        case .light: return Color.white
        case .dark: return Color(white: 0.16, opacity: 1.0)
        case .blue: return Color(red: 0.10, green: 0.14, blue: 0.24, opacity: 1.0)
        case .red: return Color(red: 1, green: 0, blue: 0, opacity: 1.0)
        case .gray: return Color(red: 0.64, green: 0.64, blue: 0.64, opacity: 1.0)
        }
    }
    
    var primaryText: Color {
        switch self {
        case .light: return Color.black
        case .dark: return Color.white
        case .blue: return Color(red: 0.98, green: 0.98, blue: 1.0, opacity: 1.0)
        case .red: return Color.white
        case .gray: return Color.white
        }
    }
    
    var secondaryText: Color {
        switch self {
        case .light: return Color(white: 0, opacity: 0.6)
        case .dark: return Color(white: 1, opacity: 0.6)
        case .blue: return Color(white: 1, opacity: 0.7)
        case .red: return Color(white: 1, opacity: 0.7)
        case .gray: return Color(white: 1, opacity: 0.7)
        }
    }
    
    var acent: Color {
        switch self {
        case .light: return .blue
        case .dark: return .orange
        case .blue: return .orange
        case .red: return .orange
        case .gray: return .orange
        }
    }
    
    var destructive: Color {
        switch self {
        case .light: return .red
        case .dark: return Color(white: 1, opacity: 0.85)
        case .blue: return Color(white: 0.95, opacity: 1.0)
        case .red: return Color(white: 0.95, opacity: 1.0)
        case .gray: return Color(white: 0.95, opacity: 1.0)
        }
    }
}

/// 扩展变量
private struct ThemeKey: EnvironmentKey {
    static let defaultValue: Theme = .light
    
}

/// 扩展变量
extension EnvironmentValues {
    var theme: Theme {
        get {
            self[ThemeKey.self]
        }
        set {
            self[ThemeKey.self] = newValue
        }
    }
}

extension View {
    /// 在视图树某个节点统一设置主题
    func theme(_ theme: Theme) -> some View {
        environment(\.theme, theme)
    }
}

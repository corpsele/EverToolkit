//
//  EnvValueEx.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/6.
//

import SwiftUI
import WidgetKit

private struct WidgetFamilyKey: EnvironmentKey {
    public static var defaultValue: WidgetFamily = .systemLarge
}

extension EnvironmentValues {
    var widgetFamily: WidgetFamily {
        get { self[WidgetFamilyKey.self] }
        set { self[WidgetFamilyKey.self] = newValue }
    }
}

//
//  EverWidgetBundle.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/5.
//

import WidgetKit
import SwiftUI

@main
struct TodayWidgetBundle: WidgetBundle {
    var body: some Widget {
        TodoWidget()
        // 如果你以后有多个 Widget，在这里继续添加：
        // AnotherWidget()
    }
}

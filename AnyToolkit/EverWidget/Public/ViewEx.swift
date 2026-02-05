//
//  ViewEx.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/5.
//

import SwiftUI
import WidgetKit

extension View {
    @ViewBuilder
    func widgetBackground(_ backgroundView: some View) -> some View {
        if Bundle.main.bundlePath.hasSuffix(".appex") {
            if #available(iOS 17.0, *) {
                containerBackground(for: .widget) {
                    backgroundView
                }
            } else {
                background(backgroundView)
            }
        } else {
            background(backgroundView)
        }
    }
}

//
//  GuideView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/27.
//

import SwiftUI

struct GuideView: View {
    var onFinsh: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("guide_welcome_title")
                .font(.largeTitle)
            Text("guide_tip_title")
                .foregroundColor(.secondary)
            Button("guide_button_begin") {
                onFinsh()
            }
        }
        .padding()
    }
}

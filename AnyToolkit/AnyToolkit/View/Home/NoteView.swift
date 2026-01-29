//
//  NoteView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/28.
//

import SwiftUI

struct NoteView: View {
    @Binding var selectedTab: TabEnum
    
    var body: some View {
        NavigationView {
            VStack {
                Color(.darkGray)
                    .ignoresSafeArea()
            }
        }
        .navigationTitle("note_tab_title")
    }
}

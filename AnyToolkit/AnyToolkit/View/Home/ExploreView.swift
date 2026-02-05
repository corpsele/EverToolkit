//
//  ExplorerView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/28.
//

import SwiftUI
import WidgetKit
import SFSafeSymbols

struct ExploreView: View {
    @Binding var selectedTab: TabEnum
    
    @Environment(\.theme) private var theme
    
    @State private var todos: [TodoItem] = TodoSharedStore.loadTodos()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(todos) { item in
                        HStack {
                            Text(item.title)
                            Spacer()
//                            Button(LocalizedStringKey("btn_check"), systemImage: SFSymbol.calendar.rawValue) {
//                                
//                            }
                            Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                        }
                    }
                    .onDelete { indexSet in
                        withAnimation {
                            TodoSharedStore.remove(indexSet)
                        }
                    }
                }
                .navigationTitle("explore_tab_title")
                .viewBackground(theme.background)
                .toolbar {
                    Button("添加内容") {
                        let newItem = TodoItem(
                            id: UUID(),
                            title: "内容标题",
                            isDone: false,
                            dueDate: Date()
                        )
                        TodoSharedStore.append(newItem)
                        todos = TodoSharedStore.loadTodos()
                        // 在你修改数据的地方调用：
                        WidgetCenter.shared.reloadTimelines(ofKind: "TodoWidget")
                    }
                }
                
                    
            }
        }
        
    }
}

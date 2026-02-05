//
//  EverWidget.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/5.
//

import WidgetKit
import SwiftUI

struct TodoEntry: TimelineEntry {
    let date: Date
    let todos: [TodoItem]
}

// MARK: - Provider：时间线提供者
struct TodoProvider: TimelineProvider {
    // 1. 占位符：Widget 第一次展示时使用
    func placeholder(in context: Context) -> TodoEntry {
        TodoEntry(
            date: Date(),
            todos: [
                TodoItem(id: UUID(), title: "示例待办", isDone: false, dueDate: nil)
            ]
        )
    }

    // 2. 快照：用于 Widget Gallery（添加界面）预览
    func getSnapshot(in context: Context, completion: @escaping (TodoEntry) -> Void) {
        let entry = TodoEntry(
            date: Date(),
            todos: TodoSharedStore.loadTodos().isEmpty
                ? [TodoItem(id: UUID(), title: "暂无待办", isDone: false, dueDate: nil)]
                : Array(TodoSharedStore.loadTodos().prefix(3))
        )
        completion(entry)
    }

    // 3. 时间线：返回一组 Entry 及其触发时间
    func getTimeline(in context: Context, completion: @escaping (Timeline<TodoEntry>) -> Void) {
        let now = Date()
        let todos = TodoSharedStore.loadTodos()

        let entry = TodoEntry(date: now, todos: todos)

        // 刷新策略：每 15 分钟刷新一次（WidgetKit 会根据电量等策略合并）
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: now)!

        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
}


struct TodoWidget: Widget {
    let kind: String = "TodoWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: TodoProvider()) { entry in
            TodoWidgetView(entry: entry)
        }
        .configurationDisplayName("今日待办")
        .description("在主屏幕上查看你的待办事项。")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

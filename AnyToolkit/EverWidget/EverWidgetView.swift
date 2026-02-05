//
//  EverWidgetView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/5.
//

import SwiftUI
import AppIntents
import WidgetKit

struct TodoWidgetView: View {
    let entry: TodoEntry

    var body: some View {
        switch entry.todos.count {
        case 0:
            emptyView
        default:
            contentView(for: entry.todos)
        }
    }

    private var emptyView: some View {
        VStack {
            Image(systemName: "tray")
                .font(.system(size: 32))
            Text("暂无待办")
                .font(.headline)
            Text("在 App 中添加待办事项")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .widgetBackground(Color.white)
    }

    @ViewBuilder
    private func contentView(for todos: [TodoItem]) -> some View {
        switch family {
        case .systemSmall:
            smallView(todos: todos)
        case .systemMedium:
            mediumView(todos: todos)
        case .systemLarge:
            largeView(todos: todos)
        @unknown default:
            smallView(todos: todos)
        }
    }

    private var family: WidgetFamily {
        // iOS 14+ 可用
        #if widgetKit
        @Environment(\.widgetFamily) var widgetFamily
        return widgetFamily
        #else
        return .systemSmall
        #endif
    }

    // MARK: - Small：只展示最近一条
    @ViewBuilder
    private func smallView(todos: [TodoItem]) -> some View {
        if let first = todos.first {
            VStack(alignment: .leading, spacing: 6) {
                Text("待办")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(first.title)
                    .font(.headline)
                    .lineLimit(2)
                HStack {
                    Spacer()
                    if let due = first.dueDate {
                        Text(due, style: .time)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
            .widgetBackground(Color(.systemGroupedBackground))
        }
    }

    // MARK: - Medium：展示 2~3 条
    @ViewBuilder
    private func mediumView(todos: [TodoItem]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("待办事项")
                .font(.headline)

            ForEach(Array(todos.prefix(3))) { item in
                HStack {
                    Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(item.isDone ? .green : .gray)
                    Text(item.title)
                        .font(.subheadline)
                        .strikethrough(item.isDone)
                    Spacer()
                }
            }

            if todos.count > 3 {
                Text("还有 \(todos.count - 3) 项...")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .widgetBackground(LinearGradient(colors: [.blue.opacity(0.15), .purple.opacity(0.15)],
                                         startPoint: .topLeading,
                                         endPoint: .bottomTrailing))
    }

    // MARK: - Large：展示更多，简单列表
    @ViewBuilder
    private func largeView(todos: [TodoItem]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("待办事项")
                    .font(.headline)
                Spacer()
                Text("\(todos.count)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Divider()

            ScrollView {
                ForEach(todos) { item in
                    HStack(alignment: .firstTextBaseline) {
                        Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(item.isDone ? .green : .gray)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title)
                                .font(.body)
                                .strikethrough(item.isDone)
                            if let due = item.dueDate {
                                Text(due, style: .date)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        Spacer()
                    }
                    .padding(.vertical, 2)
                }
            }
        }
        .padding()
        .widgetBackground( Color(.secondarySystemGroupedBackground))
    }
}

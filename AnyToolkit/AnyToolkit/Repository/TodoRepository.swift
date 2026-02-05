//
//  TodoRepository.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/5.
//

import Foundation
import SwiftUI

public enum TodoSharedStore {
    public static let userDefaults = UserDefaults(suiteName: "group.com.corpsele.AnyToolkit")

    private static let todosKey = "todos"

    public static func loadTodos() -> [TodoItem] {
        guard let data = userDefaults?.data(forKey: todosKey),
              let todos = try? JSONDecoder().decode([TodoItem].self, from: data) else {
            return []
        }
        return todos
    }

    public static func save(_ todos: [TodoItem]) {
        guard let data = try? JSONEncoder().encode(todos) else { return }
        userDefaults?.set(data, forKey: todosKey)
    }

    public static func append(_ todo: TodoItem) {
        var todos = loadTodos()
        todos.append(todo)
        save(todos)
    }
    
    public static func remove(_ indexSet: IndexSet) {
        var todos = loadTodos()
        todos.remove(atOffsets: indexSet)
        save(todos)
    }
}

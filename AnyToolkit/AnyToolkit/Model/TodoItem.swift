//
//  TodoItem.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/5.
//

import Foundation

/// 待办事项模型
public struct TodoItem: Codable, Identifiable {
    public let id: UUID
    let title: String
    var isDone: Bool
    let dueDate: Date?
}

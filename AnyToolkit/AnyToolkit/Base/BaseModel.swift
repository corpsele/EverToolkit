//
//  BaseModel.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/10.
//

import Foundation

// MARK: - Base Model Protocol
/// 基础模型协议
protocol BaseModelProtocol: Identifiable, Codable {
    var id: String { get set }
}

// MARK: - Default Implementation
extension BaseModelProtocol {
    // 如果 JSON 里没有 id，可以自动用 UUID 生成，防止崩溃
    mutating func autoGenerateIdIfNeeded() {
        if id.isEmpty {
            id = UUID().uuidString
        }
    }
}

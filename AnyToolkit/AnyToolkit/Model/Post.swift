//
//  Post.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/25.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
}

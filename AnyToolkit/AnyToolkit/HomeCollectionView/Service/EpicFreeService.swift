//
//  EpicFreeService.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/22.
//

import Combine
import Foundation

private let url = "https://uapis.cn/api/v1/game/epic-free"

struct EpicErrorMessage: Identifiable {
    var id: ObjectIdentifier

    var errorMessage: String
}

enum EpicError: Error, LocalizedError {
    case badURL
    case network(Error?)
    case decoding(Error?)
    var errorDescription: String? {

        switch self {
        case .badURL: return "无效的 URL"
        case .network(let err):
            return "网络错误: \(err?.localizedDescription ?? "未知")"
        case .decoding(let err):
            return "解析错误: \(err?.localizedDescription ?? "未知")"
        }

    }
}

final class EpicFreeService {
    // 示例接口，实际替换成你自己的
    private let baseURL = URL(string: url)!
    func fetchItems() -> AnyPublisher<EpicResponseResult, EpicError> {
        // 这里直接拼一个模拟 URL，真实项目按你的接口来
        //        let url = baseURL.appendingPathComponent("items")
        return URLSession.shared.dataTaskPublisher(for: baseURL)
            .mapError { EpicError.network($0) }
            .map(\.data)
            .decode(type: EpicResponseResult.self, decoder: JSONDecoder())
            .mapError { EpicError.decoding($0) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

//
//  PostService.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/26.
//

import Foundation
import Combine

class PostService {
    private let baseURL = "https://jsonplaceholder.typicode.com/posts"
    func fetchPosts() -> AnyPublisher<[Post], Error> {
        guard let url = URL(string: baseURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url).map(\.data).decode(type: [Post].self, decoder: JSONDecoder()).eraseToAnyPublisher()
    }
}

//
//  EpicFreeRepository.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/22.
//

import Foundation
import Combine

final class EpicFreeRepository {
    private let service: EpicFreeService
    // 简单内存缓存
    private var cachedItems: EpicResponseResult? = nil
    init(service: EpicFreeService = EpicFreeService()) {
        self.service = service
    }
    func getItems() -> AnyPublisher<EpicResponseResult, EpicError> {
        // 如果有缓存，先返回缓存
        if cachedItems != nil {
            if let items = cachedItems {
                return Just(items)
                    .setFailureType(to: EpicError.self)
                    .eraseToAnyPublisher()
            }
            
        }
        // 否则请求网络
        return service.fetchItems()
            .handleEvents(receiveOutput: { [weak self] items in
                self?.cachedItems = items
            })
            .eraseToAnyPublisher()
    }
}

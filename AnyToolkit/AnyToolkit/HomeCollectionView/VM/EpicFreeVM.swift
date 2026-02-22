//
//  EpicFreeVM.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/22.
//

import Foundation
import Combine

final class EpicFreeVM: ObservableObject {
    @Published var items: EpicResponseResult?
    @Published var epicErrorMessage: EpicErrorMessage?
    // 点击事件回调，由外部注入
    var onItemTap: ((EpicFreeModel) -> Void)?
    private let repository: EpicFreeRepository
    private var cancellables = Set<AnyCancellable>()
    init(repository: EpicFreeRepository = EpicFreeRepository()) {
        self.repository = repository
    }
    func loadData() {
        epicErrorMessage?.errorMessage = ""
        repository.getItems()
            .sink { [weak self] completion in
                guard let self = self else { return }
                if case .failure(let err) = completion {
                    self.epicErrorMessage?.errorMessage = err.errorDescription ?? ""
                }
            } receiveValue: { [weak self] items in
                self?.items = items
            }
            .store(in: &cancellables)
    }
    // 供 View 调用，把点击事件透传出去
    func handleItemTap(_ item: EpicFreeModel) {
        onItemTap?(item)
    }
}

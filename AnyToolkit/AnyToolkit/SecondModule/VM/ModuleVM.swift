//
//  PostVM.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/26.
//

import Combine
import Foundation

class ModuleVM: ObservableObject {
    @Published var modules: [Module] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    private let repo = ModuleRepository()
    private var cancellabels = Set<AnyCancellable>()
    
    func saveToLocal() {
        var list: [Module] = []
        for i in 0..<5 {
            var module = Module(id: Int32(i), title: "title\(i)", content: "content\(i)")
            if i == 0 {
                module = Module(id: Int32(i), title: "发现二级", content: "发现二级页面")
            } else if i == 1 {
                module = Module(
                    id: Int32(i),
                    title: "骨架屏",
                    content: "瀑布流",
                )
            } else if i == 2 {
                module = Module(
                    id: Int32(i),
                    title: "打字机",
                    content: "1字"
                )
            }
            list.append(module)
        }

        repo.save(modules: list)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] modules in
                guard let strongSelf = self else { return }
                
            })
            .store(in: &cancellabels)
    }

    /// 本地加载
    func loadFromLocal() {
        isLoading = true
        repo.fetchAll()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] modules in
                guard let strongSelf = self else { return }
                strongSelf.isLoading = false
                strongSelf.modules = modules
            })
            .store(in: &cancellabels)
    }

    /// 本地存储 -> 本地读取
    func fetchAndSavePosts() {
        isLoading = true
        errorMessage = nil
        repo.fetchAll()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let strongSelf = self else { return }
                strongSelf.isLoading = false
                if case let .failure(error) = completion {
                    strongSelf.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] modules in
                guard let strongSelf = self else { return }
                self?.modules = modules
            })
            .store(in: &cancellabels)
    }

    /// 删除 使用withAnimation动画
    func delete(module: Module) {
        repo.delete(module: module)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: {
                self.modules.removeAll { $0.id == module.id }
            })
            .store(in: &cancellabels)
    }
}

//
//  PostVM.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/26.
//

import Foundation
import Combine

class PostVM: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    private let api = PostService()
    private let repo = PostRepository()
    private var cancellables = Set<AnyCancellable>()
    
    /// 本地加载
    func loadFromLocal() {
        isLoading = true
        repo.fetchAll()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] posts in
                self?.isLoading = false
                self?.posts = posts
            })
            .store(in: &cancellables)
    }
    
    /// 网络请求 -> 本地存储 -> 本地读取
    func fetchAndSavePosts() {
        isLoading = true
        errorMessage = nil
        api.fetchPosts()
            .flatMap { [weak self] posts -> AnyPublisher<Void, Error> in
                guard let self = self else {
                    return Fail(error: URLError(.unknown)).eraseToAnyPublisher()
                }
                return self.repo.save(posts: posts)
            }
            .flatMap { [weak self] () -> AnyPublisher<[Post], Error> in
                guard let self = self else {
                    return Fail(error: URLError(.unknown)).eraseToAnyPublisher()
                }
                return self.repo.fetchAll()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] posts in
                self?.posts = posts
            })
            .store(in: &cancellables)
    }
    
    /// 删除 使用withAnimation动画
    func delete(post: Post) {
        repo.delete(post: post)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: {
                self.posts.removeAll { $0.id == post.id }
            })
            .store(in: &cancellables)
    }
}

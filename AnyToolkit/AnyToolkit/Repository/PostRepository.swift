//
//  PostRepository.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/25.
//

import Foundation
import CoreData
import Combine

class PostRepository {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.viewContent) {
        self.context = context
    }
    
    /// 先按serverID查，有则更新无则新增
    func save(posts: [Post]) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            self.context.perform { [weak self] in
                guard let self = self else {
                    promise(.failure(URLError(.unknown)))
                    return
                }
                do {
                    for post in posts {
                        let serverID = "\(post.id)"
                        let request = PostEntity.fetchRequest(for: serverID)
                        if let entity = try self.context.fetch(request).first {
                            entity.update(from: post, in: self.context)
                        } else {
                            let entity = PostEntity(context: self.context)
                            entity.update(from: post, in: self.context)
                        }
                    }
                    try self.context.save()
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    /// 读取
    func fetchAll() -> AnyPublisher<[Post], Error> {
        return Future<[Post], Error> { promise in
            self.context.perform { [weak self] in
                guard let self = self else {
                    promise(.failure(URLError(.unknown)))
                    return
                }
                let request: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
                request.sortDescriptors = [NSSortDescriptor(key: "serverID", ascending: false)]
                do {
                    let entities = try self.context.fetch(request)
                    let items = entities.compactMap { $0.toPost }
                    promise(.success(items))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    /// 删除
    func delete(post: Post) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            self.context.perform { [weak self] in
                guard let self = self else {
                    promise(.failure(URLError(.unknown)))
                    return
                }
                let serverID = "\(post.id)"
                let request = PostEntity.fetchRequest(for: serverID)
                do {
                    if let entity = try self.context.fetch(request).first {
                        self.context.delete(entity)
                        try self.context.save()
                    }
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }

            }
        }.eraseToAnyPublisher()
    }
    
    /// 清空 重置
    func deleteAll() -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            self.context.perform { [weak self] in
                guard let self = self else {
                    promise(.failure(URLError(.unknown)))
                    return
                }
                let request: NSFetchRequest<NSFetchRequestResult> = PostEntity.fetchRequest()
                let delete = NSBatchDeleteRequest(fetchRequest: request)
                do {
                    _ = try self.context.execute(delete)
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}

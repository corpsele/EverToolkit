//
//  PostRepository.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/25.
//

import Foundation
import CoreData
import Combine

class ModuleRepository {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.viewContent) {
        self.context = context
    }
    
    func save(modules: [Module]) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            self.context.perform { [weak self] in
                guard let self = self else {
                    promise(.failure(URLError(.unknown)))
                    return
                }
                do {
                    for module in modules {
                        let id = module.id
                        let request = ModuleEntity.fetchRequest(for: id)
                        if let entity = try self.context.fetch(request).first {
                            entity.update(from: module, in: self.context)
                        } else {
                            let entity = ModuleEntity(context: self.context)
                            entity.update(from: module, in: self.context)
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
    func fetchAll() -> AnyPublisher<[Module], Error> {
        return Future<[Module], Error> { promise in
            self.context.perform { [weak self] in
                guard let self = self else {
                    promise(.failure(URLError(.unknown)))
                    return
                }
                let request: NSFetchRequest<ModuleEntity> = ModuleEntity.fetchRequest()
                request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
                do {
                    let entities = try self.context.fetch(request)
                    let items = entities.compactMap { $0.toModule }
                    promise(.success(items))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    /// 删除
    func delete(module: Module) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            self.context.perform { [weak self] in
                guard let self = self else {
                    promise(.failure(URLError(.unknown)))
                    return
                }
                let id = module.id
                let request = ModuleEntity.fetchRequest(for: id)
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
                let request: NSFetchRequest<NSFetchRequestResult> = ModuleEntity.fetchRequest()
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

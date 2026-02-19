//
//  PostEntity+Mapping.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/25.
//

import CoreData

extension ModuleEntity {
    /// 根据serverID查找或创建，防止重复插入
    static func fetchRequest(for id: Int32) -> NSFetchRequest<ModuleEntity> {
        let request: NSFetchRequest<ModuleEntity> = ModuleEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = \(id)")
        request.fetchLimit = 1
        return request
    }
    
    func update(from module: Module, in context: NSManagedObjectContext) {
        self.id = module.id
        self.title = module.title
        self.content = module.content
    }
}

extension ModuleEntity {
    var toModule: Module? {
        guard let content = content,
              let title = title else { return nil }
        return Module(id: id, title: title, content: content)
    }
}

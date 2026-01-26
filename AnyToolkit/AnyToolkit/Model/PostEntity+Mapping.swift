//
//  PostEntity+Mapping.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/25.
//

import CoreData

extension PostEntity {
    /// 根据serverID查找或创建，防止重复插入
    static func fetchRequest(for serverID: String) -> NSFetchRequest<PostEntity> {
        let request: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        request.predicate = NSPredicate(format: "serverID = %@", serverID)
        request.fetchLimit = 1
        return request
    }
    
    func update(from post: Post, in context: NSManagedObjectContext) {
        self.serverID = "\(post.id)"
        self.title = post.title
        self.body = post.body
    }
}

extension PostEntity {
    var toPost: Post? {
        guard let serverIDString = serverID,
              let serverID = Int(serverIDString),
              let title = title,
              let body = body else { return nil }
        return Post(id: serverID, title: title, body: body)
    }
}

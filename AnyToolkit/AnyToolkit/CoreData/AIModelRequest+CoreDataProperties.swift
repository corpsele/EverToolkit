//
//  AIModelRequest+CoreDataProperties.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/11.
//
//

public import Foundation
public import CoreData


public typealias AIModelRequestCoreDataPropertiesSet = NSSet

extension AIModelRequest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AIModelRequest> {
        return NSFetchRequest<AIModelRequest>(entityName: "AIModelRequest")
    }

    @NSManaged public var id: Int32
    @NSManaged public var model: String?
    @NSManaged public var apiKey: String?
    @NSManaged public var stream: Bool
    @NSManaged public var messages: NSSet?

}

// MARK: Generated accessors for messages
extension AIModelRequest {

    @objc(addMessagesObject:)
    @NSManaged public func addToMessages(_ value: AIModelRequestMessage)

    @objc(removeMessagesObject:)
    @NSManaged public func removeFromMessages(_ value: AIModelRequestMessage)

    @objc(addMessages:)
    @NSManaged public func addToMessages(_ values: NSSet)

    @objc(removeMessages:)
    @NSManaged public func removeFromMessages(_ values: NSSet)

}

extension AIModelRequest : Identifiable {

}

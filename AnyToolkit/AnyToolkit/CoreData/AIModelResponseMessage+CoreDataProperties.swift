//
//  AIModelResponseMessage+CoreDataProperties.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/11.
//
//

public import Foundation
public import CoreData


public typealias AIModelResponseMessageCoreDataPropertiesSet = NSSet

extension AIModelResponseMessage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AIModelResponseMessage> {
        return NSFetchRequest<AIModelResponseMessage>(entityName: "AIModelResponseMessage")
    }

    @NSManaged public var content: String?
    @NSManaged public var id: Int32
    @NSManaged public var response: AIModelResponse?

}

extension AIModelResponseMessage : Identifiable {

}

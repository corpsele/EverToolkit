//
//  AIModelRequestMessage+CoreDataProperties.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/11.
//
//

public import Foundation
public import CoreData


public typealias AIModelRequestMessageCoreDataPropertiesSet = NSSet

extension AIModelRequestMessage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AIModelRequestMessage> {
        return NSFetchRequest<AIModelRequestMessage>(entityName: "AIModelRequestMessage")
    }

    @NSManaged public var content: String?
    @NSManaged public var role: String?
    @NSManaged public var id: Int32
    @NSManaged public var message: AIModelRequest?

}

extension AIModelRequestMessage : Identifiable {

}

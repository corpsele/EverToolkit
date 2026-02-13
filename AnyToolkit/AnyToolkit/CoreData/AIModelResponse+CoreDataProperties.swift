//
//  AIModelResponse+CoreDataProperties.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/11.
//
//

public import Foundation
public import CoreData


public typealias AIModelResponseCoreDataPropertiesSet = NSSet

extension AIModelResponse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AIModelResponse> {
        return NSFetchRequest<AIModelResponse>(entityName: "AIModelResponse")
    }

    @NSManaged public var id: Int32
    @NSManaged public var model: String?
    @NSManaged public var message: AIModelResponseMessage?

}

extension AIModelResponse : Identifiable {

}

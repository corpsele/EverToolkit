//
//  PostEntity+CoreDataProperties.swift
//  
//
//  Created by corpsele_n on 2026/2/13.
//
//  This file was automatically generated and should not be edited.
//

public import Foundation
public import CoreData


public typealias PostEntityCoreDataPropertiesSet = NSSet

extension PostEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostEntity> {
        return NSFetchRequest<PostEntity>(entityName: "PostEntity")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: Int32
    @NSManaged public var serverID: String?
    @NSManaged public var title: String?

}

extension PostEntity : Identifiable {

}

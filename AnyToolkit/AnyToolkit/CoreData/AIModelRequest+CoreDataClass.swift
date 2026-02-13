//
//  AIModelRequest+CoreDataClass.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/11.
//
//

public import Foundation
public import CoreData

public typealias AIModelRequestCoreDataClassSet = NSSet

@objc(AIModelRequest)
public class AIModelRequest: NSManagedObject {
    public var wrappedId: Int32 { id }
    
}

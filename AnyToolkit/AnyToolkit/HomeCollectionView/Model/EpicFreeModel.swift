//
//  FeatureModel.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/22.
//

import Foundation

struct EpicResponseResult: Identifiable, Decodable {
    var id: String? = UUID().uuidString
    let message: String
    let data: [EpicFreeModel]
    
}

struct EpicFreeModel: Identifiable, Decodable {
    let id: String
    let title: String
    let cover: String
    @IntOrString(wrappedValue: .none) var original_price: Int?
//    let original_price: String
    let original_price_desc: String
    let description: String
    let seller: String
    let is_free_now: Bool
    let free_start: String
//    let free_start_at: String
    @IntOrString(wrappedValue: .none) var free_start_at: Int?
    let free_end: String
//    let free_end_at: String
    @IntOrString(wrappedValue: .none) var free_end_at: Int?
    let link: String
}


@propertyWrapper
struct IntOrString: Decodable {

    var wrappedValue: Int?

    init(wrappedValue: Int?) {
        self.wrappedValue = wrappedValue
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self) {
            wrappedValue = Int(value) ?? 0
        } else if let value = try? container.decode(Int.self) {
            wrappedValue = value
        } else {
            wrappedValue = 0
        }
    }

}


extension KeyedDecodingContainer {
    func decode(_ type: IntOrString.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> IntOrString {
        return try decodeIfPresent(IntOrString.self, forKey: key) ?? IntOrString(wrappedValue: nil)
    }
}

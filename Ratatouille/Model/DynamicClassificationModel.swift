//
//  DynamicClassificationModel.swift
//  Ratatouille
//
//

import Foundation

// 'Classification' is a common name for area, category and ingredient.
// list all areas/all categories/all ingredients
struct DynamicClassificationList : Decodable {
    let meals: [DynamicClassification]
}

struct DynamicClassification : Decodable {
    let name: String
}

struct CustomCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }

    init?(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }

}



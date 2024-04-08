//
//  FilterPickerViewModel.swift
//  Ratatouille
//
//

import Foundation
import SwiftUI

enum SearchTag: String, CaseIterable, Identifiable {
    case area, category, ingredient, text
    
    var id: Self { self }
    
    var icon: Image {
        switch self {
        case .area:
            return Image(systemName: "globe")
        case .category:
            return Image(systemName: "square.grid.2x2")
        case .ingredient:
            return Image(systemName: "carrot.fill")
        case .text:
            return Image(systemName: "magnifyingglass")
        }
    }
}

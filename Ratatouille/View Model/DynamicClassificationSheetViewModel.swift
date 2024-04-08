//
//  DynamicClassificationSheetViewModel.swift
//  Ratatouille
//
//

import Foundation
import CoreData

class DynamicClassificationSheetVM: ObservableObject {
    var filter: String
    var name: String
    var imgURL: String?
    
    init(filter: String, name: String, imgURL: String? = nil) {
            self.filter = filter
            self.name = name
            self.imgURL = imgURL
        }
    
    func SaveDynamicClassification() {
        switch filter {
        case "area":
            saveClassificationToArea(name: name, flagURL: imgURL)
        case "category":
            saveClassificationToCategory(name: name)
        case "ingredient":
            saveClassificationToIngredient(name: name)
        default:
            break
        }
    }
    
    private func saveClassificationToArea(name: String, flagURL: String?) {
        let area = Area(context: CoreDataManager.shared.viewContext)
        area.name = name
        
        if let flagURL = flagURL {
            area.imgURL = flagURL
        }
        
        do {
            try CoreDataManager.shared.viewContext.save()
        } catch {
            print("Failed to save area: \(error)")
        }
    }
    
    private func saveClassificationToCategory(name: String) {
        let category = Category(context: CoreDataManager.shared.viewContext)
        category.name = name
        do {
            try CoreDataManager.shared.viewContext.save()
        } catch {
            print("Failed to save area: \(error)")
        }
    }
    
    private func saveClassificationToIngredient(name: String) {
        let ingredient = Ingredient(context: CoreDataManager.shared.viewContext)
        ingredient.name = name
        do {
            try CoreDataManager.shared.viewContext.save()
        } catch {
            print("Failed to save area: \(error)")
        }
    }
    
    
}

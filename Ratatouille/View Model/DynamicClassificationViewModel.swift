//
//  DynamicCategoryViewModel.swift
//  Ratatouille
//
//

import Foundation
import CoreData


struct DynamicClassificationVM {
    
    let entity: NSManagedObject
    
    var id: NSManagedObjectID {
        return entity.objectID
    }
    
    var name: String {
        guard let nameAttribute = entity.entity.attributesByName["name"] else {
            return ""
        }
        
        guard nameAttribute.attributeType == .stringAttributeType else {
            return ""
        }
        
        return entity.value(forKey: nameAttribute.name) as? String ?? ""
    }
    
    var isArchived: Bool {
        guard let archiveAttribute = entity.entity.attributesByName["isArchived"] else {
            return false
        }
        
        guard archiveAttribute.attributeType == .booleanAttributeType else {
            return false
        }
        
        return entity.value(forKey: archiveAttribute.name) as? Bool ?? false
    }
    
    var archiveDate: Date? {
        guard let dateAttribute = entity.entity.attributesByName["archiveDate"],
              let dateValue = entity.value(forKey: dateAttribute.name) as? Date else {
            return nil
        }
        return dateValue
    }
    
    var imgUrl: String? {
        guard let urlAttribute = entity.entity.attributesByName["imgURL"] else {
            return ""
        }
        
        guard urlAttribute.attributeType == .stringAttributeType else {
            return ""
        }
        
        return entity.value(forKey: urlAttribute.name) as? String ?? ""
    }
    
}

@MainActor
class DynamicClassificationListVM: ObservableObject {
    
    var viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    @Published var dynamicClassificationListFromAPI: [DynamicClassification] = []
    @Published var dynamicClassificationListFromDB: [DynamicClassificationVM] = []
    
    func getDynamicClassificationListFromAPI(query: String) async {
        do {
            let (classificationList, _) = try await NetworkManager().fetchClassificationList(query: query)
            self.dynamicClassificationListFromAPI = classificationList
        } catch {
            print(error)
        }
    }
    
    
    func getDynamicClassificationListFromDB(entityName: String) {
        switch entityName {
        case "area":
            dynamicClassificationListFromDB = CoreDataManager.shared.getAllAreas().map(DynamicClassificationVM.init)
        case "category":
            dynamicClassificationListFromDB = CoreDataManager.shared.getAllCategories().map(DynamicClassificationVM.init)
        case "ingredient":
            dynamicClassificationListFromDB = CoreDataManager.shared.getAllIngredients().map(DynamicClassificationVM.init)
        default:
            dynamicClassificationListFromDB = []
            break
        }
        
    }
    
    func toggleArchiveValueForClassification(entity: DynamicClassificationVM) {
        guard let existingEntity = CoreDataManager.shared.getAreaById(id: entity.id)
            ?? CoreDataManager.shared.getCategoryById(id: entity.id)
            ?? CoreDataManager.shared.getIngredientById(id: entity.id) else {
                print("Error finding entity.")
                return
        }
        CoreDataManager.shared.updateEntityArchivedStatus(entity: existingEntity)
    }
    
    func delete(entity: DynamicClassificationVM) {
        guard let existingEntity = CoreDataManager.shared.getAreaById(id: entity.id)
            ?? CoreDataManager.shared.getCategoryById(id: entity.id)
            ?? CoreDataManager.shared.getIngredientById(id: entity.id) else {
                print("Error finding entity.")
                return
        }
        CoreDataManager.shared.deleteEntity(entity: existingEntity)
    }
    
    func saveDynamicClassificationList(query: String) async {
        await self.getDynamicClassificationListFromAPI(query: query)
        for dynamicClassification in dynamicClassificationListFromAPI {
            switch query {
            case "area":
                saveClassificationToArea(dynamicClassification)
            case "category":
                saveClassificationToCategory(dynamicClassification)
            case "ingredient":
                saveClassificationToIngredient(dynamicClassification)
            default:
                print("Hello from saving switch default")
                break
            }
        }
    }
    
    private func saveClassificationToArea(_ classification: DynamicClassification) {
        let area = Area(context: CoreDataManager.shared.viewContext)
        area.name = classification.name
        
        do {
            try CoreDataManager.shared.viewContext.save()
        } catch {
            print("Failed to save area: \(error)")
        }
    }
    
    private func saveClassificationToCategory(_ classification: DynamicClassification) {
        let category = Category(context: CoreDataManager.shared.viewContext)
        category.name = classification.name
        
        do {
            try CoreDataManager.shared.viewContext.save()
        } catch {
            print("Failed to save category: \(error)")
        }
    }
    
    private func saveClassificationToIngredient(_ classification: DynamicClassification) {
        let ingredient = Ingredient(context: CoreDataManager.shared.viewContext)
        ingredient.name = classification.name
        
        do {
            try CoreDataManager.shared.viewContext.save()
        } catch {
            print("Failed to save ingredient: \(error)")
        }
    }
}


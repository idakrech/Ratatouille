//
//  CoreDataManager.swift
//  Ratatouille
//
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    func getMealById(id: NSManagedObjectID) -> Meal? {
        do {
            return try viewContext.existingObject(with: id) as? Meal
        } catch {
            return nil
        }
    }
    
    
    
    func updateEntityArchivedStatus(entity: NSManagedObject) {
        guard let archiveAttribute = entity.entity.attributesByName["isArchived"] else {
            print("Attribute 'isArchived' not found.")
            return
        }
        
        guard let archiveDateAttribute = entity.entity.attributesByName["archiveDate"] else {
            print("Attribute 'archiveDate' not found.")
            return
        }
        
        guard archiveAttribute.attributeType == .booleanAttributeType else {
            print("Attribute 'isArchived' is not of type Bool.")
            return
        }
        
        let newArchiveValue = !(entity.value(forKey: archiveAttribute.name) as? Bool ?? false)
        entity.setValue(newArchiveValue, forKey: archiveAttribute.name)
        
        if newArchiveValue {
            entity.setValue(Date(), forKey: archiveDateAttribute.name)
        } else {
            entity.setValue(nil, forKey: archiveDateAttribute.name)
        }
        
        save()
        print("Updated 'isArchived' status for entity.")
    }
    
    func updateMealFavoriteStatus(id: NSManagedObjectID) {
        guard let meal = getMealById(id: id) else {
            print("Meal not found.")
            return
        }

        let newFavoriteValue = !(meal.isFavorite )
        meal.isFavorite = newFavoriteValue

        save()
        print("Updated 'isFavorite' status for entity.")
    }
    
    
    func deleteEntity(entity: NSManagedObject) {
        viewContext.delete(entity)
        save()
        print("Deleted \(entity)")
    }
    
    
    
    func getAreaById(id: NSManagedObjectID) -> Area? {
        
        do {
            return try viewContext.existingObject(with: id) as? Area
        } catch {
            return nil
        }
    }
    
    func getCategoryById(id: NSManagedObjectID) -> Category? {
        
        do {
            return try viewContext.existingObject(with: id) as? Category
        } catch {
            return nil
        }
    }
    
    func getIngredientById(id: NSManagedObjectID) -> Ingredient? {
        
        do {
            return try viewContext.existingObject(with: id) as? Ingredient
        } catch {
            return nil
        }
    }
    
    func getAllAreas() -> [Area] {
        
        let request: NSFetchRequest<Area> = Area.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
        
    }
    
    func getAllCategories() -> [Category] {
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
        
    }
    
    func getAllIngredients() -> [Ingredient] {
        
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func getAllMeals() -> [Meal] {
        let request: NSFetchRequest<Meal> = Meal.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Ratatouille")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error.localizedDescription)")
            }
        }
    }
    
}


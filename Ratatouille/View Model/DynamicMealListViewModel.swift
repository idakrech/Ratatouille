//
//  DynamicMealListViewModel.swift
//  Ratatouille
//
//

import Foundation
import CoreData

class DynamicMealListVM: ObservableObject {
    
    @Published var mealListFromDB: [MealEntityVM] = []
    
    func saveMeal(meal: MealDetailsVM) {
        
        let mealToSave = Meal(context: CoreDataManager.shared.viewContext)
        mealToSave.id = Int64(meal.id)
        mealToSave.name = meal.name
        mealToSave.category = meal.category
        mealToSave.area = meal.area
        mealToSave.instructions = meal.instructions
        mealToSave.tags = meal.tags
        mealToSave.imgURL = meal.imgUrl ?? ""
        
        do {
            try CoreDataManager.shared.viewContext.save()
        } catch {
            print("Failed to save Meal: \(error)")
        }
    }
    
    func saveMeal(meal: MealEntityVM) {
        let mealToSave = Meal(context: CoreDataManager.shared.viewContext)
        mealToSave.name = meal.name
        mealToSave.category = meal.category
        mealToSave.area = meal.area
        mealToSave.instructions = meal.instructions
        mealToSave.tags = meal.tags
        mealToSave.imgURL = meal.imgURL
        
        do {
            try CoreDataManager.shared.viewContext.save()
        } catch {
            print("Failed to save Meal: \(error)")
        }
    }
    
    func getAllMealsFromDB() {
        mealListFromDB = CoreDataManager.shared.getAllMeals().map(MealEntityVM.init)
    }
    
    func deleteMeal(meal: MealEntityVM) {
        guard let mealEntity = CoreDataManager.shared.getMealById(id: meal.id) else {
            print("Error finding entity.")
            return
        }
        CoreDataManager.shared.deleteEntity(entity: mealEntity)
    }
    
    func toggleArchiveValueForMeal(meal: MealEntityVM) {
        guard let mealEntity = CoreDataManager.shared.getMealById(id: meal.id) else {
            print("Error finding entity.")
            return
        }
        CoreDataManager.shared.updateEntityArchivedStatus(entity: mealEntity)
    }
    
    func toggleFavoriteValueForMeal(meal: MealEntityVM) {
        guard let mealEntity = CoreDataManager.shared.getMealById(id: meal.id) else {
            print("Error finding entity.")
            return
        }
        CoreDataManager.shared.updateMealFavoriteStatus(id: mealEntity.objectID)
    }
    
    func getMealByIdFromDB(id: NSManagedObjectID) -> Meal? {
        if let meal = CoreDataManager.shared.getMealById(id: id) {
            return meal
        } else {
            print("Unable to get meal with id \(id)")
            return nil
        }
    }
}

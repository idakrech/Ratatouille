//
//  MyRecipesViewModel.swift
//  Ratatouille
//
//

import Foundation
import CoreData

class MyRecipesVM: ObservableObject {
    
    @Published var mealListFromDB: [MealEntityVM] = []
    
    
    func getMealsFromDB() {
        mealListFromDB = CoreDataManager.shared.getAllMeals().map(MealEntityVM.init)
    }
    
    func toggleArchiveValueForMeal(meal: MealEntityVM) {
        if let existingEntity = CoreDataManager.shared.getMealById(id: meal.id) {
               CoreDataManager.shared.updateEntityArchivedStatus(entity: existingEntity)
           } else {
               print("Meal not found in the database.")
           }
    }
    
    func toggleFavoriteValueForMeal(meal: MealEntityVM) {
        guard let mealEntity = CoreDataManager.shared.getMealById(id: meal.id) else {
            print("Error finding entity.")
            return
        }
        CoreDataManager.shared.updateMealFavoriteStatus(id: mealEntity.objectID)
    }
}

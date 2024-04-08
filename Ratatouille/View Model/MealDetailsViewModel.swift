//
//  MealDetailsViewModel.swift
//  Ratatouille
//
//

import Foundation
import CoreData

// two view models for meal details, because MealDetailsView can receive either a recipe from API or a recipe from DB.
struct MealDetailsVM {
    
    let meal: MealDetailsData
    
    var id: Int {
        Int(meal.idMeal)!
    }
    
    var name: String {
        meal.strMeal
    }
    
    var category: String {
        meal.strCategory
    }
    
    var area: String {
        meal.strArea
    }
    
    var tags: String {
        meal.strTags
    }
    
    var imgUrl: String? {
        meal.strMealThumb
    }
    
    var instructions: String {
        meal.strInstructions
    }
    
}

class MealEntityVM {
    
    var entity: Meal
    
    var id: NSManagedObjectID {
        return entity.objectID
    }
    
    var name: String {
        return entity.name ?? ""
    }
    
    var area: String {
        return entity.area ?? ""
    }
    
    var category: String {
        return entity.category ?? ""
    }
    
    var instructions: String {
        return entity.instructions ?? ""
    }
    
    var tags: String {
        return entity.tags ?? ""
    }
    
    var imgURL: String {
        return entity.imgURL ?? ""
    }
    
    var isArchived: Bool {
        return entity.isArchived
    }
    
    var archiveDate: Date? {
        return entity.archiveDate
    }
    
    var isFavorite: Bool {
        return entity.isFavorite
    }
    
    
    init(entity: Meal) {
            self.entity = entity
        }
}

@MainActor
class MealDetailsListVM: ObservableObject {
    
    @Published var mealDetailsFromAPI: [MealDetailsVM] = []
    @Published var mealDetailsFromDB: MealEntityVM?
    

    func getMealDetailsFromAPI(id: String) async {
        do {
            let mealDetails = try await NetworkManager().fetchMealById(id: id)
            self.mealDetailsFromAPI = mealDetails.map(MealDetailsVM.init)
        } catch {
            print(error)
        }
    }
    
    func getMealDetailsFromDB(id: NSManagedObjectID) {
            if let mealEntityVM = CoreDataManager.shared.getMealById(id: id).map(MealEntityVM.init) {
                mealDetailsFromDB = mealEntityVM
            }
        }
}



//
//  MealResultViewModel.swift
//  Ratatouille
//
//
//

import Foundation
import CoreData

struct MealResultVM {
    
    let meal: MealResult
    
    var id: String {
        meal.idMeal
    }
    
    var name: String {
        meal.strMeal
    }
    
    var imgUrl: URL? {
        URL(string: meal.strMealThumb)
    }
}

@MainActor
class MealResultListVM: ObservableObject {
    
    @Published var results: [MealResultVM] = []
    
    func search(query: String, filter: String) async {
        do {
            let results = try await NetworkManager().fetchMealsByFilter(query: query, filter: filter)
            self.results = results.map(MealResultVM.init)
        } catch {
            print(error)
        }
    }
}

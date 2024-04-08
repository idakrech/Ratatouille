//
//  MealResultModel.swift
//  Ratatouille
//

import Foundation

struct MealResults : Decodable {
    let meals: [MealResult]
}

struct MealResult : Decodable, Identifiable {
    let strMeal: String
    var id: String {
        return idMeal
    }
    let strMealThumb: String
    let idMeal: String

}



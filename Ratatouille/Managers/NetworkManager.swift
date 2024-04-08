//
//  NetworkManager.swift
//  Ratatouille
//
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badID
}

class NetworkManager {
    
    private var lastComponent: String = ""
    private var mappedKey: String = ""
    
    func fetchMealsByFilter(query: String, filter: String) async throws -> [MealResult] {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "themealdb.com"
        
        
        if (filter != "text" ){
            components.path = "/api/json/v1/1/filter.php"
            switch filter {
            case "area":
                components.queryItems = [URLQueryItem(name: "a", value: query)]
            case "category":
                components.queryItems = [URLQueryItem(name: "c", value: query)]
            case "ingredient":
                components.queryItems = [URLQueryItem(name: "i", value: query)]
            default:
                break
            }
        } else {
            components.path = "/api/json/v1/1/search.php"
            components.queryItems = [URLQueryItem(name: "s", value: query)]
        }
        
        guard let url = components.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.badID
        }
        
        
        let mealResults = try? JSONDecoder().decode(MealResults.self, from: data)
        return mealResults?.meals ?? []
    }
    
    func fetchMealById(id: String) async throws -> [MealDetailsData] {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "themealdb.com"
        components.path = "/api/json/v1/1/lookup.php"
        components.queryItems = [URLQueryItem(name: "i", value: id)]
        
        guard let url = components.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.badID
        }
        
        let mealDetails = try? JSONDecoder().decode(MealDetails.self, from: data)
        return mealDetails?.meals ?? []
    }
    
    func fetchClassificationList(query: String) async throws -> ([DynamicClassification], String) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "themealdb.com"
        components.path = "/api/json/v1/1/list.php"
        
        switch query {
        case "area":
            components.queryItems = [URLQueryItem(name: "a", value: "list")]
        case "category":
            components.queryItems = [URLQueryItem(name: "c", value: "list")]
        case "ingredient":
            components.queryItems = [URLQueryItem(name: "i", value: "list")]
        default:
            break
        }
        
        guard let url = components.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.badID
        }
        
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .custom { keys in
            
            self.lastComponent = keys.last!.stringValue
            
            switch self.lastComponent {
            case "strArea", "strCategory", "strIngredient":
                self.mappedKey = "name"
            default:
                self.mappedKey = self.lastComponent
            }
            
            return CustomCodingKey(stringValue: self.mappedKey)!
        }
        
        let dynamicClassifications = try decoder.decode(DynamicClassificationList.self, from: data)
        
        return (dynamicClassifications.meals, self.mappedKey)
        
    }
}



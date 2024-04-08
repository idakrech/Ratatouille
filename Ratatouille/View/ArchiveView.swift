//
//  ArchiveView.swift
//  Ratatouille
//
//

import SwiftUI

struct ArchiveView: View {
    
    @StateObject private var areaListVM = DynamicClassificationListVM()
    @StateObject private var categoryListVM = DynamicClassificationListVM()
    @StateObject private var ingredientListVM = DynamicClassificationListVM()
    @StateObject private var dynamicMealListVM = DynamicMealListVM()
    
    var body: some View {
        
        List {
            Section("Landområder") {
                ForEach(areaListVM.dynamicClassificationListFromDB.filter { $0.isArchived }, id: \.id) { area in
                    VStack(alignment: .leading) {
                        Text(area.name)
                        Text("Arkivert:\(formatArchiveDate(date: area.archiveDate!))")
                    }
                    .swipeActions(allowsFullSwipe: false) {
                        HStack {
                            Button {
                                areaListVM.delete(entity: area)
                                areaListVM.getDynamicClassificationListFromDB(entityName: "area")
                            } label: {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .tint(.red)
                            Button {
                                areaListVM.toggleArchiveValueForClassification(entity: area)
                                areaListVM.getDynamicClassificationListFromDB(entityName: "area")
                            } label: {
                                Image(systemName: "tray.and.arrow.up.fill")
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .tint(.green)
                        }
                    }
                    
                }
                
            }.task {
                areaListVM.getDynamicClassificationListFromDB(entityName: "area")
            }
            
            Section("Kategorier") {
                ForEach(categoryListVM.dynamicClassificationListFromDB.filter { $0.isArchived }, id: \.id) { category in
                    VStack(alignment: .leading) {
                        Text(category.name)
                        Text("Arkivert:\(formatArchiveDate(date: category.archiveDate!))")
                    }
                    .swipeActions(allowsFullSwipe: false) {
                        HStack {
                            Button {
                                categoryListVM.delete(entity: category)
                                categoryListVM.getDynamicClassificationListFromDB(entityName: "category")
                            } label: {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .tint(.red)
                            Button {
                                categoryListVM.toggleArchiveValueForClassification(entity: category)
                                categoryListVM.getDynamicClassificationListFromDB(entityName: "category")
                            } label: {
                                Image(systemName: "tray.and.arrow.up.fill")
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .tint(.green)
                        }
                    }
                }
                
            }.task {
                categoryListVM.getDynamicClassificationListFromDB(entityName: "category")
            }
            
            Section("Ingredienser") {
                ForEach(ingredientListVM.dynamicClassificationListFromDB.filter { $0.isArchived }, id: \.id) { ingredient in
                    VStack(alignment: .leading) {
                        Text(ingredient.name)
                        Text("Arkivert:\(formatArchiveDate(date: ingredient.archiveDate!))")
                    }
                    .swipeActions(allowsFullSwipe: false) {
                        HStack {
                            Button {
                                ingredientListVM.delete(entity: ingredient)
                                ingredientListVM.getDynamicClassificationListFromDB(entityName: "ingredient")
                            } label: {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .tint(.red)
                            Button {
                                ingredientListVM.toggleArchiveValueForClassification(entity: ingredient)
                                ingredientListVM.getDynamicClassificationListFromDB(entityName: "ingredient")
                            } label: {
                                Image(systemName: "tray.and.arrow.up.fill")
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .tint(.green)
                        }
                    }
                }
                
            }.task {
                ingredientListVM.getDynamicClassificationListFromDB(entityName: "ingredient")
            }
            
            Section("Matoppskrifter") {
                ForEach(dynamicMealListVM.mealListFromDB.filter { $0.isArchived }, id: \.id) { meal in
                    VStack(alignment: .leading) {
                        Text(meal.name)
                        Text("Arkivert:\(formatArchiveDate(date: meal.archiveDate!))")
                    }
                    .swipeActions(allowsFullSwipe: false) {
                        HStack {
                            Button {
                                dynamicMealListVM.deleteMeal(meal: meal)
                                dynamicMealListVM.getAllMealsFromDB()
                            } label: {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .tint(.red)
                            Button {
                                dynamicMealListVM.toggleArchiveValueForMeal(meal: meal)
                                dynamicMealListVM.getAllMealsFromDB()
                            } label: {
                                Image(systemName: "tray.and.arrow.up.fill")
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .tint(.green)
                        }
                    }
                }
                
            }.task {
                dynamicMealListVM.getAllMealsFromDB()
            }
        }
        
    }
    
    private func formatArchiveDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
}

struct ArchiveView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveView()
    }
}


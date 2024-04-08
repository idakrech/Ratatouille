//
//  DynamicListView.swift
//  Ratatouille
//
//

import SwiftUI
import CoreData

// for either recipe list loaded from API or recipe list saved locally in DB
struct DynamicMealListView: View {
    
    var name: String
    var filter: String
    
    @StateObject private var mealResultListVM = MealResultListVM()
    @StateObject private var dynamicMealListVM = DynamicMealListVM()
    @StateObject private var mealDetailsListVM = MealDetailsListVM()
    
    var body: some View {
        
        List(mealResultListVM.results, id: \.id) { meal in
            NavigationLink(destination: MealDetailsView(id: meal.id)) {
                
                HStack{
                    AsyncImage(url: meal.imgUrl) { image in
                        image.resizable()
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    
                    Text(meal.name)
                        .font(.system(size: 20.0))
                } .swipeActions(allowsFullSwipe: false) {
                    Button {
                        if let meal = mealDetailsListVM.mealDetailsFromAPI.first {
                            dynamicMealListVM.saveMeal(meal: meal)
                        }
                        
                    } label: {
                        Image(systemName: "square.grid.3x1.folder.fill.badge.plus")
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(10)
                    }.task {
                        await mealDetailsListVM.getMealDetailsFromAPI(id: meal.id)
                    }
                    
                }
            }
        }
        .task {
            await mealResultListVM.search(query: name, filter: filter)
        }
    }
}

struct DynamicListView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicMealListView(name: "American", filter: "area")
    }
}

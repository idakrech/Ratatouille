//
//  MyRecipesView.swift
//  Ratatouille
//
//

import SwiftUI

struct MyRecipesView: View {
    
    @State var name: String = ""
    @State var imgUrl: String = ""
    @State private var archivedMeal = false
    
    
    @StateObject private var myRecipesVM = MyRecipesVM()
    
    
    var body: some View {
        NavigationView {
            VStack{
                if !myRecipesVM.mealListFromDB.filter({ !$0.isArchived }).isEmpty {
                    List(myRecipesVM.mealListFromDB.filter { !$0.isArchived }, id: \.id) { meal in
                        NavigationLink(destination: MealDetailsView(managedObjectID: meal.id)) {
                            HStack{
                                AsyncImage(url: URL(string: meal.imgURL)) { image in
                                    image.resizable()
                                        .clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                
                                VStack {
                                    Text(meal.name)
                                        .font(.system(size: 30.0))
                                    Text(meal.tags)
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button {
                                        myRecipesVM.toggleArchiveValueForMeal(meal: meal)
                                        archivedMeal = true
                                        
                                    } label: {
                                        Image(systemName: "archivebox.fill")
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    }
                                    .tint(.blue)
                                }
                                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                    Button {
                                        myRecipesVM.toggleFavoriteValueForMeal(meal: meal)
                                    } label: {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    }
                                    .tint(.purple)
                                }
                            }
                        }
                    }
                    .onChange(of: archivedMeal) { newValue in
                        if newValue {
                            Task {
                                myRecipesVM.getMealsFromDB()
                                archivedMeal = false
                            }
                        }}
                } else {
                    VStack {
                        Image(systemName: "square.stack.3d.up.slash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                        Text("Ingen matoppskrifter")
                            .bold()
                            .font(.system(size: 20.0))
                    }
                }
            }
        }.navigationTitle("Matoppskrifter")
            .task {
                myRecipesVM.getMealsFromDB()
            }
    }
}

struct MyRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipesView()
    }
}

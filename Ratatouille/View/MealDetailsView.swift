//
//  RecipeDetailsView.swift
//  Ratatouille
//
//

import SwiftUI
import CoreData

// for lookup of either recipe from API or recipe from DB
struct MealDetailsView: View {

    @State var id: String?
    @State var managedObjectID: NSManagedObjectID?
    @State private var showingSheet = false

    @StateObject private var mealDetailsListVM = MealDetailsListVM()
    @StateObject private var dynamicClassificationListVM = DynamicClassificationListVM()

    init(id: String) {
        self._id = State(initialValue: id)
    }

    init(managedObjectID: NSManagedObjectID) {
        self._managedObjectID = State(initialValue: managedObjectID)
    }


    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if id != nil {
                        if let meal = mealDetailsListVM.mealDetailsFromAPI.first {
                            AsyncImage(url: URL(string: meal.imgUrl ?? "")) { image in
                                image.resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(minWidth: 100.0)
                            Text(meal.name)
                            Text(meal.category)
                            Text(meal.area)
                            Text(meal.tags)
                            Text(meal.instructions)
                        }
                    } else if managedObjectID != nil {
                        if let meal = mealDetailsListVM.mealDetailsFromDB {
                            AsyncImage(url: URL(string: meal.imgURL )) { image in
                                image.resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(minWidth: 100.0)
                            Text(meal.name)
                            Text(meal.category)
                            Text(meal.area)
                            Text(meal.tags)
                            Text(meal.instructions)
                        }
                    } else {
                        Text("There is no recipe fetched")
                    }
                }
                .onAppear {
                    Task {
                        if let id = id {
                            print("Fetching details for ID: \(id)")
                            await mealDetailsListVM.getMealDetailsFromAPI(id: id)
                        } else if let managedObjectID = managedObjectID {
                            print("Fetching details for Managed Object ID: \(managedObjectID)")
                            mealDetailsListVM.getMealDetailsFromDB(id: managedObjectID)
                        }
                    }
                }
            }
            .navigationBarItems(trailing: editButton)
        }
    }
        
    // edit button is only available for a recipe from database, not from API.
    private var editButton: some View {
        if managedObjectID != nil {
            return AnyView(Button("Edit", action: {
                showingSheet.toggle()
            })
            .sheet(isPresented: $showingSheet) {
                EditMealSheetView(managedObjectID: managedObjectID!)
            })
        } else {
            return AnyView(EmptyView())
        }
    }

}

struct MealDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailsView(id: "")
    }
}



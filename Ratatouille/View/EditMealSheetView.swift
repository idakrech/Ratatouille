//
//  EditMealSheetView.swift
//  Ratatouille
//
//

import SwiftUI
import CoreData

// for editing of a locally saved recipe
struct EditMealSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var mealName: String = ""
    @State private var mealTags: String = ""
    @State private var mealArea: String = ""
    @State private var mealCategory: String = ""
    @State private var mealInstructions: String = ""
    @State private var mealImgURL: String = ""
    
    @StateObject var areaListVM = DynamicClassificationListVM()
    @StateObject var categoryListVM = DynamicClassificationListVM()
    
    @StateObject var dynamicMealListVM = DynamicMealListVM()
    
    @State var managedObjectID: NSManagedObjectID
    
    @State var meal: Meal? = nil
    
    
    var body: some View {
        VStack{
            LabeledContent {
                TextField("Navn", text: $mealName)
            } label: {
                Text("Navn")
            }
            LabeledContent {
                TextField("Tags", text: $mealTags)
            } label: {
                Text("Tags")
            }
            
            LabeledContent {
                if !areaListVM.dynamicClassificationListFromDB.isEmpty {
                    Picker("Select area", selection: $mealArea, content: {
                        ForEach(areaListVM.dynamicClassificationListFromDB, id: \.id) { item in
                            Text(item.name).tag(item.name)
                        }
                    })
                    
                } else {
                    Text("Ingen landområde tilgjengelig")
                }
            } label: {
                Text("Landområde")
            }
            .task {
                areaListVM.getDynamicClassificationListFromDB(entityName: "area")
                
            }
            
            
            LabeledContent {
                if !categoryListVM.dynamicClassificationListFromDB.isEmpty {
                    Picker("Select category", selection: $mealCategory) {
                        ForEach(categoryListVM.dynamicClassificationListFromDB, id: \.id) { item in
                            Text(item.name).tag(item.name)
                        }
                    }
                    
                } else {
                    Text("Ingen kategori tilgjengelig")
                }
            } label: {
                Text("Kategori")
            }
            .task {
                categoryListVM.getDynamicClassificationListFromDB(entityName: "category")
                
            }
            
            
            LabeledContent {
                TextField("Fremgangsmåte", text: $mealInstructions)
            } label: {
                Text("Fremgangsmåte")
            }
            
            LabeledContent {
                TextField("Bilde-URL", text: $mealImgURL)
            } label: {
                Text("Bilde-URL")
            }
            
            Button("Lagre endringer") {
                if let oldMealEntity = dynamicMealListVM.getMealByIdFromDB(id: managedObjectID) {
                    
                    let oldMealEntityVM = MealEntityVM(entity: oldMealEntity)
                    
                    
                    if let meal = self.meal {
                        let newMealEntity = MealEntityVM(entity: meal)
                        dynamicMealListVM.deleteMeal(meal: oldMealEntityVM)
                        
                        meal.name = mealName
                        meal.tags = mealTags
                        meal.area = mealArea
                        meal.category = mealCategory
                        meal.instructions = mealInstructions
                        meal.imgURL = mealImgURL
                        
                        dynamicMealListVM.saveMeal(meal: newMealEntity)
                        
                    }
                    
                    dismiss()
                    
                } else {
                    print("Meal of id \(managedObjectID) not found.")
                }
            }
            .padding()
            Button("Avbryt") {
                dismiss()
            }
            .padding()
        }.onAppear {
            if let meal = dynamicMealListVM.getMealByIdFromDB(id: managedObjectID) {
                mealName = meal.name ?? ""
                mealTags = meal.tags ?? ""
                mealArea = meal.area ?? ""
                mealCategory = meal.category ?? ""
                mealInstructions = meal.instructions ?? ""
                mealImgURL = meal.imgURL ?? ""
                self.meal = meal
            } else {
                print("Meal of id \(managedObjectID) not found.")
            }
        }
        .onChange(of: mealName) { newValue in
            self.meal?.name = newValue
        }
        .onChange(of: mealTags) { newValue in
            self.meal?.tags = newValue
        }
        .onChange(of: mealArea) { newValue in
            self.meal?.area = newValue
        }
        .onChange(of: mealCategory) { newValue in
            self.meal?.category = newValue
        }
        .onChange(of: mealInstructions) { newValue in
            self.meal?.instructions = newValue
        }
        .onChange(of: mealImgURL) { newValue in
            self.meal?.imgURL = newValue
        }
    }
}

//struct EditMealSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditMealSheetView()
//    }
//}

//
//  EditMealView.swift
//  Ratatouille
//
//  Created by Ida Krech on 04/12/2023.
//

import SwiftUI

//struct EditMealView: View {
    
//    @State private var mealName: String = ""
//    @State private var mealTags: String = ""
//    @State private var mealArea: String = ""
//    @State private var mealCategory: String = ""
//    @State private var mealIngredient: String = ""
//    @State private var mealInstructions: String = ""
//    @State private var mealImgURL: String = ""
//
//    //@State var dynamicClassificationListVM = DynamicClassificationListVM()
//
//    var body: some View {
//        VStack{
//            LabeledContent {
//                TextField("Navn", text: $mealName)
//            } label: {
//                Text("Navn")
//            }
//            LabeledContent {
//                TextField("Tag", text: $mealName)
//            } label: {
//                Text("Navn")
//            }
//            LabeledContent {
//                if !dynamicClassificationListVM.dynamicClassificationListFromDB.isEmpty {
//                    Picker("Select area", selection: $mealArea, content: {
//                        ForEach(dynamicClassificationListVM.dynamicClassificationListFromDB, id: \.id) { item in
//                            Text(item.name) //.tag(item.id)
//                        }
//                    })
//
//                } else {
//                    Text("No options available")
//                }
//            }
//
//            label: {
//                Text("Area")
//            }
//            .task {
//                Task.init {
//                   await dynamicClassificationListVM.getDynamicClassificationListFromDB(entityName: "area")
//                }
//            }
//
//
//            LabeledContent {
//                TextField("Navn", text: $mealName)
//            } label: {
//                Text("Navn")
//            }
//            LabeledContent {
//                TextField("Navn", text: $mealName)
//            } label: {
//                Text("Navn")
//            }
//            LabeledContent {
//                TextField("Navn", text: $mealName)
//            } label: {
//                Text("Navn")
//            }
//            LabeledContent {
//                TextField("Navn", text: $mealName)
//            } label: {
//                Text("Navn")
//            }
//
//        }
//    }
//}

//struct EditMealView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditMealView()
//    }
//}

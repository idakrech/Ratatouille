//
//  DynamicSettingsView.swift
//  Ratatouille
//
//

import SwiftUI

// for a list of either area, category or ingredient in the settings
struct DynamicSettingsView: View {
    
    @StateObject var dynamicClassificationListVM = DynamicClassificationListVM()
    @State var filter: String
    @State var navTitle: String
    @State private var showingSheet = false
    @State private var addedNewRecord = false
    
    var body: some View {
        NavigationView {
            List(dynamicClassificationListVM.dynamicClassificationListFromDB.filter { !$0.isArchived }, id: \.id) { item in
                Text(item.name)
                
                    .swipeActions(allowsFullSwipe: false) {
                        Button {
                            dynamicClassificationListVM.toggleArchiveValueForClassification(entity: item)
                            dynamicClassificationListVM.getDynamicClassificationListFromDB(entityName: filter)
                        } label: {
                            Image(systemName: "archivebox.fill")
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .tint(.blue)
                    }
            }.task {
                Task.init {
                    dynamicClassificationListVM.getDynamicClassificationListFromDB(entityName: filter)
                }
            }.onChange(of: addedNewRecord) { newValue in
                if newValue {
                    Task {
                        dynamicClassificationListVM.getDynamicClassificationListFromDB(entityName: filter)
                        addedNewRecord = false
                    }
                }
                
            }.navigationTitle(navTitle)
                .navigationBarItems(trailing: Button(
                    action: {
                        showingSheet.toggle()
                    }
                ){
                    Image(systemName: "plus")
                        .resizable()
                        .padding(6)
                        .frame(width: 24, height: 24)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }.sheet(isPresented: $showingSheet) {
                    DynamicClassificationSheetView(filter: filter, addedNewRecord: $addedNewRecord)
                }
                )
        }
    }
}

struct DynamicSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicSettingsView(filter: "area", navTitle: "Landområder")
    }
}



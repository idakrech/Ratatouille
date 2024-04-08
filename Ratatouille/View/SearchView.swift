//
//  SearchView.swift
//  Ratatouille
//
//


import SwiftUI
import CoreData

struct SearchView: View {
    
    @StateObject private var mealResultListVM = MealResultListVM()
    @StateObject private var dynamicClassificationListVM = DynamicClassificationListVM()
    @State private var searchText: String = ""
    @State private var filter: String = ""
    @State private var selectedSearchTag: SearchTag = .area
    
    var body: some View {
        
        NavigationView {
            VStack {
                Picker("Search by", selection: $selectedSearchTag) {
                    ForEach(SearchTag.allCases) { searchTag in
                        searchTag.icon
                    }
                }.pickerStyle(.segmented)
                
                if selectedSearchTag == .text {
                    List(mealResultListVM.results, id: \.id) { meal in
                        NavigationLink(destination: MealDetailsView(id: meal.id)) {
                            HStack {
                                AsyncImage(url: meal.imgUrl) { image in
                                    image.resizable()
                                        .clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                
                                Text(meal.name)
                                    .font(.system(size: 20.0))
                            }
                        }
                    }.searchable(text: $searchText)
                        .onChange(of: searchText) { searchText in
                            Task.init {
                                if !searchText.isEmpty && searchText.count > 3 {
                                    await mealResultListVM.search(query: searchText, filter: selectedSearchTag.rawValue)
                                } else {
                                    mealResultListVM.results.removeAll()
                                }
                            }
                        }
                } else {
                    List(dynamicClassificationListVM.dynamicClassificationListFromDB, id: \.id) { item in
                        let countryAdjective = item.name
                        let countryEnum = CountryAdjectives(rawValue: countryAdjective)
                        NavigationLink(destination: DynamicMealListView(name: item.name, filter: selectedSearchTag.rawValue)) {
                            HStack {
                                if selectedSearchTag == .area {
                                    if let countryEnum = countryEnum {
                                        AsyncImage(url: URL(string: "https://flagsapi.com/\(countryEnum.countryCode)/flat/64.png") ?? URL(string: item.imgUrl ?? "")) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .clipShape(Circle())
                                        } placeholder: {
                                            Image(systemName: "photo")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .clipShape(Circle())
                                        }
                                        Text(item.name)
                                
                                    } else {
                                        AsyncImage(url: URL(string: item.imgUrl ?? "")) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .clipShape(Circle())
                                        } placeholder: {
                                            Image(systemName: "photo")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .clipShape(Circle())
                                        }
                                        Text(item.name)
                                    }
                                } else {
                                    // because categories and ingredients have no image attribute
                                    Image(systemName: "tag.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                    Text(item.name)
                                }
                            }
                        }
                    }.task {
                        Task.init {
                            dynamicClassificationListVM.getDynamicClassificationListFromDB(entityName: selectedSearchTag.rawValue)
                        }
                        
                    }
                    .onChange(of: selectedSearchTag) { selectedSearchTag in
                        Task.init {
                            dynamicClassificationListVM.getDynamicClassificationListFromDB(entityName: selectedSearchTag.rawValue)
                        }
                    }
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}



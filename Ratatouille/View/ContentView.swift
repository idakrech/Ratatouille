//
//  ContentView.swift
//  Ratatouille
//
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    let CDManager: CoreDataManager
    
    //for downloading classifications from API and populating the databases
    @State private var hasLaunchedBefore: Bool = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
    
    @AppStorage("isDarkMode") private var isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    
    @StateObject var dynamicClassificationListVM = DynamicClassificationListVM()
    
    
    var queries: [String] = ["area", "category", "ingredient"]
    
    var body: some View {
        
        TabView {
            
            NavigationStack {
                MyRecipesView()
                    .navigationTitle("Mine oppskrifter")
                    .navigationBarItems(leading: Image("ratatouille_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 100))
            }
            .tabItem{
                Label("Mine oppskrifter", systemImage: "fork.knife.circle.fill")
            }
            NavigationStack {
                SearchView()
                    .navigationTitle("Søk")
                    .navigationBarItems(leading: Image("ratatouille_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 150))
            }
            .tabItem{
                Label("Søk", systemImage: "magnifyingglass.circle.fill")
            }
            NavigationStack {
                SettingsView()
                    .navigationTitle("Innstillinger")
                    .navigationBarItems(leading: Image("ratatouille_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 100))
            }
            .tabItem {
                Label("Innstillinger", systemImage: "gearshape.circle.fill")
            }
            
        }
        .onAppear {
            print(UserDefaults.standard.bool(forKey: "hasLaunchedBefore"))
            print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
            //if you want to fetch classifications anew, uncomment:
            // hasLaunchedBefore = false
            if !hasLaunchedBefore {
                Task {
                    for query in queries {
                        await dynamicClassificationListVM.saveDynamicClassificationList(query: query)
                    }
                    UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
                }
            } else {
                return
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(CDManager: CoreDataManager()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


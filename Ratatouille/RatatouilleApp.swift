//
//  RatatouilleApp.swift
//  Ratatouille
//

//

import SwiftUI

@main
struct RatatouilleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(CDManager: CoreDataManager())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}



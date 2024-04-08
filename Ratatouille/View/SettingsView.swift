//
//  SettingsView.swift
//  Ratatouille
//
//

import SwiftUI

struct SettingsItem: Hashable {
    var name: String
    var title: String
    var text: String
    var iconName: String
}

struct SettingsView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    private let settings: [SettingsItem] = [
        SettingsItem(name: "area", title: "Landområder", text: "Redigere landområder", iconName: "globe"),
        SettingsItem(name: "category", title: "Kategorier", text: "Redigere kategorier", iconName: "square.grid.2x2"),
        SettingsItem(name: "ingredient", title: "Ingredienser", text: "Redigere ingredienser", iconName: "carrot.fill")
    ]
    
    var body: some View {
        List {
            Section {
                ForEach(settings, id: \.text) { setting in
                    NavigationLink(destination: DynamicSettingsView(filter: setting.name, navTitle: setting.title)) {
                        HStack {
                            Image(systemName: setting.iconName)
                            Text(setting.text)
                        }
                    }
                }
            }
            Section {
                HStack {
                    Image(systemName: "moon.circle")
                    Text("Aktiver mørk modus")
                    Toggle("", isOn: $isDarkMode)
                        .labelsHidden()
                        .onChange(of: isDarkMode) { newValue in
                            UserDefaults.standard.set(newValue, forKey: "isDarkMode")
                        }
                }.preferredColorScheme(isDarkMode ? .dark : .light)
                
                
            }
            
            Section {
                NavigationLink(destination: ArchiveView()) {
                    HStack {
                        Image(systemName: "archivebox")
                        Text("Administrer arkiv")
                    }
                }
            }
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

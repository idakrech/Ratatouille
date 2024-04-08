//
//  DynamicClassificationSheetView.swift
//  Ratatouille
//
//

import SwiftUI

// for adding new area/category/ingredient to database
struct DynamicClassificationSheetView: View {
    @Environment(\.dismiss) var dismiss
    @State private var classificationName: String = ""
    @StateObject var dynamicClassificationSheetVM = DynamicClassificationSheetVM(filter: "", name: "", imgURL: "")
    var filter: String
    @Binding var addedNewRecord: Bool
    
    
    var body: some View {
        VStack {
            TextField("Skriv inn navnet", text: $classificationName).multilineTextAlignment(.center)
            Button("Legg til") {
                if !classificationName.isEmpty, classificationName.split(separator: " ").count == 1, classificationName.count <= 30 {
                    dynamicClassificationSheetVM.filter = filter
                    dynamicClassificationSheetVM.name = classificationName
                    dynamicClassificationSheetVM.SaveDynamicClassification()
                    dismiss()
                    addedNewRecord = true
                }
            }
            .padding()
    
            Button("Avbryt") {
                dismiss()
            }
            .padding()
        }
    }
}

struct DynamicClassificationSheetView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicClassificationSheetView(filter: "area", addedNewRecord: .constant(false))
    }
}

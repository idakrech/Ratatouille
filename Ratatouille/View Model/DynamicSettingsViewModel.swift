//
//  DynamicSettingsViewModel.swift
//  Ratatouille
//
//  Created by Ida Krech on 03/12/2023.
//

import Foundation

class DynamicSettingsViewModel: ObservableObject {
    
    var dynamicClassificationListVM: DynamicClassificationListVM?
    
//    func delete(entity: DynamicClassificationVM) {
//        guard let existingEntity = CoreDataManager.shared.getAreaById(id: entity.id)
//            ?? CoreDataManager.shared.getCategoryById(id: entity.id)
//            ?? CoreDataManager.shared.getIngredientById(id: entity.id) else {
//                print("Error finding entity.")
//                return
//        }
//        CoreDataManager.shared.deleteEntity(entity: existingEntity)
//    }
    
//    func toggleArchiveValueForClassification(entity: DynamicClassificationVM) {
//        guard let existingEntity = CoreDataManager.shared.getAreaById(id: entity.id)
//            ?? CoreDataManager.shared.getCategoryById(id: entity.id)
//            ?? CoreDataManager.shared.getIngredientById(id: entity.id) else {
//                print("Error finding entity.")
//                return
//        }
//        CoreDataManager.shared.updateEntityArchivedStatus(entity: existingEntity)
//    }

}

//
//  File.swift
//  Ratatouille
//
//  Created by Ida Krech on 24/11/2023.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    
    func fetch() {
        guard let url = URL(string: "www.themealdb.com/api/json/v1/1/filter.php?a=Canadian") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let data = try JSONDecoder().decode([], from: <#T##Data#>)
            }
        }
    }
}

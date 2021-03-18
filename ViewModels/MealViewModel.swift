//
//  MealViewModel.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 17/03/2021.
//

import Foundation

class MealViewModel: ObservableObject {
    
    @Published var nutrients: [RecipieAPI] = []
    
    init() {
        fetchNutrients()
    }
    
    func fetchNutrients() {
        NetworkServices.fetchNutrients(minCarbs: 10, maxCarbs: 50, number: 4) { (nutrients, error) in
            if let error = error {
                print(error)
            } else {
                if let nutrientList = nutrients as? [RecipieAPI] {
                    self.nutrients = nutrientList
                }
            }
        }
    }
}

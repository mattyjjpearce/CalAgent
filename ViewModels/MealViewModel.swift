//
//  MealViewModel.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 17/03/2021.
//
import SwiftUI
import Combine
import Foundation

class MealViewModel: ObservableObject {
    
    @Published var nutrients: [RecipieAPI] = []
    
//    @EnvironmentObject var person: UserInfoModel
    
    let person =  UserInfoModel.shared

    
    
    @State public var fat = 0
    @State public var carbs = 0
    @State public var protein = 0


    
    init() {
 
        
       fetchNutrients()


    }
    
    func fetchNutrients() {
    
        NetworkServices.fetchNutrients(maxProtein: self.person.recipeNutrientsSearch.protein , maxFat: self.person.recipeNutrientsSearch.fat,  maxCarbs: self.person.recipeNutrientsSearch.carb, number: 10) { (nutrients, error) in
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

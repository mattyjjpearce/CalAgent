//
//  MealViewModel.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 17/03/2021.
//
import SwiftUI
import Combine
import Foundation

class MealViewModel: ObservableObject { //ViewModel to fetch Recipes from API - Spoonacular
    
    @Published var nutrients: [RecipeAPI] = [] //published variable Nutrients (list of Recipes from API)
    
    let person =  UserInfoModel.shared

    @State public var fat = 0
    @State public var carbs = 0
    @State public var protein = 0

    init() {
       fetchRecipeFromAPI() //Anytime this ViewModel is called it runs the fetchRecipeFromAPI method
    }
    
    //Uses the method inside Network services to pass in the parameters for fetching recipes from Spoonacular API (Recipe Database)
    func fetchRecipeFromAPI() {
        NetworkServices.fetchNutrients(maxProtein: self.person.recipeNutrientsSearch.protein , maxFat: self.person.recipeNutrientsSearch.fat,  maxCarbs: self.person.recipeNutrientsSearch.carb, number: 10) { (nutrients, error) in
            if let error = error {
                print(error)
            } else {
                if let nutrientList = nutrients as? [RecipeAPI] {
                    self.nutrients = nutrientList
                }
            }
        }
    }
}

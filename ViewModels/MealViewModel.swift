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
        
        let fat = person.personDailyCalorieGoals.fatGoal - person.personCurrentCalorieProgress.fatProgress
        person.recipeNutrientsSearch.fat = Int(fat)
        
        let carb = person.personDailyCalorieGoals.carbGoal - person.personCurrentCalorieProgress.carbProgress
        person.recipeNutrientsSearch.carb = Int(carb)
        
        let protein = person.personDailyCalorieGoals.proteinGoal - person.personCurrentCalorieProgress.proteinProgress
        person.recipeNutrientsSearch.protein = Int(protein)

//        let x = RecipieAPI(calories: 200, carbs: "5g", fat: "5g", id: 200, image: "imagelink", imageType: "imagetype", protein: "5g", title: "Dummy 1")
//        let x2 = RecipieAPI(calories: 200, carbs: "5g", fat: "5g", id: 200, image: "imagelink", imageType: "imagetype", protein: "5g", title: "Dummy 2")
//
//        nutrients.append(x)
//        nutrients.append(x2)
        
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

//
//  UserInfoModel.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 01/12/2020.
//

import Foundation

class UserInfoModel: ObservableObject {
    
    static let shared: UserInfoModel = UserInfoModel() // <<: Here

    struct UserInfo: Identifiable {
        var id = UUID()
        var firstName: String
        var height: Double
        var weight: Double
        var gender: String
        var age: Double
        var activityLevel: String
        var BMR: Double
        
    }
    
    struct AddedFoods:Identifiable{
        var name: String = ""
        var totalCals: Double = 0
        var totalProtein: Double = 0
        var totalCarbs: Double = 0
        var totalFat: Double = 0
        var id = UUID().uuidString
       //Your other properties
    }
    
    struct DailyCalorieGoals: Identifiable{
        var id = UUID()
        var calorieGoal: Double
        var fatGoal: Double
        var proteinGoal: Double
        var carbGoal: Double

    }
    
    struct CurrentCalorieProgress: Identifiable{
        var id = UUID()
        var calorieProgress: Double
        var fatProgress: Double
        var carbProgress: Double
        var proteinProgress: Double
    }
    
    struct SearchRecipeCalories: Identifiable{
        var id = UUID()
        var fat: Int
        var carb: Int
        var protein: Int
    }
    
    @Published var personUserInfo = UserInfo.init(firstName: "",  height: 0, weight: 0, gender: "", age: 0, activityLevel: "", BMR: 0)
    @Published var personDailyCalorieGoals = DailyCalorieGoals.init(calorieGoal: 2400, fatGoal: 40, proteinGoal: 40, carbGoal: 40)
    @Published var personCurrentCalorieProgress = CurrentCalorieProgress.init(calorieProgress: 1200, fatProgress:   12, carbProgress: 5, proteinProgress: 30)
    
    @Published var  recipeNutrientsSearch = SearchRecipeCalories.init(fat: 0, carb: 0, protein: 0)
    
}

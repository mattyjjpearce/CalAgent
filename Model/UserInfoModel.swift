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
        var bmr: Double
        var useSteps: Bool
        
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
    
    struct PersonSteps: Identifiable{
        var id = UUID()
        var steps: Double
        var calories: Double
        var totalCalorieGoalWithSteps: Double
        var addCalories: Bool
    }
    
    @Published var personUserInfo = UserInfo.init(firstName: "",  height: 0, weight: 0, gender: "", age: 0, activityLevel: "", bmr: 0, useSteps: false)
    @Published var personDailyCalorieGoals = DailyCalorieGoals.init(calorieGoal: 2200, fatGoal: 10, proteinGoal: 120, carbGoal: 220)
    @Published var personCurrentCalorieProgress = CurrentCalorieProgress.init(calorieProgress: 0, fatProgress:   0, carbProgress: 0, proteinProgress: 0)
    
    @Published var  recipeNutrientsSearch = SearchRecipeCalories.init(fat: 0, carb: 0, protein: 0)
    @Published var personSteps = PersonSteps.init(steps: 0.00, calories: 0.00, totalCalorieGoalWithSteps: 0.00, addCalories: false)
}

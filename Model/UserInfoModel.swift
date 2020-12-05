//
//  UserInfoModel.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 01/12/2020.
//

import Foundation

class UserInfoModel: ObservableObject {
    
    
    struct UserInfo: Identifiable {
        var id = UUID()
        var firstName: String
        var lastName: String
        var height: Int
        var weight: Int
        var gender: String
        var age: Int
        
    }
    
    struct DailyCalorieGoals: Identifiable{
        var id = UUID()
        var calorieGoal: Int
        var fatGoal: Int
        var proteinGoal: Int
        var carbGoal: Int

    }
    
    struct CurrentCalorieProgress: Identifiable{
        var id = UUID()
        var calorieProgress: Int
        var fatProgress: Int
        var carbProgress: Int
    }
    
    @Published var personUserInfo = UserInfo.init(firstName: "", lastName:"", height: 0, weight: 0, gender: "", age: 0)
    @Published var personDailyCalorieGoals = DailyCalorieGoals.init(calorieGoal: 2400, fatGoal: 0, proteinGoal: 0, carbGoal: 0)
    @Published var personCurrentCalorieProgress = CurrentCalorieProgress.init(calorieProgress: 0, fatProgress: 0, carbProgress: 0)
    
    
}

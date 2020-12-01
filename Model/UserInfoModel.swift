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
        var proteinGoal: Int
    }
    
    @Published var person1 = UserInfo.init(height: 20, weight: 30, gender: "male", age: 5)
    
}

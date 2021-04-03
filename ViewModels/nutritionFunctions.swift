//
//  nutritionFunctions.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 23/03/2021.
//

import Foundation

import HealthKit
import SwiftUI
import Combine //to use Just


class nutritionFunctions{
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var userSettingViewModel: UserSettingsViewModel = UserSettingsViewModel()
    @ObservedObject var calorieGoalViewModel: CalorieGoalsiewModel = CalorieGoalsiewModel()


    @EnvironmentObject var person: UserInfoModel


func macrosToCals(fat: Double, protein: Double, carbs: Double) -> Double {
    
    let fat = fat * 9
    let protein = protein * 4
    let carbs = carbs * 4
    
    let cals = fat + protein + carbs
    
    return cals
}
    
    func stringToDoubleGrams(input: String) -> Double {
        
      let input = input.replacingOccurrences(of: "g", with: "", options: NSString.CompareOptions.literal, range: nil)
      let output = Double(input)!
    
        return output
    }
    
    func setData(){
        person.personDailyCalorieGoals.calorieGoal = calorieGoalViewModel.calorieGoals.first?.calorieGoal ?? 0
    }
}

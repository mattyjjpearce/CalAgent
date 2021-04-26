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


class nutritionFunctions{ //Class to perform some basic mathematic functions
    
    @Environment(\.managedObjectContext) private var viewContext
    
    //Inantiating local ViewModels
    @ObservedObject var userSettingViewModel: UserSettingsViewModel = UserSettingsViewModel()
    @ObservedObject var calorieGoalViewModel: CalorieGoalsiewModel = CalorieGoalsiewModel()

    //Instantiating Environment object UserInfoModel.swift
    @EnvironmentObject var person: UserInfoModel

    //Function to convert macro-nutrients to calories
    func macrosToCals(fat: Double, protein: Double, carbs: Double) -> Double {
    
        let fat = fat * 9
        let protein = protein * 4
        let carbs = carbs * 4
        
        let cals = fat + protein + carbs
    
    return cals
    }
    
    //Function to get rid of the g of strings and turn the input into a double
    //Takes in a string, e.g. ("2g") and converts it to a double: 2
    func stringToDoubleGrams(input: String) -> Double {
        
          let input = input.replacingOccurrences(of: "g", with: "", options: NSString.CompareOptions.literal, range: nil)
          let output = Double(input)!
    
        return output
    }
    
    //Function to set calorie goal from
    func setData(){
        person.personDailyCalorieGoals.calorieGoal = calorieGoalViewModel.calorieGoals.first?.calorieGoal ?? 0
    }
    
    //Function turning the steps of the user into calories 
    func stepsToCalories(input: Double) -> Double{
        let result = input * 0.045
        return result
    }
}

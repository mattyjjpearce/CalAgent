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
        
    

        let x = RecipieAPI(calories: 200, carbs: "5g", fat: "5g", id: 200, image: "imagelink", imageType: "imagetype", protein: "5g", title: "Dummy 1")
        let x2 = RecipieAPI(calories: 200, carbs: "5g", fat: "5g", id: 200, image: "imagelink", imageType: "imagetype", protein: "5g", title: "Dummy 2")

        nutrients.append(x)
        nutrients.append(x2)
        
 //       fetchNutrients()


    }
    
    func fetchNutrients() {
       
        let x = Int(self.person.personDailyCalorieGoals.fatGoal)

        NetworkServices.fetchNutrients(maxProtein: x , maxFat: 200,  maxCarbs: 300, number: 10) { (nutrients, error) in
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

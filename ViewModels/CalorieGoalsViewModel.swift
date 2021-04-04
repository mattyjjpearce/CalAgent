//
//  CalorieGoalsViewModel.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 02/04/2021.
//

import Foundation


class CalorieGoalsiewModel: ObservableObject {
    
    @Published var calorieGoals = [CalorieGoalEntity]()

    
    init() {
    //    print(fetchProgresses().count)

    }
    
    //Creating the data
    func addCalorieGoals(id: UUID, calorieGoal: Double, fatGoal: Double, carbGoal: Double, proteinGoal: Double) {
        CoreDataManager.shared.addCalorieGoalsData(id: id, calorieGoal: calorieGoal, fatGoal: fatGoal, proteinGoal: proteinGoal, carbGoal: carbGoal)   { (isAdded, error) in
            if let error = error {
                print(error)
            } else {
                print("Data has been added from addCalorieGoal VM")
            }
        }
    }
    
    //fetching the data
    func fetchCalorieGoals() -> [CalorieGoalEntity] {
        CoreDataManager.shared.fetchCalorieGoals { (calorieGoals, error) in
            if let error = error {
                print(error)
            }
            if let calorieGoals = calorieGoals as? [CalorieGoalEntity] {
                self.calorieGoals = calorieGoals
            }
        }
        return calorieGoals
    }
    
    func deleteUserData(){
        CoreDataManager.shared.deleteCalorieGoals()
    }
}

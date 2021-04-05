//
//  CalorieProgressViewModel.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 04/04/2021.
//

import Foundation


class CalorieProgressViewModel: ObservableObject {
    
    @Published var calorieProgress = [CalorieProgressEntity]()

    
    init() {

    }
    
    //Creating the data
    func addCalorieProgressData(id: UUID, calorieProgress: Double, fatProgress: Double, carbProgress: Double, proteinPogress: Double, created: Date) {
        CoreDataManager.shared.addCalorieProgressData(id: id, calorieProgress: calorieProgress, fatProgress: fatProgress, proteinProgress: proteinPogress, carbProgress: carbProgress, created: created){ (isAdded, error) in
            if let error = error {
                print(error)
            } else {
                print("Data has been added from addCalorieProgress VM")
            }
        }
    }
    
    //fetching the data
    func fetchCalorieGoals() -> [CalorieProgressEntity] {
        CoreDataManager.shared.fetchCalorieProgressData { (calorieProgress, error) in
            if let error = error {
                print(error)
            }
            if let calorieProgress = calorieProgress as? [CalorieProgressEntity] {
                self.calorieProgress = calorieProgress
            }
        }
        return calorieProgress
    }
    
    func deleteUserData(){
        CoreDataManager.shared.deleteCalorieProgress()
    }
}

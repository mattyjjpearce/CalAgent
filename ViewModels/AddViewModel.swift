//
//  AddViewModel.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 29/03/2021.
//

import Foundation

class AddViewModel: ObservableObject {
    
    @Published var userSettings = [CalorieProgress]()

    
    init() {
      //  fetchProgresses()
    }
    
    //Creating the data
    func addCalorieTrackerDate(id: UUID, firstName: String, height: Double, weight: Double, gender: String, age: Double, activityLevel: String, bmr: Double) {
        CoreDataManager.shared.addUserSettingsData(id: id, firstName: firstName, height: height, weight: weight, gender: gender, age: age, activityLevel: activityLevel, bmr: bmr) { (isAdded, error) in
            if let error = error {
                print(error)
            } else {
                print("Data has been added!")
            }
        }
    }
    
    //fetching the data
    func fetchProgresses() {
        CoreDataManager.shared.fetchCalorieTrackerData { (userSettings, error) in
            if let error = error {
                print(error)
            }
            if let userSettings = userSettings as? [CalorieProgress] {
                self.userSettings = userSettings
            }
        }
    }
}

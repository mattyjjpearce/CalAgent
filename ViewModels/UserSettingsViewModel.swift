//
//  AddViewModel.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 29/03/2021.
//

import Foundation

class UserSettingsViewModel: ObservableObject {
    
    @Published var userSettings = [UserSettings]()

    
    init() {
    //    print(fetchProgresses().count)

    }
    
    //Creating the data
    func addUserSettingData(id: UUID, firstName: String, height: Double, weight: Double, gender: String, age: Double, activityLevel: String, bmr: Double, useSteps: Bool) {
        CoreDataManager.shared.addUserSettingsData(id: id, firstName: firstName, height: height, weight: weight, gender: gender, age: age, activityLevel: activityLevel, bmr: bmr, useSteps: useSteps) { (isAdded, error) in
            if let error = error {
                print(error)
            } else {
                print("Data has been added!")
                print(gender)
            }
        }
    }
    
    //fetching the data
    func fetchUserSettingData() -> [UserSettings] {
        CoreDataManager.shared.fetchUserSettingData { (userSettings, error) in
            if let error = error {
                print(error)
            }
            if let userSettings = userSettings as? [UserSettings] {
                self.userSettings = userSettings
            }
        }
        return userSettings
    }
    
    func deleteUserData(){
        CoreDataManager.shared.deleteUserSettingData()
    }
}

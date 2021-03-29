//
//  AddViewModel.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 29/03/2021.
//

import Foundation

class AddViewModel: ObservableObject {
    
    @Published var progresses = [CalorieProgress]()
    
    init() {
        fetchProgresses()
    }
    
    func addCalorieTrackerDate(id: UUID, calorieProgress: Double, fatProgress: Double, carbProgress: Double, proteinProgress: Double) {
        CoreDataManager.shared.addCalorieTrackerData(id: id, calorieProgress: carbProgress, fatProgress: fatProgress, carbProgress: carbProgress, proteinProgress: proteinProgress) { (isAdded, error) in
            if let error = error {
                print(error)
            } else {
                print("Data has been added!")
            }
        }
    }
    
    func fetchProgresses() {
        CoreDataManager.shared.fetchCalorieTrackerData { (progresses, error) in
            if let error = error {
                print(error)
            }
            if let progresses = progresses as? [CalorieProgress] {
                self.progresses = progresses
            }
        }
    }
}

//
//  CoreDataManager.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 29/03/2021.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared: CoreDataManager = {
        let appDelegate = AppDelegate.instance!
        let instance = CoreDataManager(managedObjectContext: appDelegate.persistanceContainer.viewContext)
        return instance
    }()
    
    var managedContext: NSManagedObjectContext
    
  private init(managedObjectContext: NSManagedObjectContext) {
        managedContext = managedObjectContext
    }
}

//MARK:- CalorieTracker Insert/Update/Delete
extension CoreDataManager {
    
    func addUserSettingsData(id: UUID, firstName: String, height: Double, weight: Double, gender: String, age: Double, activityLevel: String, bmr: Double, useSteps: Bool, completionHandler: @escaping (_ succeed: Bool, _ error: Error?) -> Void) {
        let userSettingsEntity = NSEntityDescription.insertNewObject(forEntityName: "UserSettings", into: managedContext) as? UserSettings
        userSettingsEntity?.id = id
        userSettingsEntity?.firstName = firstName
        userSettingsEntity?.height = height
        userSettingsEntity?.weight = weight
        userSettingsEntity?.gender = gender
        userSettingsEntity?.age = age
        userSettingsEntity?.activityLevel = activityLevel
        userSettingsEntity?.bmr = bmr
        userSettingsEntity?.useSteps = useSteps
        
        print("Activity Level:", activityLevel)
        do {
            try managedContext.save()
            print("context saved")
            completionHandler(true, nil)
        } catch let error {
            completionHandler(false, error)
        }
    }
    
    func fetchUserSettingData(completionHandler: @escaping (_ succeed: Any?, _ error: Error?) -> Void) {
        var progresses = [UserSettings]()
        let progressRequest: NSFetchRequest<UserSettings> = NSFetchRequest<UserSettings>(entityName: "UserSettings")
        
        do {
            progresses = try managedContext.fetch(progressRequest)
            completionHandler(progresses, nil)
        } catch let error {
            completionHandler(nil, error)
        }
    }
    
    func deleteUserSettingData(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "UserSettings")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    
        do {
            try managedContext.execute(deleteRequest)
        } catch _ as NSError {
    }
    }
    
    
    func addCalorieGoalsData(id: UUID, calorieGoal: Double, fatGoal: Double, proteinGoal: Double, carbGoal: Double, completionHandler: @escaping (_ succeed: Bool, _ error: Error?) -> Void) {
        let calorieGoalEntity = NSEntityDescription.insertNewObject(forEntityName: "CalorieGoalEntity", into: managedContext) as? CalorieGoalEntity
        calorieGoalEntity?.id = id
        calorieGoalEntity?.calorieGoal = calorieGoal
        calorieGoalEntity?.fatGoal = fatGoal
        calorieGoalEntity?.proteinGoal = proteinGoal
        calorieGoalEntity?.carbGoal = carbGoal
       
        
        do {
            try managedContext.save()
            print("context saved for add calorieGoal")
            completionHandler(true, nil)
        } catch let error {
            completionHandler(false, error)
        }
    }
    
    func fetchCalorieGoals(completionHandler: @escaping (_ succeed: Any?, _ error: Error?) -> Void) {
        var goals = [CalorieGoalEntity]()
        let calorieGoalRequest: NSFetchRequest<CalorieGoalEntity> = NSFetchRequest<CalorieGoalEntity>(entityName: "CalorieGoalEntity")
        
        do {
            goals = try managedContext.fetch(calorieGoalRequest)
            completionHandler(goals, nil)
        } catch let error {
            completionHandler(nil, error)
        }
    }
    
    func deleteCalorieGoals(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CalorieGoalEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    
        do {
            try managedContext.execute(deleteRequest)
            print("Deleted from data manager successful")
        } catch _ as NSError {
    }
    }
    
    
    
    func addCalorieProgressData(id: UUID, calorieProgress: Double, fatProgress: Double, proteinProgress: Double, carbProgress: Double, created: Date, completionHandler: @escaping (_ succeed: Bool, _ error: Error?) -> Void) {
        let calorieProgressEntity = NSEntityDescription.insertNewObject(forEntityName: "CalorieProgressEntity", into: managedContext) as? CalorieProgressEntity
        calorieProgressEntity?.id = id
        calorieProgressEntity?.calorieProgress = calorieProgress
        calorieProgressEntity?.fatProgress = fatProgress
        calorieProgressEntity?.proteinProgress = proteinProgress
        calorieProgressEntity?.carbProgress = carbProgress
        calorieProgressEntity?.created = created

       
        
        do {
            try managedContext.save()
            print("context saved for add calorieGoal")
            completionHandler(true, nil)
        } catch let error {
            completionHandler(false, error)
        }
    }
    
    func fetchCalorieProgressData(completionHandler: @escaping (_ succeed: Any?, _ error: Error?) -> Void) {
        var goals = [CalorieProgressEntity]()
        let calorieGoalRequest: NSFetchRequest<CalorieProgressEntity> = NSFetchRequest<CalorieProgressEntity>(entityName: "CalorieProgressEntity")
        
        do {
            goals = try managedContext.fetch(calorieGoalRequest)
            completionHandler(goals, nil)
        } catch let error {
            completionHandler(nil, error)
        }
    }
    
    func deleteCalorieProgress(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CalorieProgressEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    
        do {
            try managedContext.execute(deleteRequest)
            print("Deleted from data manager successful")
        } catch _ as NSError {
    }
    }
    
    
}

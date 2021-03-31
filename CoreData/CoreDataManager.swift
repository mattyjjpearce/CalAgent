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
    
    init(managedObjectContext: NSManagedObjectContext) {
        managedContext = managedObjectContext
    }
}

//MARK:- CalorieTracker Insert/Update/Delete
extension CoreDataManager {
    func addUserSettingsData(id: UUID, firstName: String, height: Double, weight: Double, gender: String, age: Double, activityLevel: String, bmr: Double, completionHandler: @escaping (_ succeed: Bool, _ error: Error?) -> Void) {
        let userSettingsEntity = NSEntityDescription.insertNewObject(forEntityName: "UserSettings", into: managedContext) as? UserSettings
        userSettingsEntity?.id = id
        userSettingsEntity?.firstName = firstName
        userSettingsEntity?.height = height
        userSettingsEntity?.weight = weight
        userSettingsEntity?.gender = gender
        userSettingsEntity?.age = age
        userSettingsEntity?.activityLevel = activityLevel
        userSettingsEntity?.bmr = bmr
        
        do {
            try managedContext.save()
            completionHandler(true, nil)
        } catch let error {
            completionHandler(false, error)
        }
    }
    
    func fetchCalorieTrackerData(completionHandler: @escaping (_ succeed: Any?, _ error: Error?) -> Void) {
        var progresses = [UserSettings]()
        let progressRequest: NSFetchRequest<UserSettings> = NSFetchRequest<UserSettings>(entityName: "UserSetitngs")
        
        do {
            progresses = try managedContext.fetch(progressRequest)
            completionHandler(progresses, nil)
        } catch let error {
            completionHandler(nil, error)
        }
    }
}

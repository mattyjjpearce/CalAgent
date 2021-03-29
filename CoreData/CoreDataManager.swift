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
    func addCalorieTrackerData(id: UUID, calorieProgress: Double, fatProgress: Double, carbProgress: Double, proteinProgress: Double, completionHandler: @escaping (_ succeed: Bool, _ error: Error?) -> Void) {
        let calorieProgressEntity = NSEntityDescription.insertNewObject(forEntityName: "CalorieProgress", into: managedContext) as? CalorieProgress
        calorieProgressEntity?.id = id
        calorieProgressEntity?.calorieProgress = calorieProgress
        calorieProgressEntity?.fatProgress = fatProgress
        calorieProgressEntity?.carbProgress = carbProgress
        calorieProgressEntity?.proteinProgress = proteinProgress
        calorieProgressEntity?.createdAt = Date()
        
        do {
            try managedContext.save()
            completionHandler(true, nil)
        } catch let error {
            completionHandler(false, error)
        }
    }
    
    func fetchCalorieTrackerData(completionHandler: @escaping (_ succeed: Any?, _ error: Error?) -> Void) {
        var progresses = [CalorieProgress]()
        let progressRequest: NSFetchRequest<CalorieProgress> = NSFetchRequest<CalorieProgress>(entityName: "CalorieProgress")
        
        do {
            progresses = try managedContext.fetch(progressRequest)
            completionHandler(progresses, nil)
        } catch let error {
            completionHandler(nil, error)
        }
    }
}

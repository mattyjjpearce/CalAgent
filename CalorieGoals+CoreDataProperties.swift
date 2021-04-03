//
//  CalorieGoals+CoreDataProperties.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 02/04/2021.
//
//

import Foundation
import CoreData


extension CalorieGoals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CalorieGoals> {
        return NSFetchRequest<CalorieGoals>(entityName: "CalorieGoals")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var calorieGoal: Double
    @NSManaged public var fatGoal: Double
    @NSManaged public var carbGoal: Double
    @NSManaged public var proteinGoal: Double

}

extension CalorieGoals : Identifiable {

}

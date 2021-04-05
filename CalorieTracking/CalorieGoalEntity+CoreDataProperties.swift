//
//  CalorieGoalEntity+CoreDataProperties.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 04/04/2021.
//
//

import Foundation
import CoreData


extension CalorieGoalEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CalorieGoalEntity> {
        return NSFetchRequest<CalorieGoalEntity>(entityName: "CalorieGoalEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var calorieGoal: Double
    @NSManaged public var fatGoal: Double
    @NSManaged public var carbGoal: Double
    @NSManaged public var proteinGoal: Double

}

extension CalorieGoalEntity : Identifiable {

}

//
//  CalorieProgressEntity+CoreDataProperties.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 04/04/2021.
//
//

import Foundation
import CoreData


extension CalorieProgressEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CalorieProgressEntity> {
        return NSFetchRequest<CalorieProgressEntity>(entityName: "CalorieProgressEntity")
    }

    @NSManaged public var calorieProgress: Double
    @NSManaged public var fatProgress: Double
    @NSManaged public var carbProgress: Double
    @NSManaged public var proteinProgress: Double
    @NSManaged public var created: Date?
    @NSManaged public var id: UUID?

}

extension CalorieProgressEntity : Identifiable {

}

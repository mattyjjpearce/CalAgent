//
//  CalorieProgress+CoreDataProperties.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 03/04/2021.
//
//

import Foundation
import CoreData


extension CalorieProgress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CalorieProgress> {
        return NSFetchRequest<CalorieProgress>(entityName: "CalorieProgress")
    }

    @NSManaged public var calorieProgress: Double
    @NSManaged public var carbProgress: Double
    @NSManaged public var fatProgress: Double
    @NSManaged public var id: UUID?
    @NSManaged public var proteinProgress: Double

}

extension CalorieProgress : Identifiable {

}

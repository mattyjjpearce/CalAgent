//
//  NewEntity+CoreDataProperties.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 04/04/2021.
//
//

import Foundation
import CoreData


extension NewEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewEntity> {
        return NSFetchRequest<NewEntity>(entityName: "NewEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var calorie: Double

}

extension NewEntity : Identifiable {

}

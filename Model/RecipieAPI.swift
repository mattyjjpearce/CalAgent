//
//  EntryAPI.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 16/03/2021.
//

import Foundation


struct RecipieAPI: Codable  {
    var title : String
    var imageURL : String
    var timeRequired : Int
    var sourceURL : String
    var ingredients : [String]
    var instructions : [String]
    var servings: Int
}



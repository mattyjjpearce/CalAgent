//
//  EntryAPI.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 16/03/2021.
//

import Foundation


struct RecipieAPI: Codable  {
    var calories : Int
    var carbs : String
    var fat : String
    var id : Int
    var image : String
    var imageType : String
    var protein : String
    var title: String
}



//
//  FoodAddModel.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 09/03/2021.
//

import Foundation


import SwiftUI

struct AddedFoods:Identifiable{
    var name: String = ""
    var totalCals: Double = 0
    var totalProtein: Double = 0
    var totalCarbs: Double = 0
    var totalFat: Double = 0
    var id = UUID().uuidString
   //Your other properties
}


class FoodAddModel: ObservableObject,Identifiable {
    
    @Published var foods : [AddedFoods]?
    
    var id = UUID().uuidString

    init() {
        dummyData()
    }
    
    func dummyData() {
        var obj:[AddedFoods] = []
        obj.append(AddedFoods(name: "Pasta", totalCals: 340, totalProtein: 20, totalCarbs: 45, totalFat: 15))
        obj.append(AddedFoods(name: "Chicken", totalCals: 560, totalProtein: 20, totalCarbs: 45, totalFat: 15))
        obj.append(AddedFoods(name: "Apple", totalCals: 54, totalProtein: 20, totalCarbs: 45, totalFat: 15))
        obj.append(AddedFoods(name: "Noodles", totalCals: 231, totalProtein: 20, totalCarbs: 45, totalFat: 15))
        foods = obj
    }
}

struct myView:View{
    @EnvironmentObject var getFood:FoodAddModel

    var unwrappedFoods:[AddedFoods]{
        getFood.foods ?? []
    }
    
    var body: some View{
        NavigationView{
        List{
        ForEach(unwrappedFoods) {obj in
            Text(obj.name)
        }
        }
    }
    }
}

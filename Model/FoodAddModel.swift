//
//  FoodAddModel.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 09/03/2021.
//

import Foundation


import SwiftUI

//Defining the structure of AddedFoods
struct AddedFoods:Identifiable{
    var name: String = ""
    var totalCals: Double = 0
    var totalProtein: Double = 0
    var totalCarbs: Double = 0
    var totalFat: Double = 0
    var id = UUID().uuidString
}


class FoodAddModel: ObservableObject,Identifiable {
    
    @Published var foods : [AddedFoods]?
    
    @ObservedObject var calorieProgressViewModel: CalorieProgressViewModel = CalorieProgressViewModel()

    var id = UUID().uuidString

    init() {
            dummyData()
            
        }
        
        func dummyData() {
            var obj:[AddedFoods] = []
            foods = obj
        }
}



//View displaying the list of foods that have been added throughout the day 
struct FoodView:View{
    @EnvironmentObject var getFood:FoodAddModel
    @EnvironmentObject var person: UserInfoModel

    var unwrappedFoods:[AddedFoods]{
        getFood.foods ?? []
    }
    
    
    @ObservedObject var calorieProgressViewModel: CalorieProgressViewModel = CalorieProgressViewModel()

    
    var body: some View{
        
        List{
        ForEach(Array(unwrappedFoods.enumerated()), id: \.1.id) { (index, obj) in
            VStack{
                HStack{
                    Text(obj.name).foregroundColor(.black)
                    Spacer()
                    Button(action: {
                        getFood.foods?.remove(at: index) //removing that individual food
                     
                        //Changing the environment object to display the new correct values
                        person.personCurrentCalorieProgress.calorieProgress -=  obj.totalCals //removing macros to progress when food is deleted
                        person.personCurrentCalorieProgress.fatProgress -=  obj.totalFat
                        person.personCurrentCalorieProgress.proteinProgress -=  obj.totalProtein
                        person.personCurrentCalorieProgress.carbProgress -=  obj.totalCarbs
                        
                        //deleteing info from core-data
                        calorieProgressViewModel.deleteUserData()
                        
                        //adding new info to core-data 
                        calorieProgressViewModel.addCalorieProgressData(id: UUID(), calorieProgress:  person.personCurrentCalorieProgress.calorieProgress, fatProgress:  person.personCurrentCalorieProgress.fatProgress, carbProgress:  person.personCurrentCalorieProgress.carbProgress, proteinPogress:  person.personCurrentCalorieProgress.proteinProgress, created: Date())
                   
                    }) {
                        Image(systemName: "minus.square.fill").foregroundColor(.red)
                            .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }.buttonStyle(PlainButtonStyle())
                    }
                Text("Kcals: \(obj.totalCals, specifier: "%.0f") F: \(obj.totalFat, specifier: "%.0f") C: \(obj.totalCarbs, specifier: "%.0f") P: \(obj.totalProtein, specifier: "%.0f")").font(.system(size: 16)).foregroundColor(.black)
            }
                        
    
                }
        }.accessibility(identifier: "foodListIdentifier")
       
    }
      
    }

   
    





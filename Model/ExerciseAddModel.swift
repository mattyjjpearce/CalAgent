//
//  ExerciseAddModel.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 11/03/2021.
//

import Foundation
import SwiftUI

struct AddedExercises:Identifiable{
    var name: String = ""
    var totalCals: Double = 0
    var id = UUID().uuidString
}


//View displaying a list of all exercises the user has added
class ExerciseAddModel: ObservableObject,Identifiable {
    
    @Published var exercises : [AddedExercises]?
    
    @ObservedObject var calorieProgressViewModel: CalorieProgressViewModel = CalorieProgressViewModel()


    var id = UUID().uuidString
}

struct DeleteExerciseView:View{
    @EnvironmentObject var getExercises:ExerciseAddModel
    @EnvironmentObject var person: UserInfoModel

    var unwrappedExercises:[AddedExercises]{
        getExercises.exercises ?? []
    }
    @ObservedObject var calorieProgressViewModel: CalorieProgressViewModel = CalorieProgressViewModel()

    var body: some View{
        
        List{
        ForEach(Array(unwrappedExercises.enumerated()), id: \.1.id) { (index, obj) in
            VStack{
                HStack{
                    Text(obj.name).foregroundColor(.black)
                    Spacer()
                    Button(action: {
                        getExercises.exercises?.remove(at: index) //removing the exercise at that index
                        
                        //changing the environment object to display the correct values
                        person.personCurrentCalorieProgress.calorieProgress +=  obj.totalCals
                        
                        //Deleting the data from core-data
                        calorieProgressViewModel.deleteUserData()
                        
                        //Adding the new values to core-data
                        calorieProgressViewModel.addCalorieProgressData(id: UUID(), calorieProgress:  person.personCurrentCalorieProgress.calorieProgress, fatProgress:  person.personCurrentCalorieProgress.fatProgress, carbProgress:  person.personCurrentCalorieProgress.carbProgress, proteinPogress:  person.personCurrentCalorieProgress.proteinProgress, created: Date())
               
                    }) {
                        Image(systemName: "minus.square.fill").foregroundColor(.red)
                            .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }.buttonStyle(PlainButtonStyle())
                    }
                Text("Kcals: \(obj.totalCals, specifier: "%.0f")").font(.system(size: 16)).foregroundColor(.black)
            }
                }
            }
    }
}
      

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
   //Your other properties
}


class ExerciseAddModel: ObservableObject,Identifiable {
    
    @Published var exercises : [AddedExercises]?

    var id = UUID().uuidString

    init() {
        dummyData()
        
    }
    
    func dummyData() {
        var obj:[AddedExercises] = []
        obj.append(AddedExercises(name: "Morning run", totalCals: 340))
        obj.append(AddedExercises(name: "Walk", totalCals: 340))

        exercises = obj
    }
    
    

}

struct DeleteExerciseView:View{
    @EnvironmentObject var getExercises:ExerciseAddModel
    @EnvironmentObject var person: UserInfoModel

    var unwrappedExercises:[AddedExercises]{
        getExercises.exercises ?? []
    }
    
    var body: some View{
        
        List{
        ForEach(Array(unwrappedExercises.enumerated()), id: \.1.id) { (index, obj) in
            VStack{
                HStack{
                    Text(obj.name).foregroundColor(.black)
                    Spacer()
                    Button(action: {
                        getExercises.exercises?.remove(at: index)
                        person.personCurrentCalorieProgress.calorieProgress -=  obj.totalCals //showing how to work this
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
      

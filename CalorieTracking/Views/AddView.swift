//
//  ProgressView.swift
//  navigationPractice
//
//  Created by Matthew Pearce on 26/11/2020.
//

import SwiftUI
import Combine


struct AddView: View{
    
    @Environment(\.managedObjectContext) private var viewContext
    
    
    private var healthStore: HealthStore?

    
    @ObservedObject var viewModel: UserSettingsViewModel = UserSettingsViewModel()
    @ObservedObject var calorieProgressViewModel: CalorieProgressViewModel = CalorieProgressViewModel()
    @ObservedObject var calorieGoalViewModel: CalorieGoalsiewModel = CalorieGoalsiewModel()

    
    @EnvironmentObject var person: UserInfoModel
    @StateObject var foods: FoodAddModel
    @StateObject var exercises: ExerciseAddModel

    @State private var showingSheet1 = false
    @State private var showingSheet2 = false

    
    @State private var newFoodNameString = ""
    @State private var newFoodFatString = ""
    @State private var newFoodProteinString = ""
    @State private var newFoodCarbString = ""

    @State private var newExerciseNameString = ""
    @State private var newExerciseCals = ""
    
  


    init() {
            _foods = StateObject(wrappedValue: FoodAddModel())
            _exercises = StateObject(wrappedValue: ExerciseAddModel())
        _ = calorieProgressViewModel.fetchCalorieGoals()
      
        healthStore = HealthStore()

        }
    
    var body: some View {
        VStack{
            Form{
                Section(header: Text("Add Food / Meals")){
                    TextField("Food Title ", text: $newFoodNameString)
                   
                    
                    TextField("Fat", text: $newFoodFatString).onReceive(Just(newFoodFatString)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.newFoodFatString = filtered
                        }
}
    
                    TextField("Carbs", text: $newFoodCarbString).onReceive(Just(newFoodCarbString)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.newFoodCarbString = filtered
                        }
}
                    
                    
                    
                    TextField("Protein", text: $newFoodProteinString).onReceive(Just(newFoodProteinString)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.newFoodProteinString = filtered
                        }
}
                    
                    Button(action: {
                        
                        if(newFoodProteinString != "" || newFoodCarbString != "" || newFoodFatString != "" ){
                        
                        //converting the input from type string to Double
                        let fatDouble: Double! = Double(newFoodFatString)
                        let carbDouble: Double! = Double(newFoodCarbString)
                        let proteinDouble: Double! = Double(newFoodProteinString)
                
                     
                            let nutritionFunction = nutritionFunctions() //creating a nutritionObject to use cals function
                            let cals = nutritionFunction.macrosToCals(fat: fatDouble, protein: carbDouble, carbs: proteinDouble)
          
                        let newAddedFood = AddedFoods(name: newFoodNameString, totalCals: cals, totalProtein: proteinDouble, totalCarbs: carbDouble, totalFat: fatDouble)
                        
                        foods.foods?.append(newAddedFood)
                            
                        person.personCurrentCalorieProgress.calorieProgress +=  cals
                        person.personCurrentCalorieProgress.fatProgress +=  fatDouble
                        person.personCurrentCalorieProgress.proteinProgress +=  proteinDouble
                        person.personCurrentCalorieProgress.carbProgress +=  carbDouble
                            
                                                    
                            
                            calorieProgressViewModel.deleteUserData()
                            
                            calorieProgressViewModel.addCalorieProgressData(id: UUID(), calorieProgress:  person.personCurrentCalorieProgress.calorieProgress, fatProgress:  person.personCurrentCalorieProgress.fatProgress, carbProgress:  person.personCurrentCalorieProgress.carbProgress, proteinPogress:  person.personCurrentCalorieProgress.proteinProgress, created: Date())
                           
                            newFoodProteinString = ""
                            newFoodFatString = ""
                            newFoodNameString = ""
                            newFoodCarbString = ""

                   
                        }
                        
                        hideKeyboard()


                    }) {
                        Text("Enter").multilineTextAlignment(.center)
                            .foregroundColor(Color.blue)
                    
                    
                }
                    Button("Delete Foods"){
                        self.showingSheet1.toggle()
                    }.sheet(isPresented: $showingSheet1, content: {
                                DeleteFoodView().environmentObject(foods)
                                    
                        
                    })
                    .foregroundColor(.red)
                
                }
                Section(header: Text("Add Exercises")
                
                ){
                    
                    TextField("Exercise Title ", text: $newExerciseNameString)
                    
                    TextField("Total Cals", text: $newExerciseCals).onReceive(Just(newExerciseCals)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.newExerciseCals = filtered
                        }
}
                    Button(action: {
                        
                        if(newExerciseCals != ""){
                        
                        //converting the input from type string to Double
                        
                        let exerciseCal: Double! = Double(newExerciseCals)
                
                        let newAddedExercise = AddedExercises(name: newExerciseNameString, totalCals: exerciseCal)
                        
                        exercises.exercises?.append(newAddedExercise)
                        
                        person.personCurrentCalorieProgress.calorieProgress -=  exerciseCal //showing how to work this
                           
                            calorieProgressViewModel.deleteUserData()
                            calorieProgressViewModel.addCalorieProgressData(id: UUID(), calorieProgress:  person.personCurrentCalorieProgress.calorieProgress, fatProgress:  person.personCurrentCalorieProgress.fatProgress, carbProgress:  person.personCurrentCalorieProgress.carbProgress, proteinPogress:  person.personCurrentCalorieProgress.proteinProgress, created: Date())
                            
                        newExerciseNameString = ""
                        newExerciseCals = "" //resetting the local variable
                        
                        }
                        hideKeyboard()


                    }) {
                        Text("Enter").multilineTextAlignment(.center)
                            .foregroundColor(Color.blue)
                    }
                    Button("Delete Exercises"){
                        self.showingSheet2.toggle()
                    }.sheet(isPresented: $showingSheet2, content: {
                                DeleteExerciseView().environmentObject(exercises)
                                    
                        
                    })
                    .foregroundColor(.red)
                }
                
                Section(header: Text("Today's Step Count")){
                    Form{
                        Text("Step Count: \(person.personSteps.steps) ")
                        Text("Calories burnt from Steps: \(person.personSteps.calories)" )
                        Button("Add to daily Calories"){
                            person.personSteps.addCalories = true 
                        }
                        .foregroundColor(.blue)
                        
                        

                    }
                }
        
        }
        }
        
        
    }
}

struct secondView:View{
    var body: some View{
        Text("Hi")
    }
}




struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}

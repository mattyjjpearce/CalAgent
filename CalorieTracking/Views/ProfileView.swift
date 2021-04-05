//
//  ProfileView.swift
//  navigationPractice
//
//  Created by Matthew Pearce on 26/11/2020.
//

import HealthKit
import SwiftUI
import Combine //to use Just

struct ProfileView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var userSettingViewModel: UserSettingsViewModel = UserSettingsViewModel()
    @ObservedObject var calorieGoalViewModel: CalorieGoalsiewModel = CalorieGoalsiewModel()
    @ObservedObject var calorieProgressViewModel: CalorieProgressViewModel = CalorieProgressViewModel()


    @EnvironmentObject var person: UserInfoModel
    
    @State private var showingSheet1 = false


    @State private var fatInputString = ""
    @State private var carbInputString = ""
    @State private var proteinInputString = ""
    
    @State private var ageInputString = ""
    @State private var heightInputString = ""
    @State private var weightInputString = ""


    @State var selectedGender = 0.00
    let genders = ["Male", "Female"]

    @State var activityLevel = ["Low", "Medium", "High"]
    @State var selectedActivityLevel = 0.00
    @State var chosenActivityLevel = ""
   
    @State var BMR = 0.00
    
    @State var userName = ""
    
    

    
    
    init(){
        _ = userSettingViewModel.fetchUserSettingData()
        _ = calorieGoalViewModel.fetchCalorieGoals()
        _ = calorieProgressViewModel.fetchCalorieGoals()
    }
   
    
    var body: some View {
        
        VStack{ //vertical stack for the form
            Form{
                Section{
                    TextField("Name: \(person.personUserInfo.firstName)" , text: $userName)
                   // Text("Caloric needs: \(self.person.personUserInfo.bmr, specifier: "%.0f") Kcal")
                    Text("Caloric needs: \(person.personUserInfo.bmr, specifier: "%.0f") Kcal")

            }
               
                

                

                Section(header: Text("Personal Settings")){
                VStack{ //manual input (fat)
                    TextField("Age: \(person.personUserInfo.age, specifier: "%.0f")", text: $ageInputString ).keyboardType(.numberPad)
                        .onReceive(Just(ageInputString)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.ageInputString = filtered
                                        }
                        }
                }
                VStack{ //manual input (carbs
                    TextField("Height: \(person.personUserInfo.height, specifier: "%.0f")cm", text: $heightInputString ).keyboardType(.numberPad)
                        .onReceive(Just(heightInputString)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.heightInputString = filtered
                                        }
                }
  
                }
                VStack{ //manual input (carbs
                    TextField("Weight: \(person.personUserInfo.weight, specifier: "%.0f")kg", text: $weightInputString ).keyboardType(.numberPad)
                        .onReceive(Just(weightInputString)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.weightInputString = filtered
                                        }
                        }
                    
                }
                    HStack {
                        Text("Select Gender")
                        Picker("", selection: $selectedGender) {

                            ForEach(0..<genders.count) { index in
                                Text(self.genders[index]).tag(index).font(.title)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    HStack {
                        Text("Activity Level")
                        Button("") {
                            self.showingSheet1.toggle()
                        }
                        Image(systemName: "info.circle").foregroundColor(.blue)
                        .sheet(isPresented: $showingSheet1, content: {
                            List{
                            Text("Low: little or no exercise")
                            Text("Medium: moderate exercise 3-5 days/week")
                            Text("High: hard exercise 6-7 days/week")
                            }
                                
                        })
                        .foregroundColor(.black)
                            
                        Picker("", selection: $selectedActivityLevel) {

                            ForEach(0..<activityLevel.count) { index in
                                Text(self.activityLevel[index]).tag(index).font(.title)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    
                    

         
                Button(action: {
                    
                    
                        //Checking that the textFields are not empty
                    if(ageInputString != "" || heightInputString != "" || weightInputString != ""){
                    
                    person.personUserInfo.firstName = userName
                        //converting the input from type string to Double
                    let ageDouble: Double! = Double(ageInputString)
                    person.personUserInfo.age = ageDouble
                    let heightDouble: Double! = Double(heightInputString)
                    person.personUserInfo.height = heightDouble
                    let weightDouble: Double! = Double(weightInputString)
                    person.personUserInfo.weight = weightDouble
                    
                        if(selectedGender == 0){
                            person.personUserInfo.gender = "Male"
                            let weightBMR = (weightDouble * 10)
                            let heightBMR = (heightDouble *  6.25)
                            let ageBMR = (ageDouble * 5)
                            let bmr = 5 + weightBMR + heightBMR - ageBMR
                            BMR = bmr
                                
                            
                            
                        }else{
                            person.personUserInfo.gender = "Female"
                            let weightBMR = (weightDouble * 10)
                            let heightBMR = (heightDouble *  6.25)
                            let ageBMR = (ageDouble * 5)
                            let bmr = weightBMR + heightBMR - ageBMR - 161
                            BMR = bmr
                            }
                        
                        switch selectedActivityLevel {
                        case 0:
                            person.personUserInfo.activityLevel = "Low"
                            chosenActivityLevel = "Low"

                            BMR = 1.2 * BMR
                        case 1:
                            person.personUserInfo.activityLevel = "Medium"
                            chosenActivityLevel = "Medium"

                            BMR = 1.55 * BMR
                        case 2:
                            person.personUserInfo.activityLevel = "High"
                            chosenActivityLevel = "High"
                            BMR = 1.725 * BMR
                        default:
                            ""
                        }
                        
                        hideKeyboard()
                        person.personUserInfo.firstName = userName
                        person.personUserInfo.bmr = BMR
                        
                        userSettingViewModel.deleteUserData()
                      
                 
                       
                        userSettingViewModel.addUserSettingData(id: UUID(), firstName: person.personUserInfo.firstName, height: person.personUserInfo.height, weight: person.personUserInfo.weight, gender: person.personUserInfo.gender, age: person.personUserInfo.age, activityLevel: person.personUserInfo.activityLevel, bmr: person.personUserInfo.bmr)
                        
                        
                     }
                    
                 

                }) {
                    Text("Enter").multilineTextAlignment(.center)
                        .foregroundColor(Color.blue)
                }
                
            }
                
                
                
                
                Section(header: Text("Macro Goals: \(person.personDailyCalorieGoals.calorieGoal, specifier: "%.0f") kcal")){
                        VStack{ //manual input (fat)
                            TextField("Fat Goal: \(person.personDailyCalorieGoals.fatGoal, specifier: "%.0f")g", text: $fatInputString ).keyboardType(.numberPad)
                                .onReceive(Just(fatInputString)) { newValue in
                                                let filtered = newValue.filter { "0123456789".contains($0) }
                                                if filtered != newValue {
                                                    self.fatInputString = filtered
                                                }
                                }
                        }
                        VStack{ //manual input (carbs
                            TextField("Carb Goal: \(person.personDailyCalorieGoals.carbGoal, specifier: "%.0f")g", text: $carbInputString ).keyboardType(.numberPad)
                                .onReceive(Just(carbInputString)) { newValue in
                                                let filtered = newValue.filter { "0123456789".contains($0) }
                                                if filtered != newValue {
                                                    self.carbInputString = filtered
                                                }
                        }
                          
                        }
                        VStack{ //manual input (carbs

                            TextField("Protein Goal: \(person.personDailyCalorieGoals.proteinGoal, specifier: "%.0f")g", text: $proteinInputString ).keyboardType(.numberPad)
                                .onReceive(Just(proteinInputString)) { newValue in
                                                let filtered = newValue.filter { "0123456789".contains($0) }
                                                if filtered != newValue {
                                                    self.proteinInputString = filtered
                                                }
                                }
                        }
                        Button(action: {
                            //converting the input from type string to Double
                            if(fatInputString == "" ){
                            person.personDailyCalorieGoals.fatGoal = person.personDailyCalorieGoals.fatGoal
                            }
                            else{
                                let fatDouble: Double! = Double(fatInputString)
                                person.personDailyCalorieGoals.fatGoal = fatDouble
                            }
                            
                            if(carbInputString == "" ){
                            person.personDailyCalorieGoals.carbGoal = person.personDailyCalorieGoals.carbGoal
                            }
                            else{
                                let carbDouble: Double! = Double(carbInputString)
                                person.personDailyCalorieGoals.carbGoal = carbDouble
                            }
                            
                            if(proteinInputString == "" ){
                            person.personDailyCalorieGoals.proteinGoal = person.personDailyCalorieGoals.proteinGoal
                            }else{
                                let proteinDouble: Double! = Double(proteinInputString)
                                person.personDailyCalorieGoals.proteinGoal = proteinDouble
                            }
                            

                      
                            
                            let fatCalories = person.personDailyCalorieGoals.fatGoal * 9
                            let carbCalories = person.personDailyCalorieGoals.carbGoal * 4
                            let proteinCalories = person.personDailyCalorieGoals.proteinGoal * 4
                            let totalCalorieGoal = fatCalories + carbCalories + proteinCalories
                            
                            person.personDailyCalorieGoals.calorieGoal = totalCalorieGoal
                            
                            
                            calorieGoalViewModel.deleteUserData()
                            calorieGoalViewModel.addCalorieGoals(id: UUID(), calorieGoal: person.personDailyCalorieGoals.calorieGoal, fatGoal: person.personDailyCalorieGoals.fatGoal, carbGoal: person.personDailyCalorieGoals.fatGoal, proteinGoal: person.personDailyCalorieGoals.proteinGoal)
                            
                            
                            hideKeyboard()
                            
                        }) {
                            Text("Enter").multilineTextAlignment(.center)
                                .foregroundColor(Color.blue)
                        }
                    }
            }
        }.onAppear(){
           
            _ = calorieProgressViewModel.fetchCalorieGoals()
            _ = userSettingViewModel.fetchUserSettingData()
            
            
            if(!userSettingViewModel.userSettings.isEmpty){ //if there is no values in viewmodel
                
                _ = userSettingViewModel.fetchUserSettingData()
                person.personUserInfo.firstName = userSettingViewModel.userSettings.first!.firstName ?? ""
                person.personUserInfo.bmr = userSettingViewModel.userSettings.first!.bmr
                person.personUserInfo.age = userSettingViewModel.userSettings.first!.age
                person.personUserInfo.weight = userSettingViewModel.userSettings.first!.weight
                person.personUserInfo.height = userSettingViewModel.userSettings.first!.height
               

            }


            
            if(!calorieGoalViewModel.calorieGoals.isEmpty){ //if there is no values in viewmodel
                
                _ = calorieGoalViewModel.fetchCalorieGoals()
            person.personDailyCalorieGoals.calorieGoal = calorieGoalViewModel.calorieGoals.first!.calorieGoal
            person.personDailyCalorieGoals.fatGoal = calorieGoalViewModel.calorieGoals.first!.fatGoal
            person.personDailyCalorieGoals.proteinGoal = calorieGoalViewModel.calorieGoals.first!.proteinGoal
            person.personDailyCalorieGoals.carbGoal = calorieGoalViewModel.calorieGoals.first!.carbGoal
            }
            
            
            if(calorieProgressViewModel.calorieProgress.isEmpty){
                calorieProgressViewModel.addCalorieProgressData(id: UUID(), calorieProgress: 0.00, fatProgress: 0.00, carbProgress: 0.00, proteinPogress: 0.00, created: Date())
                
                _ = calorieProgressViewModel.fetchCalorieGoals()
                
                person.personCurrentCalorieProgress.calorieProgress = calorieProgressViewModel.calorieProgress.first!.calorieProgress
                person.personCurrentCalorieProgress.fatProgress = calorieProgressViewModel.calorieProgress.first!.fatProgress
                person.personCurrentCalorieProgress.carbProgress = calorieProgressViewModel.calorieProgress.first!.carbProgress
                person.personCurrentCalorieProgress.proteinProgress = calorieProgressViewModel.calorieProgress.first!.proteinProgress
                
            }
            else{
                person.personCurrentCalorieProgress.calorieProgress = calorieProgressViewModel.calorieProgress.first!.calorieProgress
                person.personCurrentCalorieProgress.fatProgress = calorieProgressViewModel.calorieProgress.first!.fatProgress
                person.personCurrentCalorieProgress.carbProgress = calorieProgressViewModel.calorieProgress.first!.carbProgress
                person.personCurrentCalorieProgress.proteinProgress = calorieProgressViewModel.calorieProgress.first!.proteinProgress
                print("is not empty")
                print("checking data model:", person.personCurrentCalorieProgress.calorieProgress)


            }
        }
    }
    
}

#if canImport(UIKit)
extension View {
    
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

//Debugging preview


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView() //call the view we want to display
    }
}


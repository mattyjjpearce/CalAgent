//
//  ProfileView.swift
//  navigationPractice
//
//  Created by Matthew Pearce on 26/11/2020.
//

import HealthKit
import SwiftUI
import Combine

struct ProfileView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var userSettingViewModel: UserSettingsViewModel = UserSettingsViewModel()
    @ObservedObject var calorieGoalViewModel: CalorieGoalsiewModel = CalorieGoalsiewModel()
    @ObservedObject var calorieProgressViewModel: CalorieProgressViewModel = CalorieProgressViewModel()

    
    @EnvironmentObject var person: UserInfoModel
    
    @State private var userInfoIssue = false

    
    @State private var showingSheet1 = false
    
    @State private var showSheetStepsInfo = false

    @State private var showingSheetGender = false
    
    @State private var showingSheetActivity = false

    @State private var showingSteps = false

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
    @State var selectedSteps = 0.00
    @State var stepsLevel = ["No", "Yes"]
    
    @State var calorieGoalWithSteps = 0.00



    @State var chosenActivityLevel = ""
   
    @State var BMR = 0.00
    
    @State var userName = ""
    
    private var healthStore: HealthStore?
    
    init(){
        _ = userSettingViewModel.fetchUserSettingData()
        _ = calorieGoalViewModel.fetchCalorieGoals()
        _ = calorieProgressViewModel.fetchCalorieGoals()
        healthStore = HealthStore()
        
   //    UITableView.appearance().backgroundColor = .clear  - uncomment if wanting to change background colour of view

    }
    
    var body: some View {
        
            Form{
                Section{
                    TextField("Name: \(person.personUserInfo.firstName)" , text: $userName).accessibility(identifier: "personNameTextField")
                    Text("Caloric needs: \(person.personUserInfo.bmr, specifier: "%.0f") Kcal")
                }
                Section(header: Text("Activity Level:")){
                    HStack {
                        Text("Activity Level")
                        Button("") {
                            self.showingSheet1.toggle()
                        }
                        Image(systemName: "info.circle").foregroundColor(.blue)
                        .sheet(isPresented: $showingSheet1, content: {
                            List{
                            Text("Low: little or no exercise - Select this option if you want to add calories burnt through daily step count and individual exercises")
                            Text("Medium: moderate exercise 3-5 days/week")
                            Text("High: hard exercise 6-7 days/week")
                            }
                        })
                        .foregroundColor(.black)
                    }
                    
                    Button("Activity Level: \(person.personUserInfo.activityLevel)"){
                            
                            self.showingSheetActivity.toggle()
                        }.foregroundColor(.blue)

                        .sheet(isPresented: $showingSheetActivity, content: {
                            List{
                                Button("Low"){
                                    person.personUserInfo.activityLevel = "Low"
                                    self.showingSheetActivity.toggle()

                                }
                                Button("Medium"){
                                    person.personUserInfo.activityLevel = "Medium"
                                    self.showingSheetActivity.toggle()
                                }
                                Button("High"){
                                    person.personUserInfo.activityLevel = "High"
                                    self.showingSheetActivity.toggle()
                                }
                            }
                        })
                        .foregroundColor(.black)
                }
     
                Section(header: Text("Personal Settings")){
                VStack{
                    TextField("Age: \(person.personUserInfo.age, specifier: "%.0f")", text: $ageInputString ).keyboardType(.numberPad)
                        .accessibility(identifier: "personAgeTextField")
                        .onReceive(Just(ageInputString)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.ageInputString = filtered
                                        }
                        }
                }
                VStack{
                    TextField("Height: \(person.personUserInfo.height, specifier: "%.0f")cm", text: $heightInputString ).keyboardType(.numberPad)
                        .accessibility(identifier: "personHeightTextField")
                        .onReceive(Just(heightInputString)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.heightInputString = filtered
                                        }
                }
  
                }
                VStack{
                    TextField("Weight: \(person.personUserInfo.weight, specifier: "%.0f")kg", text: $weightInputString ).keyboardType(.numberPad)
                        .accessibility(identifier: "personWeightTextField")
                        .onReceive(Just(weightInputString)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.weightInputString = filtered
                                        }
                        }
                    
                }
                    HStack {
                        Button("Choose Gender: \(person.personUserInfo.gender)"){
                            self.showingSheetGender.toggle()
                        }.foregroundColor(.blue)

                        .sheet(isPresented: $showingSheetGender, content: {
                            List{
                                Button("Male"){
                                    person.personUserInfo.gender = "Male"
                                    self.showingSheetGender.toggle()


                                }
                                Button("Female"){
                                    person.personUserInfo.gender = "Female"
                                    self.showingSheetGender.toggle()
                                    print("chose female")
                                }
                            }
                        })
                        .foregroundColor(.black)
                    }
                    
                    HStack{
                        Button("") {
                            self.showSheetStepsInfo.toggle()
                        }
                        Image(systemName: "info.circle").foregroundColor(.blue)
                        .sheet(isPresented: $showSheetStepsInfo, content: {
                            List{
                        Text("Toggle this on, to add the calories burnt throughout the day to your totalCalorieGoal for the day. It resets every day! ")
                            }
                            
                                
                        })
                        .foregroundColor(.black)
                        Toggle("Use Steps for Calories", isOn: $showingSteps).accessibility(identifier: "toggle")
                    }
         
                Button(action: {
                    
                    if(Double(weightInputString) == nil || Double(heightInputString) == nil || Double(ageInputString) == nil ){
                        
                        userInfoIssue = true
                        
                        print("error - something inputted was nil")
                        
                    }
                        //Checking that the textFields are not empty
                    else if(ageInputString != "" || heightInputString != "" || weightInputString != ""){
                    
                        
                        
                    person.personUserInfo.firstName = userName
                        //converting the input from type string to Double
                    let ageDouble: Double! = Double(ageInputString)
                    person.personUserInfo.age = ageDouble
                    let heightDouble: Double! = Double(heightInputString)
                    person.personUserInfo.height = heightDouble
                    let weightDouble: Double! = Double(weightInputString)
                    person.personUserInfo.weight = weightDouble
                    
                        if person.personUserInfo.gender == "Male" {
                           
                            let weightBMR = (weightDouble * 10)
                            let heightBMR = (heightDouble *  6.25)
                            let ageBMR = (ageDouble * 5)
                            let bmr = 5 + weightBMR + heightBMR - ageBMR
                            BMR = bmr
                                
                        }else{
                            let weightBMR = (weightDouble * 10)
                            let heightBMR = (heightDouble *  6.25)
                            let ageBMR = (ageDouble * 5)
                            let bmr = weightBMR + heightBMR - ageBMR - 161
                            BMR = bmr
                            
                           
                        }
                     
                        //Depending on activity level, adjusting the BMR appropriately
                        if( person.personUserInfo.activityLevel == "Low"){
                        BMR = 1.2 * BMR
                        }
                        else if (person.personUserInfo.activityLevel == "Medium"){
                        BMR = 1.55 * BMR
                        }
                        else if(person.personUserInfo.activityLevel == "High"){
                        BMR = 1.725 * BMR
                        }
                        
                        switch selectedSteps{
                        case 0:
                            person.personUserInfo.useSteps = false

                        case 1:
                            person.personUserInfo.useSteps = true
                        default:
                            ""
                        }
                        
                        hideKeyboard()
                        person.personUserInfo.firstName = userName
                        person.personUserInfo.bmr = BMR
                        
                        userSettingViewModel.deleteUserData()
                      
                        if showingSteps {
                            person.personUserInfo.useSteps = true
                        }
                       
                        userSettingViewModel.addUserSettingData(id: UUID(), firstName: person.personUserInfo.firstName, height: person.personUserInfo.height, weight: person.personUserInfo.weight, gender: person.personUserInfo.gender, age: person.personUserInfo.age, activityLevel: person.personUserInfo.activityLevel, bmr: person.personUserInfo.bmr, useSteps: person.personUserInfo.useSteps)
                    }
                })
                {
                    Text("Enter").multilineTextAlignment(.center)
                        .foregroundColor(Color.blue)
                }
                }.alert(isPresented: $userInfoIssue) {
                    
                    Alert(title: Text("Error"), message: Text("Make sure all textfields are inputted properly"),dismissButton: .default(Text("Got it!")))
                }

                
                Section(header: Text("Macro Goals: \(person.personDailyCalorieGoals.calorieGoal, specifier: "%.0f") kcal")){
                        VStack{ //manual input (fat)
                            TextField("Fat Goal: \(person.personDailyCalorieGoals.fatGoal, specifier: "%.0f")g", text: $fatInputString ).keyboardType(.numberPad)
                                .accessibility(identifier: "fatGoalTextField")
                                .onReceive(Just(fatInputString)) { newValue in
                                                let filtered = newValue.filter { "0123456789".contains($0) }
                                                if filtered != newValue {
                                                    self.fatInputString = filtered
                                                }
                                }
                        }
                        VStack{ //manual input (carbs
                            TextField("Carb Goal: \(person.personDailyCalorieGoals.carbGoal, specifier: "%.0f")g", text: $carbInputString ).keyboardType(.numberPad)
                                .accessibility(identifier: "carbGoalTextField")

                                .onReceive(Just(carbInputString)) { newValue in
                                                let filtered = newValue.filter { "0123456789".contains($0) }
                                                if filtered != newValue {
                                                    self.carbInputString = filtered
                                                }
                        }
                        }
                        VStack{ //manual input (carbs

                            TextField("Protein Goal: \(person.personDailyCalorieGoals.proteinGoal, specifier: "%.0f")g", text: $proteinInputString ).keyboardType(.numberPad)
                                .accessibility(identifier: "proteinGoalTextField")
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
            
        }.onAppear(){
           
            _ = calorieProgressViewModel.fetchCalorieGoals()
            _ = userSettingViewModel.fetchUserSettingData()
            
            let personStepClass = nutritionFunctions()
            

            if(!userSettingViewModel.userSettings.isEmpty){ //if there is values in Core Data
                
                _ = userSettingViewModel.fetchUserSettingData()
                person.personUserInfo.firstName = userSettingViewModel.userSettings.first!.firstName ?? ""
                person.personUserInfo.bmr = userSettingViewModel.userSettings.first!.bmr
                person.personUserInfo.age = userSettingViewModel.userSettings.first!.age
                person.personUserInfo.weight = userSettingViewModel.userSettings.first!.weight
                person.personUserInfo.height = userSettingViewModel.userSettings.first!.height
                person.personUserInfo.gender = userSettingViewModel.userSettings.first!.gender ?? ""
                person.personUserInfo.activityLevel = userSettingViewModel.userSettings.first!.activityLevel ?? ""
                showingSteps = userSettingViewModel.userSettings.first!.useSteps
                person.personUserInfo.useSteps = userSettingViewModel.userSettings.first!.useSteps
            }
            
            if(!calorieGoalViewModel.calorieGoals.isEmpty){ //if there is no values in viewmodel
                _ = calorieGoalViewModel.fetchCalorieGoals()
            person.personDailyCalorieGoals.calorieGoal = calorieGoalViewModel.calorieGoals.first!.calorieGoal
            person.personDailyCalorieGoals.fatGoal = calorieGoalViewModel.calorieGoals.first!.fatGoal
            person.personDailyCalorieGoals.proteinGoal = calorieGoalViewModel.calorieGoals.first!.proteinGoal
            person.personDailyCalorieGoals.carbGoal = calorieGoalViewModel.calorieGoals.first!.carbGoal
            person.personUserInfo.gender = userSettingViewModel.userSettings.first!.gender ?? ""
            person.personUserInfo.activityLevel = userSettingViewModel.userSettings.first!.activityLevel ?? ""
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
            
            if let healthStore = healthStore{ //Requesting authorization to the healthstore
                healthStore.requestAuthorization{
                    success in
                healthStore.getTodaysSteps{
                        (result) in
                        print("steps", result)
                    person.personSteps.steps =  result
                    person.personSteps.calories = personStepClass.stepsToCalories(input: result)
                    
                    //If the user has allowed steps to be added to calorie count, add to calorieGoal for the day.
                    if(person.personUserInfo.useSteps){
                        
                        calorieGoalWithSteps = person.personDailyCalorieGoals.calorieGoal + person.personSteps.calories
                        print("Addition of step cals")
                    }
                }
                }
            }
        }//.background(ColourManager.Colour1)
    }
}

#if canImport(UIKit) //Function to hide the keyboard after input 
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


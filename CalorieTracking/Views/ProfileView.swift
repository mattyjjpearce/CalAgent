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

    @ObservedObject var viewModel: AddViewModel = AddViewModel()

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
    
    
    
    @FetchRequest(
            entity: UserSettings.entity(),
            sortDescriptors: [])
    private var userSettingEntity: FetchedResults<UserSettings>
    
//    init(){
//
////        let x = viewModel.fetchProgresses()
////        let y = userSettingEntity.count
////
////        print(y)
////        print(x.count)
////        if(!x.isEmpty){
////            print("id: \(x[0].id)")
////
////      person.personUserInfo.firstName = x[0].firstName!
////      ageInputString = String(x[0].age)
////      heightInputString = String(x[0].height)
////      weightInputString = String(x[0].weight)
////      selectedGender = Double(x[0].age)
////      chosenActivityLevel = x[0].activityLevel!
////      BMR = x[0].bmr
//
//        }
    
    
    init(){
       let x = viewModel.fetchProgresses()
        print(viewModel.userSettings.first?.firstName)
    }
   
    
    var body: some View {
        
        VStack{ //vertical stack for the form
            Form{
                Section{
                    TextField("\(viewModel.userSettings.first?.firstName ?? "Name")" , text: $userName)
                   // Text("Caloric needs: \(self.person.personUserInfo.bmr, specifier: "%.0f") Kcal")
                    Text("Caloric needs: \(viewModel.userSettings.first?.bmr ?? 0, specifier: "%.0f") Kcal")

            }
               
                

                

                Section(header: Text("Personal Settings")){
                VStack{ //manual input (fat)
                    TextField("Age: \(viewModel.userSettings.first?.age ?? 0, specifier: "%.0f")", text: $ageInputString ).keyboardType(.numberPad)
                        .onReceive(Just(ageInputString)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.ageInputString = filtered
                                        }
                        }
                }
                VStack{ //manual input (carbs
                    TextField("Height cm: \(viewModel.userSettings.first?.height ?? 0, specifier: "%.0f")", text: $heightInputString ).keyboardType(.numberPad)
                        .onReceive(Just(heightInputString)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.heightInputString = filtered
                                        }
                }
  
                }
                VStack{ //manual input (carbs
                    TextField("Weight (KG): \(viewModel.userSettings.first?.weight ?? 0, specifier: "%.0f")", text: $weightInputString ).keyboardType(.numberPad)
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
                        
                        viewModel.deleteUserData()
                      
                 
                       
                        viewModel.addCalorieTrackerDate(id: UUID(), firstName: person.personUserInfo.firstName, height: person.personUserInfo.height, weight: person.personUserInfo.weight, gender: person.personUserInfo.gender, age: person.personUserInfo.age, activityLevel: person.personUserInfo.activityLevel, bmr: person.personUserInfo.bmr)
                        
                        
                     }
                    
                 

                }) {
                    Text("Enter").multilineTextAlignment(.center)
                        .foregroundColor(Color.blue)
                }
                
            }
                
                
                
                
                        Section(header: Text("Macro Goals")){
                        VStack{ //manual input (fat)
                        HStack {
                        Text("Fat: \(self.person.personDailyCalorieGoals.fatGoal, specifier: "%.0f")g")
                                }
                            TextField("Enter new fat goal (g)", text: $fatInputString ).keyboardType(.numberPad)
                                .onReceive(Just(fatInputString)) { newValue in
                                                let filtered = newValue.filter { "0123456789".contains($0) }
                                                if filtered != newValue {
                                                    self.fatInputString = filtered
                                                }
                                }
                        }
                        VStack{ //manual input (carbs
                        HStack{
                        Text("Carbs: \(self.person.personDailyCalorieGoals.carbGoal, specifier: "%.0f")g")
                            }
                            TextField("Enter new Carb goal (g)", text: $carbInputString ).keyboardType(.numberPad)
                                .onReceive(Just(carbInputString)) { newValue in
                                                let filtered = newValue.filter { "0123456789".contains($0) }
                                                if filtered != newValue {
                                                    self.carbInputString = filtered
                                                }
                        }
                          
                        }
                        VStack{ //manual input (carbs
                        HStack {
                        Text("Protein: \(self.person.personDailyCalorieGoals.proteinGoal, specifier: "%.0f")g")
                            }
                            TextField("Enter new Protein goal (g)", text: $proteinInputString ).keyboardType(.numberPad)
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
                            

                            fatInputString = "" //resetting the local variable
                            carbInputString = ""
                            proteinInputString = ""
                            
                            let fatCalories = person.personDailyCalorieGoals.fatGoal * 9
                            let carbCalories = person.personDailyCalorieGoals.carbGoal * 4
                            let proteinCalories = person.personDailyCalorieGoals.proteinGoal * 4
                            let totalCalorieGoal = fatCalories + carbCalories + proteinCalories
                            
                            person.personDailyCalorieGoals.calorieGoal = totalCalorieGoal
                            
                            hideKeyboard()
                            
                        }) {
                            Text("Enter").multilineTextAlignment(.center)
                                .foregroundColor(Color.blue)
                        }
                    }
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


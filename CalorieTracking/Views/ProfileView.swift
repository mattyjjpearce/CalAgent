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
    
    
    @EnvironmentObject var person: UserInfoModel

    @State private var fatInputString = ""
    @State private var carbInputString = ""
    @State private var proteinInputString = ""
    
    @State private var ageInputString = ""
    @State private var heightInputString = ""
    @State private var weightInputString = ""


    
    @State var selectedGender = 0
    let genders = ["Male", "Female"]






    

    
    var body: some View {
        
        
        
        VStack{ //vertical stack for the form
            Form{
                Section{
                TextField("Name ", text: $person.personUserInfo.firstName)
            }.frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
               
                

                

                Section(header: Text("Personal Settings")){
                VStack{ //manual input (fat)
                    TextField("Age", text: $ageInputString ).keyboardType(.numberPad)
                        .onReceive(Just(ageInputString)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.ageInputString = filtered
                                        }
                        }
                }
                VStack{ //manual input (carbs
                    TextField("Height cm", text: $heightInputString ).keyboardType(.numberPad)
                        .onReceive(Just(heightInputString)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.heightInputString = filtered
                                        }
                }
  
                }
                VStack{ //manual input (carbs
                    TextField("Weight (KG)", text: $weightInputString ).keyboardType(.numberPad)
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
                Button(action: {
                        //Checking that the textFields are not empty
                    if(ageInputString != "" || heightInputString != "" || weightInputString != "" ){
                        //converting the input from type string to Double
                    let ageDouble: Double! = Double(ageInputString)
                    person.personUserInfo.age = ageDouble
                    let heightDouble: Double! = Double(heightInputString)
                    person.personUserInfo.height = heightDouble
                    let weightDouble: Double! = Double(weightInputString)
                    person.personUserInfo.weight = weightDouble
                    
                        if(selectedGender == 1){
                            person.personUserInfo.gender = "Male"
                        }else{
                            person.personUserInfo.gender = "Female"
                        }
                    
                    
                    print(selectedGender)
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
                            let fatDouble: Double! = Double(fatInputString)
                            person.personDailyCalorieGoals.fatGoal = fatDouble
                            let carbDouble: Double! = Double(carbInputString)
                            person.personDailyCalorieGoals.carbGoal = carbDouble
                            let proteinDouble: Double! = Double(proteinInputString)
                            person.personDailyCalorieGoals.proteinGoal = proteinDouble
                    
                            fatInputString = "0" //resetting the local variable
                            carbInputString = "0"
                            proteinInputString = "0"

                        }) {
                            Text("Enter").multilineTextAlignment(.center)
                                .foregroundColor(Color.blue)
                        }
                    }
            }
        }
    }
    
}

//Debugging preview


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView() //call the view we want to display
    }
}


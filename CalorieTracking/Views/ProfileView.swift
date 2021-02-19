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
    @State var showSliders : Bool = true
    @State private var fatInputString = "0"
    @State private var carbInputString = "0"
    @State private var proteinInputString = "0"



    

    
    var body: some View {
        
        
        VStack{ //vertical stack for the form
            Form{
                Section{
                TextField("Name ", text: $person.personUserInfo.firstName)
            }.frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Toggle(isOn: $showSliders){ //toggle to let the user decide if they want to adjust numbers with sliders or not 
                    Text("Show Sliders")
                }
                
                Section(header: Text("Macro Goals")){
                    if(showSliders){

                        VStack{
                        HStack {
                        Text("0")
                            Slider(value: $person.personDailyCalorieGoals.fatGoal, in: 0...400, step: 1).accentColor(Color.blue)
                        Text("200")
                            }
                            Text("Fat: \(self.person.personDailyCalorieGoals.fatGoal, specifier: "%.0f")").frame(width: 100, height: 20, alignment: .center)
                        }
                        VStack{
                        HStack {
                        Text("0")
                            Slider(value: $person.personDailyCalorieGoals.carbGoal, in: 0...400, step: 1).accentColor(Color.blue)
                        Text("400")
                            }
                            Text("Carbs: \(self.person.personDailyCalorieGoals.carbGoal, specifier: "%.0f")").frame(width: 100, height: 20, alignment: .center)
                        }
                        VStack{
                        HStack {
                        Text("0")
                            Slider(value: $person.personDailyCalorieGoals.proteinGoal, in: 0...200, step: 1).accentColor(Color.blue)
                        Text("200")
                            }
                            Text("Protein: \(self.person.personDailyCalorieGoals.proteinGoal, specifier: "%.0f")").frame(width: 100, height: 20, alignment: .center)
                        }
                        
                        
                        
                    }else{
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
                        HStack {
                        Text("Fat: \(self.person.personDailyCalorieGoals.carbGoal, specifier: "%.0f")g")
                            }
                            TextField("Enter new fat goal (g)", text: $carbInputString ).keyboardType(.numberPad)
                                .onReceive(Just(carbInputString)) { newValue in
                                                let filtered = newValue.filter { "0123456789".contains($0) }
                                                if filtered != newValue {
                                                    self.carbInputString = filtered
                                                }
                        }
                          
                        }
                        VStack{ //manual input (carbs
                        HStack {
                        Text("Fat: \(self.person.personDailyCalorieGoals.proteinGoal, specifier: "%.0f")g")
                            }
                            TextField("Enter new fat goal (g)", text: $proteinInputString ).keyboardType(.numberPad)
                                .onReceive(Just(proteinInputString)) { newValue in
                                                let filtered = newValue.filter { "0123456789".contains($0) }
                                                if filtered != newValue {
                                                    self.proteinInputString = filtered
                                                }
                                }
                        }
                        Button(action: {
                            let fatDouble: Double! = Double(fatInputString) //converting the input from type string to Double
                            person.personDailyCalorieGoals.fatGoal = fatDouble
                            let carbDouble: Double! = Double(carbInputString) //converting the input from type string to Double
                            person.personDailyCalorieGoals.carbGoal = carbDouble
                                                        let proteinDouble: Double! = Double(proteinInputString) //converting the input from type string to Double
                            person.personDailyCalorieGoals.proteinGoal = proteinDouble
                            
                            
                            fatInputString = "0" //resetting the local variable
                            carbInputString = "0"
                            proteinInputString = "0"


                        }) {
                            Text("Enter").multilineTextAlignment(.center)
                                .foregroundColor(Color.blue)

                        }
                        
                    }//end of if statement
                    
                    
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


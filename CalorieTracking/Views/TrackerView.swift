//
//  TrackerView.swift
//  navigationPractice
//
//  Created by Matthew Pearce on 26/11/2020.
//

import SwiftUI

struct TrackerView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    
    @ObservedObject var userSettingViewModel: UserSettingsViewModel = UserSettingsViewModel()
    @ObservedObject var calorieGoalViewModel: CalorieGoalsiewModel = CalorieGoalsiewModel()
    @ObservedObject var calorieProgressViewModel: CalorieProgressViewModel = CalorieProgressViewModel()

    
    @EnvironmentObject var person: UserInfoModel
    
    @State private var downloadAmount = 50.0
    @State private var noGoalSet = true
    @State private var fatColour = Color.blue
    
    @State private var calorieGoal = 2000.00
    @State private var fatGoal = 100.00
    @State private var proteinGoal = 100.00
    @State private var carbGoal = 100.00
    
    
    
    @State private var calorieGoalWithSteps = 0.00


  
    init(){
        _ = userSettingViewModel.fetchUserSettingData()
        _ = calorieGoalViewModel.fetchCalorieGoals()
        _ = calorieProgressViewModel.fetchCalorieGoals()
      
    }

 
    var body: some View {
            NavigationView{
                VStack{
                    HStack{
                        Spacer()
                Button("Reset") {
                    //Setting calorie progress to 0
                    person.personCurrentCalorieProgress.calorieProgress = 0.00
                    person.personCurrentCalorieProgress.fatProgress = 0.00
                    person.personCurrentCalorieProgress.carbProgress = 0.00
                    person.personCurrentCalorieProgress.proteinProgress = 0.00

                    //deleting calorie progress in core-data
                    calorieProgressViewModel.deleteUserData()
                    
                    //Creating new calorie-progress in core-data starting with 0
                    calorieProgressViewModel.addCalorieProgressData(id: UUID(), calorieProgress: person.personCurrentCalorieProgress.calorieProgress, fatProgress: person.personCurrentCalorieProgress.fatProgress, carbProgress: person.personCurrentCalorieProgress.carbProgress, proteinPogress: person.personCurrentCalorieProgress.proteinProgress, created: Date())

                }.foregroundColor(.red)
                .padding(.trailing, 20)
                    }

                Form{
                Section(header: Text("Calories")){
                   
                    VStack{
                        Text("\(person.personCurrentCalorieProgress.calorieProgress, specifier: "%.0f") / \(calorieGoalWithSteps, specifier: "%.0f") kcal")
                       
                        let CalorieProgress =  (person.personCurrentCalorieProgress.calorieProgress / calorieGoalWithSteps) * 100
                        
                        if(person.personCurrentCalorieProgress.calorieProgress > calorieGoalWithSteps){
                           
                            ProgressView( value: CalorieProgress, total: 100).scaleEffect(x: 1, y: 3, anchor: .top).shadow(color: .red, radius: 4.0, x: 1.0, y: 2.0).padding(.bottom, 10)
                            Text("\(CalorieProgress, specifier: "%.0f")%")
                        }else{
                           
                            ProgressView( value: CalorieProgress, total: 100).scaleEffect(x: 1, y: 3, anchor: .top).shadow(color: .blue, radius: 4.0, x: 1.0, y: 2.0).padding(.bottom, 10)
                            Text("\(CalorieProgress, specifier: "%.0f")%")
                        }
                    }.frame(width: .infinity, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                    if(person.personUserInfo.useSteps){
                        Section(header: Text("Daily Steps")){
                            Text("Step Count: \(person.personSteps.steps, specifier: "%.0f") ")
                            Text("Calories burnt from Steps: \(person.personSteps.calories, specifier: "%.0f")" )
                        }
                    }
                    
                    Section(header: Text("Fat")){
                        VStack{
                            Text("\(person.personCurrentCalorieProgress.fatProgress, specifier: "%.0f")g / \(person.personDailyCalorieGoals.fatGoal, specifier: "%.0f")g")
                      
                            //Fat progress % wise
                            let FatProgress =  (person.personCurrentCalorieProgress.fatProgress / person.personDailyCalorieGoals.fatGoal) * 100
            
                            if(person.personCurrentCalorieProgress.fatProgress > person.personDailyCalorieGoals.fatGoal){
                                ProgressView( value: FatProgress, total: 100).scaleEffect(x: 1, y: 3, anchor: .top).shadow(color: .red, radius: 4.0, x: 1.0, y: 2.0).padding(.bottom, 10)
                                Text("\(FatProgress, specifier: "%.0f")%")
                            }else{
                                ProgressView( value: FatProgress, total: 100).scaleEffect(x: 1, y: 3, anchor: .top).shadow(color: .blue, radius: 4.0, x: 1.0, y: 2.0).padding(.bottom, 10)
                                Text("\(FatProgress, specifier: "%.0f")%")
                            }
                        }.frame(width: .infinity, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    
                    Section(header: Text("Carbohydrates")){
                        VStack{
                            Text("\(person.personCurrentCalorieProgress.carbProgress, specifier: "%.0f")g / \(person.personDailyCalorieGoals.carbGoal, specifier: "%.0f")g")
                    
                            //carb progress % wise
                            let CarbProgress =  (person.personCurrentCalorieProgress.carbProgress / person.personDailyCalorieGoals.carbGoal) * 100
                            
                            if(person.personCurrentCalorieProgress.carbProgress > person.personDailyCalorieGoals.carbGoal){
                                ProgressView( value: CarbProgress, total: 100).scaleEffect(x: 1, y: 3, anchor: .top).shadow(color: .red, radius: 4.0, x: 1.0, y: 2.0).padding(.bottom, 10)
                                Text("\(CarbProgress, specifier: "%.0f")%")
                            }else{
                                ProgressView( value: CarbProgress, total: 100).scaleEffect(x: 1, y: 3, anchor: .top).shadow(color: .blue, radius: 4.0, x: 1.0, y: 2.0).padding(.bottom, 10)
                                Text("\(CarbProgress, specifier: "%.0f")%")
                            }
                        }.frame(width: .infinity, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    
                    Section(header: Text("Protein")){
                        VStack{
                            Text("\(person.personCurrentCalorieProgress.proteinProgress, specifier: "%.0f")g / \(person.personDailyCalorieGoals.proteinGoal, specifier: "%.0f")g")
                    
                            //protein progress % wise
                            let ProteinProgress =  (person.personCurrentCalorieProgress.proteinProgress / person.personDailyCalorieGoals.proteinGoal) * 100
                            
                            if(person.personCurrentCalorieProgress.proteinProgress > person.personDailyCalorieGoals.proteinGoal){
                                ProgressView( value: ProteinProgress, total: 100).scaleEffect(x: 1, y: 3, anchor: .top).shadow(color: .red, radius: 4.0, x: 1.0, y: 2.0).padding(.bottom, 10)
                                Text("\(ProteinProgress, specifier: "%.0f")%")
                            }else{
                                ProgressView( value: ProteinProgress, total: 100).scaleEffect(x: 1, y: 3, anchor: .top).shadow(color: .blue, radius: 4.0, x: 1.0, y: 2.0).padding(.bottom, 10)
                                Text("\(ProteinProgress, specifier: "%.0f")%")
                            }
                        }.frame(width: .infinity, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
        
                }.navigationBarTitle(Text("Daily Progress")).frame(width: .infinity, height: .infinity)
              
                }//.background(ColourManager.Colour1) - change if you want the background of this view to look like this
                
            }.onAppear(){
                _ = calorieProgressViewModel.fetchCalorieGoals()
                
            
                calorieGoalWithSteps = person.personDailyCalorieGoals.calorieGoal + person.personSteps.calories
            }
    }
}

struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerView()
    
    }
}

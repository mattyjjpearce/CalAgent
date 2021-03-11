//
//  TrackerView.swift
//  navigationPractice
//
//  Created by Matthew Pearce on 26/11/2020.
//

import SwiftUI

struct TrackerView: View {
    
    @EnvironmentObject var person: UserInfoModel
    @State private var downloadAmount = 50.0
    


    
    var body: some View {
        
            NavigationView{
                Form{
                Section(header: Text("Calories")){
                    VStack{
                                Text("Calories: \(person.personCurrentCalorieProgress.calorieProgress, specifier: "%.0f") kcal")
                               
                
        
                        let CalorieProgress =  (person.personCurrentCalorieProgress.calorieProgress / person.personDailyCalorieGoals.calorieGoal) * 100
        
                        ProgressView( value: CalorieProgress, total: 100).scaleEffect(x: 1, y: 3, anchor: .top).shadow(color: .blue, radius: 4.0, x: 1.0, y: 2.0).padding(.bottom, 10)
                        Text("\(CalorieProgress, specifier: "%.0f")%")
                    }.frame(width: .infinity, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    

                }
                    Section(header: Text("Fat")){
                        VStack{
                                    Text("Fat: \(person.personCurrentCalorieProgress.fatProgress, specifier: "%.0f")g")
                                   
                    
            
                            let FatProgress =  (person.personCurrentCalorieProgress.fatProgress / person.personDailyCalorieGoals.fatGoal) * 100
            
                            ProgressView( value: FatProgress, total: 100).scaleEffect(x: 1, y: 3, anchor: .top).shadow(color: .blue, radius: 4.0, x: 1.0, y: 2.0).padding(.bottom, 10)
                            Text("\(FatProgress, specifier: "%.0f")%")
                        }.frame(width: .infinity, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        

                    }
                    
                    Section(header: Text("Carbohydrates")){
                        VStack{
                                    Text("Carbohydrates: \(person.personCurrentCalorieProgress.carbProgress, specifier: "%.0f")g")
                                   
                    
            
                            let CarbProgress =  (person.personCurrentCalorieProgress.carbProgress / person.personDailyCalorieGoals.carbGoal) * 100
            
                            ProgressView( value: CarbProgress, total: 100).scaleEffect(x: 1, y: 3, anchor: .top).shadow(color: .blue, radius: 4.0, x: 1.0, y: 2.0).padding(.bottom, 10)
                            Text("\(CarbProgress, specifier: "%.0f")%")
                        }.frame(width: .infinity, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        

                    }
                    
                    Section(header: Text("Protein")){
                        VStack{
                                    Text("Protein: \(person.personCurrentCalorieProgress.proteinProgress, specifier: "%.0f")g")
                                   
                    
            
                            let ProteinProgress =  (person.personCurrentCalorieProgress.proteinProgress / person.personDailyCalorieGoals.proteinGoal) * 100
            
                            ProgressView( value: ProteinProgress, total: 100).scaleEffect(x: 1, y: 3, anchor: .top).shadow(color: .blue, radius: 4.0, x: 1.0, y: 2.0).padding(.bottom, 10)
                            Text("\(ProteinProgress, specifier: "%.0f")%")
                        }.frame(width: .infinity, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        

                    }
                    
                    
                }.navigationBarTitle(Text("Daily Progress")).frame(width: .infinity, height: .infinity)
                
                
                

            }
        
        
        
//        VStack{
//            //First Card
//        VStack() {
//                VStack(alignment: .leading) {
//                        Text("Calories")
//                                .font(.system(size: 26, weight: .bold, design: .default))
//                                .foregroundColor(.white)
//                            .padding(.bottom, 10)
//
//
//        }
//            VStack(){
//            Text("Calories: \(person.personCurrentCalorieProgress.calorieProgress, specifier: "%.0f") kcal").foregroundColor(.white)
//            Text("Fat: \(person.personCurrentCalorieProgress.fatProgress, specifier: "%.0f")g").foregroundColor(.white)
//            Text("Carbs: \(person.personCurrentCalorieProgress.proteinProgress, specifier: "%.0f")g").foregroundColor(.white)
//            Text("Carbs: \(person.personCurrentCalorieProgress.carbProgress, specifier: "%.0f")g").foregroundColor(.white)
//            }
//            VStack(alignment: .leading) {
//
//                let CalorieProgress =  (person.personCurrentCalorieProgress.calorieProgress / person.personDailyCalorieGoals.calorieGoal) * 100
//
//                Text("\(CalorieProgress, specifier: "%.0f")%").foregroundColor(.white)
//            ProgressView( value: CalorieProgress, total: 100).scaleEffect(x: 1, y: 3, anchor: .center)
//            }
//
//                .padding()
//    }
//
//        .frame(maxWidth: 380, alignment: .center)
//        .background(Color(.blue).opacity(0.7))
//        .cornerRadius(15)
//
//            //Second card
//            VStack(alignment: .center) {
//                    VStack(alignment: .leading) {
//                            Text("Calories")
//                                    .font(.system(size: 26, weight: .bold, design: .default))
//                                    .foregroundColor(.white)
//
//            }
//                Text("Hi").foregroundColor(.white)
//                .padding()
//
//
//
//        }
//
//            .frame(maxWidth: 380, alignment: .center)
//            .background(Color(.blue).opacity(0.7))
//            .cornerRadius(15)
//            .padding(.top, 30) //padding between cards
//
//        }.padding(15)
        
        
        
}
}




struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerView()
    
    }
}

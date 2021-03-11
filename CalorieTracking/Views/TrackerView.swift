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
        VStack{
            //First Card
        VStack(alignment: .center) {
                VStack(alignment: .leading) {
                        Text("Calories")
                                .font(.system(size: 26, weight: .bold, design: .default))
                                .foregroundColor(.white)

        }
            
            VStack(alignment: .leading) {
                
                let CalorieProgress =  (person.personCurrentCalorieProgress.calorieProgress / person.personDailyCalorieGoals.calorieGoal) * 100
                
                Text("\(CalorieProgress, specifier: "%.0f")%").foregroundColor(.white)
            ProgressView( value: CalorieProgress, total: 100).scaleEffect(x: 1, y: 3, anchor: .center)
            }

                .padding()
    }
        
        .frame(maxWidth: 380, alignment: .center)
        .background(Color(.blue).opacity(0.7))
        .cornerRadius(15)
        
            //Second card
            VStack(alignment: .center) {
                    VStack(alignment: .leading) {
                            Text("Calories")
                                    .font(.system(size: 26, weight: .bold, design: .default))
                                    .foregroundColor(.white)

            }
                Text("Hi").foregroundColor(.white)
                .padding()

               
                
        }

            .frame(maxWidth: 380, alignment: .center)
            .background(Color(.blue).opacity(0.7))
            .cornerRadius(15)
            .padding(.top, 30) //padding between cards

        }.padding(15)
        
        
        
}
}




struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerView()
    
    }
}

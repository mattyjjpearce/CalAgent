//
//  TrackerView.swift
//  navigationPractice
//
//  Created by Matthew Pearce on 26/11/2020.
//

import SwiftUI

struct TrackerView: View {
    
    @EnvironmentObject var person: UserInfoModel

    
    var body: some View {
        HStack {
            Text("\(person.personUserInfo.weight)")
            Text("\(person.personDailyCalorieGoals.calorieGoal)")
            }

        

    }
}

struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerView()
    
    }
}

//
//  ProfileView.swift
//  navigationPractice
//
//  Created by Matthew Pearce on 26/11/2020.
//

import HealthKit
import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var person: UserInfoModel

    

    
    var body: some View {
        Button(action: {
            print(self.person.person1.weight)
            self.person.person1.weight = 100
            print(self.person.person1.weight)
        }) {
            Text("Button")
        }
        .foregroundColor(ColourManager.Colour1)
       
    }
    
}

//Denuging preview


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        
        }
    }
}


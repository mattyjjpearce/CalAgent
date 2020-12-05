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
        Button(action: {
                print(person.person1.weight)
            
        }) {
            Text("Button")
        }
        .foregroundColor(ColourManager.Colour1)

        
        
        
    }
}

struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerView()
    
    }
}

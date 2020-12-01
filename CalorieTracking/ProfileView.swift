//
//  ProfileView.swift
//  navigationPractice
//
//  Created by Matthew Pearce on 26/11/2020.
//

import SwiftUI
import HealthKit

struct ProfileView: View {
    
    
    @ObservedObject var person = UserInfoModel()
    
    
    var body: some View {
        VStack{
            Text(person.person1.gender)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

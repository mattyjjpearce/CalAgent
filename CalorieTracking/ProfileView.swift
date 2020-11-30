//
//  ProfileView.swift
//  navigationPractice
//
//  Created by Matthew Pearce on 26/11/2020.
//

import SwiftUI
import HealthKit

struct ProfileView: View {
    
    
    public var healthStore: HealthStore?
    
    init() {
        //implements the HKhealthStore from HealthStore.swift class 
        healthStore = HealthStore()
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

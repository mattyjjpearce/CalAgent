//
//  ContentView.swift
//  navigationPractice
//
//  Created by Matthew Pearce on 26/11/2020.
//

import SwiftUI

struct ContentView: View {

    
    //Instantiating an object of UserInfo Model (referenced in App.swift too 
    @EnvironmentObject var person: UserInfoModel
    

    
    init() {
        //Setting appearance of UI colour
        UITabBar.appearance().backgroundColor = ColourManager.UIColour1
    }
    
    var body: some View {
        
        
        TabView {
            ProfileView().tabItem ({
                Text("Profile")
            }).tag(0)
            
            TrackerView().tabItem ({
                Text("Tracker")
            }
            ).tag(1)

            
            AddView().tabItem ({
                Text("Add")
            }).tag(2)
            
            MealView().tabItem ({
                Text("Meals")
            }).tag(3)
        }.accentColor(ColourManager.Colour3)

        
        }

    }
    
   


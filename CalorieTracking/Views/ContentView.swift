//
//  ContentView.swift
//  navigationPractice
//
//  Created by Matthew Pearce on 26/11/2020.
//

import SwiftUI

import CoreData



struct ContentView: View {

    //Instantiating an object of UserInfo Model (referenced in App.swift too 
    @EnvironmentObject var person: UserInfoModel
    
    
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var userSettingViewModel: UserSettingsViewModel = UserSettingsViewModel()
    @ObservedObject var calorieGoalViewModel: CalorieGoalsiewModel = CalorieGoalsiewModel()

    init() {
        //Setting appearance of UI colour
        UITabBar.appearance().backgroundColor = ColourManager.UIColour1
        
        
//        let x = userSettingViewModel.fetchUserSettingData()
//
//        let y = calorieGoalViewModel.fetchCalorieGoals()
        
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
        .environmentObject(MealViewModel()) // <<: Here!
        .environmentObject(UserInfoModel.shared) // <<: Here!

        
        }

    }
    
   


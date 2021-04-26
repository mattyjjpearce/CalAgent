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
    }
    
    var body: some View {
        TabView {
            ProfileView().tabItem ({
                VStack{
                    Image(systemName: "person.crop.circle.fill").foregroundColor(.red)
                        .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("Profile")
                }
            }).tag(0)
            
            
            TrackerView().tabItem ({
                VStack{
                     Image(systemName: "eye.circle.fill").foregroundColor(.red)
                    .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("Tracker")
                }
            }
            ).tag(1)
            
            
            
            AddView().tabItem ({
                VStack{
                     Image(systemName: "plus.app.fill").foregroundColor(.red)
                    .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("Add")
                }
            }).tag(2)
            
            
            
            MealView().tabItem ({
                VStack{
                    Image(systemName: "bag.fill").foregroundColor(.red)
                        .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("Meals")
                }
            }).tag(3)
        }.accentColor(ColourManager.Colour3)
        .environmentObject(MealViewModel()) // <<: Here!
        .environmentObject(UserInfoModel.shared) // Sharing the

        
        }

    }
    
   


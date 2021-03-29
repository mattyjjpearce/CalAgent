//
//App.swift
//  CalorieTracking
//
//  Created by Matthew Pearce on 26/11/2020.
//

import SwiftUI

@main
struct navigationPracticeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared
    //make an instance of user model data as a property
    var person = UserInfoModel()

    var body: some Scene {

        WindowGroup {
            ContentView()
                //pass into conent view with the following 
                .environmentObject(person)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)

        }

    }
}

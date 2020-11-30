//
//  navigationPracticeApp.swift
//  navigationPractice
//
//  Created by Matthew Pearce on 26/11/2020.
//

import SwiftUI

@main
struct navigationPracticeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

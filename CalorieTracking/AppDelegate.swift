//
//  AppDelegate.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 29/03/2021.
//

import UIKit
import CoreData

//@UIApplicationMain
class AppDelegate: NSObject, UIApplicationDelegate {
    static private(set) var instance: AppDelegate! = nil
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        AppDelegate.instance = self
        return true
    }
    
    //MARK:- CoreData Stack
    
    lazy var persistanceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CalorieTracker")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error \(error.localizedDescription)")
            }
        }
        return container
    }()
}

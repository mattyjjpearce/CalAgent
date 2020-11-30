 //
//  HealthStore.swift
//  navigationPractice
//
//  Created by Matthew Pearce on 30/11/2020.
//

import Foundation
import HealthKit

class HealthStore {
    
    //use this to access anything related to the HK api
    var healthStore: HKHealthStore?
    
    
    //check if the health data is available or not
    init() {
        
        //checking if we have access to the health data
        if HKHealthStore.isHealthDataAvailable(){
            healthStore = HKHealthStore()
        }
    }
    
    //Function determining if we have authorization to the HealthKit data
    func requestAuthorization(completion: @escaping (Bool) -> Void ){
        
        
        //Basic requirements for the app
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        
        let heightType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        
        
        let weightType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        
        
        
        //If user has apple watch, can use this data
//        let activeEnergyType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
//
//        let restingEnergyType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.basalEnergyBurned)!
//
        
        //unwrapping health store to get access to unwrapped version of the health store
        guard let healthStore = self.healthStore else { return completion(false) }
        
        healthStore.requestAuthorization(toShare: [], read: [stepType, heightType, weightType]) { (success, error) in
            completion(success)
        }
        
    }
    
}
 
 

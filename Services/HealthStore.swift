//
//  HealthStore.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 05/04/2021.
//

import Foundation
import HealthKit

// Class for all actions related to the Apple HealthStore
class HealthStore {
    
    var healthstore: HKHealthStore? // Declaration of a variable to hold the HealthStore instance
    
    init() { // Initialize the HealthStore class
        
        if HKHealthStore.isHealthDataAvailable() { // Check if health data is available on the device
            healthstore = HKHealthStore() // If available, create an instance of HKHealthStore
        }
    }
    
    // Request authorization to access health data
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)! // Define the type of data to be accessed (step count)
        
        // Unwrap the optional healthstore so we can use it
        guard let healthStore = self.healthstore else { return completion(false) }
        
        // Request authorization to read step data
        healthStore.requestAuthorization(toShare: [], read: [stepType]) { (success, error) in
            completion(success) // Call the completion handler with the authorization result
        }
    }
    
    // Get today's step count
    func getTodaysSteps(completion: @escaping (Double) -> Void) {
       
        let healthStore = self.healthstore
        
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)! // Define the type of data to be retrieved (step count)
        
        let now = Date() // Get the current time
        let startOfDay = Calendar.current.startOfDay(for: now) // Calculate the start of the day
        
        // Create a predicate to filter data for today
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )
        
        // Create a query to retrieve cumulative step count
        let query = HKStatisticsQuery(
            quantityType: stepsQuantityType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else { // Check if there's a valid result and sum
                completion(0.0) // If not, call the completion handler with 0 steps
                return
            }
            completion(sum.doubleValue(for: HKUnit.count())) // Call the completion handler with the step count
        }
        
        healthStore?.execute(query) // Execute the query using the health store instance
    }
    
}

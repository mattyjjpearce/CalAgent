//
//  HealthStore.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 05/04/2021.
//

import Foundation
import HealthKit

class HealthStore{
    
    var healthstore: HKHealthStore?
    
    init(){
        if HKHealthStore.isHealthDataAvailable(){
            healthstore = HKHealthStore()
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void ) {
        
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)! //Getting the Type of data we want (step count)
        
        //unwrapping healthstore so we can get access to an unwrapped version of the healthstore
        guard let healthStore = self.healthstore else { return completion(false) }
        
        //call request authorization
        healthStore.requestAuthorization(toShare: [], read: [stepType]){ (success, error) in completion(success)
        }
    }
    //statisticsCollection object contains all steps
    func getTodaysSteps(completion: @escaping (Double) -> Void) {
       
        let healthStore = self.healthstore

        
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )
        
        let query = HKStatisticsQuery(
            quantityType: stepsQuantityType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        
        healthStore?.execute(query)
    }
    
}

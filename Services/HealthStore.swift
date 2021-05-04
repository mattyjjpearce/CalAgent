//
//  HealthStore.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 05/04/2021.
//

import Foundation
import HealthKit

//Class for all actions related to apple HealthStore
class HealthStore{
    
    var healthstore: HKHealthStore? //Instantiation a health store
    
    
    init(){ //Whenever this class is used - check if there is availability to the healthstore and if so, create a healthstore variable
        if HKHealthStore.isHealthDataAvailable(){
            healthstore = HKHealthStore()
        }
    }
    
    
    
    func requestAuthorization(completion: @escaping (Bool) -> Void ) {
        
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)! //Getting the Type of data we want from the health store (step count)
        
        //unwrapping healthstore so we can get access to an unwrapped version of the healthstore
        guard let healthStore = self.healthstore else { return completion(false) }
        
        //call request authorization
        healthStore.requestAuthorization(toShare: [], read: [stepType]){ (success, error) in completion(success)
        }
    }
    
    //statisticsCollection object contains all steps
    func getTodaysSteps(completion: @escaping (Double) -> Void) {
       
        let healthStore = self.healthstore

        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)! //type of data we want (step count)
        
        let now = Date() //Current time
        let startOfDay = Calendar.current.startOfDay(for: now) //Start of day
        
        let predicate = HKQuery.predicateForSamples( //Creating a predicate to use in Query
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )
        
        let query = HKStatisticsQuery( //Querying the healthkit store
            quantityType: stepsQuantityType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else { //Storing the sum result in variable result 
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        
        healthStore?.execute(query)
    }
    
}

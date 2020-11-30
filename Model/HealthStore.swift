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
    
    var query: HKStatisticsCollectionQuery?
    
    
    //check if the health data is available or not
    init() {
        
        //checking if we have access to the health data
        if HKHealthStore.isHealthDataAvailable(){
            healthStore = HKHealthStore()
        }
    }
    
    //Gives us access to steps record
    func calculateSteps(completion: @escaping (HKStatisticsCollection?) -> Void){
        
        
        //Interested in Step Count
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        //Variables we need
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        var interval = DateComponents()
        interval.day = 1
        
        //For searching from start of day
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
               
        //Create collection query
        query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: startOfDay, intervalComponents: interval)
        
        query?.initialResultsHandler = {query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        //Executing the query 
        if let healthStore = healthStore, let query = self.query{
            healthStore.execute(query)
        }
    }
    
    //Function determining if we have authorization to the HealthKit data
    //Requests access to the data types specified below
    func requestAuthorization(completion: @escaping (Bool) -> Void ){
        
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        
        let heightType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        
        
        let weightType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        
        let biologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex)!
        
        let ageType = HKObjectType.characteristicType(forIdentifier: .dateOfBirth)!

        
   
        //unwrapping health store to get access to unwrapped version of the health store
        guard let healthStore = self.healthStore else { return completion(false) }
        
        
        //Requesting the authorization
        healthStore.requestAuthorization(toShare: [], read: [stepType, heightType, weightType, biologicalSex, ageType]) { (success, error) in
            completion(success)
        }
        
    }
    
}
 
 

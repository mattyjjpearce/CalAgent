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
}

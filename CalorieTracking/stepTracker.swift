////
////  stepTracker.swift
////  CalorieTrackerDis
////
////  Created by Matthew Pearce on 30/11/2020.
////
//
//import Foundation
//import HealthKit
//
//
//class stepTracker{
//
//    let healthStore = HKHealthStore()
//
//    func retrieveStepsWithAuth(completion: @escaping (Double) -> ()) {
//
//
//        let typestoRead = Set([
//            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
//               ])
//
//               let typestoShare = Set([
//                HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
//               ])
//
//
////        healthStore.requestAuthorization(toShare: typestoShare, read: typestoRead) { (success, error) -> Void in
////                   if success == false {
////                       NSLog(" Display not allowed")
////                   } else {
////                       self.retrieveSteps(completion: completion)
////                   }
//}
//
//
//    func retrieveSteps(completion: @escaping (Double) -> ()) {
//
//
//
//        let date = Date()
//        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
//        let newDate = cal.startOfDay(for: date)
//
//        let predicate = HKQuery.predicateForSamples(withStart: newDate, end: Date(), options: .strictStartDate)
//
//        var interval = DateComponents()
//                interval.day = 1
//
//
//        //Describing object type we want
//        if let stepType = HKQuantityType.quantityType(forIdentifier:HKQuantityTypeIdentifier.stepCount) {
//
//            let query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: newDate as Date, intervalComponents: interval)
//
//
//            //Setting the results handler (need to query for the results
//            query.initialResultsHandler = {query, results, error in
//
//                if error != nil {
//
//                    print("error in stepTracker.swift, loading steps")
//                    return
//                }
//
//                if let myResults = results{
//                    //need to unwrap the HKCollections stuff
//                    myResults.enumerateStatistics(from: newDate, to: <#T##Date#>, with:{ ( results, stop) in
//                        let count = results.sumQuantity()?.doubleValue(for: .count())
//                    })
//
//            }
//
//            }
//
//        }
//
//    }

}




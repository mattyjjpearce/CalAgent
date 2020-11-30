//
//  ProfileView.swift
//  navigationPractice
//
//  Created by Matthew Pearce on 26/11/2020.
//

import SwiftUI
import HealthKit

struct ProfileView: View {
    
    
    public var healthStore: HealthStore?
    
    // will need to change this to an obeservable object
    @State public var steps: [Step] = [Step]()
    
    init() {
        //implements the HKhealthStore from HealthStore.swift class 
        healthStore = HealthStore()
    }
    
    
    //Update UI from statistics
    // will be passing the statistics Collection
    
    public func updateUIFromStatistics( statisticsCollection: HKStatisticsCollection){
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)


        statisticsCollection.enumerateStatistics(from: startOfDay, to: now) { (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            
            steps.append(step)
        }
            
    }
    
    var body: some View {
        
        List(steps){ step in
            Text("\(step.count)")
            
            Text(step)
        }
            
            //When the tab appears
            .onAppear(){
                if let healthStore = healthStore{
                    healthStore.requestAuthorization{ success in
                        if success {
                            healthStore.calculateSteps { statisticsCollection in
                                if let statisticsCollection = statisticsCollection {
                                    updateUIFromStatistics(statisticsCollection: statisticsCollection
                                    
                                    )
                        
                                }
                                
                            }
                            
                        }
                       
                    }
                }
                
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

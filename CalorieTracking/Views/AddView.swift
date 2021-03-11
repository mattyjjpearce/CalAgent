//
//  ProgressView.swift
//  navigationPractice
//
//  Created by Matthew Pearce on 26/11/2020.
//

import SwiftUI
import Combine


struct AddView: View{
    
    @EnvironmentObject var person: UserInfoModel
    @StateObject var foods: FoodAddModel
    @State private var showingSheet = false
    
    @State private var newFoodNameString = ""
    @State private var newFoodFatString = ""
    @State private var newFoodProteinString = ""
    @State private var newFoodCarbString = ""




    init() {
            _foods = StateObject(wrappedValue: FoodAddModel())
        }
    
    var body: some View {
        VStack{
            Form{
                Section(header: Text("Add Food / Meals")){
                    TextField("Food Title ", text: $newFoodNameString)
                   
                    
                    TextField("Fat", text: $newFoodFatString).onReceive(Just(newFoodFatString)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.newFoodFatString = filtered
                        }
}
    
                    TextField("Carbs", text: $newFoodCarbString).onReceive(Just(newFoodCarbString)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.newFoodCarbString = filtered
                        }
}
                    
                    
                    
                    TextField("Protein", text: $newFoodProteinString).onReceive(Just(newFoodProteinString)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.newFoodProteinString = filtered
                        }
}
                    
                    Button(action: {
                        
                        if(newFoodProteinString != "" || newFoodCarbString != "" || newFoodFatString != "" ){
                        
                        //converting the input from type string to Double
                        let fatDouble: Double! = Double(newFoodFatString)
                        let carbDouble: Double! = Double(newFoodCarbString)
                        let proteinDouble: Double! = Double(newFoodProteinString)
                
                     
                        
                        let fatCalories = fatDouble * 9
                        let carbCalories = carbDouble * 4
                        let proteinCalories = proteinDouble * 4
                        let newFoodCalories = fatCalories + carbCalories + proteinCalories
                        
                        let newAddedFood = AddedFoods(name: newFoodNameString, totalCals: newFoodCalories, totalProtein: fatDouble, totalCarbs: carbDouble, totalFat: fatDouble)
                        
                        foods.foods?.append(newAddedFood)
                        
                        newFoodNameString = ""
                        newFoodFatString = "" //resetting the local variable
                        newFoodCarbString = ""
                        newFoodProteinString = ""
                        }

                    }) {
                        Text("Enter").multilineTextAlignment(.center)
                            .foregroundColor(Color.blue)
                    
                    
                }
                    Button("Delete Foods"){
                        self.showingSheet.toggle()
                    }.sheet(isPresented: $showingSheet, content: {
                                DeleteFoodView().environmentObject(foods)
                                    
                        
                    })
                    .foregroundColor(.red)
                
            }
        
        }
        }
        
    }
}

struct secondView:View{
    var body: some View{
        Text("Hi")
    }
}




struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}

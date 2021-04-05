//
//  MealView.swift
//  navigationPractice
//
//  Created by Matthew Pearce on 26/11/2020.
//

import SwiftUI
import Alamofire
import Combine //to use Just


struct MealView: View {
    
    @StateObject var foods: FoodAddModel
    
    @ObservedObject var calorieProgressViewModel: CalorieProgressViewModel = CalorieProgressViewModel()


    
    @EnvironmentObject var person: UserInfoModel
    @ObservedObject var mealViewModel: MealViewModel = MealViewModel()
    @State private var showingSheet1 = false
    @State private var showingSheet2 = false
    @State private var showingAlert = false
    
    @State private var fatInputString = ""
    @State private var carbInputString = ""
    @State private var proteinInputString = ""
   
    init() {
            _foods = StateObject(wrappedValue: FoodAddModel())

        }
    
    
    
    var body: some View {
       
        VStack{
            HStack{
            Button("Filter"){
                self.showingSheet1.toggle()
            }.sheet(isPresented: $showingSheet1, content: {
                Form{
                    Text("Filter by Macronutrients")
                    TextField("Fat g", text: $fatInputString ).keyboardType(.numberPad)
                        .onReceive(Just(fatInputString)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.fatInputString = filtered
                                        }
                }
                    TextField("Carb g", text: $carbInputString ).keyboardType(.numberPad)
                        .onReceive(Just(carbInputString)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.carbInputString = filtered
                                        }
                }
                    
                    TextField("Protein g", text: $proteinInputString ).keyboardType(.numberPad)
                        .onReceive(Just(proteinInputString)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.proteinInputString = filtered
                                        }
                }
                     
                    Button("Done"){
                        
                        if(fatInputString != "" && carbInputString != "" && proteinInputString != ""){
                        person.recipeNutrientsSearch.fat = Int(fatInputString)!
                        person.recipeNutrientsSearch.carb = Int(carbInputString)!
                        person.recipeNutrientsSearch.protein = Int(proteinInputString)!

                        mealViewModel.fetchNutrients()
                            
                        self.showingSheet1.toggle()
                            
                        }else{
                        showingAlert = true
                        }
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text("Invalid Input"), message: Text("Please enter a value in each field, or reset to remaining macros left"), dismissButton: .default(Text("Got it!")))

                    }
                }.foregroundColor(.black)
            })
            .font(.custom("Inter-Medium", size: 16))
            .foregroundColor(Color.white)
            .frame(width: 50, height: 25)
            .cornerRadius(10)
            .background(Color.gray)
                
                Button("Reset"){
                    let fat = person.personDailyCalorieGoals.fatGoal - person.personCurrentCalorieProgress.fatProgress
                    let carb = person.personDailyCalorieGoals.carbGoal - person.personCurrentCalorieProgress.carbProgress
                    let protein = person.personDailyCalorieGoals.proteinGoal - person.personCurrentCalorieProgress.proteinProgress


                    if(fat < 0){
                        person.recipeNutrientsSearch.fat = 1
                    }else{
                    person.recipeNutrientsSearch.fat = Int(fat)
                    }
                    
                    if(carb < 0){
                        person.recipeNutrientsSearch.carb = 1

                    }else{
                        person.recipeNutrientsSearch.carb = Int(carb)

                    }
                    if(protein < 0){
                    person.recipeNutrientsSearch.protein = 1
                        print("protein is 0: ")

                    }else{
                    person.recipeNutrientsSearch.protein = Int(protein)
                    }
   
                    mealViewModel.fetchNutrients()
                    
                }.font(.custom("Inter-Medium", size: 16))
                .foregroundColor(Color.white)
                .frame(width: 50, height: 25)
                .cornerRadius(10)
                .background(Color.gray)
 
                Spacer()
            }
            
        ScrollView(.vertical, showsIndicators: true){
            VStack{
                ForEach(mealViewModel.nutrients, id: \.id){
                    item in
                    VStack{
                        
                        Text(item.title) .fixedSize(horizontal: false, vertical: true)
                        
                        HStack{
                            VStack{
                                Text("\(item.calories) kcals")
                                Text("Fat: " + item.fat)
                                Text("Carbs: "+item.carbs)
                                Text("Protein: "+item.protein)
                            }.frame(width: 150)
                            VStack{
                                loadingImages(url: item.image) .aspectRatio(contentMode: .fit)
                                    .frame(width: 200, height:100)
                            }
                        }
                        
                      
                        Button("Add to Macros"){ //Selecting one of the items to View in more detail and add
                          
                            let nutritionFunction = nutritionFunctions() //creating a nutritionObject to use cals function
                            
                            
                            let fat = nutritionFunction.stringToDoubleGrams(input: item.fat)
                            let protein = nutritionFunction.stringToDoubleGrams(input: item.protein)
                            let carbs = nutritionFunction.stringToDoubleGrams(input: item.carbs)

                            let calories = Double(item.calories)
                            
                            person.personCurrentCalorieProgress.calorieProgress += calories
                            person.personCurrentCalorieProgress.fatProgress += fat
                            person.personCurrentCalorieProgress.carbProgress += carbs
                            person.personCurrentCalorieProgress.proteinProgress += protein
                            
                            
                            let newAddedFood = AddedFoods(name: item.title, totalCals: calories, totalProtein: protein, totalCarbs: carbs, totalFat: fat)
                            
                            foods.foods?.append(newAddedFood)
                            
                            
                            calorieProgressViewModel.deleteUserData()
                            
                            calorieProgressViewModel.addCalorieProgressData(id: UUID(), calorieProgress:  person.personCurrentCalorieProgress.calorieProgress, fatProgress:  person.personCurrentCalorieProgress.fatProgress, carbProgress:  person.personCurrentCalorieProgress.carbProgress, proteinPogress:  person.personCurrentCalorieProgress.proteinProgress, created: Date())
                            
                            
                                
                        }.accentColor(.blue)
                            
                    }.frame(width: 300, height: 200)
                    Divider().frame(height: 10).background(Color.blue)
                }
            }
        }.frame(width: 350, height: 550)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.black, lineWidth: 4))
        }.frame(width: 350)
        .onAppear(){


            let fat = person.personDailyCalorieGoals.fatGoal - person.personCurrentCalorieProgress.fatProgress
            let carb = person.personDailyCalorieGoals.carbGoal - person.personCurrentCalorieProgress.carbProgress
            let protein = person.personDailyCalorieGoals.proteinGoal - person.personCurrentCalorieProgress.proteinProgress


            if(fat < 0){
                person.recipeNutrientsSearch.fat = 1
            }else{
            person.recipeNutrientsSearch.fat = Int(fat)
            }
            
            if(carb < 0){
                person.recipeNutrientsSearch.carb = 1

            }else{
                person.recipeNutrientsSearch.carb = Int(carb)

            }
            if(protein < 0){
            person.recipeNutrientsSearch.protein = 1
                print("protein is 0: ")

            }else{
                person.recipeNutrientsSearch.protein = Int(protein)

                            }
            print("recipe search:", person.recipeNutrientsSearch.fat, person.recipeNutrientsSearch.carb, person.recipeNutrientsSearch.protein)
            mealViewModel.fetchNutrients()

           
        }
        
    }
}



struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealView()
    }
}

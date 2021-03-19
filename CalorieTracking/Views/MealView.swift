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
    
    @EnvironmentObject var person: UserInfoModel
    @ObservedObject var mealViewModel: MealViewModel = MealViewModel()
    @State private var showingSheet1 = false
    @State private var showingSheet2 = false
    @State private var showingAlert = false


    @State private var fatInputString = ""
    @State private var carbInputString = ""
    @State private var proteinInputString = ""

    
    
    
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
                            
                        }
                        showingAlert = true 
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
                        
                      
                        Button("Press"){ //Selecting one of the items to View in more detail and add
                            print("This id: \(item.id)")
                        }.accentColor(.blue)
                            
                    }.frame(width: 300, height: 200)
                    Divider().frame(height: 10).background(Color.blue)
                }
            }
        }.frame(width: 350, height: 500)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.black, lineWidth: 4))
        }.frame(width: 350)
    }
}



struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealView()
    }
}

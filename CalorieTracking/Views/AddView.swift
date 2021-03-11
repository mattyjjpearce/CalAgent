//
//  ProgressView.swift
//  navigationPractice
//
//  Created by Matthew Pearce on 26/11/2020.
//

import SwiftUI


struct AddView: View{
    
    @EnvironmentObject var person: UserInfoModel
    @StateObject var foods: FoodAddModel
    @State private var showingSheet = false


    init() {
            _foods = StateObject(wrappedValue: FoodAddModel())
        }
    
    var body: some View {
        VStack{
            Button("Delete Items"){
                self.showingSheet.toggle()
            }.sheet(isPresented: $showingSheet, content: {
                        DeleteFoodView().environmentObject(foods)
                            
                
            })
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
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

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

    
    init() {
            _foods = StateObject(wrappedValue: FoodAddModel())
        }

    
 
    
    
    var body: some View {
        VStack{
            HStack{
        myView().environmentObject(foods)
    }
        
        
        Button(action: {
          let  x = AddedFoods(name: "Pizza", totalCals: 1000, totalProtein: 200, totalCarbs: 320, totalFat: 56, id: "2")
            foods.foods?.append(x)

        }) {
            Text("Enter").multilineTextAlignment(.center)
                .foregroundColor(Color.blue)
    }
}
    }
}




struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}

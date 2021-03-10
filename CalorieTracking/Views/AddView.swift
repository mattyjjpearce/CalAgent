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
        myView().environmentObject(foods)
        }
    }
    }





struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}

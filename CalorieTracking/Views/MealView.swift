//
//  MealView.swift
//  navigationPractice
//
//  Created by Matthew Pearce on 26/11/2020.
//

import SwiftUI
import Alamofire

struct MealView: View {
    
    @EnvironmentObject var person: UserInfoModel
    @ObservedObject var mealViewModel: MealViewModel = MealViewModel()


    var body: some View {
       
        
        List(mealViewModel.nutrients, id: \.id) { item in
                    VStack(alignment: .leading) {
                        Text(item.title)
                    }
                }
        
    }
}



struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealView()
    }
}

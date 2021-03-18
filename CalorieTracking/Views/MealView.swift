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
       
        ScrollView(.horizontal, showsIndicators: true){
            HStack{
                ForEach(mealViewModel.nutrients, id: \.id){
                    item in
                    VStack{
                        Text(item.title).padding(15)
                        Text("\(item.calories)")
                        Text(item.fat)
                        Text(item.carbs)
                        Text(item.protein)
                        loadingImages(url: item.image) .aspectRatio(contentMode: .fit)
                            .frame(width: 300)
                    }.overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.blue, lineWidth: 4)
                    ).padding()

                }
            }
        }.frame(height: 500)

    }
}



struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealView()
    }
}

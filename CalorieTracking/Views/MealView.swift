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
    @State private var showingSheet1 = false
    @State private var showingSheet2 = false


    
    var body: some View {
       
        VStack{
            HStack{
            Button("Filter"){
                self.showingSheet1.toggle()
            }.sheet(isPresented: $showingSheet1, content: {
                Form{
                    Text("Hi")
                    
                    
                    
                    
                    Button("Done"){
                        self.showingSheet1.toggle()
                    }
                }
                            
                
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

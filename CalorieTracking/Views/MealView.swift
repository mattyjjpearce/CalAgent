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
    
    //Since the response is an array of TaskEntry object
    @State var results = [RecipieAPI]()
    
    @State private var apiKey = "8ce5b26efe34423fb9f68b003de36b55" 

 

    var body: some View {
        Text("Hello world")
        Button(action: {
            loadData2()
        }) {
            Text("Enter").multilineTextAlignment(.center)
                .foregroundColor(Color.blue)
        }
        
//        List(results, id: \.title) { item in
//                    VStack(alignment: .leading) {
//                        Text(item.title)
//                    }
//                }.onAppear(perform: loadData)
        
    }
    
    
//    func loadData() {
//            guard let url = URL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/search?query=burger&diet=vegetarian&excludeIngredients=coconut&intolerances=egg%2C%20gluten&number=10&offset=0&type=main%20course") else {
//                print("Invalid URL")
//                return
//            }
//            let request = URLRequest(url: url)
//
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                if let data = data {
//                    if let response = try? JSONDecoder().decode([RecipieAPI].self, from: data) {
//                        DispatchQueue.main.async {
//                            self.results = response
//                            print(response)
//                        }
//                        return
//                    }
//                }
//            }.resume()
//        }
    
    
    func loadData2() {
        
        AF.request("https://api.spoonacular.com/recipes/716429/information?apiKey=\(apiKey)&includeNutrition=true").responseJSON { response in
    
            debugPrint(response)
        }
    }
    

    
}



struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealView()
    }
}

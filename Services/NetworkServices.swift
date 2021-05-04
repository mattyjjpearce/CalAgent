//
//  NetworkServices.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 17/03/2021.
//

import Foundation
import Alamofire

class NetworkServices {
    
    //API key to provided by Spoonacular
    static let apiKey: String = "8e8c3bcbd09c402cb0e3279db5db7cc2"
    

    //Function to
    static func fetchNutrients(maxProtein: Int, maxFat: Int, maxCarbs: Int, number: Int, completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        
        AF.request("https://api.spoonacular.com/recipes/findByNutrients?apiKey=\(NetworkServices.apiKey)&maxFat=\(maxFat)&maxProtein=\(maxProtein)&maxCarbs=\(maxCarbs)&number=\(number)", method: .get).responseJSON { (response) in
            switch response.result { //Switch statement with result
            case .success(_): //if successfull
                
                let decoder = JSONDecoder()  //Intantiating a JSONDecoder
                
                    if let data = response.data {
                        do {
                            let nutrients = try decoder.decode([RecipeAPI].self, from: data) //Decode the API request and use the RecipeAPI model to place inside variable nutrients
                            
                            completionHandler(nutrients, nil) //ensuring it happens 
                        } catch let error {
                            completionHandler(nil, error)
                        }
                    }
                
            case .failure(let error): //if unsuccessfull
                completionHandler(nil, error)
            }
        }
    }
  
}


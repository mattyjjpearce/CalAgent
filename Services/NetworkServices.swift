//
//  NetworkServices.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 17/03/2021.
//

import Foundation
import Alamofire

class NetworkServices {
    
    // API key provided by Spoonacular
    static let apiKey: String = "8e8c3bcbd09c402cb0e3279db5db7cc2"
    
    // Function to fetch recipes based on nutrient constraints
    static func fetchNutrients(maxProtein: Int, maxFat: Int, maxCarbs: Int, number: Int, completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        
        // Construct the URL with nutrient constraints and the provided API key
        let url = "https://api.spoonacular.com/recipes/findByNutrients?" +
                  "apiKey=\(NetworkServices.apiKey)" +
                  "&maxFat=\(maxFat)&maxProtein=\(maxProtein)&maxCarbs=\(maxCarbs)&number=\(number)"
        
        // Make a GET request to the Spoonacular API using Alamofire
        AF.request(url, method: .get).responseJSON { (response) in
            switch response.result { // Switch based on the response result
                
            case .success(_): // If the request is successful
                
                let decoder = JSONDecoder()  // Instantiate a JSONDecoder
                
                if let data = response.data {
                    do {
                        let nutrients = try decoder.decode([RecipeAPI].self, from: data) // Decode the API response into an array of RecipeAPI using the specified model
                        
                        completionHandler(nutrients, nil) // Call the completion handler with the decoded data
                    } catch let error {
                        completionHandler(nil, error) // If decoding fails, call the completion handler with an error
                    }
                }
                
            case .failure(let error): // If the request fails
                completionHandler(nil, error) // Call the completion handler with an error
            }
        }
    }
  
}

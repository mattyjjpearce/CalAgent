//
//  NetworkServices.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 17/03/2021.
//

import Foundation
import Alamofire

class NetworkServices {
    
    static let apiKey: String = "8e8c3bcbd09c402cb0e3279db5db7cc2"
    
    //Function to get the recipes based on the amount of macro-nutrients left. 
    static func fetchNutrients(minCarbs: Int, maxCarbs: Int, number: Int, completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        AF.request("https://api.spoonacular.com/recipes/findByNutrients?apiKey=\(NetworkServices.apiKey)&minCarbs=\(minCarbs)&maxCarbs=\(maxCarbs)&number=\(number)", method: .get).responseJSON { (response) in
            switch response.result {
            case .success(_):
                
                let decoder = JSONDecoder()
                
                if let data = response.data {
                    do {
                        let nutrients = try decoder.decode([RecipieAPI].self, from: data)
                        completionHandler(nutrients, nil)
                    } catch let error {
                        completionHandler(nil, error)
                    }
                }
                
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
}

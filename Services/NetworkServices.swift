//
//  NetworkServices.swift
//  CalorieTrackerDis
//
//  Created by Matthew Pearce on 17/03/2021.
//

import Foundation
import Alamofire

class NetworkServices {
    
    static let apiKey: String = "8ce5b26efe34423fb9f68b003de36b55"
    
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

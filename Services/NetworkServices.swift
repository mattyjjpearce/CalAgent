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
    

    static func fetchNutrients(maxProtein: Int, maxFat: Int, maxCarbs: Int, number: Int, completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        
    
        AF.request("https://api.spoonacular.com/recipes/findByNutrients?apiKey=\(NetworkServices.apiKey)&maxFat=\(maxFat)&maxProtein=\(maxProtein)&maxCarbs=\(maxCarbs)&number=\(number)", method: .get).responseJSON { (response) in
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
    
//    static func complexSearch(maxProtein: Int, maxFat: Int, maxCarbs: Int, number: Int, completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
//        
//    
//        AF.request("https://api.spoonacular.com/recipes/complexSearch?apiKey=\(NetworkServices.apiKey)&diet=pasta&&maxFat=\(maxFat)&maxProtein=\(maxProtein)&maxCarbs=\(maxCarbs)&number=\(number)", method: .get).responseJSON { (response) in
//            switch response.result {
//            case .success(_):
//                
//             //   let decoder = JSONDecoder()
//                
//                debugPrint(response)
//                
////                if let data = response.data {
////                    do {
////                        let nutrients = try decoder.decode([RecipieAPI].self, from: data)
////                        completionHandler(nutrients, nil)
////                    } catch let error {
////                        completionHandler(nil, error)
////                    }
////                }
//                
//            case .failure(let error):
//                completionHandler(nil, error)
//            }
//        }
//    }
    
    
    
}


//let nutrients = try decoder.decode(Root.self, from: data)
//completionHandler(nutrients.results, nil)

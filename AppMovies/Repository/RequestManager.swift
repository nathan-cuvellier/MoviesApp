//
//  RequestManager.swift
//  AppMovies
//
//  Created by nathan on 18/05/2021.
//

import Foundation
import UIKit

struct RequestManager {
    static var shared = RequestManager()
    let urlSession = URLSession.shared
    
    func requestData(url: URL, completion: @escaping (Data)-> Void) -> Void {
        
        self.urlSession.dataTask(with: url) { (data, reponse, error) in
            guard error == nil else {
                return
            }
            if let data = data {
                completion(data)
            }
        }.resume()
        
    }
}

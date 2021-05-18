//
//  CategoryRepository.swift
//  AppMovies
//
//  Created by nathan on 18/05/2021.
//

import Foundation

struct CategoryRepository {
    
    func getCategories(completion: @escaping ((CategoriesWSResponse?) -> Void)) -> Void {
        let url = ApiManager.shared.createURL(pathUrl: ApiPath.categories)
        
        if let categoryUrl = url?.url {
            RequestManager.shared.requestData(url: categoryUrl) { data in
                completion(try? JSONDecoder().decode(CategoriesWSResponse.self, from: data))
            }
        }
    }
    
}

struct Genre: Decodable {
    let id: Int
    let name: String
}

struct CategoriesWSResponse: Decodable {
    let genres: [Genre]
    let page: Int?
    let totalPages: Int?
}

//
//  GenreRepository.swift
//  AppMovies
//
//  Created by nathan on 18/05/2021.
//

import Foundation

struct GenreRepository {
    
    func getGenres(completion: @escaping ((GenresWSResponse?) -> Void)) -> Void {
        let url = ApiManager.shared.createURL(pathUrl: ApiPath.categories)
        
        if let categoryUrl = url?.url {
            RequestManager.shared.requestData(url: categoryUrl) { data in
                completion(try? JSONDecoder().decode(GenresWSResponse.self, from: data))
            }
        }
    }
    
}

struct Genre: Decodable {
    let id: Int
    let name: String
}

struct GenresWSResponse: Decodable {
    let genres: [Genre]
    let page: Int?
    let totalPages: Int?
}

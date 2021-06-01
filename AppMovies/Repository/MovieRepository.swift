//
//  Movie.swift
//  AppMovies
//
//  Created by nathan on 01/06/2021.
//

import Foundation

struct MovieRepository {
    
    func getMovieById(movieId: Int, completion: @escaping ((MovieByIdResponse?) -> Void)) {
        
        
        var url = ApiManager.shared.createURL(pathUrl: ApiPath.movie)
        
        url?.path += "/\(movieId)"
        
        if let movieById = url?.url {
            RequestManager.shared.requestData(url: movieById) { data in
                completion(try? JSONDecoder().decode(MovieByIdResponse.self, from: data))
            }
        }
    }
}

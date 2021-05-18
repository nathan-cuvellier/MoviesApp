//
//  MovieRepository.swift
//  AppMovies
//
//  Created by nathan on 18/05/2021.
//

import Foundation

struct MovieRepo {
    
    func getMoviesByGenre(page: Int = 1, genreId: Int? = nil, completion: @escaping ((MovieByGenreResponse?) -> Void)) {
        
        var params: [URLQueryItem] = []
        params.append(URLQueryItem(name: "page", value: "\(page)"))
        
        if let genre = genreId {
            params.append(URLQueryItem(name: "with_genres", value: "\(genre)"))
        }
        
        let url = ApiManager.shared.createURL(pathUrl: ApiPath.movieList, queryParams: params)
        if let movieByCateUrl = url?.url {
            RequestManager.shared.requestData(url: movieByCateUrl) { data in
                completion(try? JSONDecoder().decode(MovieByGenreResponse.self, from: data))
            }
        }
    }
}

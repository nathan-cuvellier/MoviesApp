//
//  Film.swift
//  AppMovies
//
//  Created by nathan on 18/05/2021.
//

import Foundation

struct Movie : Decodable {
    var id: Int
    var title: String
    var subtitle: String?
    var releaseDate: String?
    var duration: Int?
    var genre: [String]?
    var overview: String?
    var trailerUrl: String?
    var imageUrl: String?
    var posterUrl: String?
    
    init?(from movieResponse: MovieWSResponse)
    {
        guard let id = movieResponse.id, let title = movieResponse.title, let releaseDate = movieResponse.releaseDate else {
            return nil
        }
        
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.overview = movieResponse.overview
        if let backdrop = movieResponse.backdropPath {
            self.imageUrl = ApiManager.shared.IMAGE_BASE_URL + "w500" + backdrop
        }

    }
    
    func toStringDuration() -> String{
        guard let duration = self.duration else {
            return "nil"
        }
        return "\(duration) min"
    }
    
    func toStringGenres() -> String {
        guard let genres = self.genre else {
            return "nil"
        }
        return genres.joined(separator: "/ ")
    }
    
    func toUrlTrailer() -> URL?{
        guard let trailer = self.trailerUrl else {
            return nil
        }
        return URL(string: trailer)
    }
    
    func toUrlImageUrl() -> URL? {
        guard let imageUrl = self.imageUrl else {
            return nil
        }
        return URL(string: imageUrl)
    }
    
}


struct MovieByGenreResponse: Decodable {
    let page, totalResults, totalPages: Int?
    let results: [MovieWSResponse]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
    func toMovieByGenre() -> [Movie] {
        guard let results = self.results else {
            return []
        }
        return results.compactMap { movieReponse -> Movie? in
            Movie(from: movieReponse)
        }
    }
}

struct MovieWSResponse: Decodable {
    let id: Int?
    let backdropPath: String?
    let genres: [Int]?
    let title: String?
    let overview: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case genres = "genre_ids"
        case title
        case overview
        case releaseDate = "release_date"
    }
}

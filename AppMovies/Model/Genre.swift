//
//  Genre.swift
//  AppMovies
//
//  Created by nathan on 18/05/2021.
//

import Foundation

struct Genre: Decodable {
    let id: Int
    let name: String
    
    init(fromId id: Int, fromName name: String) {
        self.id = id
        self.name = name
    }
}

struct GenresWSResponse: Decodable {
    let genres: [Genre]?
    let page: Int?
    let totalPages: Int?
    
    func toGenre() -> [Genre] {
        guard let genres = self.genres else {
            return []
        }
        return genres.compactMap { genre -> Genre? in
            Genre(fromId: genre.id, fromName: genre.name)
        }
    }
}

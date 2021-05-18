//
//  Films.swift
//  AppMovies
//
//  Created by nathan on 18/05/2021.
//

import UIKit

class MovieController: UIViewController {
    
    var movies: [Movie] = []

    private let movieRepository = MovieRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieRepository.getGenres() { response in
            if let movies = response {
                self.movies = movies.toMovie()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }

}

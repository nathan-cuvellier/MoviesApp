//
//  Films.swift
//  AppMovies
//
//  Created by nathan on 18/05/2021.
//

import UIKit

class MoviesController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie] = []
    var genre : Genre?
    var image : [String : UIImage] = [:]

    private let movieRepository = MoviesRepository()
    private let imageManager = ImageManager()
    
    private let identifier = "films_to_film"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        movieRepository.getMoviesByGenre(page: 1, genreId: self.genre?.id, completion : { response in
            if let movies = response {
                
                self.movies = movies.toMovieByGenre()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifier {
            let movieController = segue.destination as! MovieController
            if let idMovie = sender as? Int {
                movieController.movieId = idMovie
            }
        }
    }

}

extension MoviesController: UITableViewDelegate {    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: identifier, sender: movies[indexPath.item].id)
    }
}

extension MoviesController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.prepareForReuse()
        
        let movie = movies[indexPath.item]
        
        
        cell.setInformation(movie: movie)
        
        guard let url = movie.toUrlImageUrl() else {
            return cell
        }
        
        imageManager.getImageInCache(url: url) { image, imageUrl in
            DispatchQueue.main.async() {
                if imageUrl == url.absoluteString {
                    cell.setImage(image)
                }
            }
        }
        
        return cell
        
    }

    
}
/*
extension MoviesController: UITableViewDelegate {

}
*/

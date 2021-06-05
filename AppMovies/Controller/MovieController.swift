//
//  Movie.swift
//  AppMovies
//
//  Created by nathan on 01/06/2021.
//

import UIKit

class MovieController: UIViewController {
    
    var movieId : Int = 0
    var movie : Movie?
    //var image : [String : UIImage] = [:]
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var poster: UIImageView!
    
    private let movieRepository = MovieRepository()
    private let imageManager = ImageManager()
    
    private let identifier = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieRepository.getMovieById(movieId: movieId) { response in
            
            if let movieResponse = response {
                guard let movie = Movie(from: movieResponse) else {
                    return
                }
                
                self.movie = movie
                
                DispatchQueue.main.async {
                    self.titleLabel.text = movie.title
                    self.overview.text = movie.overview
                    
                    self.genreLabel.text = movie.toStringGenres()
                    
                    let format = DateFormatter()
                    format.dateFormat = "yyyy-MM-dd"
                    
                    if let releaseDate = movie.releaseDate,
                    let date = format.date(from: releaseDate)
                    {
                        
                        format.dateFormat = "dd/MM/yyyy"
                        
                        self.releaseDate.text = format.string(from: date)
                    }
                    
                    if var runtimeData = movieResponse.runtime {
                        let hours = Int(floor(Double(runtimeData) / 60))
                        
                        runtimeData -= hours * 60
                        
                        let minutes = runtimeData
                        
                        self.runtime.text = "  \(hours)h \(minutes)m"
                    }
                    
                    if let url = movie.toUrlImageUrl() {
                        self.imageManager.getImageInCache(url: url) { image, imageUrl in
                            DispatchQueue.main.async() {
                                if imageUrl ==  url.absoluteString {
                                    self.image.image = image
                                }
                            }
                        }
                    }
                    if let url = movie.toUrlPosterUrl() {
                        self.imageManager.getImageInCache(url: url) { image, imageUrl in
                            DispatchQueue.main.async() {
                                if imageUrl ==  url.absoluteString {
                                    self.poster.image = image
                                }
                            }
                        }
                    }
                    
                }
                
            }
        }
        
    }
    
}
